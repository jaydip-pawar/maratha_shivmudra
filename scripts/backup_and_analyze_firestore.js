import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';

// Helper to convert Firestore typed value to native JS
function convertFirestoreValue(val) {
  if (!val || typeof val !== 'object') return val;
  if ('stringValue' in val) return val.stringValue;
  if ('integerValue' in val) return parseInt(val.integerValue, 10);
  if ('doubleValue' in val) return parseFloat(val.doubleValue);
  if ('booleanValue' in val) return val.booleanValue;
  if ('timestampValue' in val) return val.timestampValue;
  if ('nullValue' in val) return null;
  if ('arrayValue' in val) {
    return (val.arrayValue.values || []).map(convertFirestoreValue);
  }
  if ('mapValue' in val) {
    const res = {};
    const fields = val.mapValue.fields || {};
    for (const [k, v] of Object.entries(fields)) {
      res[k] = convertFirestoreValue(v);
    }
    return res;
  }
  return val;
}

function convertDocument(doc) {
  if (!doc) return null;
  const data = {};
  if (doc.fields) {
    for (const [k, v] of Object.entries(doc.fields)) {
      data[k] = convertFirestoreValue(v);
    }
  }
  return {
    _id: doc.name ? doc.name.split('/').pop() : null,
    _path: doc.name,
    _createTime: doc.createTime,
    _updateTime: doc.updateTime,
    ...data,
  };
}

async function run() {
  console.log('--- Step 1: Getting gcloud Auth Token ---');
  let token = '';
  try {
    token = execSync('gcloud auth print-access-token', { encoding: 'utf-8' }).trim();
  } catch (err) {
    console.error('Failed to get token via gcloud:', err.message);
    process.exit(1);
  }

  const projectId = 'maratha-shivmudra';
  const baseUrl = `https://firestore.googleapis.com/v1/projects/${projectId}/databases/(default)/documents`;

  const headers = {
    Authorization: `Bearer ${token}`,
    'Content-Type': 'application/json',
  };

  const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
  const backupDir = path.resolve(process.cwd(), 'backups', `firestore_backup_${timestamp}`);
  const collectionsDir = path.join(backupDir, 'collections');
  fs.mkdirSync(collectionsDir, { recursive: true });

  console.log(`Backup directory: ${backupDir}`);

  // 1. List all root collection IDs
  console.log('--- Step 2: Listing Root Collections ---');
  const listColRes = await fetch(`${baseUrl}:listCollectionIds`, {
    method: 'POST',
    headers,
    body: JSON.stringify({ pageSize: 1000 }),
  });

  if (!listColRes.ok) {
    console.error(`Error listing collections: ${listColRes.status} ${await listColRes.text()}`);
    process.exit(1);
  }

  const listColData = await listColRes.json();
  const collectionIds = listColData.collectionIds || [];
  console.log(`Found ${collectionIds.length} root collections.`);

  const rawBackup = {
    metadata: {
      projectId,
      timestamp: new Date().toISOString(),
      totalRootCollections: collectionIds.length,
    },
    collections: {},
  };

  const cleanBackup = {
    metadata: {
      projectId,
      timestamp: new Date().toISOString(),
      totalRootCollections: collectionIds.length,
    },
    collections: {},
  };

  // Helper to fetch all documents in a collection path
  async function fetchCollectionDocs(colUrl) {
    let docs = [];
    let pageToken = null;
    do {
      const url = new URL(colUrl);
      url.searchParams.set('pageSize', '300');
      if (pageToken) url.searchParams.set('pageToken', pageToken);

      const res = await fetch(url.toString(), { headers });
      if (!res.ok) {
        console.error(`Failed to fetch ${url}: ${res.status} ${await res.text()}`);
        break;
      }
      const data = await res.json();
      if (data.documents) {
        docs = docs.concat(data.documents);
      }
      pageToken = data.nextPageToken;
    } while (pageToken);
    return docs;
  }

  // Helper to check subcollections of a document
  async function checkSubcollections(docPath) {
    const res = await fetch(`https://firestore.googleapis.com/v1/${docPath}:listCollectionIds`, {
      method: 'POST',
      headers,
      body: JSON.stringify({ pageSize: 100 }),
    });
    if (!res.ok) return [];
    const data = await res.json();
    return data.collectionIds || [];
  }

  console.log('--- Step 3: Fetching All Collections & Documents ---');
  let processed = 0;
  for (const colId of collectionIds) {
    processed++;
    if (processed % 20 === 0 || processed === collectionIds.length) {
      console.log(`Progress: ${processed}/${collectionIds.length} collections fetched...`);
    }

    const colUrl = `${baseUrl}/${colId}`;
    const rawDocs = await fetchCollectionDocs(colUrl);

    // Check for subcollections in each doc
    const docsWithSubcols = [];
    for (const d of rawDocs) {
      const subCols = await checkSubcollections(d.name);
      const subColData = {};
      for (const subId of subCols) {
        const subRawDocs = await fetchCollectionDocs(`https://firestore.googleapis.com/v1/${d.name}/${subId}`);
        subColData[subId] = subRawDocs;
      }
      docsWithSubcols.push({
        raw: d,
        subcollections: subColData,
      });
    }

    rawBackup.collections[colId] = docsWithSubcols;

    // Build clean version
    cleanBackup.collections[colId] = docsWithSubcols.map((item) => {
      const convertedDoc = convertDocument(item.raw);
      if (Object.keys(item.subcollections).length > 0) {
        convertedDoc._subcollections = {};
        for (const [sId, sDocs] of Object.entries(item.subcollections)) {
          convertedDoc._subcollections[sId] = sDocs.map(convertDocument);
        }
      }
      return convertedDoc;
    });

    // Save individual collection file
    fs.writeFileSync(
      path.join(collectionsDir, `${colId}.json`),
      JSON.stringify(cleanBackup.collections[colId], null, 2),
      'utf-8'
    );
  }

  // Save full raw and clean files
  console.log('--- Step 4: Writing Full Backup Files ---');
  fs.writeFileSync(path.join(backupDir, 'full_backup_raw.json'), JSON.stringify(rawBackup, null, 2), 'utf-8');
  fs.writeFileSync(path.join(backupDir, 'full_backup_clean.json'), JSON.stringify(cleanBackup, null, 2), 'utf-8');

  console.log('--- Step 5: Performing Architecture & Data Analysis ---');
  const phoneCollections = [];
  const systemCollections = [];

  for (const colId of collectionIds) {
    if (/^\d{10}$/.test(colId)) {
      phoneCollections.push(colId);
    } else {
      systemCollections.push(colId);
    }
  }

  let phonesWithFormInfo = 0;
  let phonesWithOnlyPersonalInfo = 0;
  let phonesWithNeither = 0;
  let phonesWithBoth = 0;
  const otherDocsInPhones = new Set();
  const allFormFields = new Set();
  const sampleForms = [];

  for (const phone of phoneCollections) {
    const docs = cleanBackup.collections[phone] || [];
    const docIds = docs.map((d) => d._id);

    const hasForm = docIds.includes('form_info');
    const hasPersonal = docIds.includes('personal_info');

    if (hasForm && hasPersonal) phonesWithBoth++;
    else if (hasForm) phonesWithFormInfo++;
    else if (hasPersonal) phonesWithOnlyPersonalInfo++;
    else phonesWithNeither++;

    for (const d of docs) {
      if (d._id !== 'form_info' && d._id !== 'personal_info') {
        otherDocsInPhones.add(d._id);
      }
      if (d._id === 'form_info') {
        for (const k of Object.keys(d)) {
          if (!k.startsWith('_')) allFormFields.add(k);
        }
        if (sampleForms.length < 5) {
          sampleForms.push(d);
        }
      }
    }
  }

  const analysisReport = {
    summary: {
      totalCollections: collectionIds.length,
      phoneCollectionsCount: phoneCollections.length,
      systemCollections: systemCollections,
      phoneBreakdown: {
        phonesWithBoth,
        phonesWithOnlyFormInfo: phonesWithFormInfo,
        totalWithFormInfo: phonesWithBoth + phonesWithFormInfo,
        phonesWithOnlyPersonalInfo,
        phonesWithNeither,
        otherDocTypesFound: Array.from(otherDocsInPhones),
      },
      systemCollectionsContent: {},
    },
    allFormFieldsFound: Array.from(allFormFields).sort(),
    sampleForms,
  };

  for (const sysCol of systemCollections) {
    analysisReport.summary.systemCollectionsContent[sysCol] = (cleanBackup.collections[sysCol] || []).map((d) => ({
      _id: d._id,
      fields: Object.keys(d).filter((k) => !k.startsWith('_')),
      dataPreview: d,
    }));
  }

  fs.writeFileSync(path.join(backupDir, 'analysis_report.json'), JSON.stringify(analysisReport, null, 2), 'utf-8');

  console.log('\n================ DATA ANALYSIS RESULTS ================');
  console.log(`Total Root Collections: ${collectionIds.length}`);
  console.log(`Phone Collections (10-digits): ${phoneCollections.length}`);
  console.log(`System Collections: ${systemCollections.join(', ')}`);
  console.log(`\nPhone Numbers Breakdown:`);
  console.log(`  - With BOTH form_info & personal_info: ${phonesWithBoth}`);
  console.log(`  - With ONLY form_info: ${phonesWithFormInfo}`);
  console.log(`  - TOTAL COMPLETED FORMS: ${phonesWithBoth + phonesWithFormInfo}`);
  console.log(`  - With ONLY personal_info (OTP verified or referral only, no form): ${phonesWithOnlyPersonalInfo}`);
  console.log(`  - Other document types inside phone collections: ${Array.from(otherDocsInPhones).join(', ') || 'None'}`);
  console.log(`\nForm Info Fields Detected Across All Records:`);
  console.log(Array.from(allFormFields).sort().join(', '));
  console.log(`\nBackup safely saved to: ${backupDir}`);
  console.log('========================================================\n');
}

run().catch((err) => {
  console.error('Fatal error in script:', err);
  process.exit(1);
});
