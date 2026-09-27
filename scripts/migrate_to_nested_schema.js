import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';

// Helper to convert native JS values to Firestore REST API typed values
function toFirestoreValue(val) {
  if (val === null || val === undefined) {
    return { nullValue: null };
  }
  if (typeof val === 'string') {
    return { stringValue: val };
  }
  if (typeof val === 'boolean') {
    return { booleanValue: val };
  }
  if (typeof val === 'number') {
    if (Number.isInteger(val)) {
      return { integerValue: val.toString() };
    }
    return { doubleValue: val };
  }
  if (Array.isArray(val)) {
    return {
      arrayValue: {
        values: val.map(toFirestoreValue),
      },
    };
  }
  if (typeof val === 'object') {
    const fields = {};
    for (const [k, v] of Object.entries(val)) {
      if (v !== undefined) {
        fields[k] = toFirestoreValue(v);
      }
    }
    return {
      mapValue: { fields },
    };
  }
  return { stringValue: String(val) };
}

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

function generateSearchTokens({ nameEn, nameMr, phone, memberId, district, taluka, village }) {
  const tokens = new Set();
  function addTokenParts(text) {
    if (!text || typeof text !== 'string') return;
    const clean = text.trim().toLowerCase();
    if (!clean) return;
    tokens.add(clean);
    const parts = clean.split(/[\s\-_,()]+/);
    for (const part of parts) {
      if (part) {
        tokens.add(part);
        for (let i = 2; i <= part.length; i++) {
          tokens.add(part.substring(0, i));
        }
      }
    }
  }
  addTokenParts(nameEn);
  addTokenParts(nameMr);
  addTokenParts(phone);
  addTokenParts(memberId);
  if (district) addTokenParts(district);
  if (taluka) addTokenParts(taluka);
  if (village) addTokenParts(village);
  return Array.from(tokens);
}

function normalizeOccupation(raw) {
  const occRaw = (raw || '').trim();
  const occLower = occRaw.toLowerCase();
  const isUnemployed = occLower.includes('बेरोजगार') || occLower.includes('unemployed') || occLower.includes('शोधत');
  const isSelfEmployed = occLower.includes('स्वयंरोजगार') || occLower.includes('self-employed');
  const isJob = (occLower.includes('नोकरी') || occLower.includes('employed') || occLower === 'job') && !isUnemployed;
  const isBusiness = occLower.includes('व्यवसाय') || occLower.includes('business');
  const isStudent = occLower.includes('विद्यार्थी') || occLower.includes('student') || occLower.includes('शिक्षण');
  const isFarmer = occLower.includes('शेती') || occLower.includes('farmer') || occLower.includes('शेतकरी');
  const isRetired = occLower.includes('निवृत्त') || occLower.includes('retired');
  const isHomemaker = occLower.includes('गृह') || occLower.includes('homemaker');

  let category = 'other';
  if (isSelfEmployed) category = 'self_employed';
  else if (isJob) category = 'job';
  else if (isBusiness) category = 'business';
  else if (isStudent) category = 'student';
  else if (isFarmer) category = 'farmer';
  else if (isUnemployed) category = 'unemployed';
  else if (isRetired) category = 'retired';
  else if (isHomemaker) category = 'homemaker';

  return { category, category_mr: occRaw, isJob, isBusiness, isStudent, isFarmer, isUnemployed, isSelfEmployed };
}

function transformMember(oldDoc) {
  const phone = oldDoc._id || oldDoc.phone;

  // Extract nested or flat
  const p = oldDoc.personal || {};
  const r = oldDoc.residence || {};
  const n = oldDoc.native_place || {};
  const o = oldDoc.occupation || {};
  const em = oldDoc.emergency || {};
  const af = oldDoc.affiliations || {};
  const pl = oldDoc.pledges || {};
  const off = oldDoc.official || {};
  const med = oldDoc.media || {};
  const mem = oldDoc.membership || {};

  const fEn = p.first_name_en || oldDoc.first_name_en || oldDoc.first_name || '';
  const mEn = p.middle_name_en || oldDoc.middle_name_en || oldDoc.middle_name || '';
  const lEn = p.last_name_en || oldDoc.last_name_en || oldDoc.last_name || '';
  const fMr = p.first_name_mr || oldDoc.first_name_mr || '';
  const mMr = p.middle_name_mr || oldDoc.middle_name_mr || '';
  const lMr = p.last_name_mr || oldDoc.last_name_mr || '';

  const fullEn = p.full_name_en || oldDoc.full_name_en || oldDoc.name || [fEn, mEn, lEn].filter(Boolean).join(' ');
  const fullMr = p.full_name_mr || oldDoc.full_name_mr || oldDoc.name_mr || [fMr, mMr, lMr].filter(Boolean).join(' ');

  const dob = p.date_of_birth || oldDoc.date_of_birth || '';
  const gender = p.gender || (oldDoc.gender && oldDoc.gender !== 'Male' ? oldDoc.gender : null);
  const email = p.email || oldDoc.email || '';
  const livingStatus = p.living_status || oldDoc.living_status || null;

  // Residence
  const addrEn = r.address_en || oldDoc.address_en || oldDoc.address || '';
  const addrMr = r.address_mr || oldDoc.address_mr || '';
  const villEn = r.village_en || oldDoc.village_en || oldDoc.village || '';
  const villMr = r.village_mr || oldDoc.village_mr || '';
  const talEn = r.taluka_en || oldDoc.taluka_en || oldDoc.taluka || oldDoc.sub_district || '';
  const talMr = r.taluka_mr || oldDoc.taluka_mr || oldDoc.sub_district_mr || '';
  const distEn = r.district_en || oldDoc.district_en || oldDoc.district || 'Pune';
  const distMr = r.district_mr || oldDoc.district_mr || 'पुणे';
  const distCode = r.district_code || oldDoc.district_code || 'PUN';
  const stateEn = r.state_en || oldDoc.state_en || oldDoc.state || 'Maharashtra';
  const stateMr = r.state_mr || oldDoc.state_mr || 'महाराष्ट्र';
  const stateCode = r.state_code || oldDoc.state_code || 'MH';
  const pincode = r.pincode || oldDoc.pincode || '';

  // Native Place
  const isSame = n.is_same_as_current !== undefined ? n.is_same_as_current : (oldDoc.is_native_address_same !== undefined ? oldDoc.is_native_address_same : false);
  const nativeMap = {
    is_same_as_current: Boolean(isSame),
  };
  if (!isSame) {
    nativeMap.address = n.address || oldDoc.native_address || null;
    nativeMap.village = n.village || oldDoc.native_village || null;
    nativeMap.taluka = n.taluka || oldDoc.native_taluka || null;
    nativeMap.district = n.district || oldDoc.native_district || null;
    nativeMap.state = n.state || oldDoc.native_state || null;
    nativeMap.state_code = n.state_code || oldDoc.native_state_code || null;
    nativeMap.pincode = n.pincode || oldDoc.native_pincode || null;
  }

  // Occupation
  const occRaw = o.category_mr || oldDoc.profession || oldDoc.living || '';
  const normOcc = normalizeOccupation(occRaw);
  const occMap = {
    category: o.category || normOcc.category,
    category_mr: normOcc.category_mr,
  };

  const jobDetails = o.job_details || {};
  const jobDesig = jobDetails.designation || oldDoc.job_designation || '';
  const jobComp = jobDetails.company || oldDoc.job_company || '';
  if (normOcc.isJob || normOcc.isSelfEmployed || jobDesig || jobComp) {
    if (jobDesig || jobComp || !normOcc.isSelfEmployed) {
      occMap.job_details = {
        designation: jobDesig,
        company: jobComp,
      };
    }
  }

  const busDetails = o.business_details || {};
  const busType = busDetails.business_type || oldDoc.business_type || '';
  if (normOcc.isBusiness || normOcc.isSelfEmployed || busType) {
    if (busType || !normOcc.isSelfEmployed) {
      occMap.business_details = {
        business_type: busType,
      };
    }
  }

  const stuDetails = o.student_details || {};
  const stuQual = stuDetails.qualification || oldDoc.education_level || oldDoc.education || '';
  const stuOther = stuDetails.qualification_other || oldDoc.education_other || '';
  if (normOcc.isStudent || stuQual || stuOther) {
    occMap.student_details = {
      qualification: stuQual,
      qualification_other: stuOther,
    };
  }

  const farmDetails = o.farming_details || {};
  let crops = farmDetails.crops_produced || oldDoc.crops_produced || [];
  if (typeof crops === 'string' && crops) crops = crops.split(',').map(s => s.trim());
  if (!Array.isArray(crops)) crops = [];
  if (normOcc.isFarmer || crops.length > 0) {
    occMap.farming_details = {
      crops_produced: crops,
    };
  }

  const unempDetails = o.unemployed_details || {};
  const unempEdu = unempDetails.highest_qualification || oldDoc.unemployed_education || '';
  const unempSec = unempDetails.preferred_sector || oldDoc.unemployed_preferred_sector || '';
  const unempSkills = unempDetails.skills_and_licenses || oldDoc.unemployed_skills || '';
  const unempReloc = unempDetails.willing_to_relocate !== undefined ? unempDetails.willing_to_relocate : (oldDoc.willing_to_relocate !== undefined ? oldDoc.willing_to_relocate : null);
  if (normOcc.isUnemployed || unempEdu || unempSec || unempSkills) {
    occMap.unemployed_details = {
      highest_qualification: unempEdu,
      preferred_sector: unempSec,
      skills_and_licenses: unempSkills,
      willing_to_relocate: unempReloc !== null ? unempReloc : true,
    };
  }

  // Emergency
  const emergencyMap = {
    blood_group: em.blood_group || oldDoc.blood_group || null,
    contact_name: em.contact_name || oldDoc.emergency_contact_name || null,
    contact_phone: em.contact_phone || oldDoc.emergency_contact_phone || null,
  };

  // Affiliations
  const isPol = af.is_politically_active !== undefined ? af.is_politically_active : (oldDoc.is_politically_active !== undefined ? oldDoc.is_politically_active : null);
  const isNgo = af.is_associated_with_ngo !== undefined ? af.is_associated_with_ngo : (oldDoc.is_associated_with_ngo !== undefined ? oldDoc.is_associated_with_ngo : null);
  const affiliationsMap = {
    is_politically_active: isPol,
    is_associated_with_ngo: isNgo,
  };
  if (isPol === true) {
    affiliationsMap.political_party = af.political_party || oldDoc.political_party || '';
    affiliationsMap.political_role = af.political_role || oldDoc.political_role || '';
  }
  if (isNgo === true) {
    affiliationsMap.ngo_name = af.ngo_name || oldDoc.ngo_name || '';
    affiliationsMap.ngo_role = af.ngo_role || oldDoc.ngo_role || '';
  }

  // Pledges
  const isOrgan = pl.is_organ_donor_pledged !== undefined ? pl.is_organ_donor_pledged : (oldDoc.is_organ_donor_pledged !== undefined ? oldDoc.is_organ_donor_pledged : false);
  const hasOrgan = pl.has_answered_organ_donation !== undefined ? pl.has_answered_organ_donation : (oldDoc.has_organ_donation_answered !== undefined ? oldDoc.has_organ_donation_answered : (isOrgan !== false));
  const pledgesMap = {
    has_answered_organ_donation: Boolean(hasOrgan),
    is_organ_donor_pledged: Boolean(isOrgan),
  };

  // Official
  const isOff = off.is_official !== undefined ? off.is_official : (oldDoc.is_official !== undefined ? oldDoc.is_official : false);
  const officialMap = {
    is_official: Boolean(isOff),
  };
  if (isOff) {
    officialMap.level = off.level || oldDoc.official_level || null;
    officialMap.role_code = off.role_code || oldDoc.official_role_code || null;
    officialMap.role_name_mr = off.role_name_mr || oldDoc.official_role_mr || null;
    officialMap.role_name_en = off.role_name_en || oldDoc.official_role_en || null;
    officialMap.full_title_mr = off.full_title_mr || oldDoc.official_full_title_mr || null;
    officialMap.full_title_en = off.full_title_en || oldDoc.official_full_title_en || null;
    officialMap.jurisdiction_vibhag = off.jurisdiction_vibhag || oldDoc.official_vibhag || null;
    officialMap.jurisdiction_district = off.jurisdiction_district || oldDoc.official_district || null;
    officialMap.jurisdiction_taluka = off.jurisdiction_taluka || oldDoc.official_taluka || null;
    if (off.appointment_date || oldDoc.official_appointment_date) {
      officialMap.appointment_date = off.appointment_date || oldDoc.official_appointment_date;
    }
  }

  // Media
  const mediaMap = {
    photo_base64: med.photo_base64 || oldDoc.photo_base64 || oldDoc.photo || null,
    photo_url: med.photo_url || oldDoc.photo_url || null,
  };

  // Membership
  const memberId = mem.member_id || oldDoc.member_id || 'PENDING';
  const isCard = mem.is_card_issued !== undefined ? mem.is_card_issued : (oldDoc.is_card_issued !== undefined ? oldDoc.is_card_issued : (memberId !== 'PENDING' && memberId.trim() !== ''));
  const isReg = mem.is_registered !== undefined ? mem.is_registered : (oldDoc.is_registered !== undefined ? oldDoc.is_registered : true);
  const isProf = mem.is_profile_complete !== undefined ? mem.is_profile_complete : (oldDoc.is_profile_complete !== undefined ? oldDoc.is_profile_complete : false);
  const isProm = mem.is_promoted !== undefined ? mem.is_promoted : (oldDoc.is_promoted !== undefined ? oldDoc.is_promoted : false);
  const isValid = mem.is_valid !== undefined ? mem.is_valid : (oldDoc.is_valid !== undefined ? oldDoc.is_valid : true);

  const membershipMap = {
    phone,
    member_id: memberId,
    referral_id: mem.referral_id || oldDoc.referral_id || 'NONE',
    role_type: mem.role_type || oldDoc.role_type || 'member',
    designation: mem.designation || oldDoc.designation || '',
    is_registered: Boolean(isReg),
    is_profile_complete: Boolean(isProf),
    is_card_issued: Boolean(isCard),
    card_issued_date: mem.card_issued_date || oldDoc.card_issued_date || null,
    is_promoted: Boolean(isProm),
    is_valid: Boolean(isValid),
  };
  if (oldDoc.serial_number !== undefined) {
    membershipMap.serial_number = oldDoc.serial_number;
  }

  const searchTokens = generateSearchTokens({
    nameEn: fullEn,
    nameMr: fullMr,
    phone,
    memberId,
    district: distEn,
    taluka: talEn,
    village: `${villEn} ${villMr}`.trim(),
  });

  return {
    personal: {
      first_name_en: fEn,
      first_name_mr: fMr,
      middle_name_en: mEn,
      middle_name_mr: mMr,
      last_name_en: lEn,
      last_name_mr: lMr,
      full_name_en: fullEn,
      full_name_mr: fullMr,
      date_of_birth: dob,
      gender,
      email,
      living_status: livingStatus,
    },
    residence: {
      address_en: addrEn,
      address_mr: addrMr,
      village_en: villEn,
      village_mr: villMr,
      taluka_en: talEn,
      taluka_mr: talMr,
      district_en: distEn,
      district_mr: distMr,
      district_code: distCode,
      state_en: stateEn,
      state_mr: stateMr,
      state_code: stateCode,
      pincode,
    },
    native_place: nativeMap,
    occupation: occMap,
    emergency: emergencyMap,
    affiliations: affiliationsMap,
    pledges: pledgesMap,
    official: officialMap,
    media: mediaMap,
    membership: membershipMap,
    search_tokens: searchTokens,
    created_at: oldDoc.created_at || oldDoc._createTime || new Date().toISOString(),
    updated_at: new Date().toISOString(),
  };
}

async function run() {
  const isDryRun = process.argv.includes('--dry-run');
  console.log(`=== FIRESTORE MIGRATION TO CLEAN NESTED SCHEMA ===`);
  console.log(`Mode: ${isDryRun ? 'DRY-RUN (No writes)' : 'LIVE COMMIT'}`);

  console.log('\n--- Step 1: Getting gcloud Auth Token ---');
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

  console.log('--- Step 2: Fetching all documents from `members` collection ---');
  let allMembers = [];
  let pageToken = '';
  do {
    const url = `${baseUrl}/members?pageSize=300${pageToken ? `&pageToken=${pageToken}` : ''}`;
    const res = await fetch(url, { headers });
    if (!res.ok) {
      throw new Error(`Failed to list members: ${res.status} ${await res.text()}`);
    }
    const json = await res.json();
    if (json.documents) {
      allMembers = allMembers.concat(json.documents.map(convertDocument));
    }
    pageToken = json.nextPageToken || '';
  } while (pageToken);

  console.log(`Successfully fetched ${allMembers.length} member documents from Firestore.`);

  console.log('--- Step 3: Transforming documents into clean nested structure ---');
  const transformedList = allMembers.map(doc => ({
    phone: doc._id || doc.phone,
    docPath: doc._path,
    original: doc,
    transformed: transformMember(doc),
  }));

  // Inspect Jaydip's document specifically
  const jaydip = transformedList.find(m => m.phone === '8691955046');
  if (jaydip) {
    console.log('\n--- Sample Verification: Jaydip Pawar (8691955046) ---');
    console.log(JSON.stringify(jaydip.transformed, null, 2));
  }

  // Pre-flight validation on all 118 documents
  console.log('\n--- Step 4: Validating transformations ---');
  let registeredCount = 0;
  let unregisteredCount = 0;

  for (const item of transformedList) {
    const t = item.transformed;
    if (!t.membership.phone) throw new Error(`Missing phone for ${item.phone}`);
    if (t.membership.is_registered) {
      registeredCount++;
      if (!t.personal.full_name_en && !t.personal.full_name_mr) throw new Error(`Missing name for registered member ${item.phone}`);
      if (!t.residence.district_en) throw new Error(`Missing district for registered member ${item.phone}`);
      if (!t.residence.taluka_en) throw new Error(`Missing taluka for registered member ${item.phone}`);
    } else {
      unregisteredCount++;
    }
    if (!Array.isArray(t.search_tokens) || t.search_tokens.length === 0) throw new Error(`Missing search_tokens for ${item.phone}`);
  }
  console.log(`All ${transformedList.length} documents passed structural validation! (${registeredCount} registered, ${unregisteredCount} unregistered/pending)`);

  if (isDryRun) {
    console.log('\n[DRY RUN COMPLETE] No writes made to Firestore.');
    return;
  }

  console.log('\n--- Step 5: Executing Batch Writes to Firestore ---');
  // Write in batches of up to 50 documents
  const BATCH_SIZE = 50;
  let committedCount = 0;

  for (let i = 0; i < transformedList.length; i += BATCH_SIZE) {
    const chunk = transformedList.slice(i, i + BATCH_SIZE);
    const writes = chunk.map(item => {
      // In Firestore REST API, an update without updateMask replaces the document fields completely!
      const fields = {};
      for (const [k, v] of Object.entries(item.transformed)) {
        fields[k] = toFirestoreValue(v);
      }
      return {
        update: {
          name: `projects/${projectId}/databases/(default)/documents/members/${item.phone}`,
          fields,
        },
      };
    });

    const commitUrl = `https://firestore.googleapis.com/v1/projects/${projectId}/databases/(default)/documents:commit`;
    const commitRes = await fetch(commitUrl, {
      method: 'POST',
      headers,
      body: JSON.stringify({ writes }),
    });

    if (!commitRes.ok) {
      const err = await commitRes.text();
      throw new Error(`Batch commit failed at chunk ${i}-${i + chunk.length}: ${err}`);
    }

    committedCount += chunk.length;
    console.log(`Committed ${committedCount}/${transformedList.length} documents...`);
  }

  console.log(`\nSUCCESS: Successfully migrated all ${committedCount} members to clean nested schema!`);
}

run().catch(err => {
  console.error('FATAL ERROR:', err);
  process.exit(1);
});
