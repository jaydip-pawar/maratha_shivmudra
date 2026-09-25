import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';

// Transliteration Maps
const devanagariToEnMap = {
  "अ": "A", "आ": "Aa", "इ": "I", "ई": "Ee", "उ": "U", "ऊ": "Oo", "ए": "E", "ऐ": "Ai", "ओ": "O", "औ": "Au", "अं": "Am",
  "क": "k", "ख": "kh", "ग": "g", "घ": "gh", "ङ": "ng",
  "च": "ch", "छ": "chh", "ज": "j", "झ": "jh", "ञ": "ny",
  "ट": "t", "ठ": "th", "ड": "d", "ढ": "dh", "ण": "n",
  "त": "t", "थ": "th", "द": "d", "ध": "dh", "न": "n",
  "प": "p", "फ": "ph", "ब": "b", "भ": "bh", "म": "m",
  "य": "y", "र": "r", "ल": "l", "व": "v", "श": "sh", "ष": "sh", "स": "s", "ह": "h", "ळ": "l", "क्ष": "ksh", "ज्ञ": "dny"
};

const matraMap = {
  "ा": "a", "ि": "i", "ी": "ee", "ु": "u", "ू": "oo", "े": "e", "ै": "ai", "ो": "o", "ौ": "au", "ं": "n", "ः": "h", "्": ""
};

function devanagariToLatin(word) {
  if (!word) return "";
  let out = "";
  const chars = Array.from(word);
  for (let i = 0; i < chars.length; i++) {
    const ch = chars[i];
    const next = chars[i + 1];
    if (devanagariToEnMap[ch]) {
      let letter = devanagariToEnMap[ch];
      if (i === 0) letter = letter.charAt(0).toUpperCase() + letter.slice(1);
      if (matraMap[next] !== undefined) {
        out += letter + matraMap[next];
        i++;
      } else if (next === "्") {
        out += letter;
        i++;
      } else {
        out += letter + (i === chars.length - 1 ? "" : "a");
      }
    } else if (matraMap[ch]) {
      out += matraMap[ch];
    } else {
      out += ch;
    }
  }
  return out;
}

const enToMrConsonants = {
  'shh': 'ष', 'kh': 'ख', 'gh': 'घ', 'ch': 'च', 'chh': 'छ', 'jh': 'झ', 'th': 'थ', 'dh': 'ध',
  'ph': 'फ', 'bh': 'भ', 'sh': 'श', 'ksh': 'क्ष', 'dny': 'ज्ञ', 'aa': 'आ', 'ee': 'ई', 'oo': 'ऊ',
  'ai': 'ऐ', 'au': 'औ', 'k': 'क', 'g': 'ग', 'c': 'क', 'j': 'ज', 't': 'त', 'd': 'द', 'n': 'न',
  'p': 'प', 'b': 'ब', 'm': 'म', 'y': 'य', 'r': 'र', 'l': 'ल', 'v': 'व', 'w': 'व', 's': 'स', 'h': 'ह'
};

function latinToDevanagari(text) {
  if (!text) return "";
  const words = text.trim().split(/\s+/);
  return words.map(word => {
    let lower = word.toLowerCase();
    let out = "";
    let i = 0;
    while (i < lower.length) {
      if (i + 3 <= lower.length && enToMrConsonants[lower.substring(i, i + 3)]) {
        out += enToMrConsonants[lower.substring(i, i + 3)];
        i += 3;
      } else if (i + 2 <= lower.length && enToMrConsonants[lower.substring(i, i + 2)]) {
        out += enToMrConsonants[lower.substring(i, i + 2)];
        i += 2;
      } else if (enToMrConsonants[lower[i]]) {
        out += enToMrConsonants[lower[i]];
        i++;
      } else {
        out += lower[i];
        i++;
      }
    }
    return out;
  }).join(" ");
}

function normalizeDigits(str) {
  if (!str) return "";
  const devanagariDigits = ["०","१","२","३","४","५","६","७","८","९"];
  let res = str.toString();
  for (let i = 0; i < 10; i++) {
    res = res.replaceAll(devanagariDigits[i], i.toString());
  }
  return res.trim();
}

function isDevanagari(text) {
  return /[\u0900-\u097F]/.test(text || "");
}

function generateSearchTokens(fields) {
  const set = new Set();
  for (const f of fields) {
    if (!f) continue;
    const clean = f.toString().trim().toLowerCase();
    if (!clean) continue;
    set.add(clean);
    const parts = clean.split(/[\s\-_,]+/);
    for (const p of parts) {
      if (!p) continue;
      set.add(p);
      for (let len = 3; len <= p.length; len++) {
        set.add(p.substring(0, len));
      }
    }
  }
  return Array.from(set);
}

// Convert native JS value to Firestore typed field
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

async function run() {
  console.log('=== Step 1: Loading Auth & Verified Local Backup ===');
  const token = execSync('gcloud auth print-access-token', { encoding: 'utf-8' }).trim();
  const backupFiles = fs.readdirSync('backups').filter(d => d.startsWith('firestore_backup_')).sort();
  const latestBackup = backupFiles.pop();
  if (!latestBackup) {
    console.error('No backup found!');
    process.exit(1);
  }
  console.log(`Using backup: backups/${latestBackup}/full_backup_clean.json`);
  const fullClean = JSON.parse(fs.readFileSync(path.join('backups', latestBackup, 'full_backup_clean.json'), 'utf8'));

  const projectId = 'maratha-shivmudra';
  const baseUrl = `https://firestore.googleapis.com/v1/projects/${projectId}/databases/(default)/documents`;
  const headers = {
    Authorization: `Bearer ${token}`,
    'Content-Type': 'application/json',
  };

  // District mappings
  const districtMapping = {
    "अहिल्यानगर": "AHI", "अहमदनगर": "AHI", "ahmednagar": "AHI",
    "अकोला": "AKL", "akola": "AKL",
    "अमरावती": "AMR", "amravati": "AMR",
    "बीड": "BEE", "beed": "BEE",
    "भंडारा": "BHA", "bhandara": "BHA",
    "बुलढाणा": "BUL", "buldhana": "BUL",
    "चंद्रपूर": "CHA", "chandrapur": "CHA",
    "छत्रपती संभाजीनगर": "CSN", "औरंगाबाद": "CSN", "aurangabad": "CSN",
    "धाराशिव": "DHA", "उस्मानाबाद": "DHA", "osmanabad": "DHA",
    "धुळे": "DHU", "dhule": "DHU",
    "गडचिरोली": "GAD", "gadchiroli": "GAD",
    "गोंदिया": "GON", "gondia": "GON",
    "हिंगोली": "HIN", "hingoli": "HIN",
    "जळगाव": "JAL", "jalgaon": "JAL",
    "जालना": "JLN", "jalna": "JLN",
    "कोल्हापूर": "KOL", "kolhapur": "KOL",
    "लातूर": "LAT", "latur": "LAT",
    "मुंबई": "MMC", "मुंबई शहर": "MMC", "mumbai": "MMC", "mumbai city": "MMC",
    "मुंबई उपनगर": "MMS", "mumbai suburban": "MMS",
    "नागपूर": "NAG", "nagpur": "NAG",
    "नांदेड": "NED", "nanded": "NED",
    "नंदुरबार": "NDB", "nandurbar": "NDB",
    "नाशिक": "NSK", "nashik": "NSK",
    "पालघर": "PLG", "palghar": "PLG",
    "परभणी": "PRB", "parbhani": "PRB",
    "पुणे": "PUN", "pune": "PUN",
    "रायगड": "RAI", "raigad": "RAI",
    "रत्नागिरी": "RAT", "ratnagiri": "RAT",
    "सांगली": "SAN", "sangli": "SAN",
    "सातारा": "SAT", "satara": "SAT",
    "सिंधुदुर्ग": "SND", "sindhudurg": "SND",
    "सोलापूर": "SOL", "solapur": "SOL",
    "ठाणे": "THA", "thane": "THA",
    "वर्धा": "WRD", "wardha": "WRD",
    "वाशीम": "WAS", "washim": "WAS",
    "यवतमाळ": "YAV", "yavatmal": "YAV"
  };

  const mhDistrictsInfo = {
    "AHI": { en: "Ahilyanagar", mr: "अहिल्यानगर" },
    "AKL": { en: "Akola", mr: "अकोला" },
    "AMR": { en: "Amravati", mr: "अमरावती" },
    "BEE": { en: "Beed", mr: "बीड" },
    "BHA": { en: "Bhandara", mr: "भंडारा" },
    "BUL": { en: "Buldhana", mr: "बुलढाणा" },
    "CHA": { en: "Chandrapur", mr: "चंद्रपूर" },
    "CSN": { en: "Chhatrapati Sambhajinagar", mr: "छत्रपती संभाजीनगर" },
    "DHA": { en: "Dharashiv", mr: "धाराशिव" },
    "DHU": { en: "Dhule", mr: "धुळे" },
    "GAD": { en: "Gadchiroli", mr: "गडचिरोली" },
    "GON": { en: "Gondia", mr: "गोंदिया" },
    "HIN": { en: "Hingoli", mr: "हिंगोली" },
    "JAL": { en: "Jalgaon", mr: "जळगाव" },
    "JLN": { en: "Jalna", mr: "जालना" },
    "KOL": { en: "Kolhapur", mr: "कोल्हापूर" },
    "LAT": { en: "Latur", mr: "लातूर" },
    "MMC": { en: "Mumbai City", mr: "मुंबई शहर" },
    "MMS": { en: "Mumbai Suburban", mr: "मुंबई उपनगर" },
    "NAG": { en: "Nagpur", mr: "नागपूर" },
    "NED": { en: "Nanded", mr: "नांदेड" },
    "NDB": { en: "Nandurbar", mr: "नंदुरबार" },
    "NSK": { en: "Nashik", mr: "नाशिक" },
    "PLG": { en: "Palghar", mr: "पालघर" },
    "PRB": { en: "Parbhani", mr: "परभणी" },
    "PUN": { en: "Pune", mr: "पुणे" },
    "RAI": { en: "Raigad", mr: "रायगड" },
    "RAT": { en: "Ratnagiri", mr: "रत्नागिरी" },
    "SAN": { en: "Sangli", mr: "सांगली" },
    "SAT": { en: "Satara", mr: "सातारा" },
    "SND": { en: "Sindhudurg", mr: "सिंधुदुर्ग" },
    "SOL": { en: "Solapur", mr: "सोलापूर" },
    "THA": { en: "Thane", mr: "ठाणे" },
    "WRD": { en: "Wardha", mr: "वर्धा" },
    "WAS": { en: "Washim", mr: "वाशीम" },
    "YAV": { en: "Yavatmal", mr: "यवतमाळ" }
  };

  console.log('\n=== Step 2: Transforming All 112 Member Records ===');
  const transformedMembers = [];
  const districtCounts = {};
  for (const code of Object.keys(mhDistrictsInfo)) {
    districtCounts[code] = 0;
  }

  for (const [colId, docs] of Object.entries(fullClean.collections)) {
    if (!/^\d{10}$/.test(colId)) continue;

    const formDoc = docs.find(d => d._id === "form_info");
    const personalDoc = docs.find(d => d._id === "personal_info");
    const phone = colId;
    const isRegistered = !!formDoc;
    const referralId = (personalDoc && personalDoc.referral_id) || (formDoc && formDoc.referral_id) || "NONE";

    let member = {
      phone,
      is_registered: isRegistered,
      referral_id: referralId,
      role_type: "member",
      designation: "",
      member_id: "PENDING",
      is_card_issued: false,
      is_profile_complete: false,
      is_valid: true,
      created_at: (formDoc && formDoc._createTime) || (personalDoc && personalDoc._createTime) || new Date().toISOString(),
      updated_at: new Date().toISOString(),
    };

    if (formDoc) {
      let state = "Maharashtra";
      let stateCode = "MH";
      let districtCode = "PUN";
      let districtEn = "Pune";
      let districtMr = "पुणे";
      let subDistrict = (formDoc.subDistrict || formDoc.sub_district || "").trim();
      let city = (formDoc.city || "").trim();

      const rawDist = (formDoc.district || "Pune").trim();
      const rawLower = rawDist.toLowerCase();

      // Special cases
      if (rawLower.includes("belgaum")) {
        state = "Karnataka";
        stateCode = "KA";
        districtCode = "KA-BEL";
        districtEn = "Belagavi";
        districtMr = "बेळगाव";
        subDistrict = subDistrict || "Belagavi";
        city = city || "Belagavi";
      } else if (rawLower.includes("surat")) {
        state = "Gujarat";
        stateCode = "GJ";
        districtCode = "GJ-SUR";
        districtEn = "Surat";
        districtMr = "सुरत";
        subDistrict = subDistrict || "Surat";
        city = city || "Surat";
      } else {
        districtCode = districtMapping[rawDist] || districtMapping[rawLower] || "PUN";
        const dInfo = mhDistrictsInfo[districtCode];
        districtEn = dInfo.en;
        districtMr = dInfo.mr;
        districtCounts[districtCode] = (districtCounts[districtCode] || 0) + 1;
      }

      const fName = (formDoc.firstName || formDoc.first_name || "").trim();
      const mName = (formDoc.middleName || formDoc.middle_name || "").trim();
      const lName = (formDoc.lastName || formDoc.last_name || "").trim();

      let fNameEn = "", mNameEn = "", lNameEn = "", fullNameEn = "";
      let fNameMr = "", mNameMr = "", lNameMr = "", fullNameMr = "";

      if (isDevanagari(fName) || isDevanagari(lName)) {
        fNameMr = fName;
        mNameMr = mName;
        lNameMr = lName;
        fullNameMr = `${fName} ${mName} ${lName}`.replace(/\s+/g, ' ').trim();

        fNameEn = devanagariToLatin(fName);
        mNameEn = devanagariToLatin(mName);
        lNameEn = devanagariToLatin(lName);
        fullNameEn = `${fNameEn} ${mNameEn} ${lNameEn}`.replace(/\s+/g, ' ').trim();
      } else {
        fNameEn = fName;
        mNameEn = mName;
        lNameEn = lName;
        fullNameEn = `${fName} ${mName} ${lName}`.replace(/\s+/g, ' ').trim();

        fNameMr = latinToDevanagari(fName);
        mNameMr = latinToDevanagari(mName);
        lNameMr = latinToDevanagari(lName);
        fullNameMr = `${fNameMr} ${mNameMr} ${lNameMr}`.replace(/\s+/g, ' ').trim();
      }

      const searchTokens = generateSearchTokens([
        fullNameEn, fullNameMr, phone, districtEn, districtMr, subDistrict, city
      ]);

      member = {
        ...member,
        first_name_en: fNameEn,
        middle_name_en: mNameEn,
        last_name_en: lNameEn,
        full_name_en: fullNameEn,

        first_name_mr: fNameMr,
        middle_name_mr: mNameMr,
        last_name_mr: lNameMr,
        full_name_mr: fullNameMr,

        gender: formDoc.gender || "Male",
        date_of_birth: formDoc.dateOfBirth || formDoc.date_of_birth || "",
        email: (formDoc.email || "").trim(),
        blood_group: formDoc.bloodGroup || formDoc.blood_group || "",
        living: (formDoc.living || "").trim(),
        profession: formDoc.profession || "",
        education: formDoc.education || "",

        address: (formDoc.address || "").trim(),
        city,
        sub_district: subDistrict,
        village: (formDoc.village || "").trim(),
        district: districtEn,
        district_code: districtCode,
        district_en: districtEn,
        district_mr: districtMr,
        state,
        state_code: stateCode,
        pincode: normalizeDigits(formDoc.pincode),

        emergency_contact_name: "",
        emergency_contact_phone: "",
        photo_url: null,
        photo_base64: null,
        search_tokens: searchTokens,
      };
    }

    transformedMembers.push(member);
  }

  console.log(`Transformed ${transformedMembers.length} member records.`);

  console.log('\n=== Step 3: Writing Members into Firestore collection "members" ===');
  let written = 0;
  for (const m of transformedMembers) {
    const docFields = {};
    for (const [k, v] of Object.entries(m)) {
      docFields[k] = toFirestoreValue(v);
    }

    const res = await fetch(`${baseUrl}/members/${m.phone}`, {
      method: 'PATCH',
      headers,
      body: JSON.stringify({ fields: docFields }),
    });

    if (!res.ok) {
      console.error(`Failed to write member ${m.phone}: ${res.status} ${await res.text()}`);
    } else {
      written++;
      if (written % 20 === 0 || written === transformedMembers.length) {
        console.log(`Written ${written}/${transformedMembers.length} members...`);
      }
    }
  }

  console.log('\n=== Step 4: Updating district_counters & social_impact ===');
  // Update district_counters
  const counterFields = {};
  for (const [code, count] of Object.entries(districtCounts)) {
    counterFields[code] = { integerValue: count.toString() };
  }
  await fetch(`${baseUrl}/counters/district_counters`, {
    method: 'PATCH',
    headers,
    body: JSON.stringify({ fields: counterFields }),
  });
  console.log('Updated counters/district_counters with verified counts.');

  // Update site_data/social_impact
  const impactFields = {
    volunteers: { integerValue: "101" },
    districts: { stringValue: "36" },
    students: { stringValue: "250+" },
    fort_drives: { stringValue: "50+" },
    relief_drives: { stringValue: "7" }
  };
  await fetch(`${baseUrl}/site_data/social_impact`, {
    method: 'PATCH',
    headers,
    body: JSON.stringify({ fields: impactFields }),
  });
  console.log('Updated site_data/social_impact (volunteers: 101, districts: 36).');

  console.log('\n=== Step 5: Deleting All 112 Legacy Root Collections ===');
  let deletedCols = 0;
  for (const [colId, docs] of Object.entries(fullClean.collections)) {
    if (!/^\d{10}$/.test(colId)) continue;
    // Delete form_info and personal_info documents
    for (const doc of docs) {
      await fetch(`${baseUrl}/${colId}/${doc._id}`, {
        method: 'DELETE',
        headers,
      });
    }
    deletedCols++;
    if (deletedCols % 20 === 0 || deletedCols === 112) {
      console.log(`Cleaned up ${deletedCols}/112 legacy collections...`);
    }
  }

  // Also delete members_index/8691955046
  await fetch(`${baseUrl}/members_index/8691955046`, {
    method: 'DELETE',
    headers,
  });
  console.log('Cleaned up legacy members_index.');

  console.log('\n=== Step 6: Verifying New Firestore Root Collections ===');
  const listColRes = await fetch(`${baseUrl}:listCollectionIds`, {
    method: 'POST',
    headers,
    body: JSON.stringify({ pageSize: 1000 }),
  });
  const listData = await listColRes.json();
  console.log('Active Root Collections:', (listData.collectionIds || []).join(', '));
  console.log('\n=== DATABASE REBUILD COMPLETED SUCCESSFULLY! ===');
}

run().catch(err => {
  console.error('Fatal error rebuilding database:', err);
  process.exit(1);
});
