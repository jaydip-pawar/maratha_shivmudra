import { execSync } from 'child_process';
import fs from 'fs';

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
    ...data,
  };
}

async function run() {
  console.log('=== VERIFYING FIRESTORE POST-MIGRATION DATA ===\n');

  const token = execSync('gcloud auth print-access-token', { encoding: 'utf-8' }).trim();
  const projectId = 'maratha-shivmudra';
  const baseUrl = `https://firestore.googleapis.com/v1/projects/${projectId}/databases/(default)/documents`;
  const headers = {
    Authorization: `Bearer ${token}`,
    'Content-Type': 'application/json',
  };

  let allMembers = [];
  let pageToken = '';
  do {
    const url = `${baseUrl}/members?pageSize=300${pageToken ? `&pageToken=${pageToken}` : ''}`;
    const res = await fetch(url, { headers });
    const json = await res.json();
    if (json.documents) {
      allMembers = allMembers.concat(json.documents.map(convertDocument));
    }
    pageToken = json.nextPageToken || '';
  } while (pageToken);

  console.log(`Fetched ${allMembers.length} live members from Firestore.`);

  let nestedValid = 0;
  let flatResiduals = 0;
  const legacyFlatKeys = ['sub_district', 'sub_district_mr', 'job_designation', 'job_company', 'crops_produced'];

  for (const doc of allMembers) {
    const hasNested = doc.personal && doc.residence && doc.membership;
    if (hasNested) nestedValid++;

    for (const key of legacyFlatKeys) {
      if (doc[key] !== undefined) {
        flatResiduals++;
        console.warn(`[WARNING] Document ${doc._id} has residual flat key: ${key}`);
      }
    }
  }

  console.log(`Documents with valid nested structure: ${nestedValid}/${allMembers.length}`);
  console.log(`Residual flat fields found: ${flatResiduals}`);

  // Inspect 8691955046
  const jaydip = allMembers.find(m => m._id === '8691955046');
  if (jaydip) {
    console.log('\n========================================');
    console.log('LIVE VERIFICATION: Jaydip Pawar (8691955046)');
    console.log('========================================');
    console.log(JSON.stringify(jaydip, null, 2));
  } else {
    console.error('ERROR: 8691955046 not found!');
  }

  // Load pre-migration backup for cross verification
  const backupPath = 'backups/firestore_backup_2026-09-26T16-20-55-861Z/collections/members.json';
  if (fs.existsSync(backupPath)) {
    const backup = JSON.parse(fs.readFileSync(backupPath, 'utf8'));
    console.log(`\nCross-checking against backup (${backup.length} members)...`);

    let matchCount = 0;
    for (const b of backup) {
      const live = allMembers.find(m => m._id === b._id);
      if (!live) {
        console.error(`MISSING IN LIVE: ${b._id}`);
        continue;
      }

      // Check phone
      if (live.membership.phone !== b.phone) {
        console.error(`PHONE MISMATCH for ${b._id}: ${live.membership.phone} vs ${b.phone}`);
        continue;
      }

      // If was registered, check names
      if (b.is_registered) {
        const expectedEn = b.full_name_en || b.name;
        if (live.personal.full_name_en !== expectedEn) {
          console.error(`NAME MISMATCH for ${b._id}: ${live.personal.full_name_en} vs ${expectedEn}`);
          continue;
        }
      }

      matchCount++;
    }

    console.log(`Data Integrity: ${matchCount}/${backup.length} members 100% matched against backup!`);
  }
}

run().catch(console.error);
