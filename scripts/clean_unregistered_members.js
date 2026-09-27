import { execSync } from 'child_process';

function toFirestoreValue(val) {
  if (val === null || val === undefined) return { nullValue: null };
  if (typeof val === 'string') return { stringValue: val };
  if (typeof val === 'boolean') return { booleanValue: val };
  if (typeof val === 'number') {
    if (Number.isInteger(val)) return { integerValue: val.toString() };
    return { doubleValue: val };
  }
  if (Array.isArray(val)) {
    return { arrayValue: { values: val.map(toFirestoreValue) } };
  }
  if (typeof val === 'object') {
    const fields = {};
    for (const [k, v] of Object.entries(val)) {
      if (v !== undefined) fields[k] = toFirestoreValue(v);
    }
    return { mapValue: { fields } };
  }
  return { stringValue: String(val) };
}

function generateSearchTokens(phone) {
  const tokens = new Set();
  tokens.add(phone);
  for (let i = 2; i <= phone.length; i++) {
    tokens.add(phone.substring(0, i));
  }
  tokens.add('pending');
  return Array.from(tokens);
}

async function run() {
  console.log('=== CLEANING UNREGISTERED (OTP-ONLY) MEMBERS ===\n');

  const token = execSync('gcloud auth print-access-token', { encoding: 'utf-8' }).trim();
  const projectId = 'maratha-shivmudra';
  const baseUrl = `https://firestore.googleapis.com/v1/projects/${projectId}/databases/(default)/documents`;
  const headers = {
    Authorization: `Bearer ${token}`,
    'Content-Type': 'application/json',
  };

  const unregisteredPhones = [
    '7020153086',
    '7021189309',
    '7276366212',
    '7796761089',
    '8108686839',
    '9146561905',
    '9172819496',
    '9527233313',
    '9561848243',
    '9767710243',
    '9960822426',
  ];

  console.log(`Cleaning ${unregisteredPhones.length} unregistered accounts...`);

  const writes = unregisteredPhones.map(phone => {
    const cleanDoc = {
      membership: {
        phone,
        member_id: 'PENDING',
        referral_id: 'NONE',
        role_type: 'member',
        designation: '',
        is_registered: false,
        is_profile_complete: false,
        is_card_issued: false,
        is_valid: true,
      },
      search_tokens: generateSearchTokens(phone),
      updated_at: new Date().toISOString(),
    };

    const fields = {};
    for (const [k, v] of Object.entries(cleanDoc)) {
      fields[k] = toFirestoreValue(v);
    }

    return {
      update: {
        name: `projects/${projectId}/databases/(default)/documents/members/${phone}`,
        fields,
      },
    };
  });

  const commitRes = await fetch(`${baseUrl}:commit`, {
    method: 'POST',
    headers,
    body: JSON.stringify({ writes }),
  });

  if (!commitRes.ok) {
    throw new Error(`Failed to commit clean unregistered members: ${await commitRes.text()}`);
  }

  console.log('SUCCESS: All 11 unregistered accounts cleaned successfully!');
}

run().catch(console.error);
