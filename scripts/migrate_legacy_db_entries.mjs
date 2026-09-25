import { execSync } from 'child_process';

const token = execSync('gcloud auth print-access-token', { encoding: 'utf-8' }).trim();
const projectId = 'maratha-shivmudra';
const baseUrl = `https://firestore.googleapis.com/v1/projects/${projectId}/databases/(default)/documents`;
const headers = {
  Authorization: `Bearer ${token}`,
  'Content-Type': 'application/json',
};

function normalizeDigits(str) {
  if (!str) return '';
  const devanagariDigits = ['०', '१', '२', '३', '४', '५', '६', '७', '८', '९'];
  let res = str.toString();
  for (let i = 0; i < 10; i++) {
    res = res.replaceAll(devanagariDigits[i], i.toString());
  }
  return res.trim();
}

function generateSearchTokens(fields) {
  const set = new Set();
  for (const f of fields) {
    if (!f) continue;
    const clean = f.toString().trim().toLowerCase();
    if (!clean) continue;
    set.add(clean);
    const parts = clean.split(/[\s\-_,()]+/);
    for (const p of parts) {
      if (!p) continue;
      set.add(p);
      for (let len = 2; len <= p.length; len++) {
        set.add(p.substring(0, len));
      }
    }
  }
  return Array.from(set);
}

function toFirestoreValue(val) {
  if (val === null || val === undefined) return { nullValue: null };
  if (typeof val === 'boolean') return { booleanValue: val };
  if (typeof val === 'number') {
    if (Number.isInteger(val)) return { integerValue: val.toString() };
    return { doubleValue: val };
  }
  if (typeof val === 'string') return { stringValue: val };
  if (Array.isArray(val)) {
    return { arrayValue: { values: val.map(toFirestoreValue) } };
  }
  if (typeof val === 'object') {
    const fields = {};
    for (const [k, v] of Object.entries(val)) {
      fields[k] = toFirestoreValue(v);
    }
    return { mapValue: { fields } };
  }
  return { stringValue: String(val) };
}

function toFirestoreFields(obj) {
  const fields = {};
  for (const [k, v] of Object.entries(obj)) {
    fields[k] = toFirestoreValue(v);
  }
  return fields;
}

// 1. Data definitions for the 3 legacy records
const legacyProfiles = [
  {
    phone: '8275902460',
    first_name_en: 'Rina',
    middle_name_en: 'Kiran',
    last_name_en: 'Ganjale',
    full_name_en: 'Rina Kiran Ganjale',
    name: 'Rina Kiran Ganjale',
    first_name_mr: 'रिना',
    middle_name_mr: 'किरण',
    last_name_mr: 'गांजाळे',
    full_name_mr: 'रिना किरण गांजाळे',
    name_mr: 'रिना किरण गांजाळे',
    gender: 'Female',
    date_of_birth: '1990-11-08',
    living: 'गृहपालक',
    profession: 'गृहपालक',
    email: '',
    address: 'तळेगाव दाभाडे',
    village: 'तळेगाव दाभाडे',
    city: 'तळेगाव',
    pincode: '410507',
    state: 'Maharashtra',
    state_code: 'MH',
    state_en: 'Maharashtra',
    state_mr: 'महाराष्ट्र',
    district: 'Pune',
    district_code: 'PUN',
    district_en: 'Pune',
    district_mr: 'पुणे',
    sub_district: 'Maval',
    sub_district_mr: 'मावळ',
    taluka: 'Maval',
    taluka_en: 'Maval',
    taluka_mr: 'मावळ',
    referral_id: 'NONE',
    member_id: 'PENDING',
    role_type: 'member',
    designation: '',
    blood_group: '',
    emergency_contact_name: '',
    emergency_contact_phone: '',
    job_designation: '',
    job_company: '',
    business_type: '',
    education_level: '',
    education_other: '',
    education: '',
    crops_produced: [],
    unemployed_education: '',
    unemployed_preferred_sector: '',
    unemployed_skills: '',
    is_card_issued: false,
    is_profile_complete: false,
    is_registered: true,
    is_valid: true,
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString(),
  },
  {
    phone: '8788516327',
    first_name_en: 'Sushant',
    middle_name_en: 'Suresh',
    last_name_en: 'Sawant',
    full_name_en: 'Sushant Suresh Sawant',
    name: 'Sushant Suresh Sawant',
    first_name_mr: 'सुशांत',
    middle_name_mr: 'सुरेश',
    last_name_mr: 'सावंत',
    full_name_mr: 'सुशांत सुरेश सावंत',
    name_mr: 'सुशांत सुरेश सावंत',
    gender: 'Male',
    date_of_birth: '1990-01-28',
    living: 'नोकरी',
    profession: 'नोकरी',
    email: 'sushantsawant268@gmail.com',
    address: 'limb',
    village: 'limb',
    city: 'satara',
    pincode: '415015',
    state: 'Maharashtra',
    state_code: 'MH',
    state_en: 'Maharashtra',
    state_mr: 'महाराष्ट्र',
    district: 'Satara',
    district_code: 'SAT',
    district_en: 'Satara',
    district_mr: 'सातारा',
    sub_district: 'Satara',
    sub_district_mr: 'सातारा',
    taluka: 'Satara',
    taluka_en: 'Satara',
    taluka_mr: 'सातारा',
    referral_id: 'NONE',
    member_id: 'PENDING',
    role_type: 'member',
    designation: '',
    blood_group: '',
    emergency_contact_name: '',
    emergency_contact_phone: '',
    job_designation: '',
    job_company: '',
    business_type: '',
    education_level: '',
    education_other: '',
    education: '',
    crops_produced: [],
    unemployed_education: '',
    unemployed_preferred_sector: '',
    unemployed_skills: '',
    is_card_issued: false,
    is_profile_complete: false,
    is_registered: true,
    is_valid: true,
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString(),
  },
  {
    phone: '9370763443',
    first_name_en: 'Abhiman',
    middle_name_en: 'Bhikan',
    last_name_en: 'Nikam',
    full_name_en: 'Abhiman Bhikan Nikam',
    name: 'Abhiman Bhikan Nikam',
    first_name_mr: 'अभिमन',
    middle_name_mr: 'भिकन',
    last_name_mr: 'निकम',
    full_name_mr: 'अभिमन भिकन निकम',
    name_mr: 'अभिमन भिकन निकम',
    gender: 'Male',
    date_of_birth: '1969-11-01',
    living: 'शेती',
    profession: 'शेती',
    email: '',
    address: 'पाळे खुर्द.',
    village: 'पाळे खुर्द',
    city: 'पाळे खुर्द',
    pincode: '423501',
    state: 'Maharashtra',
    state_code: 'MH',
    state_en: 'Maharashtra',
    state_mr: 'महाराष्ट्र',
    district: 'Nashik',
    district_code: 'NSK',
    district_en: 'Nashik',
    district_mr: 'नाशिक',
    sub_district: 'Kalwan',
    sub_district_mr: 'कळवण',
    taluka: 'Kalwan',
    taluka_en: 'Kalwan',
    taluka_mr: 'कळवण',
    referral_id: 'NONE',
    member_id: 'PENDING',
    role_type: 'member',
    designation: '',
    blood_group: '',
    emergency_contact_name: '',
    emergency_contact_phone: '',
    job_designation: '',
    job_company: '',
    business_type: '',
    education_level: '',
    education_other: '',
    education: '',
    crops_produced: [],
    unemployed_education: '',
    unemployed_preferred_sector: '',
    unemployed_skills: '',
    is_card_issued: false,
    is_profile_complete: false,
    is_registered: true,
    is_valid: true,
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString(),
  },
];

async function migrateLegacy() {
  console.log('=== Step 1: Migrating 3 Legacy Root Records into members/ ===');
  for (const prof of legacyProfiles) {
    prof.search_tokens = generateSearchTokens([
      prof.full_name_en,
      prof.full_name_mr,
      prof.first_name_en,
      prof.last_name_en,
      prof.first_name_mr,
      prof.last_name_mr,
      prof.phone,
      prof.member_id,
      prof.district,
      prof.district_en,
      prof.district_mr,
      prof.taluka,
      prof.taluka_en,
      prof.taluka_mr,
    ]);

    const fields = toFirestoreFields(prof);
    const url = `${baseUrl}/members/${prof.phone}`;
    console.log(`Writing member ${prof.phone} (${prof.full_name_en})...`);
    const res = await fetch(url, {
      method: 'PATCH',
      headers,
      body: JSON.stringify({ fields }),
    });

    if (!res.ok) {
      const errText = await res.text();
      console.error(`Failed to write member ${prof.phone}:`, errText);
    } else {
      console.log(`✓ Successfully migrated ${prof.phone} to members/`);
    }
  }

  console.log('\n=== Step 2: Fixing Missing Fields in Existing Registered Members ===');
  // 1. Dinesh Balasaheb Borade (8605474474) -> missing search_tokens
  {
    const phone = '8605474474';
    const tokens = generateSearchTokens([
      'Dinesh Balasaheb Borade',
      'दिनेश बाळासाहेब बोराडे',
      'Dinesh',
      'Borade',
      'दिनेश',
      'बोराडे',
      phone,
      'PENDING',
      'Pune',
      'पुणे',
      'Haveli',
      'हवेली',
    ]);
    const url = `${baseUrl}/members/${phone}?updateMask.fieldPaths=search_tokens&updateMask.fieldPaths=updated_at`;
    const res = await fetch(url, {
      method: 'PATCH',
      headers,
      body: JSON.stringify({
        fields: {
          search_tokens: toFirestoreValue(tokens),
          updated_at: toFirestoreValue(new Date().toISOString()),
        },
      }),
    });
    console.log(`Updated 8605474474 search_tokens: ${res.ok ? 'SUCCESS' : await res.text()}`);
  }

  // 2. Shivbhakta Shubham Subhash Ingole (7498491112) -> Latur, Chakur
  {
    const phone = '7498491112';
    const url = `${baseUrl}/members/${phone}?updateMask.fieldPaths=state_en&updateMask.fieldPaths=state_mr&updateMask.fieldPaths=taluka&updateMask.fieldPaths=taluka_en&updateMask.fieldPaths=taluka_mr&updateMask.fieldPaths=sub_district_mr&updateMask.fieldPaths=updated_at`;
    const res = await fetch(url, {
      method: 'PATCH',
      headers,
      body: JSON.stringify({
        fields: {
          state_en: toFirestoreValue('Maharashtra'),
          state_mr: toFirestoreValue('महाराष्ट्र'),
          taluka: toFirestoreValue('Chakur'),
          taluka_en: toFirestoreValue('Chakur'),
          taluka_mr: toFirestoreValue('चाकूर'),
          sub_district_mr: toFirestoreValue('चाकूर'),
          updated_at: toFirestoreValue(new Date().toISOString()),
        },
      }),
    });
    console.log(`Updated 7498491112 state/taluka: ${res.ok ? 'SUCCESS' : await res.text()}`);
  }

  // 3. Mayur Pawar (8652306970) -> Thane, Kalyan (sub_district is Dombivli/डोंबिवली)
  {
    const phone = '8652306970';
    const url = `${baseUrl}/members/${phone}?updateMask.fieldPaths=state_en&updateMask.fieldPaths=state_mr&updateMask.fieldPaths=taluka&updateMask.fieldPaths=taluka_en&updateMask.fieldPaths=taluka_mr&updateMask.fieldPaths=sub_district_mr&updateMask.fieldPaths=updated_at`;
    const res = await fetch(url, {
      method: 'PATCH',
      headers,
      body: JSON.stringify({
        fields: {
          state_en: toFirestoreValue('Maharashtra'),
          state_mr: toFirestoreValue('महाराष्ट्र'),
          taluka: toFirestoreValue('Kalyan'),
          taluka_en: toFirestoreValue('Kalyan'),
          taluka_mr: toFirestoreValue('कल्याण'),
          sub_district_mr: toFirestoreValue('डोंबिवली'),
          updated_at: toFirestoreValue(new Date().toISOString()),
        },
      }),
    });
    console.log(`Updated 8652306970 state/taluka: ${res.ok ? 'SUCCESS' : await res.text()}`);
  }

  // 4. Jaydip Bhagwan Pawar (8691955046) -> Mumbai City
  {
    const phone = '8691955046';
    const url = `${baseUrl}/members/${phone}?updateMask.fieldPaths=state_en&updateMask.fieldPaths=state_mr&updateMask.fieldPaths=taluka&updateMask.fieldPaths=taluka_en&updateMask.fieldPaths=taluka_mr&updateMask.fieldPaths=sub_district_mr&updateMask.fieldPaths=updated_at`;
    const res = await fetch(url, {
      method: 'PATCH',
      headers,
      body: JSON.stringify({
        fields: {
          state_en: toFirestoreValue('Maharashtra'),
          state_mr: toFirestoreValue('महाराष्ट्र'),
          taluka: toFirestoreValue('Mumbai City'),
          taluka_en: toFirestoreValue('Mumbai City'),
          taluka_mr: toFirestoreValue('मुंबई शहर'),
          sub_district_mr: toFirestoreValue('मुंबई शहर'),
          updated_at: toFirestoreValue(new Date().toISOString()),
        },
      }),
    });
    console.log(`Updated 8691955046 state/taluka: ${res.ok ? 'SUCCESS' : await res.text()}`);
  }

  console.log('\n=== Step 3: Deleting Legacy Root Documents ===');
  const legacyCollections = ['8275902460', '8788516327', '9370763443'];
  for (const col of legacyCollections) {
    for (const doc of ['form_info', 'personal_info']) {
      const docUrl = `${baseUrl}/${col}/${doc}`;
      const res = await fetch(docUrl, { method: 'DELETE', headers });
      console.log(`Deleted ${col}/${doc}: status ${res.status}`);
    }
  }

  console.log('\n=== Migration & Cleanup Complete ===');
}

migrateLegacy().catch(console.error);
