import fs from 'fs';
import path from 'path';

async function build() {
  console.log('Fetching India states & districts...');
  const resStates = await fetch('https://raw.githubusercontent.com/sab99r/Indian-States-And-Districts/master/states-and-districts.json');
  const statesJson = await resStates.json();

  // State translations & codes
  const stateMeta = {
    "Maharashtra": { code: "MH", mr: "महाराष्ट्र" },
    "Karnataka": { code: "KA", mr: "कर्नाटक" },
    "Gujarat": { code: "GJ", mr: "गुजरात" },
    "Goa": { code: "GA", mr: "गोवा" },
    "Madhya Pradesh": { code: "MP", mr: "मध्य प्रदेश" },
    "Delhi (NCT)": { code: "DL", mr: "दिल्ली" },
    "Rajasthan": { code: "RJ", mr: "राजस्थान" },
    "Telangana": { code: "TG", mr: "तेलंगणा" },
    "Andhra Pradesh": { code: "AP", mr: "आंध्र प्रदेश" },
    "Tamil Nadu": { code: "TN", mr: "तमिळनाडू" },
    "Kerala": { code: "KL", mr: "केरळ" },
    "Uttar Pradesh": { code: "UP", mr: "उत्तर प्रदेश" },
    "Punjab": { code: "PB", mr: "पंजाब" },
    "Haryana": { code: "HR", mr: "हरियाणा" },
    "Bihar": { code: "BR", mr: "बिहार" },
    "West Bengal": { code: "WB", mr: "पश्चिम बंगाल" },
    "Odisha": { code: "OD", mr: "ओडिशा" },
    "Chhattisgarh": { code: "CG", mr: "छत्तीसगड" },
    "Jharkhand": { code: "JH", mr: "झारखंड" },
    "Assam": { code: "AS", mr: "आसाम" },
    "Himachal Pradesh": { code: "HP", mr: "हिमाचल प्रदेश" },
    "Uttarakhand": { code: "UK", mr: "उत्तराखंड" },
    "Jammu and Kashmir": { code: "JK", mr: "जम्मू आणि काश्मीर" },
    "Ladakh": { code: "LA", mr: "लडाख" },
    "Chandigarh (UT)": { code: "CH", mr: "चंदीगड" },
    "Puducherry (UT)": { code: "PY", mr: "पुडुचेरी" },
    "Dadra and Nagar Haveli (UT)": { code: "DH", mr: "दादरा आणि नगर हवेली" },
    "Daman and Diu (UT)": { code: "DD", mr: "दमन आणि दीव" },
    "Andaman and Nicobar Islands (UT)": { code: "AN", mr: "अंदमान आणि निकोबार" },
    "Arunachal Pradesh": { code: "AR", mr: "अरुणाचल प्रदेश" },
    "Manipur": { code: "MN", mr: "मणिपूर" },
    "Meghalaya": { code: "ML", mr: "मेघालय" },
    "Mizoram": { code: "MZ", mr: "मिझोरम" },
    "Nagaland": { code: "NL", mr: "नागालँड" },
    "Sikkim": { code: "SK", mr: "सिक्कीम" },
    "Tripura": { code: "TR", mr: "त्रिपुरा" },
    "Lakshadweep (UT)": { code: "LD", mr: "लक्षद्वीप" }
  };

  // Full 36 Maharashtra Districts & Talukas
  const mhDistricts = [
    { code: "AHI", en: "Ahilyanagar", mr: "अहिल्यानगर", talukas: [
      { en: "Akole", mr: "अकोले" }, { en: "Jamkhed", mr: "जामखेड" }, { en: "Karjat", mr: "कर्जत" },
      { en: "Kopargaon", mr: "कोपरगाव" }, { en: "Nagar", mr: "नगर" }, { en: "Nevasa", mr: "नेवासा" },
      { en: "Parner", mr: "पारनेर" }, { en: "Pathardi", mr: "पाथर्डी" }, { en: "Rahata", mr: "राहाता" },
      { en: "Rahuri", mr: "राहुरी" }, { en: "Sangamner", mr: "संगमनेर" }, { en: "Shevgaon", mr: "शेवगाव" },
      { en: "Shrigonda", mr: "श्रीगोंदा" }, { en: "Shrirampur", mr: "श्रीरामपूर" }
    ]},
    { code: "AKL", en: "Akola", mr: "अकोला", talukas: [
      { en: "Akola", mr: "अकोला" }, { en: "Akot", mr: "अकोट" }, { en: "Balapur", mr: "बाळापूर" },
      { en: "Barshitakli", mr: "बार्शीटाकळी" }, { en: "Murtijapur", mr: "मुर्तिजापूर" }, { en: "Patur", mr: "पातूर" },
      { en: "Telhara", mr: "तेल्हारा" }
    ]},
    { code: "AMR", en: "Amravati", mr: "अमरावती", talukas: [
      { en: "Achalpur", mr: "अचलपूर" }, { en: "Amravati", mr: "अमरावती" }, { en: "Anjangaon Surji", mr: "अंजनगाव सुर्जी" },
      { en: "Bhatkuli", mr: "भातकुली" }, { en: "Chandur Railway", mr: "चांदूर रेल्वे" }, { en: "Chandur Bazar", mr: "चांदूर बाजार" },
      { en: "Chikhaldara", mr: "चिखलदरा" }, { en: "Daryapur", mr: "दर्यापूर" }, { en: "Dhamangaon Railway", mr: "धामणगाव रेल्वे" },
      { en: "Dharni", mr: "धारणी" }, { en: "Morshi", mr: "मोर्शी" }, { en: "Nandgaon Khandeshwar", mr: "नांदगाव खंडेश्वर" },
      { en: "Tiwsa", mr: "तिवसा" }, { en: "Warud", mr: "वरुड" }
    ]},
    { code: "CSN", en: "Chhatrapati Sambhajinagar", mr: "छत्रपती संभाजीनगर", talukas: [
      { en: "Chhatrapati Sambhajinagar", mr: "छत्रपती संभाजीनगर" }, { en: "Gangapur", mr: "गंगापूर" }, { en: "Kannad", mr: "कन्नड" },
      { en: "Khuldabad", mr: "खुलताबाद" }, { en: "Paithan", mr: "पैठण" }, { en: "Phulambri", mr: "फुलंब्री" },
      { en: "Sillod", mr: "सिल्लोड" }, { en: "Soegaon", mr: "सोयगाव" }, { en: "Vaijapur", mr: "वैजापूर" }
    ]},
    { code: "BEE", en: "Beed", mr: "बीड", talukas: [
      { en: "Ambajogai", mr: "अंबाजोगाई" }, { en: "Ashti", mr: "आष्टी" }, { en: "Beed", mr: "बीड" },
      { en: "Dharur", mr: "धारूर" }, { en: "Georai", mr: "गेवराई" }, { en: "Kaij", mr: "केज" },
      { en: "Majalgaon", mr: "माजलगाव" }, { en: "Parli", mr: "परळी" }, { en: "Patoda", mr: "पाटोदा" },
      { en: "Shirur Kasar", mr: "शिरूर कासार" }, { en: "Wadwani", mr: "वडवणी" }
    ]},
    { code: "BHA", en: "Bhandara", mr: "भंडारा", talukas: [
      { en: "Bhandara", mr: "भंडारा" }, { en: "Lakhandur", mr: "लाखांदूर" }, { en: "Lakhani", mr: "लाखनी" },
      { en: "Mohadi", mr: "मोहाडी" }, { en: "Pauni", mr: "पौनी" }, { en: "Sakoli", mr: "साकोली" }, { en: "Tumsar", mr: "तुमसर" }
    ]},
    { code: "BUL", en: "Buldhana", mr: "बुलढाणा", talukas: [
      { en: "Buldhana", mr: "बुलढाणा" }, { en: "Chikhli", mr: "चिखली" }, { en: "Deulgaon Raja", mr: "देऊळगाव राजा" },
      { en: "Jalgaon Jamod", mr: "जळगाव जामोद" }, { en: "Khamgaon", mr: "खामगाव" }, { en: "Lonar", mr: "लोणार" },
      { en: "Malkapur", mr: "मलकापूर" }, { en: "Mehkar", mr: "मेहकर" }, { en: "Motala", mr: "मोताळा" },
      { en: "Nandura", mr: "नांदुरा" }, { en: "Sangrampur", mr: "संग्रामपूर" }, { en: "Shegaon", mr: "शेगाव" },
      { en: "Sindkhed Raja", mr: "सिंदखेड राजा" }
    ]},
    { code: "CHA", en: "Chandrapur", mr: "चंद्रपूर", talukas: [
      { en: "Ballarpur", mr: "बल्लारपूर" }, { en: "Bhadravati", mr: "भद्रावती" }, { en: "Bramhapuri", mr: "ब्रह्मपुरी" },
      { en: "Chandrapur", mr: "चंद्रपूर" }, { en: "Chimur", mr: "चिमूर" }, { en: "Gondpipri", mr: "गोंडपिपरी" },
      { en: "Jiwati", mr: "जिवती" }, { en: "Korpana", mr: "कोरपना" }, { en: "Mul", mr: "मूल" },
      { en: "Nagbhid", mr: "नागभीड" }, { en: "Pombhurna", mr: "पोंभुर्णा" }, { en: "Rajura", mr: "राजुरा" },
      { en: "Sawali", mr: "सावली" }, { en: "Sindewahi", mr: "सिंदेवाही" }, { en: "Warora", mr: "वरोरा" }
    ]},
    { code: "DHU", en: "Dhule", mr: "धुळे", talukas: [
      { en: "Dhule", mr: "धुळे" }, { en: "Sakri", mr: "साक्री" }, { en: "Shirpur", mr: "शिरपूर" }, { en: "Sindkhede", mr: "शिंदखेडा" }
    ]},
    { code: "GAD", en: "Gadchiroli", mr: "गडचिरोली", talukas: [
      { en: "Aheri", mr: "अहेरी" }, { en: "Armori", mr: "आरमोरी" }, { en: "Bhamragad", mr: "भामरागड" },
      { en: "Chamorshi", mr: "चामोर्शी" }, { en: "Dhanora", mr: "धानोरा" }, { en: "Etapalli", mr: "एटापल्ली" },
      { en: "Gadchiroli", mr: "गडचिरोली" }, { en: "Korchi", mr: "कोरची" }, { en: "Kurkheda", mr: "कुरखेडा" },
      { en: "Mulchera", mr: "मुलचेरा" }, { en: "Sironcha", mr: "सिरोंचा" }, { en: "Wadsa", mr: "वडसा" }
    ]},
    { code: "GON", en: "Gondia", mr: "गोंदिया", talukas: [
      { en: "Amgaon", mr: "आमगाव" }, { en: "Arjuni Morgaon", mr: "अर्जुनी मोरगाव" }, { en: "Deori", mr: "देवरी" },
      { en: "Gondia", mr: "गोंदिया" }, { en: "Goregaon", mr: "गोरेगाव" }, { en: "Sadak Arjuni", mr: "सडक अर्जुनी" },
      { en: "Salekasa", mr: "सालेकसा" }, { en: "Tirora", mr: "तिरोरा" }
    ]},
    { code: "HIN", en: "Hingoli", mr: "हिंगोली", talukas: [
      { en: "Aundha Nagnath", mr: "औंढा नागनाथ" }, { en: "Basmath", mr: "वसमत" }, { en: "Hingoli", mr: "हिंगोली" },
      { en: "Kalamnuri", mr: "कलमनुरी" }, { en: "Sengaon", mr: "सेनगाव" }
    ]},
    { code: "JAL", en: "Jalgaon", mr: "जळगाव", talukas: [
      { en: "Amalner", mr: "अमळनेर" }, { en: "Bhadgaon", mr: "भडगाव" }, { en: "Bhusawal", mr: "भुसावळ" },
      { en: "Bodwad", mr: "बोधवड" }, { en: "Chalisgaon", mr: "चाळीसगाव" }, { en: "Chopda", mr: "चोपडा" },
      { en: "Dharangaon", mr: "धरणगाव" }, { en: "Erandol", mr: "एरंडोल" }, { en: "Jalgaon", mr: "जळगाव" },
      { en: "Jamner", mr: "जामनेर" }, { en: "Muktainagar", mr: "मुक्ताईनगर" }, { en: "Pachora", mr: "पाचोरा" },
      { en: "Parola", mr: "पारोळा" }, { en: "Raver", mr: "रावेर" }, { en: "Yawal", mr: "यावल" }
    ]},
    { code: "JLN", en: "Jalna", mr: "जालना", talukas: [
      { en: "Ambad", mr: "अंबड" }, { en: "Badnapur", mr: "बदनापूर" }, { en: "Bhokardan", mr: "भोकरदन" },
      { en: "Ghansawangi", mr: "घनसावंगी" }, { en: "Jafrabad", mr: "जाफ्राबाद" }, { en: "Jalna", mr: "जालना" },
      { en: "Mantha", mr: "मंठा" }, { en: "Partur", mr: "परतूर" }
    ]},
    { code: "KOL", en: "Kolhapur", mr: "कोल्हापूर", talukas: [
      { en: "Ajara", mr: "आजरा" }, { en: "Bavda", mr: "गगनबावडा" }, { en: "Bhudargad", mr: "भुदरगड" },
      { en: "Chandgad", mr: "चंदगड" }, { en: "Gadhinglaj", mr: "गडहिंग्लज" }, { en: "Hatkanangale", mr: "हातकणंगले" },
      { en: "Kagal", mr: "कागल" }, { en: "Karvir", mr: "करवीर" }, { en: "Panhala", mr: "पन्हाळा" },
      { en: "Radhanagari", mr: "राधानगरी" }, { en: "Shahuwadi", mr: "शाहूवाडी" }, { en: "Shirol", mr: "शिरोळ" }
    ]},
    { code: "LAT", en: "Latur", mr: "लातूर", talukas: [
      { en: "Ahmedpur", mr: "अहमदपूर" }, { en: "Ausa", mr: "औसा" }, { en: "Chakur", mr: "चाकूर" },
      { en: "Deoni", mr: "देवणी" }, { en: "Jalkot", mr: "जळकोट" }, { en: "Latur", mr: "लातूर" },
      { en: "Renapur", mr: "रेणापूर" }, { en: "Shirur Anantpal", mr: "शिरूर अनंतपाळ" }, { en: "Udgir", mr: "उदगीर" }
    ]},
    { code: "MMC", en: "Mumbai City", mr: "मुंबई शहर", talukas: [
      { en: "Mumbai City", mr: "मुंबई शहर" }, { en: "Colaba", mr: "कुलाबा" }, { en: "Fort", mr: "फोर्ट" },
      { en: "Dadar", mr: "दादर" }, { en: "Byculla", mr: "भायखळा" }, { en: "Parel", mr: "परळ" }
    ]},
    { code: "MMS", en: "Mumbai Suburban", mr: "मुंबई उपनगर", talukas: [
      { en: "Andheri", mr: "अंधेरी" }, { en: "Borivali", mr: "बोरिवली" }, { en: "Kurla", mr: "कुर्ला" }
    ]},
    { code: "NAG", en: "Nagpur", mr: "नागपूर", talukas: [
      { en: "Hingna", mr: "हिंगणा" }, { en: "Kalameshwar", mr: "कळमेश्वर" }, { en: "Kamptee", mr: "कामठी" },
      { en: "Katol", mr: "काटोल" }, { en: "Kuhi", mr: "कुही" }, { en: "Mouda", mr: "मौदा" },
      { en: "Nagpur Rural", mr: "नागपूर ग्रामीण" }, { en: "Nagpur Urban", mr: "नागपूर शहर" }, { en: "Narkhed", mr: "नरखेड" },
      { en: "Parseoni", mr: "पारशिवनी" }, { en: "Ramtek", mr: "रामटेक" }, { en: "Saoner", mr: "सावनेर" }, { en: "Umred", mr: "उमरेड" }
    ]},
    { code: "NED", en: "Nanded", mr: "नांदेड", talukas: [
      { en: "Ardhapur", mr: "अर्धापूर" }, { en: "Bhokar", mr: "भोकर" }, { en: "Biloli", mr: "बिलोली" },
      { en: "Deglur", mr: "देगलूर" }, { en: "Dharmabad", mr: "धर्माबाद" }, { en: "Hadgaon", mr: "हदगाव" },
      { en: "Himayatnagar", mr: "हिमायतनगर" }, { en: "Kandhar", mr: "कंधार" }, { en: "Kinwat", mr: "किनवट" },
      { en: "Loha", mr: "लोहा" }, { en: "Mahur", mr: "माहूर" }, { en: "Mudkhed", mr: "मुदखेड" },
      { en: "Mukhed", mr: "मुखेड" }, { en: "Naigaon", mr: "नायगाव" }, { en: "Nanded", mr: "नांदेड" }, { en: "Umri", mr: "उमरी" }
    ]},
    { code: "NDB", en: "Nandurbar", mr: "नंदुरबार", talukas: [
      { en: "Akkalkuwa", mr: "अक्कलकुवा" }, { en: "Akrani", mr: "अक्राणी (धडगाव)" }, { en: "Nandurbar", mr: "नंदुरबार" },
      { en: "Navapur", mr: "नवापूर" }, { en: "Shahada", mr: "शहादा" }, { en: "Taloda", mr: "तळोजा" }
    ]},
    { code: "NSK", en: "Nashik", mr: "नाशिक", talukas: [
      { en: "Baglan", mr: "बागलाण (सटाणा)" }, { en: "Chandwad", mr: "चांदवड" }, { en: "Deola", mr: "देवळा" },
      { en: "Dindori", mr: "दिंडोरी" }, { en: "Igatpuri", mr: "इगतपुरी" }, { en: "Kalwan", mr: "कळवण" },
      { en: "Malegaon", mr: "मालेगाव" }, { en: "Nandgaon", mr: "नांदगाव" }, { en: "Nashik", mr: "नाशिक" },
      { en: "Niphad", mr: "निफाड" }, { en: "Peint", mr: "पेठ" }, { en: "Sinnar", mr: "सिन्नर" },
      { en: "Surgana", mr: "सुरगाणा" }, { en: "Trimbakeshwar", mr: "त्र्यंबकेश्वर" }, { en: "Yevala", mr: "येवला" }
    ]},
    { code: "DHA", en: "Dharashiv", mr: "धाराशिव", talukas: [
      { en: "Bhoom", mr: "भूम" }, { en: "Dharashiv", mr: "धाराशिव" }, { en: "Kalamb", mr: "कळंब" },
      { en: "Lohara", mr: "लोहारा" }, { en: "Omerga", mr: "उमरगा" }, { en: "Paranda", mr: "परांडा" },
      { en: "Tuljapur", mr: "तुळजापूर" }, { en: "Washi", mr: "वाशी" }
    ]},
    { code: "PLG", en: "Palghar", mr: "पालघर", talukas: [
      { en: "Dahanu", mr: "डहाणू" }, { en: "Jawhar", mr: "जव्हार" }, { en: "Mokhada", mr: "मोखाडा" },
      { en: "Palghar", mr: "पालघर" }, { en: "Talasari", mr: "तलासरी" }, { en: "Vada", mr: "वाडा" },
      { en: "Vasai", mr: "वसई" }, { en: "Vikramgad", mr: "विक्रमगड" }
    ]},
    { code: "PRB", en: "Parbhani", mr: "परभणी", talukas: [
      { en: "Gangakhed", mr: "गंगाखेड" }, { en: "Jintur", mr: "जिंतूर" }, { en: "Manwath", mr: "मानवत" },
      { en: "Palam", mr: "पालम" }, { en: "Parbhani", mr: "परभणी" }, { en: "Pathri", mr: "पाथरी" },
      { en: "Purna", mr: "पूर्णा" }, { en: "Sailu", mr: "सेलू" }, { en: "Sonpeth", mr: "सोनपेठ" }
    ]},
    { code: "PUN", en: "Pune", mr: "पुणे", talukas: [
      { en: "Ambegaon", mr: "आंबेगाव" }, { en: "Baramati", mr: "बारामती" }, { en: "Bhor", mr: "भोर" },
      { en: "Daund", mr: "दौंड" }, { en: "Haveli", mr: "हवेली" }, { en: "Indapur", mr: "इंदापूर" },
      { en: "Junnar", mr: "जुन्नर" }, { en: "Khed", mr: "खेड" }, { en: "Maval", mr: "मावळ" },
      { en: "Mulshi", mr: "मुळशी" }, { en: "Pimpri-Chinchwad", mr: "पिंपरी-चिंचवड" }, { en: "Pune City", mr: "पुणे शहर" },
      { en: "Purandar", mr: "पुरंदर" }, { en: "Shirur", mr: "शिरूर" }, { en: "Velhe", mr: "वेल्हे" }
    ]},
    { code: "RAI", en: "Raigad", mr: "रायगड", talukas: [
      { en: "Alibag", mr: "अलिबाग" }, { en: "Karjat", mr: "कर्जत" }, { en: "Khalapur", mr: "खालापूर" },
      { en: "Mahad", mr: "महाड" }, { en: "Mangaon", mr: "माणगाव" }, { en: "Mhasla", mr: "म्हसळा" },
      { en: "Murud", mr: "मुरुड" }, { en: "Panvel", mr: "पनवेल" }, { en: "Pen", mr: "पेण" },
      { en: "Poladpur", mr: "पोलादपूर" }, { en: "Roha", mr: "रोहा" }, { en: "Shrivardhan", mr: "श्रीवर्धन" },
      { en: "Sudhagad", mr: "सुधागड (पाली)" }, { en: "Tala", mr: "तळा" }, { en: "Uran", mr: "उरण" }
    ]},
    { code: "RAT", en: "Ratnagiri", mr: "रत्नागिरी", talukas: [
      { en: "Chiplun", mr: "चिपळूण" }, { en: "Dapoli", mr: "दापोली" }, { en: "Guhagar", mr: "गुहागर" },
      { en: "Khed", mr: "खेड" }, { en: "Lanja", mr: "लांजा" }, { en: "Mandangad", mr: "मंडणगड" },
      { en: "Rajapur", mr: "राजापूर" }, { en: "Ratnagiri", mr: "रत्नागिरी" }, { en: "Sangameshwar", mr: "संगमेश्वर" }
    ]},
    { code: "SAN", en: "Sangli", mr: "सांगली", talukas: [
      { en: "Atpadi", mr: "आटपाडी" }, { en: "Jat", mr: "जत" }, { en: "Kadegaon", mr: "कडेगाव" },
      { en: "Kavathe Mahankal", mr: "कवठे महांकाळ" }, { en: "Khanapur", mr: "खानापूर (विटा)" }, { en: "Miraj", mr: "मिरज" },
      { en: "Palus", mr: "पलूस" }, { en: "Shirala", mr: "शिराळा" }, { en: "Tasgaon", mr: "तासगाव" }, { en: "Walwa", mr: "वाळवा (इस्लामपूर)" }
    ]},
    { code: "SAT", en: "Satara", mr: "सातारा", talukas: [
      { en: "Jaoli", mr: "जावळी" }, { en: "Karad", mr: "कराड" }, { en: "Khandala", mr: "खंडाळा" },
      { en: "Khatav", mr: "खटाव" }, { en: "Koregaon", mr: "कोरेगाव" }, { en: "Mahabaleshwar", mr: "महाबळेश्वर" },
      { en: "Man", mr: "माण" }, { en: "Patan", mr: "पाटण" }, { en: "Phaltan", mr: "फलटण" },
      { en: "Satara", mr: "सातारा" }, { en: "Wai", mr: "वाई" }
    ]},
    { code: "SND", en: "Sindhudurg", mr: "सिंधुदुर्ग", talukas: [
      { en: "Devgad", mr: "देवगड" }, { en: "Dodamarg", mr: "दोडामार्ग" }, { en: "Kankavli", mr: "कणकवली" },
      { en: "Kudal", mr: "कुडाळ" }, { en: "Malvan", mr: "मालवण" }, { en: "Sawantwadi", mr: "सावंतवाडी" },
      { en: "Vaibhavwadi", mr: "वैभववाडी" }, { en: "Vengurla", mr: "वेंगुर्ला" }
    ]},
    { code: "SOL", en: "Solapur", mr: "सोलापूर", talukas: [
      { en: "Akkalkot", mr: "अक्कलकोट" }, { en: "Barshi", mr: "बार्शी" }, { en: "Karmala", mr: "करमाळा" },
      { en: "Madha", mr: "माढा" }, { en: "Malshiras", mr: "माळशिरस" }, { en: "Mangalwedha", mr: "मंगळवेढा" },
      { en: "Mohol", mr: "मोहोळ" }, { en: "Pandharpur", mr: "पंढरपूर" }, { en: "Sangole", mr: "सांगोला" },
      { en: "North Solapur", mr: "उत्तर सोलापूर" }, { en: "South Solapur", mr: "दक्षिण सोलापूर" }
    ]},
    { code: "THA", en: "Thane", mr: "ठाणे", talukas: [
      { en: "Ambernath", mr: "अंबरनाथ" }, { en: "Bhiwandi", mr: "भिवंडी" }, { en: "Kalyan", mr: "कल्याण" },
      { en: "Murbad", mr: "मुरबाड" }, { en: "Shahapur", mr: "शहापूर" }, { en: "Thane", mr: "ठाणे" },
      { en: "Ulhasnagar", mr: "उल्हासनगर" }
    ]},
    { code: "WRD", en: "Wardha", mr: "वर्धा", talukas: [
      { en: "Arvi", mr: "आर्वी" }, { en: "Ashti", mr: "आष्टी" }, { en: "Deoli", mr: "देवळी" },
      { en: "Hinganghat", mr: "हिंगणघाट" }, { en: "Karanja", mr: "कारंजा" }, { en: "Samudrapur", mr: "समुद्रपूर" },
      { en: "Seloo", mr: "सेलू" }, { en: "Wardha", mr: "वर्धा" }
    ]},
    { code: "WAS", en: "Washim", mr: "वाशीम", talukas: [
      { en: "Karanja", mr: "कारंजा" }, { en: "Malegaon", mr: "मालेगाव" }, { en: "Mangrulpir", mr: "मंगरुळपीर" },
      { en: "Manora", mr: "मानोरा" }, { en: "Risod", mr: "रिसोड" }, { en: "Washim", mr: "वाशीम" }
    ]},
    { code: "YAV", en: "Yavatmal", mr: "यवतमाळ", talukas: [
      { en: "Arni", mr: "आर्णी" }, { en: "Babhulgaon", mr: "बाभूळगाव" }, { en: "Darwha", mr: "दारव्हा" },
      { en: "Digras", mr: "दिग्रस" }, { en: "Ghatanji", mr: "घाटंजी" }, { en: "Kalamb", mr: "कळंब" },
      { en: "Mahagaon", mr: "महागाव" }, { en: "Maregaon", mr: "मारेगाव" }, { en: "Ner", mr: "नेर" },
      { en: "Pandharkawada", mr: "पांढरकवडा (केळापूर)" }, { en: "Pusad", mr: "पुसद" }, { en: "Ralegaon", mr: "राळेगाव" },
      { en: "Umarkhed", mr: "उमरखेड" }, { en: "Wani", mr: "वणी" }, { en: "Yavatmal", mr: "यवतमाळ" }, { en: "Zari Jamani", mr: "झरी जामणी" }
    ]}
  ];

  // Specific Talukas for Karnataka (Belagavi) and Gujarat (Surat)
  const specialDistrictsTalukas = {
    "Belagavi": [
      { en: "Belagavi City", mr: "बेळगाव शहर" }, { en: "Athani", mr: "अथणी" }, { en: "Bailhongal", mr: "बैलहोंगल" },
      { en: "Chikodi", mr: "चिकोडी" }, { en: "Gokak", mr: "गोकाक" }, { en: "Hukkeri", mr: "हुक्केरी" },
      { en: "Khanapur", mr: "खानापूर" }, { en: "Nipani", mr: "निपाणी" }, { en: "Raybag", mr: "रायबाग" },
      { en: "Ramdurg", mr: "रामदुर्ग" }, { en: "Saundatti", mr: "सौंदत्ती" }
    ],
    "Surat": [
      { en: "Surat City", mr: "सुरत शहर" }, { en: "Bardoli", mr: "बारडोली" }, { en: "Kamrej", mr: "कामरेज" },
      { en: "Mahuva", mr: "महुवा" }, { en: "Mandvi", mr: "मांडवी" }, { en: "Mangrol", mr: "मांगरोल" },
      { en: "Olpad", mr: "ओलपाड" }, { en: "Choryasi", mr: "चोऱ्यासी" }, { en: "Umarpada", mr: "उमरपाडा" }
    ]
  };

  // Build final States array
  const statesOutput = [];

  // 1. Maharashtra first
  statesOutput.push({
    code: "MH",
    nameEn: "Maharashtra",
    nameMr: "महाराष्ट्र",
    districts: mhDistricts.map(d => ({
      code: d.code,
      nameEn: d.en,
      nameMr: d.mr,
      talukas: d.talukas.map(t => ({ nameEn: t.en, nameMr: t.mr }))
    }))
  });

  // 2. Add all other states from statesJson
  for (const s of statesJson.states) {
    if (s.state === "Maharashtra") continue;
    const meta = stateMeta[s.state] || { code: s.state.substring(0, 2).toUpperCase(), mr: s.state };
    
    const distList = (s.districts || []).map(distName => {
      const code = distName.substring(0, 3).toUpperCase();
      const specificTalukas = specialDistrictsTalukas[distName] || [
        { en: `${distName} City / Central`, mr: `${distName} शहर / केंद्र` },
        { en: `${distName} Rural / East`, mr: `${distName} ग्रामीण / पूर्व` },
        { en: `${distName} Rural / West`, mr: `${distName} ग्रामीण / पश्चिम` }
      ];
      return {
        code: `${meta.code}-${code}`,
        nameEn: distName,
        nameMr: distName,
        talukas: specificTalukas.map(t => ({ nameEn: t.en, nameMr: t.mr }))
      };
    });

    statesOutput.push({
      code: meta.code,
      nameEn: s.state,
      nameMr: meta.mr,
      districts: distList
    });
  }

  // Ensure Ladakh is included if missing
  if (!statesOutput.find(s => s.code === "LA")) {
    statesOutput.push({
      code: "LA",
      nameEn: "Ladakh",
      nameMr: "लडाख",
      districts: [
        { code: "LA-LEH", nameEn: "Leh", nameMr: "लेह", talukas: [{ nameEn: "Leh", nameMr: "लेह" }] },
        { code: "LA-KAR", nameEn: "Kargil", nameMr: "कारगिल", talukas: [{ nameEn: "Kargil", nameMr: "कारगिल" }] }
      ]
    });
  }

  console.log(`Generated ${statesOutput.length} states/UTs.`);
  console.log(`Total districts in Maharashtra: ${statesOutput[0].districts.length}`);
  const totalTalukasMh = statesOutput[0].districts.reduce((acc, d) => acc + d.talukas.length, 0);
  console.log(`Total talukas in Maharashtra: ${totalTalukasMh}`);

  // Write JSON asset
  fs.mkdirSync('assets/data', { recursive: true });
  fs.writeFileSync('assets/data/india_geo_hierarchy.json', JSON.stringify(statesOutput, null, 2), 'utf-8');
  console.log('Saved assets/data/india_geo_hierarchy.json');

  // Now generate Dart constants file: lib/core/constants/geo_constants.dart
  let dart = `// GENERATED FILE - DO NOT EDIT MANUALLY
// Run "node scripts/generate_geo_constants.js" to regenerate

class TalukaInfo {
  final String nameEn;
  final String nameMr;

  const TalukaInfo({
    required this.nameEn,
    required this.nameMr,
  });

  @override
  String toString() => '$nameMr ($nameEn)';
}

class DistrictInfo {
  final String code;
  final String nameEn;
  final String nameMr;
  final List<TalukaInfo> talukas;

  const DistrictInfo({
    required this.code,
    required this.nameEn,
    required this.nameMr,
    this.talukas = const [],
  });

  @override
  String toString() => '$nameMr ($nameEn)';
}

class StateInfo {
  final String code;
  final String nameEn;
  final String nameMr;
  final List<DistrictInfo> districts;

  const StateInfo({
    required this.code,
    required this.nameEn,
    required this.nameMr,
    required this.districts,
  });

  @override
  String toString() => '$nameMr ($nameEn)';
}

abstract class GeoConstants {
  static const List<StateInfo> states = [
`;

  for (const s of statesOutput) {
    dart += `    StateInfo(\n`;
    dart += `      code: '${s.code}',\n`;
    dart += `      nameEn: '${s.nameEn.replace(/'/g, "\\'")}',\n`;
    dart += `      nameMr: '${s.nameMr.replace(/'/g, "\\'")}',\n`;
    dart += `      districts: [\n`;
    for (const d of s.districts) {
      dart += `        DistrictInfo(\n`;
      dart += `          code: '${d.code}',\n`;
      dart += `          nameEn: '${d.nameEn.replace(/'/g, "\\'")}',\n`;
      dart += `          nameMr: '${d.nameMr.replace(/'/g, "\\'")}',\n`;
      dart += `          talukas: [\n`;
      for (const t of d.talukas) {
        dart += `            TalukaInfo(nameEn: '${t.nameEn.replace(/'/g, "\\'")}', nameMr: '${t.nameMr.replace(/'/g, "\\'")}'),\n`;
      }
      dart += `          ],\n`;
      dart += `        ),\n`;
    }
    dart += `      ],\n`;
    dart += `    ),\n`;
  }

  dart += `  ];

  static StateInfo get defaultState => states.first; // Maharashtra

  static StateInfo getStateByCode(String code) {
    final upper = code.trim().toUpperCase();
    return states.firstWhere(
      (s) => s.code == upper || s.nameEn.toUpperCase() == upper,
      orElse: () => defaultState,
    );
  }

  static DistrictInfo getDistrictByCode(String code) {
    final upper = code.trim().toUpperCase();
    for (final s in states) {
      for (final d in s.districts) {
        if (d.code == upper || d.code.endsWith(upper)) return d;
      }
    }
    return defaultState.districts.firstWhere((d) => d.code == 'PUN');
  }

  static String getDistrictNameMr(String code) => getDistrictByCode(code).nameMr;
  static String getDistrictNameEn(String code) => getDistrictByCode(code).nameEn;
}
`;

  fs.writeFileSync('lib/core/constants/geo_constants.dart', dart, 'utf-8');
  console.log('Saved lib/core/constants/geo_constants.dart');
}

build().catch(err => {
  console.error('Error generating geo constants:', err);
  process.exit(1);
});
