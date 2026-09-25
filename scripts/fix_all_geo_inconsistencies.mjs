import { execSync } from 'child_process';
import fs from 'fs';

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
    { en: "Dadar", mr: "दादर" }, { en: "Byculla", mr: "भायखळा" }, { en: "Parel", mr: "परळ" },
    { en: "Wadala", mr: "वडाळा" }, { en: "Matunga", mr: "माटुंगा" }
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

// Alias map for common town / colloquial inputs
const talukaAliases = {
  // Satara
  "koregav": { en: "Koregaon", mr: "कोरेगाव" },
  "कोरेगांव": { en: "Koregaon", mr: "कोरेगाव" },
  "koregaon": { en: "Koregaon", mr: "कोरेगाव" },
  "कोरेगाव": { en: "Koregaon", mr: "कोरेगाव" },
  "dahiwadi": { en: "Man", mr: "माण" },
  "dahigaon": { en: "Koregaon", mr: "कोरेगाव" },
  "दहीगाव": { en: "Koregaon", mr: "कोरेगाव" },
  "दहिगाव": { en: "Koregaon", mr: "कोरेगाव" },

  // Pune
  "pune": { en: "Pune City", mr: "पुणे शहर" },
  "पुणे विभाग": { en: "Pune City", mr: "पुणे शहर" },
  "khed": { en: "Khed", mr: "खेड" },
  "maval": { en: "Maval", mr: "मावळ" },
  "haveli": { en: "Haveli", mr: "हवेली" },

  // Mumbai Suburban
  "बोरीवली": { en: "Borivali", mr: "बोरिवली" },
  "कांदिवली": { en: "Borivali", mr: "बोरिवली" },
  "मालाड": { en: "Borivali", mr: "बोरिवली" },
  "मुंबई": { en: "Borivali", mr: "बोरिवली" },

  // Mumbai City
  "माटुंगा": { en: "Mumbai City", mr: "मुंबई शहर" },
  "वडाळा": { en: "Mumbai City", mr: "मुंबई शहर" },

  // Thane
  "मीरारोड": { en: "Thane", mr: "ठाणे" },
  "mira road": { en: "Thane", mr: "ठाणे" },

  // Raigad
  "panvel": { en: "Panvel", mr: "पनवेल" },
  "सुधागड": { en: "Sudhagad", mr: "सुधागड (पाली)" },

  // Nashik
  "nashik": { en: "Nashik", mr: "नाशिक" },
  "deola": { en: "Deola", mr: "देवळा" },

  // Sangli
  "jath": { en: "Jat", mr: "जत" },

  // Ahilyanagar
  "jamkhed": { en: "Jamkhed", mr: "जामखेड" },

  // Nanded
  "dharmabad": { en: "Dharmabad", mr: "धर्माबाद" },

  // Hingoli
  "sengaon": { en: "Sengaon", mr: "सेनगाव" },

  // Chandrapur
  "jiwati": { en: "Jiwati", mr: "जिवती" },

  // Kolhapur
  "ajara": { en: "Ajara", mr: "आजरा" },

  // Amravati
  "चांदुर रेल्वे": { en: "Chandur Railway", mr: "चांदूर रेल्वे" },

  // Jalna
  "जाफराबाद": { en: "Jafrabad", mr: "जाफ्राबाद" },

  // Out of state
  "belgaum": { en: "Belagavi City", mr: "बेळगाव शहर" },
  "surat": { en: "Surat City", mr: "सुरत शहर" }
};

// Users explicitly preserved as demo data per user instruction
const PRESERVED_DEMO_USERS = new Set([
  '8691955046', // Jaydip Bhagwan Pawar
  '8652306970'  // Mayur Pawar
]);

async function runFix() {
  const token = execSync('gcloud auth print-access-token', { encoding: 'utf-8' }).trim();
  const projectId = 'maratha-shivmudra';
  const baseUrl = `https://firestore.googleapis.com/v1/projects/${projectId}/databases/(default)/documents`;
  
  console.log('--- Step 1: Fetching all members from Firestore ---');
  const res = await fetch(`${baseUrl}/members?pageSize=200`, { headers: { Authorization: `Bearer ${token}` } });
  const data = await res.json();
  const docs = data.documents || [];
  const regDocs = docs.filter(d => d.fields?.is_registered?.booleanValue === true);
  console.log(`Found ${regDocs.length} registered members.`);

  const distMap = new Map();
  for (const d of mhDistricts) {
    distMap.set(d.en.toLowerCase(), d);
    distMap.set(d.mr, d);
    distMap.set(d.code, d);
  }

  const updates = [];

  for (const d of regDocs) {
    const f = d.fields || {};
    const id = d.name.split('/').pop();

    if (PRESERVED_DEMO_USERS.has(id)) {
      console.log(`[SKIP DEMO USER] ${id} (${f.name?.stringValue || f.full_name_mr?.stringValue}) preserved as-is per instruction.`);
      continue;
    }

    const rawDist = (f.district?.stringValue || f.district_en?.stringValue || '').trim();
    const rawTaluka = (f.sub_district?.stringValue || f.taluka?.stringValue || f.taluka_en?.stringValue || '').trim();
    const rawState = (f.state?.stringValue || '').trim();
    const name = f.full_name_mr?.stringValue || f.name?.stringValue || '';

    let isSpecial = false;
    let canonicalDist = null;
    let canonicalTaluka = null;
    let canonicalState = { en: "Maharashtra", mr: "महाराष्ट्र", code: "MH" };

    if (rawDist.toLowerCase().includes('belag') || rawDist.toLowerCase().includes('belgaum')) {
      isSpecial = true;
      canonicalState = { en: "Karnataka", mr: "कर्नाटक", code: "KA" };
      canonicalDist = { en: "Belagavi", mr: "बेळगाव", code: "KA-BEL" };
      canonicalTaluka = { en: "Belagavi City", mr: "बेळगाव शहर" };
    } else if (rawDist.toLowerCase().includes('surat')) {
      isSpecial = true;
      canonicalState = { en: "Gujarat", mr: "गुजरात", code: "GJ" };
      canonicalDist = { en: "Surat", mr: "सुरत", code: "GJ-SUR" };
      canonicalTaluka = { en: "Surat City", mr: "सुरत शहर" };
    }

    if (!isSpecial) {
      canonicalDist = distMap.get(rawDist.toLowerCase()) || distMap.get(rawDist);
      if (!canonicalDist) {
        console.warn(`WARNING: Unknown district "${rawDist}" for user ${id} (${name})`);
        continue;
      }

      const lowerT = rawTaluka.toLowerCase();
      if (talukaAliases[lowerT] || talukaAliases[rawTaluka]) {
        canonicalTaluka = talukaAliases[lowerT] || talukaAliases[rawTaluka];
      } else {
        for (const t of canonicalDist.talukas) {
          if (t.en.toLowerCase() === lowerT || t.mr === rawTaluka) {
            canonicalTaluka = t;
            break;
          }
        }
        if (!canonicalTaluka) {
          for (const t of canonicalDist.talukas) {
            if (lowerT.includes(t.en.toLowerCase()) || t.en.toLowerCase().includes(lowerT) ||
                rawTaluka.includes(t.mr) || t.mr.includes(rawTaluka)) {
              canonicalTaluka = t;
              break;
            }
          }
        }
      }
    }

    if (!canonicalTaluka) {
      console.warn(`WARNING: Could not resolve taluka "${rawTaluka}" in district "${canonicalDist?.en}" for user ${id} (${name})`);
      continue;
    }

    // Determine if fields need standardization
    const currentTalukaEn = f.sub_district?.stringValue || '';
    const currentTalukaMr = f.sub_district_mr?.stringValue || '';
    const currentDistEn = f.district_en?.stringValue || f.district?.stringValue || '';
    const currentDistMr = f.district_mr?.stringValue || '';
    const currentDistCode = f.district_code?.stringValue || '';
    const currentStateEn = f.state?.stringValue || '';
    const currentStateCode = f.state_code?.stringValue || '';

    const needsUpdate =
      currentTalukaEn !== canonicalTaluka.en ||
      currentTalukaMr !== canonicalTaluka.mr ||
      f.taluka?.stringValue !== canonicalTaluka.en ||
      f.taluka_en?.stringValue !== canonicalTaluka.en ||
      f.taluka_mr?.stringValue !== canonicalTaluka.mr ||
      currentDistEn !== canonicalDist.en ||
      currentDistMr !== canonicalDist.mr ||
      currentDistCode !== canonicalDist.code ||
      currentStateEn !== canonicalState.en ||
      currentStateCode !== canonicalState.code;

    if (needsUpdate) {
      updates.push({
        id,
        name,
        docName: d.name,
        fields: {
          state: canonicalState.en,
          state_en: canonicalState.en,
          state_mr: canonicalState.mr,
          state_code: canonicalState.code,
          district: canonicalDist.en,
          district_en: canonicalDist.en,
          district_mr: canonicalDist.mr,
          district_code: canonicalDist.code,
          sub_district: canonicalTaluka.en,
          sub_district_mr: canonicalTaluka.mr,
          taluka: canonicalTaluka.en,
          taluka_en: canonicalTaluka.en,
          taluka_mr: canonicalTaluka.mr
        },
        oldValues: {
          sub_district: currentTalukaEn,
          district: currentDistEn
        }
      });
    }
  }

  console.log(`\n--- Step 2: Preparing ${updates.length} updates ---`);
  for (const u of updates) {
    console.log(`[STANDARDIZE] ${u.id} (${u.name}):`);
    console.log(`   FROM -> Dist: "${u.oldValues.district}", Taluka: "${u.oldValues.sub_district}"`);
    console.log(`   TO   -> Dist: "${u.fields.district}" (${u.fields.district_mr}) [${u.fields.district_code}], Taluka: "${u.fields.sub_district}" (${u.fields.sub_district_mr})`);
  }

  console.log('\n--- Step 3: Executing Firestore Updates in Batch ---');
  // Firestore commit API batch size <= 500
  const writes = updates.map(u => ({
    update: {
      name: u.docName,
      fields: Object.fromEntries(
        Object.entries(u.fields).map(([k, v]) => [k, { stringValue: v }])
      )
    },
    updateMask: {
      fieldPaths: Object.keys(u.fields)
    }
  }));

  const commitRes = await fetch(`${baseUrl}:commit`, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${token}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ writes })
  });

  if (!commitRes.ok) {
    const errText = await commitRes.text();
    console.error('Batch commit failed:', commitRes.status, errText);
    process.exit(1);
  }

  const commitData = await commitRes.json();
  console.log(`Successfully committed ${commitData.writeResults?.length || 0} document updates!`);

  console.log('\n--- Step 4: Verification Post-Update ---');
  const verifyRes = await fetch(`${baseUrl}/members?pageSize=200`, { headers: { Authorization: `Bearer ${token}` } });
  const verifyData = await verifyRes.json();
  const verifyDocs = verifyData.documents || [];
  
  // Verify Satara talukas specifically
  const sataraDocs = verifyDocs.filter(d => {
    const f = d.fields || {};
    return (f.district?.stringValue === 'Satara' || f.district_en?.stringValue === 'Satara') && f.is_registered?.booleanValue === true;
  });

  const sataraTalukaCounts = {};
  for (const d of sataraDocs) {
    const f = d.fields || {};
    const t = f.sub_district?.stringValue;
    sataraTalukaCounts[t] = (sataraTalukaCounts[t] || 0) + 1;
  }
  console.log('Satara Talukas Distribution:', sataraTalukaCounts);

  // Verify Pune talukas specifically
  const puneDocs = verifyDocs.filter(d => {
    const f = d.fields || {};
    return (f.district?.stringValue === 'Pune' || f.district_en?.stringValue === 'Pune') && f.is_registered?.booleanValue === true;
  });

  const puneTalukaCounts = {};
  for (const d of puneDocs) {
    const f = d.fields || {};
    const t = f.sub_district?.stringValue;
    puneTalukaCounts[t] = (puneTalukaCounts[t] || 0) + 1;
  }
  console.log('Pune Talukas Distribution:', puneTalukaCounts);
}

runFix().catch(console.error);
