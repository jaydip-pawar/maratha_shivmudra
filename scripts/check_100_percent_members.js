import { execSync } from 'child_process';

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

function calculateCompletion(m) {
  let score = 0;
  const missing = [];

  const personal = m.personal || {};
  const residence = m.residence || {};
  const media = m.media || {};
  const emergency = m.emergency || {};
  const native = m.native_place || {};
  const affiliations = m.affiliations || {};
  const pledges = m.pledges || {};
  const occ = m.occupation || {};

  // 1. Basic Info (15%)
  const hasName = (personal.full_name_mr || personal.full_name_en || personal.first_name_mr || personal.first_name_en || m.name || m.name_mr || m.first_name);
  const hasDob = personal.date_of_birth || m.date_of_birth || m.dateOfBirth;
  if (hasName && hasDob) {
    score += 15;
  } else {
    missing.push('Basic Info (Name/DOB)');
  }

  // 2. Current Address (15%)
  const dist = residence.district_en || residence.district || m.district_en || m.district;
  const taluka = residence.taluka_en || residence.taluka || m.taluka_en || m.sub_district || m.subDistrict;
  const addr = residence.address_en || residence.address_mr || residence.address || m.address || m.address_mr;
  const pin = residence.pincode || m.pincode;
  if (dist && taluka && addr && pin) {
    score += 15;
  } else {
    missing.push('Current Address (Dist/Tal/Addr/Pin)');
  }

  // 3. Photo (15%)
  const photo = media.photo_base64 || media.photo_url || m.photo_base64 || m.photo_url || m.photoUrl;
  if (photo && photo.length > 0) {
    score += 15;
  } else {
    missing.push('Photo');
  }

  // 4. Blood Group (10%)
  const bg = emergency.blood_group || m.blood_group || m.bloodGroup;
  if (bg && bg.trim().length > 0) {
    score += 10;
  } else {
    missing.push('Blood Group');
  }

  // 5. Emergency Contact (10%)
  const eName = emergency.contact_name || m.emergency_contact_name || m.emergencyContactName;
  const ePhone = emergency.contact_phone || m.emergency_contact_phone || m.emergencyContactPhone;
  if (eName && eName.trim().length > 0 && ePhone && ePhone.trim().length > 0) {
    score += 10;
  } else {
    missing.push('Emergency Contact');
  }

  // 6. Native Place (10%)
  const isSame = native.is_same_as_current === true || m.is_native_address_same === true;
  const natDist = native.district || native.district_en || m.native_district;
  const natTal = native.taluka || native.taluka_en || m.native_taluka;
  if (isSame || (natDist && natTal)) {
    score += 10;
  } else {
    missing.push('Native Place');
  }

  // 7. Political Status (10%)
  const isPol = affiliations.is_politically_active !== undefined ? affiliations.is_politically_active : m.is_politically_active;
  const polParty = affiliations.political_party || m.political_party || '';
  const polRole = affiliations.political_role || m.political_role || '';
  if (isPol !== null && isPol !== undefined) {
    if (!isPol || (polParty.trim().length > 0 && polRole.trim().length > 0)) {
      score += 10;
    } else {
      missing.push('Political Details (Party/Role)');
    }
  } else {
    missing.push('Political Status (Not Answered)');
  }

  // 8. Social / NGO (5%)
  const isNgo = affiliations.is_associated_with_ngo !== undefined ? affiliations.is_associated_with_ngo : m.is_associated_with_ngo;
  const ngoName = affiliations.ngo_name || m.ngo_name || '';
  const ngoRole = affiliations.ngo_role || m.ngo_role || '';
  if (isNgo !== null && isNgo !== undefined) {
    if (!isNgo || (ngoName.trim().length > 0 && ngoRole.trim().length > 0)) {
      score += 5;
    } else {
      missing.push('NGO Details (Name/Role)');
    }
  } else {
    missing.push('NGO Status (Not Answered)');
  }

  // 9. Organ Donation (5%)
  const hasOrganConsent = pledges.has_answered_organ_donation !== undefined ? pledges.has_answered_organ_donation : (m.has_organ_donation_answered || m.hasOrganDonationConsentAnswered);
  const isOrganPledged = pledges.is_organ_donor_pledged !== undefined ? pledges.is_organ_donor_pledged : (m.is_organ_donor_pledged || m.isOrganDonorPledged);
  if (hasOrganConsent || isOrganPledged) {
    score += 5;
  } else {
    missing.push('Organ Donation Pledge');
  }

  // 10. Occupation Details (5%)
  const occCategory = (occ.category_mr || occ.category || m.profession || m.living || '').toLowerCase();
  if (occCategory.length > 0) {
    score += 5;
  } else {
    missing.push('Occupation');
  }

  return { score, missing };
}

async function run() {
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

  console.log(`\n========================================`);
  console.log(`TOTAL MEMBERS FETCHED: ${allMembers.length}`);
  console.log(`========================================\n`);

  const membersWithAssignedId = [];
  const members100Percent = [];
  const scoreBuckets = {
    '100%': [],
    '85-99%': [],
    '50-84%': [],
    'below 50%': []
  };

  for (const m of allMembers) {
    const mem = m.membership || {};
    const memberId = mem.member_id || m.member_id;
    const isAssigned = memberId && memberId !== 'PENDING' && memberId !== 'NONE' && memberId.trim().length > 0;

    const { score, missing } = calculateCompletion(m);

    const name = (m.personal && m.personal.full_name_en) || m.name || m.full_name_en || m._id;
    const phone = m._id;

    const summary = {
      phone,
      name,
      score: `${score}%`,
      memberId: memberId || 'None',
      isCardIssued: mem.is_card_issued ?? m.is_card_issued ?? false,
      missing,
    };

    if (isAssigned) {
      membersWithAssignedId.push(summary);
    }

    if (score === 100) {
      members100Percent.push(summary);
      scoreBuckets['100%'].push(summary);
    } else if (score >= 85) {
      scoreBuckets['85-99%'].push(summary);
    } else if (score >= 50) {
      scoreBuckets['50-84%'].push(summary);
    } else {
      scoreBuckets['below 50%'].push(summary);
    }
  }

  console.log(`\n--- 1. MEMBERS WITH 100% COMPLETION (${members100Percent.length}) ---`);
  if (members100Percent.length === 0) {
    console.log('No members found with 100% completion.');
  } else {
    console.log(JSON.stringify(members100Percent, null, 2));
  }

  console.log(`\n--- 2. MEMBERS WITH MEMBER ID ASSIGNED (${membersWithAssignedId.length}) ---`);
  if (membersWithAssignedId.length === 0) {
    console.log('No members have an assigned member ID (all are PENDING/NONE).');
  } else {
    console.log(JSON.stringify(membersWithAssignedId, null, 2));
  }

  console.log(`\n--- 3. COMPLETION SCORE DISTRIBUTION ---`);
  console.log(`100%: ${scoreBuckets['100%'].length}`);
  console.log(`85-99%: ${scoreBuckets['85-99%'].length}`);
  console.log(`50-84%: ${scoreBuckets['50-84%'].length}`);
  console.log(`Below 50%: ${scoreBuckets['below 50%'].length}`);

  console.log(`\n--- 4. TOP HIGHEST SCORING MEMBERS (85-99%) ---`);
  for (const item of scoreBuckets['85-99%']) {
    console.log(`- ${item.name} (${item.phone}): ${item.score} | MemberID: ${item.memberId} | Missing: ${item.missing.join(', ')}`);
  }
}

run().catch(console.error);
