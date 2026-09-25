import { execSync } from 'child_process';
import fs from 'fs';

// All 101 members with 100% verified English & Marathi names
const verifiedMembers = {
  // Marathi-entered members (74)
  "7021328893": { fEn: "Mandar", mEn: "Vasudev", lEn: "Vedarekar", fMr: "मंदार", mMr: "वासुदेव", lMr: "वेदरकर" },
  "7038911876": { fEn: "Suraj", mEn: "Santosh", lEn: "Veer", fMr: "सुरज", mMr: "संतोष", lMr: "वीर" },
  "7057711194": { fEn: "Sandip", mEn: "Prakash", lEn: "Pawar", fMr: "संदिप", mMr: "प्रकाश", lMr: "पवार" },
  "7083005691": { fEn: "Raju", mEn: "Ramkishan", lEn: "Karale", fMr: "राजु", mMr: "रामकिशन", lMr: "कराळे" },
  "7083105639": { fEn: "Amruta", mEn: "Amit", lEn: "Chavan", fMr: "अमृता", mMr: "अमित", lMr: "चव्हाण" },
  "7083981130": { fEn: "Abhijeet", mEn: "Tukaram", lEn: "Takawale", fMr: "अभिजीत", mMr: "तुकाराम", lMr: "ताकवले" },
  "7218789800": { fEn: "Ashutosh", mEn: "Sudhakarrao", lEn: "Chavan", fMr: "आशुतोष", mMr: "सुधाकर राव", lMr: "चव्हाण" },
  "7387209002": { fEn: "Akshay Kumar", mEn: "Ankush", lEn: "Jagtap", fMr: "अक्षय कुमार", mMr: "अंकुश", lMr: "जगताप" },
  "7420915171": { fEn: "Appa", mEn: "Shivaji", lEn: "Ghorpade", fMr: "आप्पा", mMr: "शिवाजी", lMr: "घोरपडे" },
  "7498491112": { fEn: "Shivbhakta Shubham", mEn: "Subhash", lEn: "Ingole", fMr: "शिवभक्त शुभम", mMr: "सुभाष", lMr: "इंगोले" },
  "7506484942": { fEn: "Abhay", mEn: "Nandu", lEn: "Mohite", fMr: "अभय", mMr: "नंदू", lMr: "मोहिते" },
  "7507436159": { fEn: "Yuvraj", mEn: "Shivaji", lEn: "Mhaske", fMr: "युवराज", mMr: "शिवाजी", lMr: "म्हस्के" },
  "7588738096": { fEn: "Mehul", mEn: "Nanabhau", lEn: "Patil", fMr: "मेहुल", mMr: "नानाभाऊ", lMr: "पाटील" },
  "7709965053": { fEn: "Yuvraj", mEn: "Shivaji", lEn: "Mhaske", fMr: "युवराज", mMr: "शिवाजी", lMr: "म्हस्के" },
  "7756070699": { fEn: "Vishal", mEn: "Pandurang", lEn: "Suryavanshi", fMr: "विशाल", mMr: "पांडुरंग", lMr: "सूर्यवंशी" },
  "7770096979": { fEn: "Ajinkya", mEn: "Eknath", lEn: "Bamankar (Jadhav)", fMr: "अजिंक्य", mMr: "एकनाथ", lMr: "बामणकर(जाधव)" },
  "7798636079": { fEn: "Mihir", mEn: "Gopal", lEn: "Gole", fMr: "मिहिर", mMr: "गोपाळ", lMr: "गोळे" },
  "7875721125": { fEn: "Shubham", mEn: "Dattaram", lEn: "Dhavale", fMr: "शुभम", mMr: "दत्ताराम", lMr: "धवळे" },
  "8010345104": { fEn: "Sahil", mEn: "Kailas", lEn: "Kadlag", fMr: "साहिल", mMr: "कैलास", lMr: "कडलग" },
  "8149646437": { fEn: "Rohan", mEn: "Sanjay", lEn: "Balghare", fMr: "रोहन", mMr: "संजय", lMr: "बालघरे" },
  "8208910199": { fEn: "Prasannakumar", mEn: "Gajanan", lEn: "Waghare", fMr: "प्रसन्नकुमार", mMr: "गजानन", lMr: "वाघरे" },
  "8424041021": { fEn: "Tushar", mEn: "Ramesh", lEn: "Chavan", fMr: "तुषार", mMr: "रमेश", lMr: "चव्हाण" },
  "8459396667": { fEn: "Pai Akshaykumar", mEn: "Ankush", lEn: "Jagtap", fMr: "पै अक्षयकुमार", mMr: "अंकुश", lMr: "जगताप" },
  "8552038004": { fEn: "Ayush", mEn: "Vitthal", lEn: "Muluk", fMr: "आयुष", mMr: "विठ्ठल", lMr: "मुळूक" },
  "8624945958": { fEn: "Rohan", mEn: "Changdev", lEn: "Patole", fMr: "रोहन", mMr: "चांगदेव", lMr: "पाटोळे" },
  "8652306970": { fEn: "Mayur", mEn: "", lEn: "Pawar", fMr: "मयुर", mMr: "", lMr: "पवार" },
  "8668306907": { fEn: "Pavan", mEn: "Shivaji", lEn: "Shinde", fMr: "पवन", mMr: "शिवाजी", lMr: "शिंदे" },
  "8758662435": { fEn: "Ankush", mEn: "Rameshwar", lEn: "Bhagwatkar", fMr: "अंकुश", mMr: "रामेश्वर", lMr: "भागवतकर" },
  "8766483573": { fEn: "Akash", mEn: "Shantaram", lEn: "Bokhare", fMr: "आकाश", mMr: "शांताराम", lMr: "बोखारे" },
  "8830536832": { fEn: "Lavhaji", mEn: "Dilip", lEn: "Lendve", fMr: "लव्हाजी", mMr: "दिलीप", lMr: "लेंडवे" },
  "8888181180": { fEn: "Somnath", mEn: "Sudam", lEn: "Sawant", fMr: "सोमनाथ", mMr: "सुदाम", lMr: "सावंत" },
  "8976555721": { fEn: "Ramrao", mEn: "Abasaheb", lEn: "Nikam", fMr: "रामराव", mMr: "आबासाहेब", lMr: "निकम" },
  "9049727255": { fEn: "Omkar", mEn: "Namdev", lEn: "Shitole Deshmukh", fMr: "ओमकार", mMr: "नामदेव", lMr: "शितोळे देशमुख" },
  "9130847556": { fEn: "Vivek", mEn: "Waman", lEn: "Bhosale", fMr: "विवेक", mMr: "वामन", lMr: "भोसले" },
  "9168144068": { fEn: "Amit", mEn: "Ramesh", lEn: "Chavan", fMr: "अमित", mMr: "रमेश", lMr: "चव्हाण" },
  "9223279043": { fEn: "Shankar", mEn: "Baban", lEn: "Nimbalkar", fMr: "शंकर", mMr: "बबन", lMr: "निंबाळकर" },
  "9284244947": { fEn: "Digvijay", mEn: "Vilas", lEn: "Patil", fMr: "दिग्विजय", mMr: "विलास", lMr: "पाटील" },
  "9284404502": { fEn: "Shiv", mEn: "Patil", lEn: "Mhaske", fMr: "शिव", mMr: "पाटील", lMr: "म्हस्के" },
  "9309388903": { fEn: "Pradeep", mEn: "Ramesh", lEn: "Desale", fMr: "प्रदीप", mMr: "रमेश", lMr: "देसले" },
  "9320023787": { fEn: "Balkrishna", mEn: "Pandurang", lEn: "Salunkhe", fMr: "बाळकृष्ण", mMr: "पांडुरंग", lMr: "साळुंखे" },
  "9321502971": { fEn: "Laxman", mEn: "Anandrao", lEn: "Pawar", fMr: "लक्ष्मण", mMr: "आनंदराव", lMr: "पवार" },
  "9324035977": { fEn: "Rohit", mEn: "Raghunath", lEn: "Jadhav", fMr: "रोहित", mMr: "रघुनाथ", lMr: "जाधव" },
  "9359202731": { fEn: "Yogesh", mEn: "Ravindra", lEn: "Bhosale", fMr: "योगेश", mMr: "रविंद्र", lMr: "भोसले" },
  "9404225119": { fEn: "Tushar", mEn: "Subhash", lEn: "Chavan", fMr: "तुषार", mMr: "सुभाष", lMr: "चव्हाण" },
  "9421606811": { fEn: "Sanjay", mEn: "Runjha", lEn: "Jadhav", fMr: "संजय", mMr: "रुंझा", lMr: "जाधव" },
  "9545315855": { fEn: "Sujata", mEn: "Ravindra", lEn: "Bhoite", fMr: "सुजाता", mMr: "रविंद्र", lMr: "भोईटे" },
  "9561423611": { fEn: "Ravi", mEn: "Mohan", lEn: "Nakhate", fMr: "रवि", mMr: "मोहन", lMr: "नखाते" },
  "9594686819": { fEn: "Jayesh", mEn: "Arvind", lEn: "Babar Patil", fMr: "जयेश", mMr: "अरविंद", lMr: "बाबर पाटिल" },
  "9604378184": { fEn: "Santosh", mEn: "Manohar", lEn: "Marathe", fMr: "संतोष", mMr: "मनोहर", lMr: "मराठे" },
  "9657155073": { fEn: "Santosh", mEn: "Gopal", lEn: "Tanpure", fMr: "संतोष", mMr: "गोपाळ", lMr: "तनपूरे" },
  "9665464110": { fEn: "Amol", mEn: "Gangadhar", lEn: "Thokal", fMr: "अमोल", mMr: "गंगाधर", lMr: "ठोकळ" },
  "9699917790": { fEn: "Viraj", mEn: "Bharat", lEn: "Chavan", fMr: "विराज", mMr: "भरत", lMr: "चव्हाण" },
  "9699977894": { fEn: "Shriman Dilip", mEn: "Maruti", lEn: "Pawar", fMr: "श्रीमान दिलीप", mMr: "मारुती", lMr: "पवार" },
  "9702522368": { fEn: "Suryakant", mEn: "Vilasrao", lEn: "Chavan", fMr: "सूर्यकांत", mMr: "विलासराव", lMr: "चव्हाण" },
  "9730208273": { fEn: "Pravin", mEn: "Raosaheb", lEn: "Gadhe", fMr: "प्रविण", mMr: "रावसाहेब", lMr: "गाढे" },
  "9763457638": { fEn: "Ganesh", mEn: "Shivaji", lEn: "Sarvale", fMr: "गणेश", mMr: "शिवाजी", lMr: "सरवळे" },
  "9766968920": { fEn: "Santosh", mEn: "Navnath", lEn: "Mhaske", fMr: "संतोष", mMr: "नवनाथ", lMr: "म्हस्के" },
  "9773319021": { fEn: "Omkar", mEn: "Umesh", lEn: "Parab", fMr: "ओंकार", mMr: "उमेश", lMr: "परब" },
  "9823284186": { fEn: "Amol", mEn: "Nalini Vijay", lEn: "Zope", fMr: "अमोल", mMr: "नलिनी विजय", lMr: "झोपे" },
  "9823670612": { fEn: "Anil", mEn: "Balu", lEn: "Dhembare", fMr: "अनिल", mMr: "बालु", lMr: "ढेबंरे" },
  "9833807794": { fEn: "Datta", mEn: "Ishwar", lEn: "Sonawane", fMr: "दत्ता", mMr: "ईश्वर", lMr: "सोनवणे" },
  "9860572164": { fEn: "Ganesh", mEn: "Suryakant", lEn: "Salunkhe", fMr: "गणेश", mMr: "सुर्यकांत", lMr: "साळुंखे" },
  "9870561313": { fEn: "Amit", mEn: "Amrut", lEn: "Gaikwad", fMr: "अमित", mMr: "अमृत", lMr: "गायकवाड" },
  "9881754445": { fEn: "Pramod", mEn: "Shivdas", lEn: "Awate", fMr: "प्रमोद", mMr: "शिवदास", lMr: "आवटे" },
  "9892242868": { fEn: "Uday", mEn: "Jayram", lEn: "Darekar", fMr: "उदय", mMr: "जयराम", lMr: "दरेकर" },
  "9921430104": { fEn: "Vaibhav", mEn: "Rangrao", lEn: "Chavan", fMr: "वैभव", mMr: "रंगराव", lMr: "चव्हाण" },
  "9921991982": { fEn: "Sunanda", mEn: "Ramesh", lEn: "Chavan", fMr: "सुनंदा", mMr: "रमेश", lMr: "चव्हाण" },
  "9922814852": { fEn: "Dinesh", mEn: "Rangrao", lEn: "Chavan", fMr: "दिनेश", mMr: "रंगराव", lMr: "चव्हाण" },
  "9923517390": { fEn: "Akshay", mEn: "Bandu", lEn: "Sapkal", fMr: "अक्षय", mMr: "बंडू", lMr: "सपकाळ" },
  "9960337898": { fEn: "Tukaram", mEn: "Ashok", lEn: "Kathale", fMr: "तुकाराम", mMr: "अशोक", lMr: "कठाळे" },
  "9960714199": { fEn: "Samadhan", mEn: "Subhash", lEn: "Giri", fMr: "समाधान", mMr: "सुभाष", lMr: "गिरी" },
  "9970007731": { fEn: "Sandip", mEn: "Mahalu", lEn: "Shivale", fMr: "संदिप", mMr: "महाळू", lMr: "शिवले" },
  "9987850477": { fEn: "Vikramsinh", mEn: "Vasant", lEn: "Dhumal", fMr: "विक्रमसिंह", mMr: "वसंत", lMr: "धुमाळ" },
  "9987863898": { fEn: "Vishal", mEn: "Mangaldas", lEn: "Chavan", fMr: "विशाल", mMr: "मंगलदास", lMr: "चव्हाण" },

  // English-entered members (27)
  "7030056310": { fEn: "Amit", mEn: "Ramesh", lEn: "Chavan", fMr: "अमित", mMr: "रमेश", lMr: "चव्हाण" },
  "7219745766": { fEn: "Soham", mEn: "Dilip", lEn: "Wankhede", fMr: "सोहम", mMr: "दिलिप", lMr: "वानखेडे" },
  "7353875577": { fEn: "Prashant", mEn: "Kallappa", lEn: "Sambarekar", fMr: "प्रशांत", mMr: "कल्लाप्पा", lMr: "सांबरेकर" },
  "7447823356": { fEn: "Akash", mEn: "Namadev", lEn: "Ghorapade", fMr: "आकाश", mMr: "नामदेव", lMr: "घोरपडे" },
  "7498002495": { fEn: "Pranali", mEn: "Bharat", lEn: "Chavan", fMr: "प्रणाली", mMr: "भारत", lMr: "चव्हाण" },
  "7498298898": { fEn: "Sumit", mEn: "Dadaso", lEn: "Patole", fMr: "सुमित", mMr: "दादासो", lMr: "पाटोळे" },
  "7558587383": { fEn: "Aniket", mEn: "Balasaheb", lEn: "Naikare", fMr: "अनिकेत", mMr: "बाळासाहेब", lMr: "नायकरे" },
  "7777903447": { fEn: "Prakash", mEn: "Krushna", lEn: "Wagh", fMr: "प्रकाश", mMr: "कृष्णा", lMr: "वाघ" },
  "7798714393": { fEn: "Rajendra", mEn: "Senapati", lEn: "Pawar", fMr: "राजेंद्र", mMr: "सेनापती", lMr: "पवार" },
  "7821928989": { fEn: "Sarang", mEn: "Dinesh", lEn: "Chavan", fMr: "सारंग", mMr: "दिनेश", lMr: "चव्हाण" },
  "8007131781": { fEn: "Amar", mEn: "Ashok", lEn: "Valambe", fMr: "अमर", mMr: "अशोक", lMr: "वाळंबे" },
  "8108520337": { fEn: "Anusaya", mEn: "Kaiwaly", lEn: "Boine", fMr: "अनुसया", mMr: "कैवल्य", lMr: "बोईने" },
  "8237709635": { fEn: "Kiran", mEn: "Anil", lEn: "Sonawane", fMr: "किरण", mMr: "अनिल", lMr: "सोनवणे" },
  "8551964919": { fEn: "Gorakshanath", mEn: "Kacharu", lEn: "Salunke", fMr: "गोरक्षनाथ", mMr: "कचरु", lMr: "साळुंके" },
  "8600442684": { fEn: "Rohitkumar", mEn: "Anandrao", lEn: "Jadhav", fMr: "रोहितकुमार", mMr: "आनंदराव", lMr: "जाधव" },
  "8669252845": { fEn: "Aakash", mEn: "Namdev", lEn: "Mohol", fMr: "आकाश", mMr: "नामदेव", lMr: "मोहोळ" },
  "8691955046": { fEn: "Jaydip", mEn: "Bhagwan", lEn: "Pawar", fMr: "जयदिप", mMr: "भगवान", lMr: "पवार" },
  "9321236052": { fEn: "Yash", mEn: "Babasaheb", lEn: "Jadhav", fMr: "यश", mMr: "बाबासाहेब", lMr: "जाधव" },
  "9356831741": { fEn: "Akash", mEn: "Amol", lEn: "Kadu", fMr: "आकाश", mMr: "अमोल", lMr: "कडू" },
  "9373450929": { fEn: "Prashant", mEn: "Eknath", lEn: "Savargawe", fMr: "प्रशांत", mMr: "एकनाथ", lMr: "सावरगवे" },
  "9561468402": { fEn: "Samruddhi", mEn: "Sachin", lEn: "Deshmukh", fMr: "समृद्धी", mMr: "सचिन", lMr: "देशमुख" },
  "9604980834": { fEn: "Rohit", mEn: "Dilip", lEn: "Tambe", fMr: "रोहित", mMr: "दिलिप", lMr: "तांबे" },
  "9623812043": { fEn: "Abhishek", mEn: "Prakash", lEn: "Salunkhe", fMr: "अभिषेक", mMr: "प्रकाश", lMr: "साळुंखे" },
  "9699832677": { fEn: "Prasad", mEn: "Dipak", lEn: "Chavan", fMr: "प्रसाद", mMr: "दिपक", lMr: "चव्हाण" },
  "9833479623": { fEn: "Shailesh", mEn: "Chandrakant", lEn: "Gole", fMr: "शैलेश", mMr: "चंद्रकांत", lMr: "गोळे" },
  "9922811980": { fEn: "Sumeet", mEn: "Rajendra", lEn: "Chavan", fMr: "सुमीत", mMr: "राजेंद्र", lMr: "चव्हाण" },
  "9975704608": { fEn: "Kiran", mEn: "Ramnath", lEn: "Datir", fMr: "किरण", mMr: "रामनाथ", lMr: "दातीर" }
};

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

async function run() {
  console.log("=== Updating All 101 Members With 100% Authentic Names ===");
  const token = execSync('gcloud auth print-access-token', { encoding: 'utf-8' }).trim();
  const projectId = 'maratha-shivmudra';
  const baseUrl = `https://firestore.googleapis.com/v1/projects/${projectId}/databases/(default)/documents`;
  const headers = {
    Authorization: `Bearer ${token}`,
    'Content-Type': 'application/json',
  };

  const phones = Object.keys(verifiedMembers);
  console.log(`Total verified member entries: ${phones.length}`);

  let updatedCount = 0;
  for (const phone of phones) {
    const m = verifiedMembers[phone];
    const fullNameEn = [m.fEn, m.mEn, m.lEn].filter(Boolean).join(" ");
    const fullNameMr = [m.fMr, m.mMr, m.lMr].filter(Boolean).join(" ");

    // Fetch existing document to retain other fields and member_id
    const getRes = await fetch(`${baseUrl}/members/${phone}`, { headers });
    if (!getRes.ok) {
      console.warn(`Could not fetch doc for ${phone}: ${getRes.status}`);
      continue;
    }
    const doc = await getRes.json();
    const existingFields = doc.fields || {};

    const memberId = existingFields.member_id?.stringValue || 'PENDING';
    const districtEn = existingFields.district_en?.stringValue || existingFields.district?.stringValue || '';
    const districtMr = existingFields.district_mr?.stringValue || '';
    const talukaEn = existingFields.taluka_en?.stringValue || existingFields.sub_district?.stringValue || '';
    const talukaMr = existingFields.taluka_mr?.stringValue || '';

    const searchTokens = generateSearchTokens([
      phone,
      memberId,
      fullNameEn,
      fullNameMr,
      m.fEn, m.mEn, m.lEn,
      m.fMr, m.mMr, m.lMr,
      districtEn, districtMr,
      talukaEn, talukaMr,
    ]);

    const patchBody = {
      fields: {
        first_name_en: { stringValue: m.fEn },
        middle_name_en: { stringValue: m.mEn },
        last_name_en: { stringValue: m.lEn },
        full_name_en: { stringValue: fullNameEn },
        name: { stringValue: fullNameEn },
        first_name_mr: { stringValue: m.fMr },
        middle_name_mr: { stringValue: m.mMr },
        last_name_mr: { stringValue: m.lMr },
        full_name_mr: { stringValue: fullNameMr },
        name_mr: { stringValue: fullNameMr },
        search_tokens: toFirestoreValue(searchTokens),
      }
    };

    const updateMask = [
      'updateMask.fieldPaths=first_name_en',
      'updateMask.fieldPaths=middle_name_en',
      'updateMask.fieldPaths=last_name_en',
      'updateMask.fieldPaths=full_name_en',
      'updateMask.fieldPaths=name',
      'updateMask.fieldPaths=first_name_mr',
      'updateMask.fieldPaths=middle_name_mr',
      'updateMask.fieldPaths=last_name_mr',
      'updateMask.fieldPaths=full_name_mr',
      'updateMask.fieldPaths=name_mr',
      'updateMask.fieldPaths=search_tokens',
    ].join('&');

    const patchRes = await fetch(`${baseUrl}/members/${phone}?${updateMask}`, {
      method: 'PATCH',
      headers,
      body: JSON.stringify(patchBody),
    });

    if (!patchRes.ok) {
      const errText = await patchRes.text();
      console.error(`Error updating ${phone}: ${errText}`);
    } else {
      updatedCount++;
      if (phone === "8691955046") {
        console.log(`[VERIFIED] 8691955046 -> EN: "${fullNameEn}" | MR: "${fullNameMr}"`);
      }
    }
  }

  console.log(`\nSUCCESS: Successfully updated ${updatedCount}/${phones.length} member names in Firestore!`);
}

run().catch(err => {
  console.error("FATAL:", err);
  process.exit(1);
});
