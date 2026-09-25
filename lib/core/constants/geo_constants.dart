// GENERATED FILE - DO NOT EDIT MANUALLY
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
    StateInfo(
      code: 'MH',
      nameEn: 'Maharashtra',
      nameMr: 'महाराष्ट्र',
      districts: [
        DistrictInfo(
          code: 'AHI',
          nameEn: 'Ahilyanagar',
          nameMr: 'अहिल्यानगर',
          talukas: [
            TalukaInfo(nameEn: 'Akole', nameMr: 'अकोले'),
            TalukaInfo(nameEn: 'Jamkhed', nameMr: 'जामखेड'),
            TalukaInfo(nameEn: 'Karjat', nameMr: 'कर्जत'),
            TalukaInfo(nameEn: 'Kopargaon', nameMr: 'कोपरगाव'),
            TalukaInfo(nameEn: 'Nagar', nameMr: 'नगर'),
            TalukaInfo(nameEn: 'Nevasa', nameMr: 'नेवासा'),
            TalukaInfo(nameEn: 'Parner', nameMr: 'पारनेर'),
            TalukaInfo(nameEn: 'Pathardi', nameMr: 'पाथर्डी'),
            TalukaInfo(nameEn: 'Rahata', nameMr: 'राहाता'),
            TalukaInfo(nameEn: 'Rahuri', nameMr: 'राहुरी'),
            TalukaInfo(nameEn: 'Sangamner', nameMr: 'संगमनेर'),
            TalukaInfo(nameEn: 'Shevgaon', nameMr: 'शेवगाव'),
            TalukaInfo(nameEn: 'Shrigonda', nameMr: 'श्रीगोंदा'),
            TalukaInfo(nameEn: 'Shrirampur', nameMr: 'श्रीरामपूर'),
          ],
        ),
        DistrictInfo(
          code: 'AKL',
          nameEn: 'Akola',
          nameMr: 'अकोला',
          talukas: [
            TalukaInfo(nameEn: 'Akola', nameMr: 'अकोला'),
            TalukaInfo(nameEn: 'Akot', nameMr: 'अकोट'),
            TalukaInfo(nameEn: 'Balapur', nameMr: 'बाळापूर'),
            TalukaInfo(nameEn: 'Barshitakli', nameMr: 'बार्शीटाकळी'),
            TalukaInfo(nameEn: 'Murtijapur', nameMr: 'मुर्तिजापूर'),
            TalukaInfo(nameEn: 'Patur', nameMr: 'पातूर'),
            TalukaInfo(nameEn: 'Telhara', nameMr: 'तेल्हारा'),
          ],
        ),
        DistrictInfo(
          code: 'AMR',
          nameEn: 'Amravati',
          nameMr: 'अमरावती',
          talukas: [
            TalukaInfo(nameEn: 'Achalpur', nameMr: 'अचलपूर'),
            TalukaInfo(nameEn: 'Amravati', nameMr: 'अमरावती'),
            TalukaInfo(nameEn: 'Anjangaon Surji', nameMr: 'अंजनगाव सुर्जी'),
            TalukaInfo(nameEn: 'Bhatkuli', nameMr: 'भातकुली'),
            TalukaInfo(nameEn: 'Chandur Railway', nameMr: 'चांदूर रेल्वे'),
            TalukaInfo(nameEn: 'Chandur Bazar', nameMr: 'चांदूर बाजार'),
            TalukaInfo(nameEn: 'Chikhaldara', nameMr: 'चिखलदरा'),
            TalukaInfo(nameEn: 'Daryapur', nameMr: 'दर्यापूर'),
            TalukaInfo(nameEn: 'Dhamangaon Railway', nameMr: 'धामणगाव रेल्वे'),
            TalukaInfo(nameEn: 'Dharni', nameMr: 'धारणी'),
            TalukaInfo(nameEn: 'Morshi', nameMr: 'मोर्शी'),
            TalukaInfo(nameEn: 'Nandgaon Khandeshwar', nameMr: 'नांदगाव खंडेश्वर'),
            TalukaInfo(nameEn: 'Tiwsa', nameMr: 'तिवसा'),
            TalukaInfo(nameEn: 'Warud', nameMr: 'वरुड'),
          ],
        ),
        DistrictInfo(
          code: 'CSN',
          nameEn: 'Chhatrapati Sambhajinagar',
          nameMr: 'छत्रपती संभाजीनगर',
          talukas: [
            TalukaInfo(nameEn: 'Chhatrapati Sambhajinagar', nameMr: 'छत्रपती संभाजीनगर'),
            TalukaInfo(nameEn: 'Gangapur', nameMr: 'गंगापूर'),
            TalukaInfo(nameEn: 'Kannad', nameMr: 'कन्नड'),
            TalukaInfo(nameEn: 'Khuldabad', nameMr: 'खुलताबाद'),
            TalukaInfo(nameEn: 'Paithan', nameMr: 'पैठण'),
            TalukaInfo(nameEn: 'Phulambri', nameMr: 'फुलंब्री'),
            TalukaInfo(nameEn: 'Sillod', nameMr: 'सिल्लोड'),
            TalukaInfo(nameEn: 'Soegaon', nameMr: 'सोयगाव'),
            TalukaInfo(nameEn: 'Vaijapur', nameMr: 'वैजापूर'),
          ],
        ),
        DistrictInfo(
          code: 'BEE',
          nameEn: 'Beed',
          nameMr: 'बीड',
          talukas: [
            TalukaInfo(nameEn: 'Ambajogai', nameMr: 'अंबाजोगाई'),
            TalukaInfo(nameEn: 'Ashti', nameMr: 'आष्टी'),
            TalukaInfo(nameEn: 'Beed', nameMr: 'बीड'),
            TalukaInfo(nameEn: 'Dharur', nameMr: 'धारूर'),
            TalukaInfo(nameEn: 'Georai', nameMr: 'गेवराई'),
            TalukaInfo(nameEn: 'Kaij', nameMr: 'केज'),
            TalukaInfo(nameEn: 'Majalgaon', nameMr: 'माजलगाव'),
            TalukaInfo(nameEn: 'Parli', nameMr: 'परळी'),
            TalukaInfo(nameEn: 'Patoda', nameMr: 'पाटोदा'),
            TalukaInfo(nameEn: 'Shirur Kasar', nameMr: 'शिरूर कासार'),
            TalukaInfo(nameEn: 'Wadwani', nameMr: 'वडवणी'),
          ],
        ),
        DistrictInfo(
          code: 'BHA',
          nameEn: 'Bhandara',
          nameMr: 'भंडारा',
          talukas: [
            TalukaInfo(nameEn: 'Bhandara', nameMr: 'भंडारा'),
            TalukaInfo(nameEn: 'Lakhandur', nameMr: 'लाखांदूर'),
            TalukaInfo(nameEn: 'Lakhani', nameMr: 'लाखनी'),
            TalukaInfo(nameEn: 'Mohadi', nameMr: 'मोहाडी'),
            TalukaInfo(nameEn: 'Pauni', nameMr: 'पौनी'),
            TalukaInfo(nameEn: 'Sakoli', nameMr: 'साकोली'),
            TalukaInfo(nameEn: 'Tumsar', nameMr: 'तुमसर'),
          ],
        ),
        DistrictInfo(
          code: 'BUL',
          nameEn: 'Buldhana',
          nameMr: 'बुलढाणा',
          talukas: [
            TalukaInfo(nameEn: 'Buldhana', nameMr: 'बुलढाणा'),
            TalukaInfo(nameEn: 'Chikhli', nameMr: 'चिखली'),
            TalukaInfo(nameEn: 'Deulgaon Raja', nameMr: 'देऊळगाव राजा'),
            TalukaInfo(nameEn: 'Jalgaon Jamod', nameMr: 'जळगाव जामोद'),
            TalukaInfo(nameEn: 'Khamgaon', nameMr: 'खामगाव'),
            TalukaInfo(nameEn: 'Lonar', nameMr: 'लोणार'),
            TalukaInfo(nameEn: 'Malkapur', nameMr: 'मलकापूर'),
            TalukaInfo(nameEn: 'Mehkar', nameMr: 'मेहकर'),
            TalukaInfo(nameEn: 'Motala', nameMr: 'मोताळा'),
            TalukaInfo(nameEn: 'Nandura', nameMr: 'नांदुरा'),
            TalukaInfo(nameEn: 'Sangrampur', nameMr: 'संग्रामपूर'),
            TalukaInfo(nameEn: 'Shegaon', nameMr: 'शेगाव'),
            TalukaInfo(nameEn: 'Sindkhed Raja', nameMr: 'सिंदखेड राजा'),
          ],
        ),
        DistrictInfo(
          code: 'CHA',
          nameEn: 'Chandrapur',
          nameMr: 'चंद्रपूर',
          talukas: [
            TalukaInfo(nameEn: 'Ballarpur', nameMr: 'बल्लारपूर'),
            TalukaInfo(nameEn: 'Bhadravati', nameMr: 'भद्रावती'),
            TalukaInfo(nameEn: 'Bramhapuri', nameMr: 'ब्रह्मपुरी'),
            TalukaInfo(nameEn: 'Chandrapur', nameMr: 'चंद्रपूर'),
            TalukaInfo(nameEn: 'Chimur', nameMr: 'चिमूर'),
            TalukaInfo(nameEn: 'Gondpipri', nameMr: 'गोंडपिपरी'),
            TalukaInfo(nameEn: 'Jiwati', nameMr: 'जिवती'),
            TalukaInfo(nameEn: 'Korpana', nameMr: 'कोरपना'),
            TalukaInfo(nameEn: 'Mul', nameMr: 'मूल'),
            TalukaInfo(nameEn: 'Nagbhid', nameMr: 'नागभीड'),
            TalukaInfo(nameEn: 'Pombhurna', nameMr: 'पोंभुर्णा'),
            TalukaInfo(nameEn: 'Rajura', nameMr: 'राजुरा'),
            TalukaInfo(nameEn: 'Sawali', nameMr: 'सावली'),
            TalukaInfo(nameEn: 'Sindewahi', nameMr: 'सिंदेवाही'),
            TalukaInfo(nameEn: 'Warora', nameMr: 'वरोरा'),
          ],
        ),
        DistrictInfo(
          code: 'DHU',
          nameEn: 'Dhule',
          nameMr: 'धुळे',
          talukas: [
            TalukaInfo(nameEn: 'Dhule', nameMr: 'धुळे'),
            TalukaInfo(nameEn: 'Sakri', nameMr: 'साक्री'),
            TalukaInfo(nameEn: 'Shirpur', nameMr: 'शिरपूर'),
            TalukaInfo(nameEn: 'Sindkhede', nameMr: 'शिंदखेडा'),
          ],
        ),
        DistrictInfo(
          code: 'GAD',
          nameEn: 'Gadchiroli',
          nameMr: 'गडचिरोली',
          talukas: [
            TalukaInfo(nameEn: 'Aheri', nameMr: 'अहेरी'),
            TalukaInfo(nameEn: 'Armori', nameMr: 'आरमोरी'),
            TalukaInfo(nameEn: 'Bhamragad', nameMr: 'भामरागड'),
            TalukaInfo(nameEn: 'Chamorshi', nameMr: 'चामोर्शी'),
            TalukaInfo(nameEn: 'Dhanora', nameMr: 'धानोरा'),
            TalukaInfo(nameEn: 'Etapalli', nameMr: 'एटापल्ली'),
            TalukaInfo(nameEn: 'Gadchiroli', nameMr: 'गडचिरोली'),
            TalukaInfo(nameEn: 'Korchi', nameMr: 'कोरची'),
            TalukaInfo(nameEn: 'Kurkheda', nameMr: 'कुरखेडा'),
            TalukaInfo(nameEn: 'Mulchera', nameMr: 'मुलचेरा'),
            TalukaInfo(nameEn: 'Sironcha', nameMr: 'सिरोंचा'),
            TalukaInfo(nameEn: 'Wadsa', nameMr: 'वडसा'),
          ],
        ),
        DistrictInfo(
          code: 'GON',
          nameEn: 'Gondia',
          nameMr: 'गोंदिया',
          talukas: [
            TalukaInfo(nameEn: 'Amgaon', nameMr: 'आमगाव'),
            TalukaInfo(nameEn: 'Arjuni Morgaon', nameMr: 'अर्जुनी मोरगाव'),
            TalukaInfo(nameEn: 'Deori', nameMr: 'देवरी'),
            TalukaInfo(nameEn: 'Gondia', nameMr: 'गोंदिया'),
            TalukaInfo(nameEn: 'Goregaon', nameMr: 'गोरेगाव'),
            TalukaInfo(nameEn: 'Sadak Arjuni', nameMr: 'सडक अर्जुनी'),
            TalukaInfo(nameEn: 'Salekasa', nameMr: 'सालेकसा'),
            TalukaInfo(nameEn: 'Tirora', nameMr: 'तिरोरा'),
          ],
        ),
        DistrictInfo(
          code: 'HIN',
          nameEn: 'Hingoli',
          nameMr: 'हिंगोली',
          talukas: [
            TalukaInfo(nameEn: 'Aundha Nagnath', nameMr: 'औंढा नागनाथ'),
            TalukaInfo(nameEn: 'Basmath', nameMr: 'वसमत'),
            TalukaInfo(nameEn: 'Hingoli', nameMr: 'हिंगोली'),
            TalukaInfo(nameEn: 'Kalamnuri', nameMr: 'कलमनुरी'),
            TalukaInfo(nameEn: 'Sengaon', nameMr: 'सेनगाव'),
          ],
        ),
        DistrictInfo(
          code: 'JAL',
          nameEn: 'Jalgaon',
          nameMr: 'जळगाव',
          talukas: [
            TalukaInfo(nameEn: 'Amalner', nameMr: 'अमळनेर'),
            TalukaInfo(nameEn: 'Bhadgaon', nameMr: 'भडगाव'),
            TalukaInfo(nameEn: 'Bhusawal', nameMr: 'भुसावळ'),
            TalukaInfo(nameEn: 'Bodwad', nameMr: 'बोधवड'),
            TalukaInfo(nameEn: 'Chalisgaon', nameMr: 'चाळीसगाव'),
            TalukaInfo(nameEn: 'Chopda', nameMr: 'चोपडा'),
            TalukaInfo(nameEn: 'Dharangaon', nameMr: 'धरणगाव'),
            TalukaInfo(nameEn: 'Erandol', nameMr: 'एरंडोल'),
            TalukaInfo(nameEn: 'Jalgaon', nameMr: 'जळगाव'),
            TalukaInfo(nameEn: 'Jamner', nameMr: 'जामनेर'),
            TalukaInfo(nameEn: 'Muktainagar', nameMr: 'मुक्ताईनगर'),
            TalukaInfo(nameEn: 'Pachora', nameMr: 'पाचोरा'),
            TalukaInfo(nameEn: 'Parola', nameMr: 'पारोळा'),
            TalukaInfo(nameEn: 'Raver', nameMr: 'रावेर'),
            TalukaInfo(nameEn: 'Yawal', nameMr: 'यावल'),
          ],
        ),
        DistrictInfo(
          code: 'JLN',
          nameEn: 'Jalna',
          nameMr: 'जालना',
          talukas: [
            TalukaInfo(nameEn: 'Ambad', nameMr: 'अंबड'),
            TalukaInfo(nameEn: 'Badnapur', nameMr: 'बदनापूर'),
            TalukaInfo(nameEn: 'Bhokardan', nameMr: 'भोकरदन'),
            TalukaInfo(nameEn: 'Ghansawangi', nameMr: 'घनसावंगी'),
            TalukaInfo(nameEn: 'Jafrabad', nameMr: 'जाफ्राबाद'),
            TalukaInfo(nameEn: 'Jalna', nameMr: 'जालना'),
            TalukaInfo(nameEn: 'Mantha', nameMr: 'मंठा'),
            TalukaInfo(nameEn: 'Partur', nameMr: 'परतूर'),
          ],
        ),
        DistrictInfo(
          code: 'KOL',
          nameEn: 'Kolhapur',
          nameMr: 'कोल्हापूर',
          talukas: [
            TalukaInfo(nameEn: 'Ajara', nameMr: 'आजरा'),
            TalukaInfo(nameEn: 'Bavda', nameMr: 'गगनबावडा'),
            TalukaInfo(nameEn: 'Bhudargad', nameMr: 'भुदरगड'),
            TalukaInfo(nameEn: 'Chandgad', nameMr: 'चंदगड'),
            TalukaInfo(nameEn: 'Gadhinglaj', nameMr: 'गडहिंग्लज'),
            TalukaInfo(nameEn: 'Hatkanangale', nameMr: 'हातकणंगले'),
            TalukaInfo(nameEn: 'Kagal', nameMr: 'कागल'),
            TalukaInfo(nameEn: 'Karvir', nameMr: 'करवीर'),
            TalukaInfo(nameEn: 'Panhala', nameMr: 'पन्हाळा'),
            TalukaInfo(nameEn: 'Radhanagari', nameMr: 'राधानगरी'),
            TalukaInfo(nameEn: 'Shahuwadi', nameMr: 'शाहूवाडी'),
            TalukaInfo(nameEn: 'Shirol', nameMr: 'शिरोळ'),
          ],
        ),
        DistrictInfo(
          code: 'LAT',
          nameEn: 'Latur',
          nameMr: 'लातूर',
          talukas: [
            TalukaInfo(nameEn: 'Ahmedpur', nameMr: 'अहमदपूर'),
            TalukaInfo(nameEn: 'Ausa', nameMr: 'औसा'),
            TalukaInfo(nameEn: 'Chakur', nameMr: 'चाकूर'),
            TalukaInfo(nameEn: 'Deoni', nameMr: 'देवणी'),
            TalukaInfo(nameEn: 'Jalkot', nameMr: 'जळकोट'),
            TalukaInfo(nameEn: 'Latur', nameMr: 'लातूर'),
            TalukaInfo(nameEn: 'Renapur', nameMr: 'रेणापूर'),
            TalukaInfo(nameEn: 'Shirur Anantpal', nameMr: 'शिरूर अनंतपाळ'),
            TalukaInfo(nameEn: 'Udgir', nameMr: 'उदगीर'),
          ],
        ),
        DistrictInfo(
          code: 'MMC',
          nameEn: 'Mumbai City',
          nameMr: 'मुंबई शहर',
          talukas: [
            TalukaInfo(nameEn: 'Mumbai City', nameMr: 'मुंबई शहर'),
            TalukaInfo(nameEn: 'Colaba', nameMr: 'कुलाबा'),
            TalukaInfo(nameEn: 'Fort', nameMr: 'फोर्ट'),
            TalukaInfo(nameEn: 'Dadar', nameMr: 'दादर'),
            TalukaInfo(nameEn: 'Byculla', nameMr: 'भायखळा'),
            TalukaInfo(nameEn: 'Parel', nameMr: 'परळ'),
          ],
        ),
        DistrictInfo(
          code: 'MMS',
          nameEn: 'Mumbai Suburban',
          nameMr: 'मुंबई उपनगर',
          talukas: [
            TalukaInfo(nameEn: 'Andheri', nameMr: 'अंधेरी'),
            TalukaInfo(nameEn: 'Borivali', nameMr: 'बोरिवली'),
            TalukaInfo(nameEn: 'Kurla', nameMr: 'कुर्ला'),
          ],
        ),
        DistrictInfo(
          code: 'NAG',
          nameEn: 'Nagpur',
          nameMr: 'नागपूर',
          talukas: [
            TalukaInfo(nameEn: 'Hingna', nameMr: 'हिंगणा'),
            TalukaInfo(nameEn: 'Kalameshwar', nameMr: 'कळमेश्वर'),
            TalukaInfo(nameEn: 'Kamptee', nameMr: 'कामठी'),
            TalukaInfo(nameEn: 'Katol', nameMr: 'काटोल'),
            TalukaInfo(nameEn: 'Kuhi', nameMr: 'कुही'),
            TalukaInfo(nameEn: 'Mouda', nameMr: 'मौदा'),
            TalukaInfo(nameEn: 'Nagpur Rural', nameMr: 'नागपूर ग्रामीण'),
            TalukaInfo(nameEn: 'Nagpur Urban', nameMr: 'नागपूर शहर'),
            TalukaInfo(nameEn: 'Narkhed', nameMr: 'नरखेड'),
            TalukaInfo(nameEn: 'Parseoni', nameMr: 'पारशिवनी'),
            TalukaInfo(nameEn: 'Ramtek', nameMr: 'रामटेक'),
            TalukaInfo(nameEn: 'Saoner', nameMr: 'सावनेर'),
            TalukaInfo(nameEn: 'Umred', nameMr: 'उमरेड'),
          ],
        ),
        DistrictInfo(
          code: 'NED',
          nameEn: 'Nanded',
          nameMr: 'नांदेड',
          talukas: [
            TalukaInfo(nameEn: 'Ardhapur', nameMr: 'अर्धापूर'),
            TalukaInfo(nameEn: 'Bhokar', nameMr: 'भोकर'),
            TalukaInfo(nameEn: 'Biloli', nameMr: 'बिलोली'),
            TalukaInfo(nameEn: 'Deglur', nameMr: 'देगलूर'),
            TalukaInfo(nameEn: 'Dharmabad', nameMr: 'धर्माबाद'),
            TalukaInfo(nameEn: 'Hadgaon', nameMr: 'हदगाव'),
            TalukaInfo(nameEn: 'Himayatnagar', nameMr: 'हिमायतनगर'),
            TalukaInfo(nameEn: 'Kandhar', nameMr: 'कंधार'),
            TalukaInfo(nameEn: 'Kinwat', nameMr: 'किनवट'),
            TalukaInfo(nameEn: 'Loha', nameMr: 'लोहा'),
            TalukaInfo(nameEn: 'Mahur', nameMr: 'माहूर'),
            TalukaInfo(nameEn: 'Mudkhed', nameMr: 'मुदखेड'),
            TalukaInfo(nameEn: 'Mukhed', nameMr: 'मुखेड'),
            TalukaInfo(nameEn: 'Naigaon', nameMr: 'नायगाव'),
            TalukaInfo(nameEn: 'Nanded', nameMr: 'नांदेड'),
            TalukaInfo(nameEn: 'Umri', nameMr: 'उमरी'),
          ],
        ),
        DistrictInfo(
          code: 'NDB',
          nameEn: 'Nandurbar',
          nameMr: 'नंदुरबार',
          talukas: [
            TalukaInfo(nameEn: 'Akkalkuwa', nameMr: 'अक्कलकुवा'),
            TalukaInfo(nameEn: 'Akrani', nameMr: 'अक्राणी (धडगाव)'),
            TalukaInfo(nameEn: 'Nandurbar', nameMr: 'नंदुरबार'),
            TalukaInfo(nameEn: 'Navapur', nameMr: 'नवापूर'),
            TalukaInfo(nameEn: 'Shahada', nameMr: 'शहादा'),
            TalukaInfo(nameEn: 'Taloda', nameMr: 'तळोजा'),
          ],
        ),
        DistrictInfo(
          code: 'NSK',
          nameEn: 'Nashik',
          nameMr: 'नाशिक',
          talukas: [
            TalukaInfo(nameEn: 'Baglan', nameMr: 'बागलाण (सटाणा)'),
            TalukaInfo(nameEn: 'Chandwad', nameMr: 'चांदवड'),
            TalukaInfo(nameEn: 'Deola', nameMr: 'देवळा'),
            TalukaInfo(nameEn: 'Dindori', nameMr: 'दिंडोरी'),
            TalukaInfo(nameEn: 'Igatpuri', nameMr: 'इगतपुरी'),
            TalukaInfo(nameEn: 'Kalwan', nameMr: 'कळवण'),
            TalukaInfo(nameEn: 'Malegaon', nameMr: 'मालेगाव'),
            TalukaInfo(nameEn: 'Nandgaon', nameMr: 'नांदगाव'),
            TalukaInfo(nameEn: 'Nashik', nameMr: 'नाशिक'),
            TalukaInfo(nameEn: 'Niphad', nameMr: 'निफाड'),
            TalukaInfo(nameEn: 'Peint', nameMr: 'पेठ'),
            TalukaInfo(nameEn: 'Sinnar', nameMr: 'सिन्नर'),
            TalukaInfo(nameEn: 'Surgana', nameMr: 'सुरगाणा'),
            TalukaInfo(nameEn: 'Trimbakeshwar', nameMr: 'त्र्यंबकेश्वर'),
            TalukaInfo(nameEn: 'Yevala', nameMr: 'येवला'),
          ],
        ),
        DistrictInfo(
          code: 'DHA',
          nameEn: 'Dharashiv',
          nameMr: 'धाराशिव',
          talukas: [
            TalukaInfo(nameEn: 'Bhoom', nameMr: 'भूम'),
            TalukaInfo(nameEn: 'Dharashiv', nameMr: 'धाराशिव'),
            TalukaInfo(nameEn: 'Kalamb', nameMr: 'कळंब'),
            TalukaInfo(nameEn: 'Lohara', nameMr: 'लोहारा'),
            TalukaInfo(nameEn: 'Omerga', nameMr: 'उमरगा'),
            TalukaInfo(nameEn: 'Paranda', nameMr: 'परांडा'),
            TalukaInfo(nameEn: 'Tuljapur', nameMr: 'तुळजापूर'),
            TalukaInfo(nameEn: 'Washi', nameMr: 'वाशी'),
          ],
        ),
        DistrictInfo(
          code: 'PLG',
          nameEn: 'Palghar',
          nameMr: 'पालघर',
          talukas: [
            TalukaInfo(nameEn: 'Dahanu', nameMr: 'डहाणू'),
            TalukaInfo(nameEn: 'Jawhar', nameMr: 'जव्हार'),
            TalukaInfo(nameEn: 'Mokhada', nameMr: 'मोखाडा'),
            TalukaInfo(nameEn: 'Palghar', nameMr: 'पालघर'),
            TalukaInfo(nameEn: 'Talasari', nameMr: 'तलासरी'),
            TalukaInfo(nameEn: 'Vada', nameMr: 'वाडा'),
            TalukaInfo(nameEn: 'Vasai', nameMr: 'वसई'),
            TalukaInfo(nameEn: 'Vikramgad', nameMr: 'विक्रमगड'),
          ],
        ),
        DistrictInfo(
          code: 'PRB',
          nameEn: 'Parbhani',
          nameMr: 'परभणी',
          talukas: [
            TalukaInfo(nameEn: 'Gangakhed', nameMr: 'गंगाखेड'),
            TalukaInfo(nameEn: 'Jintur', nameMr: 'जिंतूर'),
            TalukaInfo(nameEn: 'Manwath', nameMr: 'मानवत'),
            TalukaInfo(nameEn: 'Palam', nameMr: 'पालम'),
            TalukaInfo(nameEn: 'Parbhani', nameMr: 'परभणी'),
            TalukaInfo(nameEn: 'Pathri', nameMr: 'पाथरी'),
            TalukaInfo(nameEn: 'Purna', nameMr: 'पूर्णा'),
            TalukaInfo(nameEn: 'Sailu', nameMr: 'सेलू'),
            TalukaInfo(nameEn: 'Sonpeth', nameMr: 'सोनपेठ'),
          ],
        ),
        DistrictInfo(
          code: 'PUN',
          nameEn: 'Pune',
          nameMr: 'पुणे',
          talukas: [
            TalukaInfo(nameEn: 'Ambegaon', nameMr: 'आंबेगाव'),
            TalukaInfo(nameEn: 'Baramati', nameMr: 'बारामती'),
            TalukaInfo(nameEn: 'Bhor', nameMr: 'भोर'),
            TalukaInfo(nameEn: 'Daund', nameMr: 'दौंड'),
            TalukaInfo(nameEn: 'Haveli', nameMr: 'हवेली'),
            TalukaInfo(nameEn: 'Indapur', nameMr: 'इंदापूर'),
            TalukaInfo(nameEn: 'Junnar', nameMr: 'जुन्नर'),
            TalukaInfo(nameEn: 'Khed', nameMr: 'खेड'),
            TalukaInfo(nameEn: 'Maval', nameMr: 'मावळ'),
            TalukaInfo(nameEn: 'Mulshi', nameMr: 'मुळशी'),
            TalukaInfo(nameEn: 'Pimpri-Chinchwad', nameMr: 'पिंपरी-चिंचवड'),
            TalukaInfo(nameEn: 'Pune City', nameMr: 'पुणे शहर'),
            TalukaInfo(nameEn: 'Purandar', nameMr: 'पुरंदर'),
            TalukaInfo(nameEn: 'Shirur', nameMr: 'शिरूर'),
            TalukaInfo(nameEn: 'Velhe', nameMr: 'वेल्हे'),
          ],
        ),
        DistrictInfo(
          code: 'RAI',
          nameEn: 'Raigad',
          nameMr: 'रायगड',
          talukas: [
            TalukaInfo(nameEn: 'Alibag', nameMr: 'अलिबाग'),
            TalukaInfo(nameEn: 'Karjat', nameMr: 'कर्जत'),
            TalukaInfo(nameEn: 'Khalapur', nameMr: 'खालापूर'),
            TalukaInfo(nameEn: 'Mahad', nameMr: 'महाड'),
            TalukaInfo(nameEn: 'Mangaon', nameMr: 'माणगाव'),
            TalukaInfo(nameEn: 'Mhasla', nameMr: 'म्हसळा'),
            TalukaInfo(nameEn: 'Murud', nameMr: 'मुरुड'),
            TalukaInfo(nameEn: 'Panvel', nameMr: 'पनवेल'),
            TalukaInfo(nameEn: 'Pen', nameMr: 'पेण'),
            TalukaInfo(nameEn: 'Poladpur', nameMr: 'पोलादपूर'),
            TalukaInfo(nameEn: 'Roha', nameMr: 'रोहा'),
            TalukaInfo(nameEn: 'Shrivardhan', nameMr: 'श्रीवर्धन'),
            TalukaInfo(nameEn: 'Sudhagad', nameMr: 'सुधागड (पाली)'),
            TalukaInfo(nameEn: 'Tala', nameMr: 'तळा'),
            TalukaInfo(nameEn: 'Uran', nameMr: 'उरण'),
          ],
        ),
        DistrictInfo(
          code: 'RAT',
          nameEn: 'Ratnagiri',
          nameMr: 'रत्नागिरी',
          talukas: [
            TalukaInfo(nameEn: 'Chiplun', nameMr: 'चिपळूण'),
            TalukaInfo(nameEn: 'Dapoli', nameMr: 'दापोली'),
            TalukaInfo(nameEn: 'Guhagar', nameMr: 'गुहागर'),
            TalukaInfo(nameEn: 'Khed', nameMr: 'खेड'),
            TalukaInfo(nameEn: 'Lanja', nameMr: 'लांजा'),
            TalukaInfo(nameEn: 'Mandangad', nameMr: 'मंडणगड'),
            TalukaInfo(nameEn: 'Rajapur', nameMr: 'राजापूर'),
            TalukaInfo(nameEn: 'Ratnagiri', nameMr: 'रत्नागिरी'),
            TalukaInfo(nameEn: 'Sangameshwar', nameMr: 'संगमेश्वर'),
          ],
        ),
        DistrictInfo(
          code: 'SAN',
          nameEn: 'Sangli',
          nameMr: 'सांगली',
          talukas: [
            TalukaInfo(nameEn: 'Atpadi', nameMr: 'आटपाडी'),
            TalukaInfo(nameEn: 'Jat', nameMr: 'जत'),
            TalukaInfo(nameEn: 'Kadegaon', nameMr: 'कडेगाव'),
            TalukaInfo(nameEn: 'Kavathe Mahankal', nameMr: 'कवठे महांकाळ'),
            TalukaInfo(nameEn: 'Khanapur', nameMr: 'खानापूर (विटा)'),
            TalukaInfo(nameEn: 'Miraj', nameMr: 'मिरज'),
            TalukaInfo(nameEn: 'Palus', nameMr: 'पलूस'),
            TalukaInfo(nameEn: 'Shirala', nameMr: 'शिराळा'),
            TalukaInfo(nameEn: 'Tasgaon', nameMr: 'तासगाव'),
            TalukaInfo(nameEn: 'Walwa', nameMr: 'वाळवा (इस्लामपूर)'),
          ],
        ),
        DistrictInfo(
          code: 'SAT',
          nameEn: 'Satara',
          nameMr: 'सातारा',
          talukas: [
            TalukaInfo(nameEn: 'Jaoli', nameMr: 'जावळी'),
            TalukaInfo(nameEn: 'Karad', nameMr: 'कराड'),
            TalukaInfo(nameEn: 'Khandala', nameMr: 'खंडाळा'),
            TalukaInfo(nameEn: 'Khatav', nameMr: 'खटाव'),
            TalukaInfo(nameEn: 'Koregaon', nameMr: 'कोरेगाव'),
            TalukaInfo(nameEn: 'Mahabaleshwar', nameMr: 'महाबळेश्वर'),
            TalukaInfo(nameEn: 'Man', nameMr: 'माण'),
            TalukaInfo(nameEn: 'Patan', nameMr: 'पाटण'),
            TalukaInfo(nameEn: 'Phaltan', nameMr: 'फलटण'),
            TalukaInfo(nameEn: 'Satara', nameMr: 'सातारा'),
            TalukaInfo(nameEn: 'Wai', nameMr: 'वाई'),
          ],
        ),
        DistrictInfo(
          code: 'SND',
          nameEn: 'Sindhudurg',
          nameMr: 'सिंधुदुर्ग',
          talukas: [
            TalukaInfo(nameEn: 'Devgad', nameMr: 'देवगड'),
            TalukaInfo(nameEn: 'Dodamarg', nameMr: 'दोडामार्ग'),
            TalukaInfo(nameEn: 'Kankavli', nameMr: 'कणकवली'),
            TalukaInfo(nameEn: 'Kudal', nameMr: 'कुडाळ'),
            TalukaInfo(nameEn: 'Malvan', nameMr: 'मालवण'),
            TalukaInfo(nameEn: 'Sawantwadi', nameMr: 'सावंतवाडी'),
            TalukaInfo(nameEn: 'Vaibhavwadi', nameMr: 'वैभववाडी'),
            TalukaInfo(nameEn: 'Vengurla', nameMr: 'वेंगुर्ला'),
          ],
        ),
        DistrictInfo(
          code: 'SOL',
          nameEn: 'Solapur',
          nameMr: 'सोलापूर',
          talukas: [
            TalukaInfo(nameEn: 'Akkalkot', nameMr: 'अक्कलकोट'),
            TalukaInfo(nameEn: 'Barshi', nameMr: 'बार्शी'),
            TalukaInfo(nameEn: 'Karmala', nameMr: 'करमाळा'),
            TalukaInfo(nameEn: 'Madha', nameMr: 'माढा'),
            TalukaInfo(nameEn: 'Malshiras', nameMr: 'माळशिरस'),
            TalukaInfo(nameEn: 'Mangalwedha', nameMr: 'मंगळवेढा'),
            TalukaInfo(nameEn: 'Mohol', nameMr: 'मोहोळ'),
            TalukaInfo(nameEn: 'Pandharpur', nameMr: 'पंढरपूर'),
            TalukaInfo(nameEn: 'Sangole', nameMr: 'सांगोला'),
            TalukaInfo(nameEn: 'North Solapur', nameMr: 'उत्तर सोलापूर'),
            TalukaInfo(nameEn: 'South Solapur', nameMr: 'दक्षिण सोलापूर'),
          ],
        ),
        DistrictInfo(
          code: 'THA',
          nameEn: 'Thane',
          nameMr: 'ठाणे',
          talukas: [
            TalukaInfo(nameEn: 'Ambernath', nameMr: 'अंबरनाथ'),
            TalukaInfo(nameEn: 'Bhiwandi', nameMr: 'भिवंडी'),
            TalukaInfo(nameEn: 'Kalyan', nameMr: 'कल्याण'),
            TalukaInfo(nameEn: 'Murbad', nameMr: 'मुरबाड'),
            TalukaInfo(nameEn: 'Shahapur', nameMr: 'शहापूर'),
            TalukaInfo(nameEn: 'Thane', nameMr: 'ठाणे'),
            TalukaInfo(nameEn: 'Ulhasnagar', nameMr: 'उल्हासनगर'),
          ],
        ),
        DistrictInfo(
          code: 'WRD',
          nameEn: 'Wardha',
          nameMr: 'वर्धा',
          talukas: [
            TalukaInfo(nameEn: 'Arvi', nameMr: 'आर्वी'),
            TalukaInfo(nameEn: 'Ashti', nameMr: 'आष्टी'),
            TalukaInfo(nameEn: 'Deoli', nameMr: 'देवळी'),
            TalukaInfo(nameEn: 'Hinganghat', nameMr: 'हिंगणघाट'),
            TalukaInfo(nameEn: 'Karanja', nameMr: 'कारंजा'),
            TalukaInfo(nameEn: 'Samudrapur', nameMr: 'समुद्रपूर'),
            TalukaInfo(nameEn: 'Seloo', nameMr: 'सेलू'),
            TalukaInfo(nameEn: 'Wardha', nameMr: 'वर्धा'),
          ],
        ),
        DistrictInfo(
          code: 'WAS',
          nameEn: 'Washim',
          nameMr: 'वाशीम',
          talukas: [
            TalukaInfo(nameEn: 'Karanja', nameMr: 'कारंजा'),
            TalukaInfo(nameEn: 'Malegaon', nameMr: 'मालेगाव'),
            TalukaInfo(nameEn: 'Mangrulpir', nameMr: 'मंगरुळपीर'),
            TalukaInfo(nameEn: 'Manora', nameMr: 'मानोरा'),
            TalukaInfo(nameEn: 'Risod', nameMr: 'रिसोड'),
            TalukaInfo(nameEn: 'Washim', nameMr: 'वाशीम'),
          ],
        ),
        DistrictInfo(
          code: 'YAV',
          nameEn: 'Yavatmal',
          nameMr: 'यवतमाळ',
          talukas: [
            TalukaInfo(nameEn: 'Arni', nameMr: 'आर्णी'),
            TalukaInfo(nameEn: 'Babhulgaon', nameMr: 'बाभूळगाव'),
            TalukaInfo(nameEn: 'Darwha', nameMr: 'दारव्हा'),
            TalukaInfo(nameEn: 'Digras', nameMr: 'दिग्रस'),
            TalukaInfo(nameEn: 'Ghatanji', nameMr: 'घाटंजी'),
            TalukaInfo(nameEn: 'Kalamb', nameMr: 'कळंब'),
            TalukaInfo(nameEn: 'Mahagaon', nameMr: 'महागाव'),
            TalukaInfo(nameEn: 'Maregaon', nameMr: 'मारेगाव'),
            TalukaInfo(nameEn: 'Ner', nameMr: 'नेर'),
            TalukaInfo(nameEn: 'Pandharkawada', nameMr: 'पांढरकवडा (केळापूर)'),
            TalukaInfo(nameEn: 'Pusad', nameMr: 'पुसद'),
            TalukaInfo(nameEn: 'Ralegaon', nameMr: 'राळेगाव'),
            TalukaInfo(nameEn: 'Umarkhed', nameMr: 'उमरखेड'),
            TalukaInfo(nameEn: 'Wani', nameMr: 'वणी'),
            TalukaInfo(nameEn: 'Yavatmal', nameMr: 'यवतमाळ'),
            TalukaInfo(nameEn: 'Zari Jamani', nameMr: 'झरी जामणी'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'AP',
      nameEn: 'Andhra Pradesh',
      nameMr: 'आंध्र प्रदेश',
      districts: [
        DistrictInfo(
          code: 'AP-ANA',
          nameEn: 'Anantapur',
          nameMr: 'Anantapur',
          talukas: [
            TalukaInfo(nameEn: 'Anantapur City / Central', nameMr: 'Anantapur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Anantapur Rural / East', nameMr: 'Anantapur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Anantapur Rural / West', nameMr: 'Anantapur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AP-CHI',
          nameEn: 'Chittoor',
          nameMr: 'Chittoor',
          talukas: [
            TalukaInfo(nameEn: 'Chittoor City / Central', nameMr: 'Chittoor शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chittoor Rural / East', nameMr: 'Chittoor ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chittoor Rural / West', nameMr: 'Chittoor ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AP-EAS',
          nameEn: 'East Godavari',
          nameMr: 'East Godavari',
          talukas: [
            TalukaInfo(nameEn: 'East Godavari City / Central', nameMr: 'East Godavari शहर / केंद्र'),
            TalukaInfo(nameEn: 'East Godavari Rural / East', nameMr: 'East Godavari ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'East Godavari Rural / West', nameMr: 'East Godavari ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AP-GUN',
          nameEn: 'Guntur',
          nameMr: 'Guntur',
          talukas: [
            TalukaInfo(nameEn: 'Guntur City / Central', nameMr: 'Guntur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Guntur Rural / East', nameMr: 'Guntur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Guntur Rural / West', nameMr: 'Guntur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AP-KRI',
          nameEn: 'Krishna',
          nameMr: 'Krishna',
          talukas: [
            TalukaInfo(nameEn: 'Krishna City / Central', nameMr: 'Krishna शहर / केंद्र'),
            TalukaInfo(nameEn: 'Krishna Rural / East', nameMr: 'Krishna ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Krishna Rural / West', nameMr: 'Krishna ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AP-KUR',
          nameEn: 'Kurnool',
          nameMr: 'Kurnool',
          talukas: [
            TalukaInfo(nameEn: 'Kurnool City / Central', nameMr: 'Kurnool शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kurnool Rural / East', nameMr: 'Kurnool ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kurnool Rural / West', nameMr: 'Kurnool ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AP-NEL',
          nameEn: 'Nellore',
          nameMr: 'Nellore',
          talukas: [
            TalukaInfo(nameEn: 'Nellore City / Central', nameMr: 'Nellore शहर / केंद्र'),
            TalukaInfo(nameEn: 'Nellore Rural / East', nameMr: 'Nellore ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Nellore Rural / West', nameMr: 'Nellore ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AP-PRA',
          nameEn: 'Prakasam',
          nameMr: 'Prakasam',
          talukas: [
            TalukaInfo(nameEn: 'Prakasam City / Central', nameMr: 'Prakasam शहर / केंद्र'),
            TalukaInfo(nameEn: 'Prakasam Rural / East', nameMr: 'Prakasam ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Prakasam Rural / West', nameMr: 'Prakasam ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AP-SRI',
          nameEn: 'Srikakulam',
          nameMr: 'Srikakulam',
          talukas: [
            TalukaInfo(nameEn: 'Srikakulam City / Central', nameMr: 'Srikakulam शहर / केंद्र'),
            TalukaInfo(nameEn: 'Srikakulam Rural / East', nameMr: 'Srikakulam ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Srikakulam Rural / West', nameMr: 'Srikakulam ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AP-VIS',
          nameEn: 'Visakhapatnam',
          nameMr: 'Visakhapatnam',
          talukas: [
            TalukaInfo(nameEn: 'Visakhapatnam City / Central', nameMr: 'Visakhapatnam शहर / केंद्र'),
            TalukaInfo(nameEn: 'Visakhapatnam Rural / East', nameMr: 'Visakhapatnam ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Visakhapatnam Rural / West', nameMr: 'Visakhapatnam ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AP-VIZ',
          nameEn: 'Vizianagaram',
          nameMr: 'Vizianagaram',
          talukas: [
            TalukaInfo(nameEn: 'Vizianagaram City / Central', nameMr: 'Vizianagaram शहर / केंद्र'),
            TalukaInfo(nameEn: 'Vizianagaram Rural / East', nameMr: 'Vizianagaram ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Vizianagaram Rural / West', nameMr: 'Vizianagaram ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AP-WES',
          nameEn: 'West Godavari',
          nameMr: 'West Godavari',
          talukas: [
            TalukaInfo(nameEn: 'West Godavari City / Central', nameMr: 'West Godavari शहर / केंद्र'),
            TalukaInfo(nameEn: 'West Godavari Rural / East', nameMr: 'West Godavari ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'West Godavari Rural / West', nameMr: 'West Godavari ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AP-YSR',
          nameEn: 'YSR Kadapa',
          nameMr: 'YSR Kadapa',
          talukas: [
            TalukaInfo(nameEn: 'YSR Kadapa City / Central', nameMr: 'YSR Kadapa शहर / केंद्र'),
            TalukaInfo(nameEn: 'YSR Kadapa Rural / East', nameMr: 'YSR Kadapa ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'YSR Kadapa Rural / West', nameMr: 'YSR Kadapa ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'AR',
      nameEn: 'Arunachal Pradesh',
      nameMr: 'अरुणाचल प्रदेश',
      districts: [
        DistrictInfo(
          code: 'AR-TAW',
          nameEn: 'Tawang',
          nameMr: 'Tawang',
          talukas: [
            TalukaInfo(nameEn: 'Tawang City / Central', nameMr: 'Tawang शहर / केंद्र'),
            TalukaInfo(nameEn: 'Tawang Rural / East', nameMr: 'Tawang ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Tawang Rural / West', nameMr: 'Tawang ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-WES',
          nameEn: 'West Kameng',
          nameMr: 'West Kameng',
          talukas: [
            TalukaInfo(nameEn: 'West Kameng City / Central', nameMr: 'West Kameng शहर / केंद्र'),
            TalukaInfo(nameEn: 'West Kameng Rural / East', nameMr: 'West Kameng ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'West Kameng Rural / West', nameMr: 'West Kameng ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-EAS',
          nameEn: 'East Kameng',
          nameMr: 'East Kameng',
          talukas: [
            TalukaInfo(nameEn: 'East Kameng City / Central', nameMr: 'East Kameng शहर / केंद्र'),
            TalukaInfo(nameEn: 'East Kameng Rural / East', nameMr: 'East Kameng ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'East Kameng Rural / West', nameMr: 'East Kameng ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-PAP',
          nameEn: 'Papum Pare',
          nameMr: 'Papum Pare',
          talukas: [
            TalukaInfo(nameEn: 'Papum Pare City / Central', nameMr: 'Papum Pare शहर / केंद्र'),
            TalukaInfo(nameEn: 'Papum Pare Rural / East', nameMr: 'Papum Pare ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Papum Pare Rural / West', nameMr: 'Papum Pare ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-KUR',
          nameEn: 'Kurung Kumey',
          nameMr: 'Kurung Kumey',
          talukas: [
            TalukaInfo(nameEn: 'Kurung Kumey City / Central', nameMr: 'Kurung Kumey शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kurung Kumey Rural / East', nameMr: 'Kurung Kumey ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kurung Kumey Rural / West', nameMr: 'Kurung Kumey ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-KRA',
          nameEn: 'Kra Daadi',
          nameMr: 'Kra Daadi',
          talukas: [
            TalukaInfo(nameEn: 'Kra Daadi City / Central', nameMr: 'Kra Daadi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kra Daadi Rural / East', nameMr: 'Kra Daadi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kra Daadi Rural / West', nameMr: 'Kra Daadi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-LOW',
          nameEn: 'Lower Subansiri',
          nameMr: 'Lower Subansiri',
          talukas: [
            TalukaInfo(nameEn: 'Lower Subansiri City / Central', nameMr: 'Lower Subansiri शहर / केंद्र'),
            TalukaInfo(nameEn: 'Lower Subansiri Rural / East', nameMr: 'Lower Subansiri ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Lower Subansiri Rural / West', nameMr: 'Lower Subansiri ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-UPP',
          nameEn: 'Upper Subansiri',
          nameMr: 'Upper Subansiri',
          talukas: [
            TalukaInfo(nameEn: 'Upper Subansiri City / Central', nameMr: 'Upper Subansiri शहर / केंद्र'),
            TalukaInfo(nameEn: 'Upper Subansiri Rural / East', nameMr: 'Upper Subansiri ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Upper Subansiri Rural / West', nameMr: 'Upper Subansiri ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-WES',
          nameEn: 'West Siang',
          nameMr: 'West Siang',
          talukas: [
            TalukaInfo(nameEn: 'West Siang City / Central', nameMr: 'West Siang शहर / केंद्र'),
            TalukaInfo(nameEn: 'West Siang Rural / East', nameMr: 'West Siang ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'West Siang Rural / West', nameMr: 'West Siang ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-EAS',
          nameEn: 'East Siang',
          nameMr: 'East Siang',
          talukas: [
            TalukaInfo(nameEn: 'East Siang City / Central', nameMr: 'East Siang शहर / केंद्र'),
            TalukaInfo(nameEn: 'East Siang Rural / East', nameMr: 'East Siang ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'East Siang Rural / West', nameMr: 'East Siang ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-SIA',
          nameEn: 'Siang',
          nameMr: 'Siang',
          talukas: [
            TalukaInfo(nameEn: 'Siang City / Central', nameMr: 'Siang शहर / केंद्र'),
            TalukaInfo(nameEn: 'Siang Rural / East', nameMr: 'Siang ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Siang Rural / West', nameMr: 'Siang ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-UPP',
          nameEn: 'Upper Siang',
          nameMr: 'Upper Siang',
          talukas: [
            TalukaInfo(nameEn: 'Upper Siang City / Central', nameMr: 'Upper Siang शहर / केंद्र'),
            TalukaInfo(nameEn: 'Upper Siang Rural / East', nameMr: 'Upper Siang ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Upper Siang Rural / West', nameMr: 'Upper Siang ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-LOW',
          nameEn: 'Lower Siang',
          nameMr: 'Lower Siang',
          talukas: [
            TalukaInfo(nameEn: 'Lower Siang City / Central', nameMr: 'Lower Siang शहर / केंद्र'),
            TalukaInfo(nameEn: 'Lower Siang Rural / East', nameMr: 'Lower Siang ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Lower Siang Rural / West', nameMr: 'Lower Siang ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-LOW',
          nameEn: 'Lower Dibang Valley',
          nameMr: 'Lower Dibang Valley',
          talukas: [
            TalukaInfo(nameEn: 'Lower Dibang Valley City / Central', nameMr: 'Lower Dibang Valley शहर / केंद्र'),
            TalukaInfo(nameEn: 'Lower Dibang Valley Rural / East', nameMr: 'Lower Dibang Valley ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Lower Dibang Valley Rural / West', nameMr: 'Lower Dibang Valley ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-DIB',
          nameEn: 'Dibang Valley',
          nameMr: 'Dibang Valley',
          talukas: [
            TalukaInfo(nameEn: 'Dibang Valley City / Central', nameMr: 'Dibang Valley शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dibang Valley Rural / East', nameMr: 'Dibang Valley ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dibang Valley Rural / West', nameMr: 'Dibang Valley ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-ANJ',
          nameEn: 'Anjaw',
          nameMr: 'Anjaw',
          talukas: [
            TalukaInfo(nameEn: 'Anjaw City / Central', nameMr: 'Anjaw शहर / केंद्र'),
            TalukaInfo(nameEn: 'Anjaw Rural / East', nameMr: 'Anjaw ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Anjaw Rural / West', nameMr: 'Anjaw ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-LOH',
          nameEn: 'Lohit',
          nameMr: 'Lohit',
          talukas: [
            TalukaInfo(nameEn: 'Lohit City / Central', nameMr: 'Lohit शहर / केंद्र'),
            TalukaInfo(nameEn: 'Lohit Rural / East', nameMr: 'Lohit ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Lohit Rural / West', nameMr: 'Lohit ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-NAM',
          nameEn: 'Namsai',
          nameMr: 'Namsai',
          talukas: [
            TalukaInfo(nameEn: 'Namsai City / Central', nameMr: 'Namsai शहर / केंद्र'),
            TalukaInfo(nameEn: 'Namsai Rural / East', nameMr: 'Namsai ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Namsai Rural / West', nameMr: 'Namsai ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-CHA',
          nameEn: 'Changlang',
          nameMr: 'Changlang',
          talukas: [
            TalukaInfo(nameEn: 'Changlang City / Central', nameMr: 'Changlang शहर / केंद्र'),
            TalukaInfo(nameEn: 'Changlang Rural / East', nameMr: 'Changlang ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Changlang Rural / West', nameMr: 'Changlang ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-TIR',
          nameEn: 'Tirap',
          nameMr: 'Tirap',
          talukas: [
            TalukaInfo(nameEn: 'Tirap City / Central', nameMr: 'Tirap शहर / केंद्र'),
            TalukaInfo(nameEn: 'Tirap Rural / East', nameMr: 'Tirap ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Tirap Rural / West', nameMr: 'Tirap ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AR-LON',
          nameEn: 'Longding',
          nameMr: 'Longding',
          talukas: [
            TalukaInfo(nameEn: 'Longding City / Central', nameMr: 'Longding शहर / केंद्र'),
            TalukaInfo(nameEn: 'Longding Rural / East', nameMr: 'Longding ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Longding Rural / West', nameMr: 'Longding ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'AS',
      nameEn: 'Assam',
      nameMr: 'आसाम',
      districts: [
        DistrictInfo(
          code: 'AS-BAK',
          nameEn: 'Baksa',
          nameMr: 'Baksa',
          talukas: [
            TalukaInfo(nameEn: 'Baksa City / Central', nameMr: 'Baksa शहर / केंद्र'),
            TalukaInfo(nameEn: 'Baksa Rural / East', nameMr: 'Baksa ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Baksa Rural / West', nameMr: 'Baksa ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-BAR',
          nameEn: 'Barpeta',
          nameMr: 'Barpeta',
          talukas: [
            TalukaInfo(nameEn: 'Barpeta City / Central', nameMr: 'Barpeta शहर / केंद्र'),
            TalukaInfo(nameEn: 'Barpeta Rural / East', nameMr: 'Barpeta ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Barpeta Rural / West', nameMr: 'Barpeta ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-BIS',
          nameEn: 'Biswanath',
          nameMr: 'Biswanath',
          talukas: [
            TalukaInfo(nameEn: 'Biswanath City / Central', nameMr: 'Biswanath शहर / केंद्र'),
            TalukaInfo(nameEn: 'Biswanath Rural / East', nameMr: 'Biswanath ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Biswanath Rural / West', nameMr: 'Biswanath ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-BON',
          nameEn: 'Bongaigaon',
          nameMr: 'Bongaigaon',
          talukas: [
            TalukaInfo(nameEn: 'Bongaigaon City / Central', nameMr: 'Bongaigaon शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bongaigaon Rural / East', nameMr: 'Bongaigaon ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bongaigaon Rural / West', nameMr: 'Bongaigaon ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-CAC',
          nameEn: 'Cachar',
          nameMr: 'Cachar',
          talukas: [
            TalukaInfo(nameEn: 'Cachar City / Central', nameMr: 'Cachar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Cachar Rural / East', nameMr: 'Cachar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Cachar Rural / West', nameMr: 'Cachar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-CHA',
          nameEn: 'Charaideo',
          nameMr: 'Charaideo',
          talukas: [
            TalukaInfo(nameEn: 'Charaideo City / Central', nameMr: 'Charaideo शहर / केंद्र'),
            TalukaInfo(nameEn: 'Charaideo Rural / East', nameMr: 'Charaideo ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Charaideo Rural / West', nameMr: 'Charaideo ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-CHI',
          nameEn: 'Chirang',
          nameMr: 'Chirang',
          talukas: [
            TalukaInfo(nameEn: 'Chirang City / Central', nameMr: 'Chirang शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chirang Rural / East', nameMr: 'Chirang ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chirang Rural / West', nameMr: 'Chirang ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-DAR',
          nameEn: 'Darrang',
          nameMr: 'Darrang',
          talukas: [
            TalukaInfo(nameEn: 'Darrang City / Central', nameMr: 'Darrang शहर / केंद्र'),
            TalukaInfo(nameEn: 'Darrang Rural / East', nameMr: 'Darrang ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Darrang Rural / West', nameMr: 'Darrang ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-DHE',
          nameEn: 'Dhemaji',
          nameMr: 'Dhemaji',
          talukas: [
            TalukaInfo(nameEn: 'Dhemaji City / Central', nameMr: 'Dhemaji शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dhemaji Rural / East', nameMr: 'Dhemaji ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dhemaji Rural / West', nameMr: 'Dhemaji ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-DHU',
          nameEn: 'Dhubri',
          nameMr: 'Dhubri',
          talukas: [
            TalukaInfo(nameEn: 'Dhubri City / Central', nameMr: 'Dhubri शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dhubri Rural / East', nameMr: 'Dhubri ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dhubri Rural / West', nameMr: 'Dhubri ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-DIB',
          nameEn: 'Dibrugarh',
          nameMr: 'Dibrugarh',
          talukas: [
            TalukaInfo(nameEn: 'Dibrugarh City / Central', nameMr: 'Dibrugarh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dibrugarh Rural / East', nameMr: 'Dibrugarh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dibrugarh Rural / West', nameMr: 'Dibrugarh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-GOA',
          nameEn: 'Goalpara',
          nameMr: 'Goalpara',
          talukas: [
            TalukaInfo(nameEn: 'Goalpara City / Central', nameMr: 'Goalpara शहर / केंद्र'),
            TalukaInfo(nameEn: 'Goalpara Rural / East', nameMr: 'Goalpara ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Goalpara Rural / West', nameMr: 'Goalpara ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-GOL',
          nameEn: 'Golaghat',
          nameMr: 'Golaghat',
          talukas: [
            TalukaInfo(nameEn: 'Golaghat City / Central', nameMr: 'Golaghat शहर / केंद्र'),
            TalukaInfo(nameEn: 'Golaghat Rural / East', nameMr: 'Golaghat ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Golaghat Rural / West', nameMr: 'Golaghat ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-HAI',
          nameEn: 'Hailakandi',
          nameMr: 'Hailakandi',
          talukas: [
            TalukaInfo(nameEn: 'Hailakandi City / Central', nameMr: 'Hailakandi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Hailakandi Rural / East', nameMr: 'Hailakandi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Hailakandi Rural / West', nameMr: 'Hailakandi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-HOJ',
          nameEn: 'Hojai',
          nameMr: 'Hojai',
          talukas: [
            TalukaInfo(nameEn: 'Hojai City / Central', nameMr: 'Hojai शहर / केंद्र'),
            TalukaInfo(nameEn: 'Hojai Rural / East', nameMr: 'Hojai ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Hojai Rural / West', nameMr: 'Hojai ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-JOR',
          nameEn: 'Jorhat',
          nameMr: 'Jorhat',
          talukas: [
            TalukaInfo(nameEn: 'Jorhat City / Central', nameMr: 'Jorhat शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jorhat Rural / East', nameMr: 'Jorhat ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jorhat Rural / West', nameMr: 'Jorhat ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-KAM',
          nameEn: 'Kamrup Metropolitan',
          nameMr: 'Kamrup Metropolitan',
          talukas: [
            TalukaInfo(nameEn: 'Kamrup Metropolitan City / Central', nameMr: 'Kamrup Metropolitan शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kamrup Metropolitan Rural / East', nameMr: 'Kamrup Metropolitan ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kamrup Metropolitan Rural / West', nameMr: 'Kamrup Metropolitan ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-KAM',
          nameEn: 'Kamrup',
          nameMr: 'Kamrup',
          talukas: [
            TalukaInfo(nameEn: 'Kamrup City / Central', nameMr: 'Kamrup शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kamrup Rural / East', nameMr: 'Kamrup ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kamrup Rural / West', nameMr: 'Kamrup ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-KAR',
          nameEn: 'Karbi Anglong',
          nameMr: 'Karbi Anglong',
          talukas: [
            TalukaInfo(nameEn: 'Karbi Anglong City / Central', nameMr: 'Karbi Anglong शहर / केंद्र'),
            TalukaInfo(nameEn: 'Karbi Anglong Rural / East', nameMr: 'Karbi Anglong ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Karbi Anglong Rural / West', nameMr: 'Karbi Anglong ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-KAR',
          nameEn: 'Karimganj',
          nameMr: 'Karimganj',
          talukas: [
            TalukaInfo(nameEn: 'Karimganj City / Central', nameMr: 'Karimganj शहर / केंद्र'),
            TalukaInfo(nameEn: 'Karimganj Rural / East', nameMr: 'Karimganj ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Karimganj Rural / West', nameMr: 'Karimganj ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-KOK',
          nameEn: 'Kokrajhar',
          nameMr: 'Kokrajhar',
          talukas: [
            TalukaInfo(nameEn: 'Kokrajhar City / Central', nameMr: 'Kokrajhar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kokrajhar Rural / East', nameMr: 'Kokrajhar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kokrajhar Rural / West', nameMr: 'Kokrajhar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-LAK',
          nameEn: 'Lakhimpur',
          nameMr: 'Lakhimpur',
          talukas: [
            TalukaInfo(nameEn: 'Lakhimpur City / Central', nameMr: 'Lakhimpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Lakhimpur Rural / East', nameMr: 'Lakhimpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Lakhimpur Rural / West', nameMr: 'Lakhimpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-MAJ',
          nameEn: 'Majuli',
          nameMr: 'Majuli',
          talukas: [
            TalukaInfo(nameEn: 'Majuli City / Central', nameMr: 'Majuli शहर / केंद्र'),
            TalukaInfo(nameEn: 'Majuli Rural / East', nameMr: 'Majuli ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Majuli Rural / West', nameMr: 'Majuli ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-MOR',
          nameEn: 'Morigaon',
          nameMr: 'Morigaon',
          talukas: [
            TalukaInfo(nameEn: 'Morigaon City / Central', nameMr: 'Morigaon शहर / केंद्र'),
            TalukaInfo(nameEn: 'Morigaon Rural / East', nameMr: 'Morigaon ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Morigaon Rural / West', nameMr: 'Morigaon ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-NAG',
          nameEn: 'Nagaon',
          nameMr: 'Nagaon',
          talukas: [
            TalukaInfo(nameEn: 'Nagaon City / Central', nameMr: 'Nagaon शहर / केंद्र'),
            TalukaInfo(nameEn: 'Nagaon Rural / East', nameMr: 'Nagaon ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Nagaon Rural / West', nameMr: 'Nagaon ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-NAL',
          nameEn: 'Nalbari',
          nameMr: 'Nalbari',
          talukas: [
            TalukaInfo(nameEn: 'Nalbari City / Central', nameMr: 'Nalbari शहर / केंद्र'),
            TalukaInfo(nameEn: 'Nalbari Rural / East', nameMr: 'Nalbari ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Nalbari Rural / West', nameMr: 'Nalbari ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-DIM',
          nameEn: 'Dima Hasao',
          nameMr: 'Dima Hasao',
          talukas: [
            TalukaInfo(nameEn: 'Dima Hasao City / Central', nameMr: 'Dima Hasao शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dima Hasao Rural / East', nameMr: 'Dima Hasao ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dima Hasao Rural / West', nameMr: 'Dima Hasao ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-SIV',
          nameEn: 'Sivasagar',
          nameMr: 'Sivasagar',
          talukas: [
            TalukaInfo(nameEn: 'Sivasagar City / Central', nameMr: 'Sivasagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sivasagar Rural / East', nameMr: 'Sivasagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sivasagar Rural / West', nameMr: 'Sivasagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-SON',
          nameEn: 'Sonitpur',
          nameMr: 'Sonitpur',
          talukas: [
            TalukaInfo(nameEn: 'Sonitpur City / Central', nameMr: 'Sonitpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sonitpur Rural / East', nameMr: 'Sonitpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sonitpur Rural / West', nameMr: 'Sonitpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-SOU',
          nameEn: 'South Salmara-Mankachar',
          nameMr: 'South Salmara-Mankachar',
          talukas: [
            TalukaInfo(nameEn: 'South Salmara-Mankachar City / Central', nameMr: 'South Salmara-Mankachar शहर / केंद्र'),
            TalukaInfo(nameEn: 'South Salmara-Mankachar Rural / East', nameMr: 'South Salmara-Mankachar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'South Salmara-Mankachar Rural / West', nameMr: 'South Salmara-Mankachar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-TIN',
          nameEn: 'Tinsukia',
          nameMr: 'Tinsukia',
          talukas: [
            TalukaInfo(nameEn: 'Tinsukia City / Central', nameMr: 'Tinsukia शहर / केंद्र'),
            TalukaInfo(nameEn: 'Tinsukia Rural / East', nameMr: 'Tinsukia ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Tinsukia Rural / West', nameMr: 'Tinsukia ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-UDA',
          nameEn: 'Udalguri',
          nameMr: 'Udalguri',
          talukas: [
            TalukaInfo(nameEn: 'Udalguri City / Central', nameMr: 'Udalguri शहर / केंद्र'),
            TalukaInfo(nameEn: 'Udalguri Rural / East', nameMr: 'Udalguri ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Udalguri Rural / West', nameMr: 'Udalguri ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'AS-WES',
          nameEn: 'West Karbi Anglong',
          nameMr: 'West Karbi Anglong',
          talukas: [
            TalukaInfo(nameEn: 'West Karbi Anglong City / Central', nameMr: 'West Karbi Anglong शहर / केंद्र'),
            TalukaInfo(nameEn: 'West Karbi Anglong Rural / East', nameMr: 'West Karbi Anglong ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'West Karbi Anglong Rural / West', nameMr: 'West Karbi Anglong ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'BR',
      nameEn: 'Bihar',
      nameMr: 'बिहार',
      districts: [
        DistrictInfo(
          code: 'BR-ARA',
          nameEn: 'Araria',
          nameMr: 'Araria',
          talukas: [
            TalukaInfo(nameEn: 'Araria City / Central', nameMr: 'Araria शहर / केंद्र'),
            TalukaInfo(nameEn: 'Araria Rural / East', nameMr: 'Araria ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Araria Rural / West', nameMr: 'Araria ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-ARW',
          nameEn: 'Arwal',
          nameMr: 'Arwal',
          talukas: [
            TalukaInfo(nameEn: 'Arwal City / Central', nameMr: 'Arwal शहर / केंद्र'),
            TalukaInfo(nameEn: 'Arwal Rural / East', nameMr: 'Arwal ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Arwal Rural / West', nameMr: 'Arwal ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-AUR',
          nameEn: 'Aurangabad',
          nameMr: 'Aurangabad',
          talukas: [
            TalukaInfo(nameEn: 'Aurangabad City / Central', nameMr: 'Aurangabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Aurangabad Rural / East', nameMr: 'Aurangabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Aurangabad Rural / West', nameMr: 'Aurangabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-BAN',
          nameEn: 'Banka',
          nameMr: 'Banka',
          talukas: [
            TalukaInfo(nameEn: 'Banka City / Central', nameMr: 'Banka शहर / केंद्र'),
            TalukaInfo(nameEn: 'Banka Rural / East', nameMr: 'Banka ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Banka Rural / West', nameMr: 'Banka ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-BEG',
          nameEn: 'Begusarai',
          nameMr: 'Begusarai',
          talukas: [
            TalukaInfo(nameEn: 'Begusarai City / Central', nameMr: 'Begusarai शहर / केंद्र'),
            TalukaInfo(nameEn: 'Begusarai Rural / East', nameMr: 'Begusarai ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Begusarai Rural / West', nameMr: 'Begusarai ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-BHA',
          nameEn: 'Bhagalpur',
          nameMr: 'Bhagalpur',
          talukas: [
            TalukaInfo(nameEn: 'Bhagalpur City / Central', nameMr: 'Bhagalpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bhagalpur Rural / East', nameMr: 'Bhagalpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bhagalpur Rural / West', nameMr: 'Bhagalpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-BHO',
          nameEn: 'Bhojpur',
          nameMr: 'Bhojpur',
          talukas: [
            TalukaInfo(nameEn: 'Bhojpur City / Central', nameMr: 'Bhojpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bhojpur Rural / East', nameMr: 'Bhojpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bhojpur Rural / West', nameMr: 'Bhojpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-BUX',
          nameEn: 'Buxar',
          nameMr: 'Buxar',
          talukas: [
            TalukaInfo(nameEn: 'Buxar City / Central', nameMr: 'Buxar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Buxar Rural / East', nameMr: 'Buxar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Buxar Rural / West', nameMr: 'Buxar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-DAR',
          nameEn: 'Darbhanga',
          nameMr: 'Darbhanga',
          talukas: [
            TalukaInfo(nameEn: 'Darbhanga City / Central', nameMr: 'Darbhanga शहर / केंद्र'),
            TalukaInfo(nameEn: 'Darbhanga Rural / East', nameMr: 'Darbhanga ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Darbhanga Rural / West', nameMr: 'Darbhanga ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-EAS',
          nameEn: 'East Champaran (Motihari)',
          nameMr: 'East Champaran (Motihari)',
          talukas: [
            TalukaInfo(nameEn: 'East Champaran (Motihari) City / Central', nameMr: 'East Champaran (Motihari) शहर / केंद्र'),
            TalukaInfo(nameEn: 'East Champaran (Motihari) Rural / East', nameMr: 'East Champaran (Motihari) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'East Champaran (Motihari) Rural / West', nameMr: 'East Champaran (Motihari) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-GAY',
          nameEn: 'Gaya',
          nameMr: 'Gaya',
          talukas: [
            TalukaInfo(nameEn: 'Gaya City / Central', nameMr: 'Gaya शहर / केंद्र'),
            TalukaInfo(nameEn: 'Gaya Rural / East', nameMr: 'Gaya ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Gaya Rural / West', nameMr: 'Gaya ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-GOP',
          nameEn: 'Gopalganj',
          nameMr: 'Gopalganj',
          talukas: [
            TalukaInfo(nameEn: 'Gopalganj City / Central', nameMr: 'Gopalganj शहर / केंद्र'),
            TalukaInfo(nameEn: 'Gopalganj Rural / East', nameMr: 'Gopalganj ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Gopalganj Rural / West', nameMr: 'Gopalganj ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-JAM',
          nameEn: 'Jamui',
          nameMr: 'Jamui',
          talukas: [
            TalukaInfo(nameEn: 'Jamui City / Central', nameMr: 'Jamui शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jamui Rural / East', nameMr: 'Jamui ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jamui Rural / West', nameMr: 'Jamui ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-JEH',
          nameEn: 'Jehanabad',
          nameMr: 'Jehanabad',
          talukas: [
            TalukaInfo(nameEn: 'Jehanabad City / Central', nameMr: 'Jehanabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jehanabad Rural / East', nameMr: 'Jehanabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jehanabad Rural / West', nameMr: 'Jehanabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-KAI',
          nameEn: 'Kaimur (Bhabua)',
          nameMr: 'Kaimur (Bhabua)',
          talukas: [
            TalukaInfo(nameEn: 'Kaimur (Bhabua) City / Central', nameMr: 'Kaimur (Bhabua) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kaimur (Bhabua) Rural / East', nameMr: 'Kaimur (Bhabua) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kaimur (Bhabua) Rural / West', nameMr: 'Kaimur (Bhabua) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-KAT',
          nameEn: 'Katihar',
          nameMr: 'Katihar',
          talukas: [
            TalukaInfo(nameEn: 'Katihar City / Central', nameMr: 'Katihar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Katihar Rural / East', nameMr: 'Katihar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Katihar Rural / West', nameMr: 'Katihar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-KHA',
          nameEn: 'Khagaria',
          nameMr: 'Khagaria',
          talukas: [
            TalukaInfo(nameEn: 'Khagaria City / Central', nameMr: 'Khagaria शहर / केंद्र'),
            TalukaInfo(nameEn: 'Khagaria Rural / East', nameMr: 'Khagaria ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Khagaria Rural / West', nameMr: 'Khagaria ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-KIS',
          nameEn: 'Kishanganj',
          nameMr: 'Kishanganj',
          talukas: [
            TalukaInfo(nameEn: 'Kishanganj City / Central', nameMr: 'Kishanganj शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kishanganj Rural / East', nameMr: 'Kishanganj ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kishanganj Rural / West', nameMr: 'Kishanganj ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-LAK',
          nameEn: 'Lakhisarai',
          nameMr: 'Lakhisarai',
          talukas: [
            TalukaInfo(nameEn: 'Lakhisarai City / Central', nameMr: 'Lakhisarai शहर / केंद्र'),
            TalukaInfo(nameEn: 'Lakhisarai Rural / East', nameMr: 'Lakhisarai ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Lakhisarai Rural / West', nameMr: 'Lakhisarai ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-MAD',
          nameEn: 'Madhepura',
          nameMr: 'Madhepura',
          talukas: [
            TalukaInfo(nameEn: 'Madhepura City / Central', nameMr: 'Madhepura शहर / केंद्र'),
            TalukaInfo(nameEn: 'Madhepura Rural / East', nameMr: 'Madhepura ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Madhepura Rural / West', nameMr: 'Madhepura ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-MAD',
          nameEn: 'Madhubani',
          nameMr: 'Madhubani',
          talukas: [
            TalukaInfo(nameEn: 'Madhubani City / Central', nameMr: 'Madhubani शहर / केंद्र'),
            TalukaInfo(nameEn: 'Madhubani Rural / East', nameMr: 'Madhubani ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Madhubani Rural / West', nameMr: 'Madhubani ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-MUN',
          nameEn: 'Munger (Monghyr)',
          nameMr: 'Munger (Monghyr)',
          talukas: [
            TalukaInfo(nameEn: 'Munger (Monghyr) City / Central', nameMr: 'Munger (Monghyr) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Munger (Monghyr) Rural / East', nameMr: 'Munger (Monghyr) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Munger (Monghyr) Rural / West', nameMr: 'Munger (Monghyr) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-MUZ',
          nameEn: 'Muzaffarpur',
          nameMr: 'Muzaffarpur',
          talukas: [
            TalukaInfo(nameEn: 'Muzaffarpur City / Central', nameMr: 'Muzaffarpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Muzaffarpur Rural / East', nameMr: 'Muzaffarpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Muzaffarpur Rural / West', nameMr: 'Muzaffarpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-NAL',
          nameEn: 'Nalanda',
          nameMr: 'Nalanda',
          talukas: [
            TalukaInfo(nameEn: 'Nalanda City / Central', nameMr: 'Nalanda शहर / केंद्र'),
            TalukaInfo(nameEn: 'Nalanda Rural / East', nameMr: 'Nalanda ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Nalanda Rural / West', nameMr: 'Nalanda ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-NAW',
          nameEn: 'Nawada',
          nameMr: 'Nawada',
          talukas: [
            TalukaInfo(nameEn: 'Nawada City / Central', nameMr: 'Nawada शहर / केंद्र'),
            TalukaInfo(nameEn: 'Nawada Rural / East', nameMr: 'Nawada ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Nawada Rural / West', nameMr: 'Nawada ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-PAT',
          nameEn: 'Patna',
          nameMr: 'Patna',
          talukas: [
            TalukaInfo(nameEn: 'Patna City / Central', nameMr: 'Patna शहर / केंद्र'),
            TalukaInfo(nameEn: 'Patna Rural / East', nameMr: 'Patna ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Patna Rural / West', nameMr: 'Patna ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-PUR',
          nameEn: 'Purnia (Purnea)',
          nameMr: 'Purnia (Purnea)',
          talukas: [
            TalukaInfo(nameEn: 'Purnia (Purnea) City / Central', nameMr: 'Purnia (Purnea) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Purnia (Purnea) Rural / East', nameMr: 'Purnia (Purnea) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Purnia (Purnea) Rural / West', nameMr: 'Purnia (Purnea) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-ROH',
          nameEn: 'Rohtas',
          nameMr: 'Rohtas',
          talukas: [
            TalukaInfo(nameEn: 'Rohtas City / Central', nameMr: 'Rohtas शहर / केंद्र'),
            TalukaInfo(nameEn: 'Rohtas Rural / East', nameMr: 'Rohtas ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Rohtas Rural / West', nameMr: 'Rohtas ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-SAH',
          nameEn: 'Saharsa',
          nameMr: 'Saharsa',
          talukas: [
            TalukaInfo(nameEn: 'Saharsa City / Central', nameMr: 'Saharsa शहर / केंद्र'),
            TalukaInfo(nameEn: 'Saharsa Rural / East', nameMr: 'Saharsa ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Saharsa Rural / West', nameMr: 'Saharsa ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-SAM',
          nameEn: 'Samastipur',
          nameMr: 'Samastipur',
          talukas: [
            TalukaInfo(nameEn: 'Samastipur City / Central', nameMr: 'Samastipur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Samastipur Rural / East', nameMr: 'Samastipur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Samastipur Rural / West', nameMr: 'Samastipur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-SAR',
          nameEn: 'Saran',
          nameMr: 'Saran',
          talukas: [
            TalukaInfo(nameEn: 'Saran City / Central', nameMr: 'Saran शहर / केंद्र'),
            TalukaInfo(nameEn: 'Saran Rural / East', nameMr: 'Saran ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Saran Rural / West', nameMr: 'Saran ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-SHE',
          nameEn: 'Sheikhpura',
          nameMr: 'Sheikhpura',
          talukas: [
            TalukaInfo(nameEn: 'Sheikhpura City / Central', nameMr: 'Sheikhpura शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sheikhpura Rural / East', nameMr: 'Sheikhpura ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sheikhpura Rural / West', nameMr: 'Sheikhpura ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-SHE',
          nameEn: 'Sheohar',
          nameMr: 'Sheohar',
          talukas: [
            TalukaInfo(nameEn: 'Sheohar City / Central', nameMr: 'Sheohar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sheohar Rural / East', nameMr: 'Sheohar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sheohar Rural / West', nameMr: 'Sheohar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-SIT',
          nameEn: 'Sitamarhi',
          nameMr: 'Sitamarhi',
          talukas: [
            TalukaInfo(nameEn: 'Sitamarhi City / Central', nameMr: 'Sitamarhi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sitamarhi Rural / East', nameMr: 'Sitamarhi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sitamarhi Rural / West', nameMr: 'Sitamarhi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-SIW',
          nameEn: 'Siwan',
          nameMr: 'Siwan',
          talukas: [
            TalukaInfo(nameEn: 'Siwan City / Central', nameMr: 'Siwan शहर / केंद्र'),
            TalukaInfo(nameEn: 'Siwan Rural / East', nameMr: 'Siwan ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Siwan Rural / West', nameMr: 'Siwan ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-SUP',
          nameEn: 'Supaul',
          nameMr: 'Supaul',
          talukas: [
            TalukaInfo(nameEn: 'Supaul City / Central', nameMr: 'Supaul शहर / केंद्र'),
            TalukaInfo(nameEn: 'Supaul Rural / East', nameMr: 'Supaul ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Supaul Rural / West', nameMr: 'Supaul ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-VAI',
          nameEn: 'Vaishali',
          nameMr: 'Vaishali',
          talukas: [
            TalukaInfo(nameEn: 'Vaishali City / Central', nameMr: 'Vaishali शहर / केंद्र'),
            TalukaInfo(nameEn: 'Vaishali Rural / East', nameMr: 'Vaishali ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Vaishali Rural / West', nameMr: 'Vaishali ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'BR-WES',
          nameEn: 'West Champaran',
          nameMr: 'West Champaran',
          talukas: [
            TalukaInfo(nameEn: 'West Champaran City / Central', nameMr: 'West Champaran शहर / केंद्र'),
            TalukaInfo(nameEn: 'West Champaran Rural / East', nameMr: 'West Champaran ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'West Champaran Rural / West', nameMr: 'West Champaran ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'CH',
      nameEn: 'Chandigarh (UT)',
      nameMr: 'चंदीगड',
      districts: [
        DistrictInfo(
          code: 'CH-CHA',
          nameEn: 'Chandigarh',
          nameMr: 'Chandigarh',
          talukas: [
            TalukaInfo(nameEn: 'Chandigarh City / Central', nameMr: 'Chandigarh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chandigarh Rural / East', nameMr: 'Chandigarh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chandigarh Rural / West', nameMr: 'Chandigarh ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'CG',
      nameEn: 'Chhattisgarh',
      nameMr: 'छत्तीसगड',
      districts: [
        DistrictInfo(
          code: 'CG-BAL',
          nameEn: 'Balod',
          nameMr: 'Balod',
          talukas: [
            TalukaInfo(nameEn: 'Balod City / Central', nameMr: 'Balod शहर / केंद्र'),
            TalukaInfo(nameEn: 'Balod Rural / East', nameMr: 'Balod ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Balod Rural / West', nameMr: 'Balod ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-BAL',
          nameEn: 'Baloda Bazar',
          nameMr: 'Baloda Bazar',
          talukas: [
            TalukaInfo(nameEn: 'Baloda Bazar City / Central', nameMr: 'Baloda Bazar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Baloda Bazar Rural / East', nameMr: 'Baloda Bazar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Baloda Bazar Rural / West', nameMr: 'Baloda Bazar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-BAL',
          nameEn: 'Balrampur',
          nameMr: 'Balrampur',
          talukas: [
            TalukaInfo(nameEn: 'Balrampur City / Central', nameMr: 'Balrampur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Balrampur Rural / East', nameMr: 'Balrampur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Balrampur Rural / West', nameMr: 'Balrampur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-BAS',
          nameEn: 'Bastar',
          nameMr: 'Bastar',
          talukas: [
            TalukaInfo(nameEn: 'Bastar City / Central', nameMr: 'Bastar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bastar Rural / East', nameMr: 'Bastar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bastar Rural / West', nameMr: 'Bastar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-BEM',
          nameEn: 'Bemetara',
          nameMr: 'Bemetara',
          talukas: [
            TalukaInfo(nameEn: 'Bemetara City / Central', nameMr: 'Bemetara शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bemetara Rural / East', nameMr: 'Bemetara ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bemetara Rural / West', nameMr: 'Bemetara ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-BIJ',
          nameEn: 'Bijapur',
          nameMr: 'Bijapur',
          talukas: [
            TalukaInfo(nameEn: 'Bijapur City / Central', nameMr: 'Bijapur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bijapur Rural / East', nameMr: 'Bijapur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bijapur Rural / West', nameMr: 'Bijapur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-BIL',
          nameEn: 'Bilaspur',
          nameMr: 'Bilaspur',
          talukas: [
            TalukaInfo(nameEn: 'Bilaspur City / Central', nameMr: 'Bilaspur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bilaspur Rural / East', nameMr: 'Bilaspur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bilaspur Rural / West', nameMr: 'Bilaspur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-DAN',
          nameEn: 'Dantewada (South Bastar)',
          nameMr: 'Dantewada (South Bastar)',
          talukas: [
            TalukaInfo(nameEn: 'Dantewada (South Bastar) City / Central', nameMr: 'Dantewada (South Bastar) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dantewada (South Bastar) Rural / East', nameMr: 'Dantewada (South Bastar) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dantewada (South Bastar) Rural / West', nameMr: 'Dantewada (South Bastar) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-DHA',
          nameEn: 'Dhamtari',
          nameMr: 'Dhamtari',
          talukas: [
            TalukaInfo(nameEn: 'Dhamtari City / Central', nameMr: 'Dhamtari शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dhamtari Rural / East', nameMr: 'Dhamtari ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dhamtari Rural / West', nameMr: 'Dhamtari ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-DUR',
          nameEn: 'Durg',
          nameMr: 'Durg',
          talukas: [
            TalukaInfo(nameEn: 'Durg City / Central', nameMr: 'Durg शहर / केंद्र'),
            TalukaInfo(nameEn: 'Durg Rural / East', nameMr: 'Durg ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Durg Rural / West', nameMr: 'Durg ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-GAR',
          nameEn: 'Gariyaband',
          nameMr: 'Gariyaband',
          talukas: [
            TalukaInfo(nameEn: 'Gariyaband City / Central', nameMr: 'Gariyaband शहर / केंद्र'),
            TalukaInfo(nameEn: 'Gariyaband Rural / East', nameMr: 'Gariyaband ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Gariyaband Rural / West', nameMr: 'Gariyaband ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-JAN',
          nameEn: 'Janjgir-Champa',
          nameMr: 'Janjgir-Champa',
          talukas: [
            TalukaInfo(nameEn: 'Janjgir-Champa City / Central', nameMr: 'Janjgir-Champa शहर / केंद्र'),
            TalukaInfo(nameEn: 'Janjgir-Champa Rural / East', nameMr: 'Janjgir-Champa ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Janjgir-Champa Rural / West', nameMr: 'Janjgir-Champa ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-JAS',
          nameEn: 'Jashpur',
          nameMr: 'Jashpur',
          talukas: [
            TalukaInfo(nameEn: 'Jashpur City / Central', nameMr: 'Jashpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jashpur Rural / East', nameMr: 'Jashpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jashpur Rural / West', nameMr: 'Jashpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-KAB',
          nameEn: 'Kabirdham (Kawardha)',
          nameMr: 'Kabirdham (Kawardha)',
          talukas: [
            TalukaInfo(nameEn: 'Kabirdham (Kawardha) City / Central', nameMr: 'Kabirdham (Kawardha) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kabirdham (Kawardha) Rural / East', nameMr: 'Kabirdham (Kawardha) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kabirdham (Kawardha) Rural / West', nameMr: 'Kabirdham (Kawardha) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-KAN',
          nameEn: 'Kanker (North Bastar)',
          nameMr: 'Kanker (North Bastar)',
          talukas: [
            TalukaInfo(nameEn: 'Kanker (North Bastar) City / Central', nameMr: 'Kanker (North Bastar) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kanker (North Bastar) Rural / East', nameMr: 'Kanker (North Bastar) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kanker (North Bastar) Rural / West', nameMr: 'Kanker (North Bastar) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-KON',
          nameEn: 'Kondagaon',
          nameMr: 'Kondagaon',
          talukas: [
            TalukaInfo(nameEn: 'Kondagaon City / Central', nameMr: 'Kondagaon शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kondagaon Rural / East', nameMr: 'Kondagaon ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kondagaon Rural / West', nameMr: 'Kondagaon ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-KOR',
          nameEn: 'Korba',
          nameMr: 'Korba',
          talukas: [
            TalukaInfo(nameEn: 'Korba City / Central', nameMr: 'Korba शहर / केंद्र'),
            TalukaInfo(nameEn: 'Korba Rural / East', nameMr: 'Korba ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Korba Rural / West', nameMr: 'Korba ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-KOR',
          nameEn: 'Korea (Koriya)',
          nameMr: 'Korea (Koriya)',
          talukas: [
            TalukaInfo(nameEn: 'Korea (Koriya) City / Central', nameMr: 'Korea (Koriya) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Korea (Koriya) Rural / East', nameMr: 'Korea (Koriya) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Korea (Koriya) Rural / West', nameMr: 'Korea (Koriya) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-MAH',
          nameEn: 'Mahasamund',
          nameMr: 'Mahasamund',
          talukas: [
            TalukaInfo(nameEn: 'Mahasamund City / Central', nameMr: 'Mahasamund शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mahasamund Rural / East', nameMr: 'Mahasamund ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mahasamund Rural / West', nameMr: 'Mahasamund ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-MUN',
          nameEn: 'Mungeli',
          nameMr: 'Mungeli',
          talukas: [
            TalukaInfo(nameEn: 'Mungeli City / Central', nameMr: 'Mungeli शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mungeli Rural / East', nameMr: 'Mungeli ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mungeli Rural / West', nameMr: 'Mungeli ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-NAR',
          nameEn: 'Narayanpur',
          nameMr: 'Narayanpur',
          talukas: [
            TalukaInfo(nameEn: 'Narayanpur City / Central', nameMr: 'Narayanpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Narayanpur Rural / East', nameMr: 'Narayanpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Narayanpur Rural / West', nameMr: 'Narayanpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-RAI',
          nameEn: 'Raigarh',
          nameMr: 'Raigarh',
          talukas: [
            TalukaInfo(nameEn: 'Raigarh City / Central', nameMr: 'Raigarh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Raigarh Rural / East', nameMr: 'Raigarh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Raigarh Rural / West', nameMr: 'Raigarh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-RAI',
          nameEn: 'Raipur',
          nameMr: 'Raipur',
          talukas: [
            TalukaInfo(nameEn: 'Raipur City / Central', nameMr: 'Raipur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Raipur Rural / East', nameMr: 'Raipur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Raipur Rural / West', nameMr: 'Raipur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-RAJ',
          nameEn: 'Rajnandgaon',
          nameMr: 'Rajnandgaon',
          talukas: [
            TalukaInfo(nameEn: 'Rajnandgaon City / Central', nameMr: 'Rajnandgaon शहर / केंद्र'),
            TalukaInfo(nameEn: 'Rajnandgaon Rural / East', nameMr: 'Rajnandgaon ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Rajnandgaon Rural / West', nameMr: 'Rajnandgaon ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-SUK',
          nameEn: 'Sukma',
          nameMr: 'Sukma',
          talukas: [
            TalukaInfo(nameEn: 'Sukma City / Central', nameMr: 'Sukma शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sukma Rural / East', nameMr: 'Sukma ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sukma Rural / West', nameMr: 'Sukma ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-SUR',
          nameEn: 'Surajpur  ',
          nameMr: 'Surajpur  ',
          talukas: [
            TalukaInfo(nameEn: 'Surajpur   City / Central', nameMr: 'Surajpur   शहर / केंद्र'),
            TalukaInfo(nameEn: 'Surajpur   Rural / East', nameMr: 'Surajpur   ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Surajpur   Rural / West', nameMr: 'Surajpur   ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'CG-SUR',
          nameEn: 'Surguja',
          nameMr: 'Surguja',
          talukas: [
            TalukaInfo(nameEn: 'Surguja City / Central', nameMr: 'Surguja शहर / केंद्र'),
            TalukaInfo(nameEn: 'Surguja Rural / East', nameMr: 'Surguja ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Surguja Rural / West', nameMr: 'Surguja ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'DH',
      nameEn: 'Dadra and Nagar Haveli (UT)',
      nameMr: 'दादरा आणि नगर हवेली',
      districts: [
        DistrictInfo(
          code: 'DH-DAD',
          nameEn: 'Dadra & Nagar Haveli',
          nameMr: 'Dadra & Nagar Haveli',
          talukas: [
            TalukaInfo(nameEn: 'Dadra & Nagar Haveli City / Central', nameMr: 'Dadra & Nagar Haveli शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dadra & Nagar Haveli Rural / East', nameMr: 'Dadra & Nagar Haveli ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dadra & Nagar Haveli Rural / West', nameMr: 'Dadra & Nagar Haveli ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'DD',
      nameEn: 'Daman and Diu (UT)',
      nameMr: 'दमन आणि दीव',
      districts: [
        DistrictInfo(
          code: 'DD-DAM',
          nameEn: 'Daman',
          nameMr: 'Daman',
          talukas: [
            TalukaInfo(nameEn: 'Daman City / Central', nameMr: 'Daman शहर / केंद्र'),
            TalukaInfo(nameEn: 'Daman Rural / East', nameMr: 'Daman ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Daman Rural / West', nameMr: 'Daman ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'DD-DIU',
          nameEn: 'Diu',
          nameMr: 'Diu',
          talukas: [
            TalukaInfo(nameEn: 'Diu City / Central', nameMr: 'Diu शहर / केंद्र'),
            TalukaInfo(nameEn: 'Diu Rural / East', nameMr: 'Diu ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Diu Rural / West', nameMr: 'Diu ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'DL',
      nameEn: 'Delhi (NCT)',
      nameMr: 'दिल्ली',
      districts: [
        DistrictInfo(
          code: 'DL-CEN',
          nameEn: 'Central Delhi',
          nameMr: 'Central Delhi',
          talukas: [
            TalukaInfo(nameEn: 'Central Delhi City / Central', nameMr: 'Central Delhi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Central Delhi Rural / East', nameMr: 'Central Delhi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Central Delhi Rural / West', nameMr: 'Central Delhi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'DL-EAS',
          nameEn: 'East Delhi',
          nameMr: 'East Delhi',
          talukas: [
            TalukaInfo(nameEn: 'East Delhi City / Central', nameMr: 'East Delhi शहर / केंद्र'),
            TalukaInfo(nameEn: 'East Delhi Rural / East', nameMr: 'East Delhi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'East Delhi Rural / West', nameMr: 'East Delhi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'DL-NEW',
          nameEn: 'New Delhi',
          nameMr: 'New Delhi',
          talukas: [
            TalukaInfo(nameEn: 'New Delhi City / Central', nameMr: 'New Delhi शहर / केंद्र'),
            TalukaInfo(nameEn: 'New Delhi Rural / East', nameMr: 'New Delhi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'New Delhi Rural / West', nameMr: 'New Delhi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'DL-NOR',
          nameEn: 'North Delhi',
          nameMr: 'North Delhi',
          talukas: [
            TalukaInfo(nameEn: 'North Delhi City / Central', nameMr: 'North Delhi शहर / केंद्र'),
            TalukaInfo(nameEn: 'North Delhi Rural / East', nameMr: 'North Delhi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'North Delhi Rural / West', nameMr: 'North Delhi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'DL-NOR',
          nameEn: 'North East  Delhi',
          nameMr: 'North East  Delhi',
          talukas: [
            TalukaInfo(nameEn: 'North East  Delhi City / Central', nameMr: 'North East  Delhi शहर / केंद्र'),
            TalukaInfo(nameEn: 'North East  Delhi Rural / East', nameMr: 'North East  Delhi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'North East  Delhi Rural / West', nameMr: 'North East  Delhi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'DL-NOR',
          nameEn: 'North West  Delhi',
          nameMr: 'North West  Delhi',
          talukas: [
            TalukaInfo(nameEn: 'North West  Delhi City / Central', nameMr: 'North West  Delhi शहर / केंद्र'),
            TalukaInfo(nameEn: 'North West  Delhi Rural / East', nameMr: 'North West  Delhi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'North West  Delhi Rural / West', nameMr: 'North West  Delhi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'DL-SHA',
          nameEn: 'Shahdara',
          nameMr: 'Shahdara',
          talukas: [
            TalukaInfo(nameEn: 'Shahdara City / Central', nameMr: 'Shahdara शहर / केंद्र'),
            TalukaInfo(nameEn: 'Shahdara Rural / East', nameMr: 'Shahdara ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Shahdara Rural / West', nameMr: 'Shahdara ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'DL-SOU',
          nameEn: 'South Delhi',
          nameMr: 'South Delhi',
          talukas: [
            TalukaInfo(nameEn: 'South Delhi City / Central', nameMr: 'South Delhi शहर / केंद्र'),
            TalukaInfo(nameEn: 'South Delhi Rural / East', nameMr: 'South Delhi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'South Delhi Rural / West', nameMr: 'South Delhi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'DL-SOU',
          nameEn: 'South East Delhi',
          nameMr: 'South East Delhi',
          talukas: [
            TalukaInfo(nameEn: 'South East Delhi City / Central', nameMr: 'South East Delhi शहर / केंद्र'),
            TalukaInfo(nameEn: 'South East Delhi Rural / East', nameMr: 'South East Delhi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'South East Delhi Rural / West', nameMr: 'South East Delhi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'DL-SOU',
          nameEn: 'South West  Delhi',
          nameMr: 'South West  Delhi',
          talukas: [
            TalukaInfo(nameEn: 'South West  Delhi City / Central', nameMr: 'South West  Delhi शहर / केंद्र'),
            TalukaInfo(nameEn: 'South West  Delhi Rural / East', nameMr: 'South West  Delhi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'South West  Delhi Rural / West', nameMr: 'South West  Delhi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'DL-WES',
          nameEn: 'West Delhi',
          nameMr: 'West Delhi',
          talukas: [
            TalukaInfo(nameEn: 'West Delhi City / Central', nameMr: 'West Delhi शहर / केंद्र'),
            TalukaInfo(nameEn: 'West Delhi Rural / East', nameMr: 'West Delhi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'West Delhi Rural / West', nameMr: 'West Delhi ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'GA',
      nameEn: 'Goa',
      nameMr: 'गोवा',
      districts: [
        DistrictInfo(
          code: 'GA-NOR',
          nameEn: 'North Goa',
          nameMr: 'North Goa',
          talukas: [
            TalukaInfo(nameEn: 'North Goa City / Central', nameMr: 'North Goa शहर / केंद्र'),
            TalukaInfo(nameEn: 'North Goa Rural / East', nameMr: 'North Goa ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'North Goa Rural / West', nameMr: 'North Goa ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GA-SOU',
          nameEn: 'South Goa',
          nameMr: 'South Goa',
          talukas: [
            TalukaInfo(nameEn: 'South Goa City / Central', nameMr: 'South Goa शहर / केंद्र'),
            TalukaInfo(nameEn: 'South Goa Rural / East', nameMr: 'South Goa ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'South Goa Rural / West', nameMr: 'South Goa ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'GJ',
      nameEn: 'Gujarat',
      nameMr: 'गुजरात',
      districts: [
        DistrictInfo(
          code: 'GJ-AHM',
          nameEn: 'Ahmedabad',
          nameMr: 'Ahmedabad',
          talukas: [
            TalukaInfo(nameEn: 'Ahmedabad City / Central', nameMr: 'Ahmedabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ahmedabad Rural / East', nameMr: 'Ahmedabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ahmedabad Rural / West', nameMr: 'Ahmedabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-AMR',
          nameEn: 'Amreli',
          nameMr: 'Amreli',
          talukas: [
            TalukaInfo(nameEn: 'Amreli City / Central', nameMr: 'Amreli शहर / केंद्र'),
            TalukaInfo(nameEn: 'Amreli Rural / East', nameMr: 'Amreli ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Amreli Rural / West', nameMr: 'Amreli ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-ANA',
          nameEn: 'Anand',
          nameMr: 'Anand',
          talukas: [
            TalukaInfo(nameEn: 'Anand City / Central', nameMr: 'Anand शहर / केंद्र'),
            TalukaInfo(nameEn: 'Anand Rural / East', nameMr: 'Anand ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Anand Rural / West', nameMr: 'Anand ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-ARA',
          nameEn: 'Aravalli',
          nameMr: 'Aravalli',
          talukas: [
            TalukaInfo(nameEn: 'Aravalli City / Central', nameMr: 'Aravalli शहर / केंद्र'),
            TalukaInfo(nameEn: 'Aravalli Rural / East', nameMr: 'Aravalli ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Aravalli Rural / West', nameMr: 'Aravalli ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-BAN',
          nameEn: 'Banaskantha (Palanpur)',
          nameMr: 'Banaskantha (Palanpur)',
          talukas: [
            TalukaInfo(nameEn: 'Banaskantha (Palanpur) City / Central', nameMr: 'Banaskantha (Palanpur) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Banaskantha (Palanpur) Rural / East', nameMr: 'Banaskantha (Palanpur) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Banaskantha (Palanpur) Rural / West', nameMr: 'Banaskantha (Palanpur) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-BHA',
          nameEn: 'Bharuch',
          nameMr: 'Bharuch',
          talukas: [
            TalukaInfo(nameEn: 'Bharuch City / Central', nameMr: 'Bharuch शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bharuch Rural / East', nameMr: 'Bharuch ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bharuch Rural / West', nameMr: 'Bharuch ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-BHA',
          nameEn: 'Bhavnagar',
          nameMr: 'Bhavnagar',
          talukas: [
            TalukaInfo(nameEn: 'Bhavnagar City / Central', nameMr: 'Bhavnagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bhavnagar Rural / East', nameMr: 'Bhavnagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bhavnagar Rural / West', nameMr: 'Bhavnagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-BOT',
          nameEn: 'Botad',
          nameMr: 'Botad',
          talukas: [
            TalukaInfo(nameEn: 'Botad City / Central', nameMr: 'Botad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Botad Rural / East', nameMr: 'Botad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Botad Rural / West', nameMr: 'Botad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-CHH',
          nameEn: 'Chhota Udepur',
          nameMr: 'Chhota Udepur',
          talukas: [
            TalukaInfo(nameEn: 'Chhota Udepur City / Central', nameMr: 'Chhota Udepur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chhota Udepur Rural / East', nameMr: 'Chhota Udepur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chhota Udepur Rural / West', nameMr: 'Chhota Udepur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-DAH',
          nameEn: 'Dahod',
          nameMr: 'Dahod',
          talukas: [
            TalukaInfo(nameEn: 'Dahod City / Central', nameMr: 'Dahod शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dahod Rural / East', nameMr: 'Dahod ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dahod Rural / West', nameMr: 'Dahod ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-DAN',
          nameEn: 'Dangs (Ahwa)',
          nameMr: 'Dangs (Ahwa)',
          talukas: [
            TalukaInfo(nameEn: 'Dangs (Ahwa) City / Central', nameMr: 'Dangs (Ahwa) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dangs (Ahwa) Rural / East', nameMr: 'Dangs (Ahwa) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dangs (Ahwa) Rural / West', nameMr: 'Dangs (Ahwa) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-DEV',
          nameEn: 'Devbhoomi Dwarka',
          nameMr: 'Devbhoomi Dwarka',
          talukas: [
            TalukaInfo(nameEn: 'Devbhoomi Dwarka City / Central', nameMr: 'Devbhoomi Dwarka शहर / केंद्र'),
            TalukaInfo(nameEn: 'Devbhoomi Dwarka Rural / East', nameMr: 'Devbhoomi Dwarka ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Devbhoomi Dwarka Rural / West', nameMr: 'Devbhoomi Dwarka ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-GAN',
          nameEn: 'Gandhinagar',
          nameMr: 'Gandhinagar',
          talukas: [
            TalukaInfo(nameEn: 'Gandhinagar City / Central', nameMr: 'Gandhinagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Gandhinagar Rural / East', nameMr: 'Gandhinagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Gandhinagar Rural / West', nameMr: 'Gandhinagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-GIR',
          nameEn: 'Gir Somnath',
          nameMr: 'Gir Somnath',
          talukas: [
            TalukaInfo(nameEn: 'Gir Somnath City / Central', nameMr: 'Gir Somnath शहर / केंद्र'),
            TalukaInfo(nameEn: 'Gir Somnath Rural / East', nameMr: 'Gir Somnath ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Gir Somnath Rural / West', nameMr: 'Gir Somnath ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-JAM',
          nameEn: 'Jamnagar',
          nameMr: 'Jamnagar',
          talukas: [
            TalukaInfo(nameEn: 'Jamnagar City / Central', nameMr: 'Jamnagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jamnagar Rural / East', nameMr: 'Jamnagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jamnagar Rural / West', nameMr: 'Jamnagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-JUN',
          nameEn: 'Junagadh',
          nameMr: 'Junagadh',
          talukas: [
            TalukaInfo(nameEn: 'Junagadh City / Central', nameMr: 'Junagadh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Junagadh Rural / East', nameMr: 'Junagadh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Junagadh Rural / West', nameMr: 'Junagadh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-KAC',
          nameEn: 'Kachchh',
          nameMr: 'Kachchh',
          talukas: [
            TalukaInfo(nameEn: 'Kachchh City / Central', nameMr: 'Kachchh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kachchh Rural / East', nameMr: 'Kachchh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kachchh Rural / West', nameMr: 'Kachchh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-KHE',
          nameEn: 'Kheda (Nadiad)',
          nameMr: 'Kheda (Nadiad)',
          talukas: [
            TalukaInfo(nameEn: 'Kheda (Nadiad) City / Central', nameMr: 'Kheda (Nadiad) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kheda (Nadiad) Rural / East', nameMr: 'Kheda (Nadiad) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kheda (Nadiad) Rural / West', nameMr: 'Kheda (Nadiad) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-MAH',
          nameEn: 'Mahisagar',
          nameMr: 'Mahisagar',
          talukas: [
            TalukaInfo(nameEn: 'Mahisagar City / Central', nameMr: 'Mahisagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mahisagar Rural / East', nameMr: 'Mahisagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mahisagar Rural / West', nameMr: 'Mahisagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-MEH',
          nameEn: 'Mehsana',
          nameMr: 'Mehsana',
          talukas: [
            TalukaInfo(nameEn: 'Mehsana City / Central', nameMr: 'Mehsana शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mehsana Rural / East', nameMr: 'Mehsana ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mehsana Rural / West', nameMr: 'Mehsana ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-MOR',
          nameEn: 'Morbi',
          nameMr: 'Morbi',
          talukas: [
            TalukaInfo(nameEn: 'Morbi City / Central', nameMr: 'Morbi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Morbi Rural / East', nameMr: 'Morbi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Morbi Rural / West', nameMr: 'Morbi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-NAR',
          nameEn: 'Narmada (Rajpipla)',
          nameMr: 'Narmada (Rajpipla)',
          talukas: [
            TalukaInfo(nameEn: 'Narmada (Rajpipla) City / Central', nameMr: 'Narmada (Rajpipla) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Narmada (Rajpipla) Rural / East', nameMr: 'Narmada (Rajpipla) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Narmada (Rajpipla) Rural / West', nameMr: 'Narmada (Rajpipla) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-NAV',
          nameEn: 'Navsari',
          nameMr: 'Navsari',
          talukas: [
            TalukaInfo(nameEn: 'Navsari City / Central', nameMr: 'Navsari शहर / केंद्र'),
            TalukaInfo(nameEn: 'Navsari Rural / East', nameMr: 'Navsari ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Navsari Rural / West', nameMr: 'Navsari ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-PAN',
          nameEn: 'Panchmahal (Godhra)',
          nameMr: 'Panchmahal (Godhra)',
          talukas: [
            TalukaInfo(nameEn: 'Panchmahal (Godhra) City / Central', nameMr: 'Panchmahal (Godhra) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Panchmahal (Godhra) Rural / East', nameMr: 'Panchmahal (Godhra) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Panchmahal (Godhra) Rural / West', nameMr: 'Panchmahal (Godhra) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-PAT',
          nameEn: 'Patan',
          nameMr: 'Patan',
          talukas: [
            TalukaInfo(nameEn: 'Patan City / Central', nameMr: 'Patan शहर / केंद्र'),
            TalukaInfo(nameEn: 'Patan Rural / East', nameMr: 'Patan ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Patan Rural / West', nameMr: 'Patan ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-POR',
          nameEn: 'Porbandar',
          nameMr: 'Porbandar',
          talukas: [
            TalukaInfo(nameEn: 'Porbandar City / Central', nameMr: 'Porbandar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Porbandar Rural / East', nameMr: 'Porbandar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Porbandar Rural / West', nameMr: 'Porbandar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-RAJ',
          nameEn: 'Rajkot',
          nameMr: 'Rajkot',
          talukas: [
            TalukaInfo(nameEn: 'Rajkot City / Central', nameMr: 'Rajkot शहर / केंद्र'),
            TalukaInfo(nameEn: 'Rajkot Rural / East', nameMr: 'Rajkot ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Rajkot Rural / West', nameMr: 'Rajkot ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-SAB',
          nameEn: 'Sabarkantha (Himmatnagar)',
          nameMr: 'Sabarkantha (Himmatnagar)',
          talukas: [
            TalukaInfo(nameEn: 'Sabarkantha (Himmatnagar) City / Central', nameMr: 'Sabarkantha (Himmatnagar) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sabarkantha (Himmatnagar) Rural / East', nameMr: 'Sabarkantha (Himmatnagar) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sabarkantha (Himmatnagar) Rural / West', nameMr: 'Sabarkantha (Himmatnagar) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-SUR',
          nameEn: 'Surat',
          nameMr: 'Surat',
          talukas: [
            TalukaInfo(nameEn: 'Surat City', nameMr: 'सुरत शहर'),
            TalukaInfo(nameEn: 'Bardoli', nameMr: 'बारडोली'),
            TalukaInfo(nameEn: 'Kamrej', nameMr: 'कामरेज'),
            TalukaInfo(nameEn: 'Mahuva', nameMr: 'महुवा'),
            TalukaInfo(nameEn: 'Mandvi', nameMr: 'मांडवी'),
            TalukaInfo(nameEn: 'Mangrol', nameMr: 'मांगरोल'),
            TalukaInfo(nameEn: 'Olpad', nameMr: 'ओलपाड'),
            TalukaInfo(nameEn: 'Choryasi', nameMr: 'चोऱ्यासी'),
            TalukaInfo(nameEn: 'Umarpada', nameMr: 'उमरपाडा'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-SUR',
          nameEn: 'Surendranagar',
          nameMr: 'Surendranagar',
          talukas: [
            TalukaInfo(nameEn: 'Surendranagar City / Central', nameMr: 'Surendranagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Surendranagar Rural / East', nameMr: 'Surendranagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Surendranagar Rural / West', nameMr: 'Surendranagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-TAP',
          nameEn: 'Tapi (Vyara)',
          nameMr: 'Tapi (Vyara)',
          talukas: [
            TalukaInfo(nameEn: 'Tapi (Vyara) City / Central', nameMr: 'Tapi (Vyara) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Tapi (Vyara) Rural / East', nameMr: 'Tapi (Vyara) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Tapi (Vyara) Rural / West', nameMr: 'Tapi (Vyara) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-VAD',
          nameEn: 'Vadodara',
          nameMr: 'Vadodara',
          talukas: [
            TalukaInfo(nameEn: 'Vadodara City / Central', nameMr: 'Vadodara शहर / केंद्र'),
            TalukaInfo(nameEn: 'Vadodara Rural / East', nameMr: 'Vadodara ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Vadodara Rural / West', nameMr: 'Vadodara ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'GJ-VAL',
          nameEn: 'Valsad',
          nameMr: 'Valsad',
          talukas: [
            TalukaInfo(nameEn: 'Valsad City / Central', nameMr: 'Valsad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Valsad Rural / East', nameMr: 'Valsad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Valsad Rural / West', nameMr: 'Valsad ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'HR',
      nameEn: 'Haryana',
      nameMr: 'हरियाणा',
      districts: [
        DistrictInfo(
          code: 'HR-AMB',
          nameEn: 'Ambala',
          nameMr: 'Ambala',
          talukas: [
            TalukaInfo(nameEn: 'Ambala City / Central', nameMr: 'Ambala शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ambala Rural / East', nameMr: 'Ambala ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ambala Rural / West', nameMr: 'Ambala ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-BHI',
          nameEn: 'Bhiwani',
          nameMr: 'Bhiwani',
          talukas: [
            TalukaInfo(nameEn: 'Bhiwani City / Central', nameMr: 'Bhiwani शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bhiwani Rural / East', nameMr: 'Bhiwani ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bhiwani Rural / West', nameMr: 'Bhiwani ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-CHA',
          nameEn: 'Charkhi Dadri',
          nameMr: 'Charkhi Dadri',
          talukas: [
            TalukaInfo(nameEn: 'Charkhi Dadri City / Central', nameMr: 'Charkhi Dadri शहर / केंद्र'),
            TalukaInfo(nameEn: 'Charkhi Dadri Rural / East', nameMr: 'Charkhi Dadri ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Charkhi Dadri Rural / West', nameMr: 'Charkhi Dadri ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-FAR',
          nameEn: 'Faridabad',
          nameMr: 'Faridabad',
          talukas: [
            TalukaInfo(nameEn: 'Faridabad City / Central', nameMr: 'Faridabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Faridabad Rural / East', nameMr: 'Faridabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Faridabad Rural / West', nameMr: 'Faridabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-FAT',
          nameEn: 'Fatehabad',
          nameMr: 'Fatehabad',
          talukas: [
            TalukaInfo(nameEn: 'Fatehabad City / Central', nameMr: 'Fatehabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Fatehabad Rural / East', nameMr: 'Fatehabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Fatehabad Rural / West', nameMr: 'Fatehabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-GUR',
          nameEn: 'Gurgaon',
          nameMr: 'Gurgaon',
          talukas: [
            TalukaInfo(nameEn: 'Gurgaon City / Central', nameMr: 'Gurgaon शहर / केंद्र'),
            TalukaInfo(nameEn: 'Gurgaon Rural / East', nameMr: 'Gurgaon ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Gurgaon Rural / West', nameMr: 'Gurgaon ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-HIS',
          nameEn: 'Hisar',
          nameMr: 'Hisar',
          talukas: [
            TalukaInfo(nameEn: 'Hisar City / Central', nameMr: 'Hisar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Hisar Rural / East', nameMr: 'Hisar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Hisar Rural / West', nameMr: 'Hisar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-JHA',
          nameEn: 'Jhajjar',
          nameMr: 'Jhajjar',
          talukas: [
            TalukaInfo(nameEn: 'Jhajjar City / Central', nameMr: 'Jhajjar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jhajjar Rural / East', nameMr: 'Jhajjar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jhajjar Rural / West', nameMr: 'Jhajjar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-JIN',
          nameEn: 'Jind',
          nameMr: 'Jind',
          talukas: [
            TalukaInfo(nameEn: 'Jind City / Central', nameMr: 'Jind शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jind Rural / East', nameMr: 'Jind ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jind Rural / West', nameMr: 'Jind ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-KAI',
          nameEn: 'Kaithal',
          nameMr: 'Kaithal',
          talukas: [
            TalukaInfo(nameEn: 'Kaithal City / Central', nameMr: 'Kaithal शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kaithal Rural / East', nameMr: 'Kaithal ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kaithal Rural / West', nameMr: 'Kaithal ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-KAR',
          nameEn: 'Karnal',
          nameMr: 'Karnal',
          talukas: [
            TalukaInfo(nameEn: 'Karnal City / Central', nameMr: 'Karnal शहर / केंद्र'),
            TalukaInfo(nameEn: 'Karnal Rural / East', nameMr: 'Karnal ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Karnal Rural / West', nameMr: 'Karnal ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-KUR',
          nameEn: 'Kurukshetra',
          nameMr: 'Kurukshetra',
          talukas: [
            TalukaInfo(nameEn: 'Kurukshetra City / Central', nameMr: 'Kurukshetra शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kurukshetra Rural / East', nameMr: 'Kurukshetra ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kurukshetra Rural / West', nameMr: 'Kurukshetra ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-MAH',
          nameEn: 'Mahendragarh',
          nameMr: 'Mahendragarh',
          talukas: [
            TalukaInfo(nameEn: 'Mahendragarh City / Central', nameMr: 'Mahendragarh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mahendragarh Rural / East', nameMr: 'Mahendragarh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mahendragarh Rural / West', nameMr: 'Mahendragarh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-MEW',
          nameEn: 'Mewat',
          nameMr: 'Mewat',
          talukas: [
            TalukaInfo(nameEn: 'Mewat City / Central', nameMr: 'Mewat शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mewat Rural / East', nameMr: 'Mewat ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mewat Rural / West', nameMr: 'Mewat ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-PAL',
          nameEn: 'Palwal',
          nameMr: 'Palwal',
          talukas: [
            TalukaInfo(nameEn: 'Palwal City / Central', nameMr: 'Palwal शहर / केंद्र'),
            TalukaInfo(nameEn: 'Palwal Rural / East', nameMr: 'Palwal ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Palwal Rural / West', nameMr: 'Palwal ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-PAN',
          nameEn: 'Panchkula',
          nameMr: 'Panchkula',
          talukas: [
            TalukaInfo(nameEn: 'Panchkula City / Central', nameMr: 'Panchkula शहर / केंद्र'),
            TalukaInfo(nameEn: 'Panchkula Rural / East', nameMr: 'Panchkula ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Panchkula Rural / West', nameMr: 'Panchkula ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-PAN',
          nameEn: 'Panipat',
          nameMr: 'Panipat',
          talukas: [
            TalukaInfo(nameEn: 'Panipat City / Central', nameMr: 'Panipat शहर / केंद्र'),
            TalukaInfo(nameEn: 'Panipat Rural / East', nameMr: 'Panipat ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Panipat Rural / West', nameMr: 'Panipat ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-REW',
          nameEn: 'Rewari',
          nameMr: 'Rewari',
          talukas: [
            TalukaInfo(nameEn: 'Rewari City / Central', nameMr: 'Rewari शहर / केंद्र'),
            TalukaInfo(nameEn: 'Rewari Rural / East', nameMr: 'Rewari ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Rewari Rural / West', nameMr: 'Rewari ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-ROH',
          nameEn: 'Rohtak',
          nameMr: 'Rohtak',
          talukas: [
            TalukaInfo(nameEn: 'Rohtak City / Central', nameMr: 'Rohtak शहर / केंद्र'),
            TalukaInfo(nameEn: 'Rohtak Rural / East', nameMr: 'Rohtak ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Rohtak Rural / West', nameMr: 'Rohtak ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-SIR',
          nameEn: 'Sirsa',
          nameMr: 'Sirsa',
          talukas: [
            TalukaInfo(nameEn: 'Sirsa City / Central', nameMr: 'Sirsa शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sirsa Rural / East', nameMr: 'Sirsa ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sirsa Rural / West', nameMr: 'Sirsa ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-SON',
          nameEn: 'Sonipat',
          nameMr: 'Sonipat',
          talukas: [
            TalukaInfo(nameEn: 'Sonipat City / Central', nameMr: 'Sonipat शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sonipat Rural / East', nameMr: 'Sonipat ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sonipat Rural / West', nameMr: 'Sonipat ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HR-YAM',
          nameEn: 'Yamunanagar',
          nameMr: 'Yamunanagar',
          talukas: [
            TalukaInfo(nameEn: 'Yamunanagar City / Central', nameMr: 'Yamunanagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Yamunanagar Rural / East', nameMr: 'Yamunanagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Yamunanagar Rural / West', nameMr: 'Yamunanagar ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'HP',
      nameEn: 'Himachal Pradesh',
      nameMr: 'हिमाचल प्रदेश',
      districts: [
        DistrictInfo(
          code: 'HP-BIL',
          nameEn: 'Bilaspur',
          nameMr: 'Bilaspur',
          talukas: [
            TalukaInfo(nameEn: 'Bilaspur City / Central', nameMr: 'Bilaspur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bilaspur Rural / East', nameMr: 'Bilaspur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bilaspur Rural / West', nameMr: 'Bilaspur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HP-CHA',
          nameEn: 'Chamba',
          nameMr: 'Chamba',
          talukas: [
            TalukaInfo(nameEn: 'Chamba City / Central', nameMr: 'Chamba शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chamba Rural / East', nameMr: 'Chamba ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chamba Rural / West', nameMr: 'Chamba ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HP-HAM',
          nameEn: 'Hamirpur',
          nameMr: 'Hamirpur',
          talukas: [
            TalukaInfo(nameEn: 'Hamirpur City / Central', nameMr: 'Hamirpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Hamirpur Rural / East', nameMr: 'Hamirpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Hamirpur Rural / West', nameMr: 'Hamirpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HP-KAN',
          nameEn: 'Kangra',
          nameMr: 'Kangra',
          talukas: [
            TalukaInfo(nameEn: 'Kangra City / Central', nameMr: 'Kangra शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kangra Rural / East', nameMr: 'Kangra ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kangra Rural / West', nameMr: 'Kangra ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HP-KIN',
          nameEn: 'Kinnaur',
          nameMr: 'Kinnaur',
          talukas: [
            TalukaInfo(nameEn: 'Kinnaur City / Central', nameMr: 'Kinnaur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kinnaur Rural / East', nameMr: 'Kinnaur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kinnaur Rural / West', nameMr: 'Kinnaur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HP-KUL',
          nameEn: 'Kullu',
          nameMr: 'Kullu',
          talukas: [
            TalukaInfo(nameEn: 'Kullu City / Central', nameMr: 'Kullu शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kullu Rural / East', nameMr: 'Kullu ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kullu Rural / West', nameMr: 'Kullu ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HP-LAH',
          nameEn: 'Lahaul &amp; Spiti',
          nameMr: 'Lahaul &amp; Spiti',
          talukas: [
            TalukaInfo(nameEn: 'Lahaul &amp; Spiti City / Central', nameMr: 'Lahaul &amp; Spiti शहर / केंद्र'),
            TalukaInfo(nameEn: 'Lahaul &amp; Spiti Rural / East', nameMr: 'Lahaul &amp; Spiti ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Lahaul &amp; Spiti Rural / West', nameMr: 'Lahaul &amp; Spiti ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HP-MAN',
          nameEn: 'Mandi',
          nameMr: 'Mandi',
          talukas: [
            TalukaInfo(nameEn: 'Mandi City / Central', nameMr: 'Mandi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mandi Rural / East', nameMr: 'Mandi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mandi Rural / West', nameMr: 'Mandi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HP-SHI',
          nameEn: 'Shimla',
          nameMr: 'Shimla',
          talukas: [
            TalukaInfo(nameEn: 'Shimla City / Central', nameMr: 'Shimla शहर / केंद्र'),
            TalukaInfo(nameEn: 'Shimla Rural / East', nameMr: 'Shimla ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Shimla Rural / West', nameMr: 'Shimla ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HP-SIR',
          nameEn: 'Sirmaur (Sirmour)',
          nameMr: 'Sirmaur (Sirmour)',
          talukas: [
            TalukaInfo(nameEn: 'Sirmaur (Sirmour) City / Central', nameMr: 'Sirmaur (Sirmour) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sirmaur (Sirmour) Rural / East', nameMr: 'Sirmaur (Sirmour) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sirmaur (Sirmour) Rural / West', nameMr: 'Sirmaur (Sirmour) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HP-SOL',
          nameEn: 'Solan',
          nameMr: 'Solan',
          talukas: [
            TalukaInfo(nameEn: 'Solan City / Central', nameMr: 'Solan शहर / केंद्र'),
            TalukaInfo(nameEn: 'Solan Rural / East', nameMr: 'Solan ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Solan Rural / West', nameMr: 'Solan ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'HP-UNA',
          nameEn: 'Una',
          nameMr: 'Una',
          talukas: [
            TalukaInfo(nameEn: 'Una City / Central', nameMr: 'Una शहर / केंद्र'),
            TalukaInfo(nameEn: 'Una Rural / East', nameMr: 'Una ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Una Rural / West', nameMr: 'Una ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'JK',
      nameEn: 'Jammu and Kashmir',
      nameMr: 'जम्मू आणि काश्मीर',
      districts: [
        DistrictInfo(
          code: 'JK-ANA',
          nameEn: 'Anantnag',
          nameMr: 'Anantnag',
          talukas: [
            TalukaInfo(nameEn: 'Anantnag City / Central', nameMr: 'Anantnag शहर / केंद्र'),
            TalukaInfo(nameEn: 'Anantnag Rural / East', nameMr: 'Anantnag ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Anantnag Rural / West', nameMr: 'Anantnag ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-BAN',
          nameEn: 'Bandipore',
          nameMr: 'Bandipore',
          talukas: [
            TalukaInfo(nameEn: 'Bandipore City / Central', nameMr: 'Bandipore शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bandipore Rural / East', nameMr: 'Bandipore ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bandipore Rural / West', nameMr: 'Bandipore ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-BAR',
          nameEn: 'Baramulla',
          nameMr: 'Baramulla',
          talukas: [
            TalukaInfo(nameEn: 'Baramulla City / Central', nameMr: 'Baramulla शहर / केंद्र'),
            TalukaInfo(nameEn: 'Baramulla Rural / East', nameMr: 'Baramulla ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Baramulla Rural / West', nameMr: 'Baramulla ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-BUD',
          nameEn: 'Budgam',
          nameMr: 'Budgam',
          talukas: [
            TalukaInfo(nameEn: 'Budgam City / Central', nameMr: 'Budgam शहर / केंद्र'),
            TalukaInfo(nameEn: 'Budgam Rural / East', nameMr: 'Budgam ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Budgam Rural / West', nameMr: 'Budgam ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-DOD',
          nameEn: 'Doda',
          nameMr: 'Doda',
          talukas: [
            TalukaInfo(nameEn: 'Doda City / Central', nameMr: 'Doda शहर / केंद्र'),
            TalukaInfo(nameEn: 'Doda Rural / East', nameMr: 'Doda ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Doda Rural / West', nameMr: 'Doda ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-GAN',
          nameEn: 'Ganderbal',
          nameMr: 'Ganderbal',
          talukas: [
            TalukaInfo(nameEn: 'Ganderbal City / Central', nameMr: 'Ganderbal शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ganderbal Rural / East', nameMr: 'Ganderbal ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ganderbal Rural / West', nameMr: 'Ganderbal ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-JAM',
          nameEn: 'Jammu',
          nameMr: 'Jammu',
          talukas: [
            TalukaInfo(nameEn: 'Jammu City / Central', nameMr: 'Jammu शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jammu Rural / East', nameMr: 'Jammu ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jammu Rural / West', nameMr: 'Jammu ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-KAR',
          nameEn: 'Kargil',
          nameMr: 'Kargil',
          talukas: [
            TalukaInfo(nameEn: 'Kargil City / Central', nameMr: 'Kargil शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kargil Rural / East', nameMr: 'Kargil ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kargil Rural / West', nameMr: 'Kargil ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-KAT',
          nameEn: 'Kathua',
          nameMr: 'Kathua',
          talukas: [
            TalukaInfo(nameEn: 'Kathua City / Central', nameMr: 'Kathua शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kathua Rural / East', nameMr: 'Kathua ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kathua Rural / West', nameMr: 'Kathua ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-KIS',
          nameEn: 'Kishtwar',
          nameMr: 'Kishtwar',
          talukas: [
            TalukaInfo(nameEn: 'Kishtwar City / Central', nameMr: 'Kishtwar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kishtwar Rural / East', nameMr: 'Kishtwar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kishtwar Rural / West', nameMr: 'Kishtwar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-KUL',
          nameEn: 'Kulgam',
          nameMr: 'Kulgam',
          talukas: [
            TalukaInfo(nameEn: 'Kulgam City / Central', nameMr: 'Kulgam शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kulgam Rural / East', nameMr: 'Kulgam ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kulgam Rural / West', nameMr: 'Kulgam ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-KUP',
          nameEn: 'Kupwara',
          nameMr: 'Kupwara',
          talukas: [
            TalukaInfo(nameEn: 'Kupwara City / Central', nameMr: 'Kupwara शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kupwara Rural / East', nameMr: 'Kupwara ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kupwara Rural / West', nameMr: 'Kupwara ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-LEH',
          nameEn: 'Leh',
          nameMr: 'Leh',
          talukas: [
            TalukaInfo(nameEn: 'Leh City / Central', nameMr: 'Leh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Leh Rural / East', nameMr: 'Leh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Leh Rural / West', nameMr: 'Leh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-POO',
          nameEn: 'Poonch',
          nameMr: 'Poonch',
          talukas: [
            TalukaInfo(nameEn: 'Poonch City / Central', nameMr: 'Poonch शहर / केंद्र'),
            TalukaInfo(nameEn: 'Poonch Rural / East', nameMr: 'Poonch ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Poonch Rural / West', nameMr: 'Poonch ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-PUL',
          nameEn: 'Pulwama',
          nameMr: 'Pulwama',
          talukas: [
            TalukaInfo(nameEn: 'Pulwama City / Central', nameMr: 'Pulwama शहर / केंद्र'),
            TalukaInfo(nameEn: 'Pulwama Rural / East', nameMr: 'Pulwama ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Pulwama Rural / West', nameMr: 'Pulwama ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-RAJ',
          nameEn: 'Rajouri',
          nameMr: 'Rajouri',
          talukas: [
            TalukaInfo(nameEn: 'Rajouri City / Central', nameMr: 'Rajouri शहर / केंद्र'),
            TalukaInfo(nameEn: 'Rajouri Rural / East', nameMr: 'Rajouri ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Rajouri Rural / West', nameMr: 'Rajouri ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-RAM',
          nameEn: 'Ramban',
          nameMr: 'Ramban',
          talukas: [
            TalukaInfo(nameEn: 'Ramban City / Central', nameMr: 'Ramban शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ramban Rural / East', nameMr: 'Ramban ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ramban Rural / West', nameMr: 'Ramban ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-REA',
          nameEn: 'Reasi',
          nameMr: 'Reasi',
          talukas: [
            TalukaInfo(nameEn: 'Reasi City / Central', nameMr: 'Reasi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Reasi Rural / East', nameMr: 'Reasi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Reasi Rural / West', nameMr: 'Reasi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-SAM',
          nameEn: 'Samba',
          nameMr: 'Samba',
          talukas: [
            TalukaInfo(nameEn: 'Samba City / Central', nameMr: 'Samba शहर / केंद्र'),
            TalukaInfo(nameEn: 'Samba Rural / East', nameMr: 'Samba ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Samba Rural / West', nameMr: 'Samba ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-SHO',
          nameEn: 'Shopian',
          nameMr: 'Shopian',
          talukas: [
            TalukaInfo(nameEn: 'Shopian City / Central', nameMr: 'Shopian शहर / केंद्र'),
            TalukaInfo(nameEn: 'Shopian Rural / East', nameMr: 'Shopian ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Shopian Rural / West', nameMr: 'Shopian ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-SRI',
          nameEn: 'Srinagar',
          nameMr: 'Srinagar',
          talukas: [
            TalukaInfo(nameEn: 'Srinagar City / Central', nameMr: 'Srinagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Srinagar Rural / East', nameMr: 'Srinagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Srinagar Rural / West', nameMr: 'Srinagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JK-UDH',
          nameEn: 'Udhampur',
          nameMr: 'Udhampur',
          talukas: [
            TalukaInfo(nameEn: 'Udhampur City / Central', nameMr: 'Udhampur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Udhampur Rural / East', nameMr: 'Udhampur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Udhampur Rural / West', nameMr: 'Udhampur ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'JH',
      nameEn: 'Jharkhand',
      nameMr: 'झारखंड',
      districts: [
        DistrictInfo(
          code: 'JH-BOK',
          nameEn: 'Bokaro',
          nameMr: 'Bokaro',
          talukas: [
            TalukaInfo(nameEn: 'Bokaro City / Central', nameMr: 'Bokaro शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bokaro Rural / East', nameMr: 'Bokaro ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bokaro Rural / West', nameMr: 'Bokaro ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-CHA',
          nameEn: 'Chatra',
          nameMr: 'Chatra',
          talukas: [
            TalukaInfo(nameEn: 'Chatra City / Central', nameMr: 'Chatra शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chatra Rural / East', nameMr: 'Chatra ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chatra Rural / West', nameMr: 'Chatra ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-DEO',
          nameEn: 'Deoghar',
          nameMr: 'Deoghar',
          talukas: [
            TalukaInfo(nameEn: 'Deoghar City / Central', nameMr: 'Deoghar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Deoghar Rural / East', nameMr: 'Deoghar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Deoghar Rural / West', nameMr: 'Deoghar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-DHA',
          nameEn: 'Dhanbad',
          nameMr: 'Dhanbad',
          talukas: [
            TalukaInfo(nameEn: 'Dhanbad City / Central', nameMr: 'Dhanbad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dhanbad Rural / East', nameMr: 'Dhanbad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dhanbad Rural / West', nameMr: 'Dhanbad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-DUM',
          nameEn: 'Dumka',
          nameMr: 'Dumka',
          talukas: [
            TalukaInfo(nameEn: 'Dumka City / Central', nameMr: 'Dumka शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dumka Rural / East', nameMr: 'Dumka ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dumka Rural / West', nameMr: 'Dumka ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-EAS',
          nameEn: 'East Singhbhum',
          nameMr: 'East Singhbhum',
          talukas: [
            TalukaInfo(nameEn: 'East Singhbhum City / Central', nameMr: 'East Singhbhum शहर / केंद्र'),
            TalukaInfo(nameEn: 'East Singhbhum Rural / East', nameMr: 'East Singhbhum ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'East Singhbhum Rural / West', nameMr: 'East Singhbhum ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-GAR',
          nameEn: 'Garhwa',
          nameMr: 'Garhwa',
          talukas: [
            TalukaInfo(nameEn: 'Garhwa City / Central', nameMr: 'Garhwa शहर / केंद्र'),
            TalukaInfo(nameEn: 'Garhwa Rural / East', nameMr: 'Garhwa ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Garhwa Rural / West', nameMr: 'Garhwa ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-GIR',
          nameEn: 'Giridih',
          nameMr: 'Giridih',
          talukas: [
            TalukaInfo(nameEn: 'Giridih City / Central', nameMr: 'Giridih शहर / केंद्र'),
            TalukaInfo(nameEn: 'Giridih Rural / East', nameMr: 'Giridih ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Giridih Rural / West', nameMr: 'Giridih ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-GOD',
          nameEn: 'Godda',
          nameMr: 'Godda',
          talukas: [
            TalukaInfo(nameEn: 'Godda City / Central', nameMr: 'Godda शहर / केंद्र'),
            TalukaInfo(nameEn: 'Godda Rural / East', nameMr: 'Godda ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Godda Rural / West', nameMr: 'Godda ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-GUM',
          nameEn: 'Gumla',
          nameMr: 'Gumla',
          talukas: [
            TalukaInfo(nameEn: 'Gumla City / Central', nameMr: 'Gumla शहर / केंद्र'),
            TalukaInfo(nameEn: 'Gumla Rural / East', nameMr: 'Gumla ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Gumla Rural / West', nameMr: 'Gumla ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-HAZ',
          nameEn: 'Hazaribag',
          nameMr: 'Hazaribag',
          talukas: [
            TalukaInfo(nameEn: 'Hazaribag City / Central', nameMr: 'Hazaribag शहर / केंद्र'),
            TalukaInfo(nameEn: 'Hazaribag Rural / East', nameMr: 'Hazaribag ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Hazaribag Rural / West', nameMr: 'Hazaribag ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-JAM',
          nameEn: 'Jamtara',
          nameMr: 'Jamtara',
          talukas: [
            TalukaInfo(nameEn: 'Jamtara City / Central', nameMr: 'Jamtara शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jamtara Rural / East', nameMr: 'Jamtara ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jamtara Rural / West', nameMr: 'Jamtara ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-KHU',
          nameEn: 'Khunti',
          nameMr: 'Khunti',
          talukas: [
            TalukaInfo(nameEn: 'Khunti City / Central', nameMr: 'Khunti शहर / केंद्र'),
            TalukaInfo(nameEn: 'Khunti Rural / East', nameMr: 'Khunti ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Khunti Rural / West', nameMr: 'Khunti ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-KOD',
          nameEn: 'Koderma',
          nameMr: 'Koderma',
          talukas: [
            TalukaInfo(nameEn: 'Koderma City / Central', nameMr: 'Koderma शहर / केंद्र'),
            TalukaInfo(nameEn: 'Koderma Rural / East', nameMr: 'Koderma ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Koderma Rural / West', nameMr: 'Koderma ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-LAT',
          nameEn: 'Latehar',
          nameMr: 'Latehar',
          talukas: [
            TalukaInfo(nameEn: 'Latehar City / Central', nameMr: 'Latehar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Latehar Rural / East', nameMr: 'Latehar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Latehar Rural / West', nameMr: 'Latehar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-LOH',
          nameEn: 'Lohardaga',
          nameMr: 'Lohardaga',
          talukas: [
            TalukaInfo(nameEn: 'Lohardaga City / Central', nameMr: 'Lohardaga शहर / केंद्र'),
            TalukaInfo(nameEn: 'Lohardaga Rural / East', nameMr: 'Lohardaga ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Lohardaga Rural / West', nameMr: 'Lohardaga ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-PAK',
          nameEn: 'Pakur',
          nameMr: 'Pakur',
          talukas: [
            TalukaInfo(nameEn: 'Pakur City / Central', nameMr: 'Pakur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Pakur Rural / East', nameMr: 'Pakur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Pakur Rural / West', nameMr: 'Pakur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-PAL',
          nameEn: 'Palamu',
          nameMr: 'Palamu',
          talukas: [
            TalukaInfo(nameEn: 'Palamu City / Central', nameMr: 'Palamu शहर / केंद्र'),
            TalukaInfo(nameEn: 'Palamu Rural / East', nameMr: 'Palamu ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Palamu Rural / West', nameMr: 'Palamu ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-RAM',
          nameEn: 'Ramgarh',
          nameMr: 'Ramgarh',
          talukas: [
            TalukaInfo(nameEn: 'Ramgarh City / Central', nameMr: 'Ramgarh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ramgarh Rural / East', nameMr: 'Ramgarh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ramgarh Rural / West', nameMr: 'Ramgarh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-RAN',
          nameEn: 'Ranchi',
          nameMr: 'Ranchi',
          talukas: [
            TalukaInfo(nameEn: 'Ranchi City / Central', nameMr: 'Ranchi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ranchi Rural / East', nameMr: 'Ranchi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ranchi Rural / West', nameMr: 'Ranchi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-SAH',
          nameEn: 'Sahibganj',
          nameMr: 'Sahibganj',
          talukas: [
            TalukaInfo(nameEn: 'Sahibganj City / Central', nameMr: 'Sahibganj शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sahibganj Rural / East', nameMr: 'Sahibganj ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sahibganj Rural / West', nameMr: 'Sahibganj ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-SER',
          nameEn: 'Seraikela-Kharsawan',
          nameMr: 'Seraikela-Kharsawan',
          talukas: [
            TalukaInfo(nameEn: 'Seraikela-Kharsawan City / Central', nameMr: 'Seraikela-Kharsawan शहर / केंद्र'),
            TalukaInfo(nameEn: 'Seraikela-Kharsawan Rural / East', nameMr: 'Seraikela-Kharsawan ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Seraikela-Kharsawan Rural / West', nameMr: 'Seraikela-Kharsawan ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-SIM',
          nameEn: 'Simdega',
          nameMr: 'Simdega',
          talukas: [
            TalukaInfo(nameEn: 'Simdega City / Central', nameMr: 'Simdega शहर / केंद्र'),
            TalukaInfo(nameEn: 'Simdega Rural / East', nameMr: 'Simdega ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Simdega Rural / West', nameMr: 'Simdega ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'JH-WES',
          nameEn: 'West Singhbhum',
          nameMr: 'West Singhbhum',
          talukas: [
            TalukaInfo(nameEn: 'West Singhbhum City / Central', nameMr: 'West Singhbhum शहर / केंद्र'),
            TalukaInfo(nameEn: 'West Singhbhum Rural / East', nameMr: 'West Singhbhum ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'West Singhbhum Rural / West', nameMr: 'West Singhbhum ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'KA',
      nameEn: 'Karnataka',
      nameMr: 'कर्नाटक',
      districts: [
        DistrictInfo(
          code: 'KA-BAG',
          nameEn: 'Bagalkot',
          nameMr: 'Bagalkot',
          talukas: [
            TalukaInfo(nameEn: 'Bagalkot City / Central', nameMr: 'Bagalkot शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bagalkot Rural / East', nameMr: 'Bagalkot ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bagalkot Rural / West', nameMr: 'Bagalkot ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-BAL',
          nameEn: 'Ballari (Bellary)',
          nameMr: 'Ballari (Bellary)',
          talukas: [
            TalukaInfo(nameEn: 'Ballari (Bellary) City / Central', nameMr: 'Ballari (Bellary) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ballari (Bellary) Rural / East', nameMr: 'Ballari (Bellary) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ballari (Bellary) Rural / West', nameMr: 'Ballari (Bellary) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-BEL',
          nameEn: 'Belagavi (Belgaum)',
          nameMr: 'Belagavi (Belgaum)',
          talukas: [
            TalukaInfo(nameEn: 'Belagavi (Belgaum) City / Central', nameMr: 'Belagavi (Belgaum) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Belagavi (Belgaum) Rural / East', nameMr: 'Belagavi (Belgaum) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Belagavi (Belgaum) Rural / West', nameMr: 'Belagavi (Belgaum) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-BEN',
          nameEn: 'Bengaluru (Bangalore) Rural',
          nameMr: 'Bengaluru (Bangalore) Rural',
          talukas: [
            TalukaInfo(nameEn: 'Bengaluru (Bangalore) Rural City / Central', nameMr: 'Bengaluru (Bangalore) Rural शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bengaluru (Bangalore) Rural Rural / East', nameMr: 'Bengaluru (Bangalore) Rural ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bengaluru (Bangalore) Rural Rural / West', nameMr: 'Bengaluru (Bangalore) Rural ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-BEN',
          nameEn: 'Bengaluru (Bangalore) Urban',
          nameMr: 'Bengaluru (Bangalore) Urban',
          talukas: [
            TalukaInfo(nameEn: 'Bengaluru (Bangalore) Urban City / Central', nameMr: 'Bengaluru (Bangalore) Urban शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bengaluru (Bangalore) Urban Rural / East', nameMr: 'Bengaluru (Bangalore) Urban ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bengaluru (Bangalore) Urban Rural / West', nameMr: 'Bengaluru (Bangalore) Urban ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-BID',
          nameEn: 'Bidar',
          nameMr: 'Bidar',
          talukas: [
            TalukaInfo(nameEn: 'Bidar City / Central', nameMr: 'Bidar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bidar Rural / East', nameMr: 'Bidar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bidar Rural / West', nameMr: 'Bidar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-CHA',
          nameEn: 'Chamarajanagar',
          nameMr: 'Chamarajanagar',
          talukas: [
            TalukaInfo(nameEn: 'Chamarajanagar City / Central', nameMr: 'Chamarajanagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chamarajanagar Rural / East', nameMr: 'Chamarajanagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chamarajanagar Rural / West', nameMr: 'Chamarajanagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-CHI',
          nameEn: 'Chikballapur',
          nameMr: 'Chikballapur',
          talukas: [
            TalukaInfo(nameEn: 'Chikballapur City / Central', nameMr: 'Chikballapur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chikballapur Rural / East', nameMr: 'Chikballapur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chikballapur Rural / West', nameMr: 'Chikballapur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-CHI',
          nameEn: 'Chikkamagaluru (Chikmagalur)',
          nameMr: 'Chikkamagaluru (Chikmagalur)',
          talukas: [
            TalukaInfo(nameEn: 'Chikkamagaluru (Chikmagalur) City / Central', nameMr: 'Chikkamagaluru (Chikmagalur) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chikkamagaluru (Chikmagalur) Rural / East', nameMr: 'Chikkamagaluru (Chikmagalur) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chikkamagaluru (Chikmagalur) Rural / West', nameMr: 'Chikkamagaluru (Chikmagalur) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-CHI',
          nameEn: 'Chitradurga',
          nameMr: 'Chitradurga',
          talukas: [
            TalukaInfo(nameEn: 'Chitradurga City / Central', nameMr: 'Chitradurga शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chitradurga Rural / East', nameMr: 'Chitradurga ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chitradurga Rural / West', nameMr: 'Chitradurga ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-DAK',
          nameEn: 'Dakshina Kannada',
          nameMr: 'Dakshina Kannada',
          talukas: [
            TalukaInfo(nameEn: 'Dakshina Kannada City / Central', nameMr: 'Dakshina Kannada शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dakshina Kannada Rural / East', nameMr: 'Dakshina Kannada ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dakshina Kannada Rural / West', nameMr: 'Dakshina Kannada ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-DAV',
          nameEn: 'Davangere',
          nameMr: 'Davangere',
          talukas: [
            TalukaInfo(nameEn: 'Davangere City / Central', nameMr: 'Davangere शहर / केंद्र'),
            TalukaInfo(nameEn: 'Davangere Rural / East', nameMr: 'Davangere ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Davangere Rural / West', nameMr: 'Davangere ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-DHA',
          nameEn: 'Dharwad',
          nameMr: 'Dharwad',
          talukas: [
            TalukaInfo(nameEn: 'Dharwad City / Central', nameMr: 'Dharwad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dharwad Rural / East', nameMr: 'Dharwad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dharwad Rural / West', nameMr: 'Dharwad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-GAD',
          nameEn: 'Gadag',
          nameMr: 'Gadag',
          talukas: [
            TalukaInfo(nameEn: 'Gadag City / Central', nameMr: 'Gadag शहर / केंद्र'),
            TalukaInfo(nameEn: 'Gadag Rural / East', nameMr: 'Gadag ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Gadag Rural / West', nameMr: 'Gadag ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-HAS',
          nameEn: 'Hassan',
          nameMr: 'Hassan',
          talukas: [
            TalukaInfo(nameEn: 'Hassan City / Central', nameMr: 'Hassan शहर / केंद्र'),
            TalukaInfo(nameEn: 'Hassan Rural / East', nameMr: 'Hassan ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Hassan Rural / West', nameMr: 'Hassan ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-HAV',
          nameEn: 'Haveri',
          nameMr: 'Haveri',
          talukas: [
            TalukaInfo(nameEn: 'Haveri City / Central', nameMr: 'Haveri शहर / केंद्र'),
            TalukaInfo(nameEn: 'Haveri Rural / East', nameMr: 'Haveri ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Haveri Rural / West', nameMr: 'Haveri ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-KAL',
          nameEn: 'Kalaburagi (Gulbarga)',
          nameMr: 'Kalaburagi (Gulbarga)',
          talukas: [
            TalukaInfo(nameEn: 'Kalaburagi (Gulbarga) City / Central', nameMr: 'Kalaburagi (Gulbarga) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kalaburagi (Gulbarga) Rural / East', nameMr: 'Kalaburagi (Gulbarga) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kalaburagi (Gulbarga) Rural / West', nameMr: 'Kalaburagi (Gulbarga) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-KOD',
          nameEn: 'Kodagu',
          nameMr: 'Kodagu',
          talukas: [
            TalukaInfo(nameEn: 'Kodagu City / Central', nameMr: 'Kodagu शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kodagu Rural / East', nameMr: 'Kodagu ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kodagu Rural / West', nameMr: 'Kodagu ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-KOL',
          nameEn: 'Kolar',
          nameMr: 'Kolar',
          talukas: [
            TalukaInfo(nameEn: 'Kolar City / Central', nameMr: 'Kolar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kolar Rural / East', nameMr: 'Kolar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kolar Rural / West', nameMr: 'Kolar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-KOP',
          nameEn: 'Koppal',
          nameMr: 'Koppal',
          talukas: [
            TalukaInfo(nameEn: 'Koppal City / Central', nameMr: 'Koppal शहर / केंद्र'),
            TalukaInfo(nameEn: 'Koppal Rural / East', nameMr: 'Koppal ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Koppal Rural / West', nameMr: 'Koppal ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-MAN',
          nameEn: 'Mandya',
          nameMr: 'Mandya',
          talukas: [
            TalukaInfo(nameEn: 'Mandya City / Central', nameMr: 'Mandya शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mandya Rural / East', nameMr: 'Mandya ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mandya Rural / West', nameMr: 'Mandya ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-MYS',
          nameEn: 'Mysuru (Mysore)',
          nameMr: 'Mysuru (Mysore)',
          talukas: [
            TalukaInfo(nameEn: 'Mysuru (Mysore) City / Central', nameMr: 'Mysuru (Mysore) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mysuru (Mysore) Rural / East', nameMr: 'Mysuru (Mysore) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mysuru (Mysore) Rural / West', nameMr: 'Mysuru (Mysore) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-RAI',
          nameEn: 'Raichur',
          nameMr: 'Raichur',
          talukas: [
            TalukaInfo(nameEn: 'Raichur City / Central', nameMr: 'Raichur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Raichur Rural / East', nameMr: 'Raichur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Raichur Rural / West', nameMr: 'Raichur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-RAM',
          nameEn: 'Ramanagara',
          nameMr: 'Ramanagara',
          talukas: [
            TalukaInfo(nameEn: 'Ramanagara City / Central', nameMr: 'Ramanagara शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ramanagara Rural / East', nameMr: 'Ramanagara ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ramanagara Rural / West', nameMr: 'Ramanagara ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-SHI',
          nameEn: 'Shivamogga (Shimoga)',
          nameMr: 'Shivamogga (Shimoga)',
          talukas: [
            TalukaInfo(nameEn: 'Shivamogga (Shimoga) City / Central', nameMr: 'Shivamogga (Shimoga) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Shivamogga (Shimoga) Rural / East', nameMr: 'Shivamogga (Shimoga) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Shivamogga (Shimoga) Rural / West', nameMr: 'Shivamogga (Shimoga) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-TUM',
          nameEn: 'Tumakuru (Tumkur)',
          nameMr: 'Tumakuru (Tumkur)',
          talukas: [
            TalukaInfo(nameEn: 'Tumakuru (Tumkur) City / Central', nameMr: 'Tumakuru (Tumkur) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Tumakuru (Tumkur) Rural / East', nameMr: 'Tumakuru (Tumkur) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Tumakuru (Tumkur) Rural / West', nameMr: 'Tumakuru (Tumkur) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-UDU',
          nameEn: 'Udupi',
          nameMr: 'Udupi',
          talukas: [
            TalukaInfo(nameEn: 'Udupi City / Central', nameMr: 'Udupi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Udupi Rural / East', nameMr: 'Udupi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Udupi Rural / West', nameMr: 'Udupi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-UTT',
          nameEn: 'Uttara Kannada (Karwar)',
          nameMr: 'Uttara Kannada (Karwar)',
          talukas: [
            TalukaInfo(nameEn: 'Uttara Kannada (Karwar) City / Central', nameMr: 'Uttara Kannada (Karwar) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Uttara Kannada (Karwar) Rural / East', nameMr: 'Uttara Kannada (Karwar) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Uttara Kannada (Karwar) Rural / West', nameMr: 'Uttara Kannada (Karwar) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-VIJ',
          nameEn: 'Vijayapura (Bijapur)',
          nameMr: 'Vijayapura (Bijapur)',
          talukas: [
            TalukaInfo(nameEn: 'Vijayapura (Bijapur) City / Central', nameMr: 'Vijayapura (Bijapur) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Vijayapura (Bijapur) Rural / East', nameMr: 'Vijayapura (Bijapur) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Vijayapura (Bijapur) Rural / West', nameMr: 'Vijayapura (Bijapur) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KA-YAD',
          nameEn: 'Yadgir',
          nameMr: 'Yadgir',
          talukas: [
            TalukaInfo(nameEn: 'Yadgir City / Central', nameMr: 'Yadgir शहर / केंद्र'),
            TalukaInfo(nameEn: 'Yadgir Rural / East', nameMr: 'Yadgir ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Yadgir Rural / West', nameMr: 'Yadgir ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'KL',
      nameEn: 'Kerala',
      nameMr: 'केरळ',
      districts: [
        DistrictInfo(
          code: 'KL-ALA',
          nameEn: 'Alappuzha',
          nameMr: 'Alappuzha',
          talukas: [
            TalukaInfo(nameEn: 'Alappuzha City / Central', nameMr: 'Alappuzha शहर / केंद्र'),
            TalukaInfo(nameEn: 'Alappuzha Rural / East', nameMr: 'Alappuzha ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Alappuzha Rural / West', nameMr: 'Alappuzha ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KL-ERN',
          nameEn: 'Ernakulam',
          nameMr: 'Ernakulam',
          talukas: [
            TalukaInfo(nameEn: 'Ernakulam City / Central', nameMr: 'Ernakulam शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ernakulam Rural / East', nameMr: 'Ernakulam ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ernakulam Rural / West', nameMr: 'Ernakulam ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KL-IDU',
          nameEn: 'Idukki',
          nameMr: 'Idukki',
          talukas: [
            TalukaInfo(nameEn: 'Idukki City / Central', nameMr: 'Idukki शहर / केंद्र'),
            TalukaInfo(nameEn: 'Idukki Rural / East', nameMr: 'Idukki ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Idukki Rural / West', nameMr: 'Idukki ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KL-KAN',
          nameEn: 'Kannur',
          nameMr: 'Kannur',
          talukas: [
            TalukaInfo(nameEn: 'Kannur City / Central', nameMr: 'Kannur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kannur Rural / East', nameMr: 'Kannur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kannur Rural / West', nameMr: 'Kannur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KL-KAS',
          nameEn: 'Kasaragod',
          nameMr: 'Kasaragod',
          talukas: [
            TalukaInfo(nameEn: 'Kasaragod City / Central', nameMr: 'Kasaragod शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kasaragod Rural / East', nameMr: 'Kasaragod ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kasaragod Rural / West', nameMr: 'Kasaragod ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KL-KOL',
          nameEn: 'Kollam',
          nameMr: 'Kollam',
          talukas: [
            TalukaInfo(nameEn: 'Kollam City / Central', nameMr: 'Kollam शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kollam Rural / East', nameMr: 'Kollam ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kollam Rural / West', nameMr: 'Kollam ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KL-KOT',
          nameEn: 'Kottayam',
          nameMr: 'Kottayam',
          talukas: [
            TalukaInfo(nameEn: 'Kottayam City / Central', nameMr: 'Kottayam शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kottayam Rural / East', nameMr: 'Kottayam ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kottayam Rural / West', nameMr: 'Kottayam ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KL-KOZ',
          nameEn: 'Kozhikode',
          nameMr: 'Kozhikode',
          talukas: [
            TalukaInfo(nameEn: 'Kozhikode City / Central', nameMr: 'Kozhikode शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kozhikode Rural / East', nameMr: 'Kozhikode ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kozhikode Rural / West', nameMr: 'Kozhikode ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KL-MAL',
          nameEn: 'Malappuram',
          nameMr: 'Malappuram',
          talukas: [
            TalukaInfo(nameEn: 'Malappuram City / Central', nameMr: 'Malappuram शहर / केंद्र'),
            TalukaInfo(nameEn: 'Malappuram Rural / East', nameMr: 'Malappuram ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Malappuram Rural / West', nameMr: 'Malappuram ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KL-PAL',
          nameEn: 'Palakkad',
          nameMr: 'Palakkad',
          talukas: [
            TalukaInfo(nameEn: 'Palakkad City / Central', nameMr: 'Palakkad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Palakkad Rural / East', nameMr: 'Palakkad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Palakkad Rural / West', nameMr: 'Palakkad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KL-PAT',
          nameEn: 'Pathanamthitta',
          nameMr: 'Pathanamthitta',
          talukas: [
            TalukaInfo(nameEn: 'Pathanamthitta City / Central', nameMr: 'Pathanamthitta शहर / केंद्र'),
            TalukaInfo(nameEn: 'Pathanamthitta Rural / East', nameMr: 'Pathanamthitta ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Pathanamthitta Rural / West', nameMr: 'Pathanamthitta ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KL-THI',
          nameEn: 'Thiruvananthapuram',
          nameMr: 'Thiruvananthapuram',
          talukas: [
            TalukaInfo(nameEn: 'Thiruvananthapuram City / Central', nameMr: 'Thiruvananthapuram शहर / केंद्र'),
            TalukaInfo(nameEn: 'Thiruvananthapuram Rural / East', nameMr: 'Thiruvananthapuram ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Thiruvananthapuram Rural / West', nameMr: 'Thiruvananthapuram ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KL-THR',
          nameEn: 'Thrissur',
          nameMr: 'Thrissur',
          talukas: [
            TalukaInfo(nameEn: 'Thrissur City / Central', nameMr: 'Thrissur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Thrissur Rural / East', nameMr: 'Thrissur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Thrissur Rural / West', nameMr: 'Thrissur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'KL-WAY',
          nameEn: 'Wayanad',
          nameMr: 'Wayanad',
          talukas: [
            TalukaInfo(nameEn: 'Wayanad City / Central', nameMr: 'Wayanad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Wayanad Rural / East', nameMr: 'Wayanad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Wayanad Rural / West', nameMr: 'Wayanad ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'LD',
      nameEn: 'Lakshadweep (UT)',
      nameMr: 'लक्षद्वीप',
      districts: [
        DistrictInfo(
          code: 'LD-AGA',
          nameEn: 'Agatti',
          nameMr: 'Agatti',
          talukas: [
            TalukaInfo(nameEn: 'Agatti City / Central', nameMr: 'Agatti शहर / केंद्र'),
            TalukaInfo(nameEn: 'Agatti Rural / East', nameMr: 'Agatti ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Agatti Rural / West', nameMr: 'Agatti ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'LD-AMI',
          nameEn: 'Amini',
          nameMr: 'Amini',
          talukas: [
            TalukaInfo(nameEn: 'Amini City / Central', nameMr: 'Amini शहर / केंद्र'),
            TalukaInfo(nameEn: 'Amini Rural / East', nameMr: 'Amini ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Amini Rural / West', nameMr: 'Amini ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'LD-AND',
          nameEn: 'Androth',
          nameMr: 'Androth',
          talukas: [
            TalukaInfo(nameEn: 'Androth City / Central', nameMr: 'Androth शहर / केंद्र'),
            TalukaInfo(nameEn: 'Androth Rural / East', nameMr: 'Androth ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Androth Rural / West', nameMr: 'Androth ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'LD-BIT',
          nameEn: 'Bithra',
          nameMr: 'Bithra',
          talukas: [
            TalukaInfo(nameEn: 'Bithra City / Central', nameMr: 'Bithra शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bithra Rural / East', nameMr: 'Bithra ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bithra Rural / West', nameMr: 'Bithra ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'LD-CHE',
          nameEn: 'Chethlath',
          nameMr: 'Chethlath',
          talukas: [
            TalukaInfo(nameEn: 'Chethlath City / Central', nameMr: 'Chethlath शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chethlath Rural / East', nameMr: 'Chethlath ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chethlath Rural / West', nameMr: 'Chethlath ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'LD-KAV',
          nameEn: 'Kavaratti',
          nameMr: 'Kavaratti',
          talukas: [
            TalukaInfo(nameEn: 'Kavaratti City / Central', nameMr: 'Kavaratti शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kavaratti Rural / East', nameMr: 'Kavaratti ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kavaratti Rural / West', nameMr: 'Kavaratti ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'LD-KAD',
          nameEn: 'Kadmath',
          nameMr: 'Kadmath',
          talukas: [
            TalukaInfo(nameEn: 'Kadmath City / Central', nameMr: 'Kadmath शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kadmath Rural / East', nameMr: 'Kadmath ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kadmath Rural / West', nameMr: 'Kadmath ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'LD-KAL',
          nameEn: 'Kalpeni',
          nameMr: 'Kalpeni',
          talukas: [
            TalukaInfo(nameEn: 'Kalpeni City / Central', nameMr: 'Kalpeni शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kalpeni Rural / East', nameMr: 'Kalpeni ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kalpeni Rural / West', nameMr: 'Kalpeni ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'LD-KIL',
          nameEn: 'Kilthan',
          nameMr: 'Kilthan',
          talukas: [
            TalukaInfo(nameEn: 'Kilthan City / Central', nameMr: 'Kilthan शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kilthan Rural / East', nameMr: 'Kilthan ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kilthan Rural / West', nameMr: 'Kilthan ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'LD-MIN',
          nameEn: 'Minicoy',
          nameMr: 'Minicoy',
          talukas: [
            TalukaInfo(nameEn: 'Minicoy City / Central', nameMr: 'Minicoy शहर / केंद्र'),
            TalukaInfo(nameEn: 'Minicoy Rural / East', nameMr: 'Minicoy ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Minicoy Rural / West', nameMr: 'Minicoy ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'MP',
      nameEn: 'Madhya Pradesh',
      nameMr: 'मध्य प्रदेश',
      districts: [
        DistrictInfo(
          code: 'MP-AGA',
          nameEn: 'Agar Malwa',
          nameMr: 'Agar Malwa',
          talukas: [
            TalukaInfo(nameEn: 'Agar Malwa City / Central', nameMr: 'Agar Malwa शहर / केंद्र'),
            TalukaInfo(nameEn: 'Agar Malwa Rural / East', nameMr: 'Agar Malwa ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Agar Malwa Rural / West', nameMr: 'Agar Malwa ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-ALI',
          nameEn: 'Alirajpur',
          nameMr: 'Alirajpur',
          talukas: [
            TalukaInfo(nameEn: 'Alirajpur City / Central', nameMr: 'Alirajpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Alirajpur Rural / East', nameMr: 'Alirajpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Alirajpur Rural / West', nameMr: 'Alirajpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-ANU',
          nameEn: 'Anuppur',
          nameMr: 'Anuppur',
          talukas: [
            TalukaInfo(nameEn: 'Anuppur City / Central', nameMr: 'Anuppur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Anuppur Rural / East', nameMr: 'Anuppur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Anuppur Rural / West', nameMr: 'Anuppur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-ASH',
          nameEn: 'Ashoknagar',
          nameMr: 'Ashoknagar',
          talukas: [
            TalukaInfo(nameEn: 'Ashoknagar City / Central', nameMr: 'Ashoknagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ashoknagar Rural / East', nameMr: 'Ashoknagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ashoknagar Rural / West', nameMr: 'Ashoknagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-BAL',
          nameEn: 'Balaghat',
          nameMr: 'Balaghat',
          talukas: [
            TalukaInfo(nameEn: 'Balaghat City / Central', nameMr: 'Balaghat शहर / केंद्र'),
            TalukaInfo(nameEn: 'Balaghat Rural / East', nameMr: 'Balaghat ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Balaghat Rural / West', nameMr: 'Balaghat ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-BAR',
          nameEn: 'Barwani',
          nameMr: 'Barwani',
          talukas: [
            TalukaInfo(nameEn: 'Barwani City / Central', nameMr: 'Barwani शहर / केंद्र'),
            TalukaInfo(nameEn: 'Barwani Rural / East', nameMr: 'Barwani ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Barwani Rural / West', nameMr: 'Barwani ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-BET',
          nameEn: 'Betul',
          nameMr: 'Betul',
          talukas: [
            TalukaInfo(nameEn: 'Betul City / Central', nameMr: 'Betul शहर / केंद्र'),
            TalukaInfo(nameEn: 'Betul Rural / East', nameMr: 'Betul ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Betul Rural / West', nameMr: 'Betul ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-BHI',
          nameEn: 'Bhind',
          nameMr: 'Bhind',
          talukas: [
            TalukaInfo(nameEn: 'Bhind City / Central', nameMr: 'Bhind शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bhind Rural / East', nameMr: 'Bhind ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bhind Rural / West', nameMr: 'Bhind ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-BHO',
          nameEn: 'Bhopal',
          nameMr: 'Bhopal',
          talukas: [
            TalukaInfo(nameEn: 'Bhopal City / Central', nameMr: 'Bhopal शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bhopal Rural / East', nameMr: 'Bhopal ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bhopal Rural / West', nameMr: 'Bhopal ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-BUR',
          nameEn: 'Burhanpur',
          nameMr: 'Burhanpur',
          talukas: [
            TalukaInfo(nameEn: 'Burhanpur City / Central', nameMr: 'Burhanpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Burhanpur Rural / East', nameMr: 'Burhanpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Burhanpur Rural / West', nameMr: 'Burhanpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-CHH',
          nameEn: 'Chhatarpur',
          nameMr: 'Chhatarpur',
          talukas: [
            TalukaInfo(nameEn: 'Chhatarpur City / Central', nameMr: 'Chhatarpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chhatarpur Rural / East', nameMr: 'Chhatarpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chhatarpur Rural / West', nameMr: 'Chhatarpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-CHH',
          nameEn: 'Chhindwara',
          nameMr: 'Chhindwara',
          talukas: [
            TalukaInfo(nameEn: 'Chhindwara City / Central', nameMr: 'Chhindwara शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chhindwara Rural / East', nameMr: 'Chhindwara ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chhindwara Rural / West', nameMr: 'Chhindwara ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-DAM',
          nameEn: 'Damoh',
          nameMr: 'Damoh',
          talukas: [
            TalukaInfo(nameEn: 'Damoh City / Central', nameMr: 'Damoh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Damoh Rural / East', nameMr: 'Damoh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Damoh Rural / West', nameMr: 'Damoh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-DAT',
          nameEn: 'Datia',
          nameMr: 'Datia',
          talukas: [
            TalukaInfo(nameEn: 'Datia City / Central', nameMr: 'Datia शहर / केंद्र'),
            TalukaInfo(nameEn: 'Datia Rural / East', nameMr: 'Datia ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Datia Rural / West', nameMr: 'Datia ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-DEW',
          nameEn: 'Dewas',
          nameMr: 'Dewas',
          talukas: [
            TalukaInfo(nameEn: 'Dewas City / Central', nameMr: 'Dewas शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dewas Rural / East', nameMr: 'Dewas ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dewas Rural / West', nameMr: 'Dewas ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-DHA',
          nameEn: 'Dhar',
          nameMr: 'Dhar',
          talukas: [
            TalukaInfo(nameEn: 'Dhar City / Central', nameMr: 'Dhar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dhar Rural / East', nameMr: 'Dhar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dhar Rural / West', nameMr: 'Dhar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-DIN',
          nameEn: 'Dindori',
          nameMr: 'Dindori',
          talukas: [
            TalukaInfo(nameEn: 'Dindori City / Central', nameMr: 'Dindori शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dindori Rural / East', nameMr: 'Dindori ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dindori Rural / West', nameMr: 'Dindori ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-GUN',
          nameEn: 'Guna',
          nameMr: 'Guna',
          talukas: [
            TalukaInfo(nameEn: 'Guna City / Central', nameMr: 'Guna शहर / केंद्र'),
            TalukaInfo(nameEn: 'Guna Rural / East', nameMr: 'Guna ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Guna Rural / West', nameMr: 'Guna ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-GWA',
          nameEn: 'Gwalior',
          nameMr: 'Gwalior',
          talukas: [
            TalukaInfo(nameEn: 'Gwalior City / Central', nameMr: 'Gwalior शहर / केंद्र'),
            TalukaInfo(nameEn: 'Gwalior Rural / East', nameMr: 'Gwalior ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Gwalior Rural / West', nameMr: 'Gwalior ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-HAR',
          nameEn: 'Harda',
          nameMr: 'Harda',
          talukas: [
            TalukaInfo(nameEn: 'Harda City / Central', nameMr: 'Harda शहर / केंद्र'),
            TalukaInfo(nameEn: 'Harda Rural / East', nameMr: 'Harda ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Harda Rural / West', nameMr: 'Harda ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-HOS',
          nameEn: 'Hoshangabad',
          nameMr: 'Hoshangabad',
          talukas: [
            TalukaInfo(nameEn: 'Hoshangabad City / Central', nameMr: 'Hoshangabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Hoshangabad Rural / East', nameMr: 'Hoshangabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Hoshangabad Rural / West', nameMr: 'Hoshangabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-IND',
          nameEn: 'Indore',
          nameMr: 'Indore',
          talukas: [
            TalukaInfo(nameEn: 'Indore City / Central', nameMr: 'Indore शहर / केंद्र'),
            TalukaInfo(nameEn: 'Indore Rural / East', nameMr: 'Indore ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Indore Rural / West', nameMr: 'Indore ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-JAB',
          nameEn: 'Jabalpur',
          nameMr: 'Jabalpur',
          talukas: [
            TalukaInfo(nameEn: 'Jabalpur City / Central', nameMr: 'Jabalpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jabalpur Rural / East', nameMr: 'Jabalpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jabalpur Rural / West', nameMr: 'Jabalpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-JHA',
          nameEn: 'Jhabua',
          nameMr: 'Jhabua',
          talukas: [
            TalukaInfo(nameEn: 'Jhabua City / Central', nameMr: 'Jhabua शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jhabua Rural / East', nameMr: 'Jhabua ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jhabua Rural / West', nameMr: 'Jhabua ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-KAT',
          nameEn: 'Katni',
          nameMr: 'Katni',
          talukas: [
            TalukaInfo(nameEn: 'Katni City / Central', nameMr: 'Katni शहर / केंद्र'),
            TalukaInfo(nameEn: 'Katni Rural / East', nameMr: 'Katni ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Katni Rural / West', nameMr: 'Katni ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-KHA',
          nameEn: 'Khandwa',
          nameMr: 'Khandwa',
          talukas: [
            TalukaInfo(nameEn: 'Khandwa City / Central', nameMr: 'Khandwa शहर / केंद्र'),
            TalukaInfo(nameEn: 'Khandwa Rural / East', nameMr: 'Khandwa ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Khandwa Rural / West', nameMr: 'Khandwa ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-KHA',
          nameEn: 'Khargone',
          nameMr: 'Khargone',
          talukas: [
            TalukaInfo(nameEn: 'Khargone City / Central', nameMr: 'Khargone शहर / केंद्र'),
            TalukaInfo(nameEn: 'Khargone Rural / East', nameMr: 'Khargone ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Khargone Rural / West', nameMr: 'Khargone ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-MAN',
          nameEn: 'Mandla',
          nameMr: 'Mandla',
          talukas: [
            TalukaInfo(nameEn: 'Mandla City / Central', nameMr: 'Mandla शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mandla Rural / East', nameMr: 'Mandla ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mandla Rural / West', nameMr: 'Mandla ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-MAN',
          nameEn: 'Mandsaur',
          nameMr: 'Mandsaur',
          talukas: [
            TalukaInfo(nameEn: 'Mandsaur City / Central', nameMr: 'Mandsaur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mandsaur Rural / East', nameMr: 'Mandsaur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mandsaur Rural / West', nameMr: 'Mandsaur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-MOR',
          nameEn: 'Morena',
          nameMr: 'Morena',
          talukas: [
            TalukaInfo(nameEn: 'Morena City / Central', nameMr: 'Morena शहर / केंद्र'),
            TalukaInfo(nameEn: 'Morena Rural / East', nameMr: 'Morena ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Morena Rural / West', nameMr: 'Morena ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-NAR',
          nameEn: 'Narsinghpur',
          nameMr: 'Narsinghpur',
          talukas: [
            TalukaInfo(nameEn: 'Narsinghpur City / Central', nameMr: 'Narsinghpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Narsinghpur Rural / East', nameMr: 'Narsinghpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Narsinghpur Rural / West', nameMr: 'Narsinghpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-NEE',
          nameEn: 'Neemuch',
          nameMr: 'Neemuch',
          talukas: [
            TalukaInfo(nameEn: 'Neemuch City / Central', nameMr: 'Neemuch शहर / केंद्र'),
            TalukaInfo(nameEn: 'Neemuch Rural / East', nameMr: 'Neemuch ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Neemuch Rural / West', nameMr: 'Neemuch ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-PAN',
          nameEn: 'Panna',
          nameMr: 'Panna',
          talukas: [
            TalukaInfo(nameEn: 'Panna City / Central', nameMr: 'Panna शहर / केंद्र'),
            TalukaInfo(nameEn: 'Panna Rural / East', nameMr: 'Panna ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Panna Rural / West', nameMr: 'Panna ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-RAI',
          nameEn: 'Raisen',
          nameMr: 'Raisen',
          talukas: [
            TalukaInfo(nameEn: 'Raisen City / Central', nameMr: 'Raisen शहर / केंद्र'),
            TalukaInfo(nameEn: 'Raisen Rural / East', nameMr: 'Raisen ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Raisen Rural / West', nameMr: 'Raisen ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-RAJ',
          nameEn: 'Rajgarh',
          nameMr: 'Rajgarh',
          talukas: [
            TalukaInfo(nameEn: 'Rajgarh City / Central', nameMr: 'Rajgarh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Rajgarh Rural / East', nameMr: 'Rajgarh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Rajgarh Rural / West', nameMr: 'Rajgarh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-RAT',
          nameEn: 'Ratlam',
          nameMr: 'Ratlam',
          talukas: [
            TalukaInfo(nameEn: 'Ratlam City / Central', nameMr: 'Ratlam शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ratlam Rural / East', nameMr: 'Ratlam ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ratlam Rural / West', nameMr: 'Ratlam ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-REW',
          nameEn: 'Rewa',
          nameMr: 'Rewa',
          talukas: [
            TalukaInfo(nameEn: 'Rewa City / Central', nameMr: 'Rewa शहर / केंद्र'),
            TalukaInfo(nameEn: 'Rewa Rural / East', nameMr: 'Rewa ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Rewa Rural / West', nameMr: 'Rewa ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-SAG',
          nameEn: 'Sagar',
          nameMr: 'Sagar',
          talukas: [
            TalukaInfo(nameEn: 'Sagar City / Central', nameMr: 'Sagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sagar Rural / East', nameMr: 'Sagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sagar Rural / West', nameMr: 'Sagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-SAT',
          nameEn: 'Satna',
          nameMr: 'Satna',
          talukas: [
            TalukaInfo(nameEn: 'Satna City / Central', nameMr: 'Satna शहर / केंद्र'),
            TalukaInfo(nameEn: 'Satna Rural / East', nameMr: 'Satna ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Satna Rural / West', nameMr: 'Satna ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-SEH',
          nameEn: 'Sehore',
          nameMr: 'Sehore',
          talukas: [
            TalukaInfo(nameEn: 'Sehore City / Central', nameMr: 'Sehore शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sehore Rural / East', nameMr: 'Sehore ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sehore Rural / West', nameMr: 'Sehore ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-SEO',
          nameEn: 'Seoni',
          nameMr: 'Seoni',
          talukas: [
            TalukaInfo(nameEn: 'Seoni City / Central', nameMr: 'Seoni शहर / केंद्र'),
            TalukaInfo(nameEn: 'Seoni Rural / East', nameMr: 'Seoni ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Seoni Rural / West', nameMr: 'Seoni ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-SHA',
          nameEn: 'Shahdol',
          nameMr: 'Shahdol',
          talukas: [
            TalukaInfo(nameEn: 'Shahdol City / Central', nameMr: 'Shahdol शहर / केंद्र'),
            TalukaInfo(nameEn: 'Shahdol Rural / East', nameMr: 'Shahdol ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Shahdol Rural / West', nameMr: 'Shahdol ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-SHA',
          nameEn: 'Shajapur',
          nameMr: 'Shajapur',
          talukas: [
            TalukaInfo(nameEn: 'Shajapur City / Central', nameMr: 'Shajapur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Shajapur Rural / East', nameMr: 'Shajapur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Shajapur Rural / West', nameMr: 'Shajapur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-SHE',
          nameEn: 'Sheopur',
          nameMr: 'Sheopur',
          talukas: [
            TalukaInfo(nameEn: 'Sheopur City / Central', nameMr: 'Sheopur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sheopur Rural / East', nameMr: 'Sheopur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sheopur Rural / West', nameMr: 'Sheopur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-SHI',
          nameEn: 'Shivpuri',
          nameMr: 'Shivpuri',
          talukas: [
            TalukaInfo(nameEn: 'Shivpuri City / Central', nameMr: 'Shivpuri शहर / केंद्र'),
            TalukaInfo(nameEn: 'Shivpuri Rural / East', nameMr: 'Shivpuri ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Shivpuri Rural / West', nameMr: 'Shivpuri ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-SID',
          nameEn: 'Sidhi',
          nameMr: 'Sidhi',
          talukas: [
            TalukaInfo(nameEn: 'Sidhi City / Central', nameMr: 'Sidhi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sidhi Rural / East', nameMr: 'Sidhi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sidhi Rural / West', nameMr: 'Sidhi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-SIN',
          nameEn: 'Singrauli',
          nameMr: 'Singrauli',
          talukas: [
            TalukaInfo(nameEn: 'Singrauli City / Central', nameMr: 'Singrauli शहर / केंद्र'),
            TalukaInfo(nameEn: 'Singrauli Rural / East', nameMr: 'Singrauli ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Singrauli Rural / West', nameMr: 'Singrauli ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-TIK',
          nameEn: 'Tikamgarh',
          nameMr: 'Tikamgarh',
          talukas: [
            TalukaInfo(nameEn: 'Tikamgarh City / Central', nameMr: 'Tikamgarh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Tikamgarh Rural / East', nameMr: 'Tikamgarh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Tikamgarh Rural / West', nameMr: 'Tikamgarh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-UJJ',
          nameEn: 'Ujjain',
          nameMr: 'Ujjain',
          talukas: [
            TalukaInfo(nameEn: 'Ujjain City / Central', nameMr: 'Ujjain शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ujjain Rural / East', nameMr: 'Ujjain ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ujjain Rural / West', nameMr: 'Ujjain ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-UMA',
          nameEn: 'Umaria',
          nameMr: 'Umaria',
          talukas: [
            TalukaInfo(nameEn: 'Umaria City / Central', nameMr: 'Umaria शहर / केंद्र'),
            TalukaInfo(nameEn: 'Umaria Rural / East', nameMr: 'Umaria ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Umaria Rural / West', nameMr: 'Umaria ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MP-VID',
          nameEn: 'Vidisha',
          nameMr: 'Vidisha',
          talukas: [
            TalukaInfo(nameEn: 'Vidisha City / Central', nameMr: 'Vidisha शहर / केंद्र'),
            TalukaInfo(nameEn: 'Vidisha Rural / East', nameMr: 'Vidisha ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Vidisha Rural / West', nameMr: 'Vidisha ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'MN',
      nameEn: 'Manipur',
      nameMr: 'मणिपूर',
      districts: [
        DistrictInfo(
          code: 'MN-BIS',
          nameEn: 'Bishnupur',
          nameMr: 'Bishnupur',
          talukas: [
            TalukaInfo(nameEn: 'Bishnupur City / Central', nameMr: 'Bishnupur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bishnupur Rural / East', nameMr: 'Bishnupur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bishnupur Rural / West', nameMr: 'Bishnupur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MN-CHA',
          nameEn: 'Chandel',
          nameMr: 'Chandel',
          talukas: [
            TalukaInfo(nameEn: 'Chandel City / Central', nameMr: 'Chandel शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chandel Rural / East', nameMr: 'Chandel ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chandel Rural / West', nameMr: 'Chandel ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MN-CHU',
          nameEn: 'Churachandpur',
          nameMr: 'Churachandpur',
          talukas: [
            TalukaInfo(nameEn: 'Churachandpur City / Central', nameMr: 'Churachandpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Churachandpur Rural / East', nameMr: 'Churachandpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Churachandpur Rural / West', nameMr: 'Churachandpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MN-IMP',
          nameEn: 'Imphal East',
          nameMr: 'Imphal East',
          talukas: [
            TalukaInfo(nameEn: 'Imphal East City / Central', nameMr: 'Imphal East शहर / केंद्र'),
            TalukaInfo(nameEn: 'Imphal East Rural / East', nameMr: 'Imphal East ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Imphal East Rural / West', nameMr: 'Imphal East ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MN-IMP',
          nameEn: 'Imphal West',
          nameMr: 'Imphal West',
          talukas: [
            TalukaInfo(nameEn: 'Imphal West City / Central', nameMr: 'Imphal West शहर / केंद्र'),
            TalukaInfo(nameEn: 'Imphal West Rural / East', nameMr: 'Imphal West ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Imphal West Rural / West', nameMr: 'Imphal West ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MN-JIR',
          nameEn: 'Jiribam',
          nameMr: 'Jiribam',
          talukas: [
            TalukaInfo(nameEn: 'Jiribam City / Central', nameMr: 'Jiribam शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jiribam Rural / East', nameMr: 'Jiribam ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jiribam Rural / West', nameMr: 'Jiribam ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MN-KAK',
          nameEn: 'Kakching',
          nameMr: 'Kakching',
          talukas: [
            TalukaInfo(nameEn: 'Kakching City / Central', nameMr: 'Kakching शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kakching Rural / East', nameMr: 'Kakching ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kakching Rural / West', nameMr: 'Kakching ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MN-KAM',
          nameEn: 'Kamjong',
          nameMr: 'Kamjong',
          talukas: [
            TalukaInfo(nameEn: 'Kamjong City / Central', nameMr: 'Kamjong शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kamjong Rural / East', nameMr: 'Kamjong ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kamjong Rural / West', nameMr: 'Kamjong ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MN-KAN',
          nameEn: 'Kangpokpi',
          nameMr: 'Kangpokpi',
          talukas: [
            TalukaInfo(nameEn: 'Kangpokpi City / Central', nameMr: 'Kangpokpi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kangpokpi Rural / East', nameMr: 'Kangpokpi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kangpokpi Rural / West', nameMr: 'Kangpokpi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MN-NON',
          nameEn: 'Noney',
          nameMr: 'Noney',
          talukas: [
            TalukaInfo(nameEn: 'Noney City / Central', nameMr: 'Noney शहर / केंद्र'),
            TalukaInfo(nameEn: 'Noney Rural / East', nameMr: 'Noney ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Noney Rural / West', nameMr: 'Noney ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MN-PHE',
          nameEn: 'Pherzawl',
          nameMr: 'Pherzawl',
          talukas: [
            TalukaInfo(nameEn: 'Pherzawl City / Central', nameMr: 'Pherzawl शहर / केंद्र'),
            TalukaInfo(nameEn: 'Pherzawl Rural / East', nameMr: 'Pherzawl ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Pherzawl Rural / West', nameMr: 'Pherzawl ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MN-SEN',
          nameEn: 'Senapati',
          nameMr: 'Senapati',
          talukas: [
            TalukaInfo(nameEn: 'Senapati City / Central', nameMr: 'Senapati शहर / केंद्र'),
            TalukaInfo(nameEn: 'Senapati Rural / East', nameMr: 'Senapati ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Senapati Rural / West', nameMr: 'Senapati ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MN-TAM',
          nameEn: 'Tamenglong',
          nameMr: 'Tamenglong',
          talukas: [
            TalukaInfo(nameEn: 'Tamenglong City / Central', nameMr: 'Tamenglong शहर / केंद्र'),
            TalukaInfo(nameEn: 'Tamenglong Rural / East', nameMr: 'Tamenglong ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Tamenglong Rural / West', nameMr: 'Tamenglong ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MN-TEN',
          nameEn: 'Tengnoupal',
          nameMr: 'Tengnoupal',
          talukas: [
            TalukaInfo(nameEn: 'Tengnoupal City / Central', nameMr: 'Tengnoupal शहर / केंद्र'),
            TalukaInfo(nameEn: 'Tengnoupal Rural / East', nameMr: 'Tengnoupal ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Tengnoupal Rural / West', nameMr: 'Tengnoupal ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MN-THO',
          nameEn: 'Thoubal',
          nameMr: 'Thoubal',
          talukas: [
            TalukaInfo(nameEn: 'Thoubal City / Central', nameMr: 'Thoubal शहर / केंद्र'),
            TalukaInfo(nameEn: 'Thoubal Rural / East', nameMr: 'Thoubal ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Thoubal Rural / West', nameMr: 'Thoubal ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MN-UKH',
          nameEn: 'Ukhrul',
          nameMr: 'Ukhrul',
          talukas: [
            TalukaInfo(nameEn: 'Ukhrul City / Central', nameMr: 'Ukhrul शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ukhrul Rural / East', nameMr: 'Ukhrul ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ukhrul Rural / West', nameMr: 'Ukhrul ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'ML',
      nameEn: 'Meghalaya',
      nameMr: 'मेघालय',
      districts: [
        DistrictInfo(
          code: 'ML-EAS',
          nameEn: 'East Garo Hills',
          nameMr: 'East Garo Hills',
          talukas: [
            TalukaInfo(nameEn: 'East Garo Hills City / Central', nameMr: 'East Garo Hills शहर / केंद्र'),
            TalukaInfo(nameEn: 'East Garo Hills Rural / East', nameMr: 'East Garo Hills ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'East Garo Hills Rural / West', nameMr: 'East Garo Hills ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'ML-EAS',
          nameEn: 'East Jaintia Hills',
          nameMr: 'East Jaintia Hills',
          talukas: [
            TalukaInfo(nameEn: 'East Jaintia Hills City / Central', nameMr: 'East Jaintia Hills शहर / केंद्र'),
            TalukaInfo(nameEn: 'East Jaintia Hills Rural / East', nameMr: 'East Jaintia Hills ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'East Jaintia Hills Rural / West', nameMr: 'East Jaintia Hills ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'ML-EAS',
          nameEn: 'East Khasi Hills',
          nameMr: 'East Khasi Hills',
          talukas: [
            TalukaInfo(nameEn: 'East Khasi Hills City / Central', nameMr: 'East Khasi Hills शहर / केंद्र'),
            TalukaInfo(nameEn: 'East Khasi Hills Rural / East', nameMr: 'East Khasi Hills ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'East Khasi Hills Rural / West', nameMr: 'East Khasi Hills ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'ML-NOR',
          nameEn: 'North Garo Hills',
          nameMr: 'North Garo Hills',
          talukas: [
            TalukaInfo(nameEn: 'North Garo Hills City / Central', nameMr: 'North Garo Hills शहर / केंद्र'),
            TalukaInfo(nameEn: 'North Garo Hills Rural / East', nameMr: 'North Garo Hills ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'North Garo Hills Rural / West', nameMr: 'North Garo Hills ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'ML-RI ',
          nameEn: 'Ri Bhoi',
          nameMr: 'Ri Bhoi',
          talukas: [
            TalukaInfo(nameEn: 'Ri Bhoi City / Central', nameMr: 'Ri Bhoi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ri Bhoi Rural / East', nameMr: 'Ri Bhoi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ri Bhoi Rural / West', nameMr: 'Ri Bhoi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'ML-SOU',
          nameEn: 'South Garo Hills',
          nameMr: 'South Garo Hills',
          talukas: [
            TalukaInfo(nameEn: 'South Garo Hills City / Central', nameMr: 'South Garo Hills शहर / केंद्र'),
            TalukaInfo(nameEn: 'South Garo Hills Rural / East', nameMr: 'South Garo Hills ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'South Garo Hills Rural / West', nameMr: 'South Garo Hills ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'ML-SOU',
          nameEn: 'South West Garo Hills ',
          nameMr: 'South West Garo Hills ',
          talukas: [
            TalukaInfo(nameEn: 'South West Garo Hills  City / Central', nameMr: 'South West Garo Hills  शहर / केंद्र'),
            TalukaInfo(nameEn: 'South West Garo Hills  Rural / East', nameMr: 'South West Garo Hills  ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'South West Garo Hills  Rural / West', nameMr: 'South West Garo Hills  ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'ML-SOU',
          nameEn: 'South West Khasi Hills',
          nameMr: 'South West Khasi Hills',
          talukas: [
            TalukaInfo(nameEn: 'South West Khasi Hills City / Central', nameMr: 'South West Khasi Hills शहर / केंद्र'),
            TalukaInfo(nameEn: 'South West Khasi Hills Rural / East', nameMr: 'South West Khasi Hills ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'South West Khasi Hills Rural / West', nameMr: 'South West Khasi Hills ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'ML-WES',
          nameEn: 'West Garo Hills',
          nameMr: 'West Garo Hills',
          talukas: [
            TalukaInfo(nameEn: 'West Garo Hills City / Central', nameMr: 'West Garo Hills शहर / केंद्र'),
            TalukaInfo(nameEn: 'West Garo Hills Rural / East', nameMr: 'West Garo Hills ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'West Garo Hills Rural / West', nameMr: 'West Garo Hills ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'ML-WES',
          nameEn: 'West Jaintia Hills',
          nameMr: 'West Jaintia Hills',
          talukas: [
            TalukaInfo(nameEn: 'West Jaintia Hills City / Central', nameMr: 'West Jaintia Hills शहर / केंद्र'),
            TalukaInfo(nameEn: 'West Jaintia Hills Rural / East', nameMr: 'West Jaintia Hills ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'West Jaintia Hills Rural / West', nameMr: 'West Jaintia Hills ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'ML-WES',
          nameEn: 'West Khasi Hills',
          nameMr: 'West Khasi Hills',
          talukas: [
            TalukaInfo(nameEn: 'West Khasi Hills City / Central', nameMr: 'West Khasi Hills शहर / केंद्र'),
            TalukaInfo(nameEn: 'West Khasi Hills Rural / East', nameMr: 'West Khasi Hills ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'West Khasi Hills Rural / West', nameMr: 'West Khasi Hills ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'MZ',
      nameEn: 'Mizoram',
      nameMr: 'मिझोरम',
      districts: [
        DistrictInfo(
          code: 'MZ-AIZ',
          nameEn: 'Aizawl',
          nameMr: 'Aizawl',
          talukas: [
            TalukaInfo(nameEn: 'Aizawl City / Central', nameMr: 'Aizawl शहर / केंद्र'),
            TalukaInfo(nameEn: 'Aizawl Rural / East', nameMr: 'Aizawl ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Aizawl Rural / West', nameMr: 'Aizawl ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MZ-CHA',
          nameEn: 'Champhai',
          nameMr: 'Champhai',
          talukas: [
            TalukaInfo(nameEn: 'Champhai City / Central', nameMr: 'Champhai शहर / केंद्र'),
            TalukaInfo(nameEn: 'Champhai Rural / East', nameMr: 'Champhai ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Champhai Rural / West', nameMr: 'Champhai ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MZ-KOL',
          nameEn: 'Kolasib',
          nameMr: 'Kolasib',
          talukas: [
            TalukaInfo(nameEn: 'Kolasib City / Central', nameMr: 'Kolasib शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kolasib Rural / East', nameMr: 'Kolasib ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kolasib Rural / West', nameMr: 'Kolasib ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MZ-LAW',
          nameEn: 'Lawngtlai',
          nameMr: 'Lawngtlai',
          talukas: [
            TalukaInfo(nameEn: 'Lawngtlai City / Central', nameMr: 'Lawngtlai शहर / केंद्र'),
            TalukaInfo(nameEn: 'Lawngtlai Rural / East', nameMr: 'Lawngtlai ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Lawngtlai Rural / West', nameMr: 'Lawngtlai ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MZ-LUN',
          nameEn: 'Lunglei',
          nameMr: 'Lunglei',
          talukas: [
            TalukaInfo(nameEn: 'Lunglei City / Central', nameMr: 'Lunglei शहर / केंद्र'),
            TalukaInfo(nameEn: 'Lunglei Rural / East', nameMr: 'Lunglei ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Lunglei Rural / West', nameMr: 'Lunglei ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MZ-MAM',
          nameEn: 'Mamit',
          nameMr: 'Mamit',
          talukas: [
            TalukaInfo(nameEn: 'Mamit City / Central', nameMr: 'Mamit शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mamit Rural / East', nameMr: 'Mamit ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mamit Rural / West', nameMr: 'Mamit ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MZ-SAI',
          nameEn: 'Saiha',
          nameMr: 'Saiha',
          talukas: [
            TalukaInfo(nameEn: 'Saiha City / Central', nameMr: 'Saiha शहर / केंद्र'),
            TalukaInfo(nameEn: 'Saiha Rural / East', nameMr: 'Saiha ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Saiha Rural / West', nameMr: 'Saiha ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'MZ-SER',
          nameEn: 'Serchhip',
          nameMr: 'Serchhip',
          talukas: [
            TalukaInfo(nameEn: 'Serchhip City / Central', nameMr: 'Serchhip शहर / केंद्र'),
            TalukaInfo(nameEn: 'Serchhip Rural / East', nameMr: 'Serchhip ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Serchhip Rural / West', nameMr: 'Serchhip ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'NL',
      nameEn: 'Nagaland',
      nameMr: 'नागालँड',
      districts: [
        DistrictInfo(
          code: 'NL-DIM',
          nameEn: 'Dimapur',
          nameMr: 'Dimapur',
          talukas: [
            TalukaInfo(nameEn: 'Dimapur City / Central', nameMr: 'Dimapur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dimapur Rural / East', nameMr: 'Dimapur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dimapur Rural / West', nameMr: 'Dimapur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'NL-KIP',
          nameEn: 'Kiphire',
          nameMr: 'Kiphire',
          talukas: [
            TalukaInfo(nameEn: 'Kiphire City / Central', nameMr: 'Kiphire शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kiphire Rural / East', nameMr: 'Kiphire ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kiphire Rural / West', nameMr: 'Kiphire ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'NL-KOH',
          nameEn: 'Kohima',
          nameMr: 'Kohima',
          talukas: [
            TalukaInfo(nameEn: 'Kohima City / Central', nameMr: 'Kohima शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kohima Rural / East', nameMr: 'Kohima ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kohima Rural / West', nameMr: 'Kohima ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'NL-LON',
          nameEn: 'Longleng',
          nameMr: 'Longleng',
          talukas: [
            TalukaInfo(nameEn: 'Longleng City / Central', nameMr: 'Longleng शहर / केंद्र'),
            TalukaInfo(nameEn: 'Longleng Rural / East', nameMr: 'Longleng ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Longleng Rural / West', nameMr: 'Longleng ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'NL-MOK',
          nameEn: 'Mokokchung',
          nameMr: 'Mokokchung',
          talukas: [
            TalukaInfo(nameEn: 'Mokokchung City / Central', nameMr: 'Mokokchung शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mokokchung Rural / East', nameMr: 'Mokokchung ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mokokchung Rural / West', nameMr: 'Mokokchung ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'NL-MON',
          nameEn: 'Mon',
          nameMr: 'Mon',
          talukas: [
            TalukaInfo(nameEn: 'Mon City / Central', nameMr: 'Mon शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mon Rural / East', nameMr: 'Mon ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mon Rural / West', nameMr: 'Mon ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'NL-PER',
          nameEn: 'Peren',
          nameMr: 'Peren',
          talukas: [
            TalukaInfo(nameEn: 'Peren City / Central', nameMr: 'Peren शहर / केंद्र'),
            TalukaInfo(nameEn: 'Peren Rural / East', nameMr: 'Peren ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Peren Rural / West', nameMr: 'Peren ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'NL-PHE',
          nameEn: 'Phek',
          nameMr: 'Phek',
          talukas: [
            TalukaInfo(nameEn: 'Phek City / Central', nameMr: 'Phek शहर / केंद्र'),
            TalukaInfo(nameEn: 'Phek Rural / East', nameMr: 'Phek ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Phek Rural / West', nameMr: 'Phek ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'NL-TUE',
          nameEn: 'Tuensang',
          nameMr: 'Tuensang',
          talukas: [
            TalukaInfo(nameEn: 'Tuensang City / Central', nameMr: 'Tuensang शहर / केंद्र'),
            TalukaInfo(nameEn: 'Tuensang Rural / East', nameMr: 'Tuensang ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Tuensang Rural / West', nameMr: 'Tuensang ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'NL-WOK',
          nameEn: 'Wokha',
          nameMr: 'Wokha',
          talukas: [
            TalukaInfo(nameEn: 'Wokha City / Central', nameMr: 'Wokha शहर / केंद्र'),
            TalukaInfo(nameEn: 'Wokha Rural / East', nameMr: 'Wokha ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Wokha Rural / West', nameMr: 'Wokha ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'NL-ZUN',
          nameEn: 'Zunheboto',
          nameMr: 'Zunheboto',
          talukas: [
            TalukaInfo(nameEn: 'Zunheboto City / Central', nameMr: 'Zunheboto शहर / केंद्र'),
            TalukaInfo(nameEn: 'Zunheboto Rural / East', nameMr: 'Zunheboto ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Zunheboto Rural / West', nameMr: 'Zunheboto ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'OD',
      nameEn: 'Odisha',
      nameMr: 'ओडिशा',
      districts: [
        DistrictInfo(
          code: 'OD-ANG',
          nameEn: 'Angul',
          nameMr: 'Angul',
          talukas: [
            TalukaInfo(nameEn: 'Angul City / Central', nameMr: 'Angul शहर / केंद्र'),
            TalukaInfo(nameEn: 'Angul Rural / East', nameMr: 'Angul ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Angul Rural / West', nameMr: 'Angul ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-BAL',
          nameEn: 'Balangir',
          nameMr: 'Balangir',
          talukas: [
            TalukaInfo(nameEn: 'Balangir City / Central', nameMr: 'Balangir शहर / केंद्र'),
            TalukaInfo(nameEn: 'Balangir Rural / East', nameMr: 'Balangir ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Balangir Rural / West', nameMr: 'Balangir ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-BAL',
          nameEn: 'Balasore',
          nameMr: 'Balasore',
          talukas: [
            TalukaInfo(nameEn: 'Balasore City / Central', nameMr: 'Balasore शहर / केंद्र'),
            TalukaInfo(nameEn: 'Balasore Rural / East', nameMr: 'Balasore ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Balasore Rural / West', nameMr: 'Balasore ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-BAR',
          nameEn: 'Bargarh',
          nameMr: 'Bargarh',
          talukas: [
            TalukaInfo(nameEn: 'Bargarh City / Central', nameMr: 'Bargarh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bargarh Rural / East', nameMr: 'Bargarh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bargarh Rural / West', nameMr: 'Bargarh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-BHA',
          nameEn: 'Bhadrak',
          nameMr: 'Bhadrak',
          talukas: [
            TalukaInfo(nameEn: 'Bhadrak City / Central', nameMr: 'Bhadrak शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bhadrak Rural / East', nameMr: 'Bhadrak ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bhadrak Rural / West', nameMr: 'Bhadrak ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-BOU',
          nameEn: 'Boudh',
          nameMr: 'Boudh',
          talukas: [
            TalukaInfo(nameEn: 'Boudh City / Central', nameMr: 'Boudh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Boudh Rural / East', nameMr: 'Boudh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Boudh Rural / West', nameMr: 'Boudh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-CUT',
          nameEn: 'Cuttack',
          nameMr: 'Cuttack',
          talukas: [
            TalukaInfo(nameEn: 'Cuttack City / Central', nameMr: 'Cuttack शहर / केंद्र'),
            TalukaInfo(nameEn: 'Cuttack Rural / East', nameMr: 'Cuttack ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Cuttack Rural / West', nameMr: 'Cuttack ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-DEO',
          nameEn: 'Deogarh',
          nameMr: 'Deogarh',
          talukas: [
            TalukaInfo(nameEn: 'Deogarh City / Central', nameMr: 'Deogarh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Deogarh Rural / East', nameMr: 'Deogarh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Deogarh Rural / West', nameMr: 'Deogarh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-DHE',
          nameEn: 'Dhenkanal',
          nameMr: 'Dhenkanal',
          talukas: [
            TalukaInfo(nameEn: 'Dhenkanal City / Central', nameMr: 'Dhenkanal शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dhenkanal Rural / East', nameMr: 'Dhenkanal ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dhenkanal Rural / West', nameMr: 'Dhenkanal ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-GAJ',
          nameEn: 'Gajapati',
          nameMr: 'Gajapati',
          talukas: [
            TalukaInfo(nameEn: 'Gajapati City / Central', nameMr: 'Gajapati शहर / केंद्र'),
            TalukaInfo(nameEn: 'Gajapati Rural / East', nameMr: 'Gajapati ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Gajapati Rural / West', nameMr: 'Gajapati ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-GAN',
          nameEn: 'Ganjam',
          nameMr: 'Ganjam',
          talukas: [
            TalukaInfo(nameEn: 'Ganjam City / Central', nameMr: 'Ganjam शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ganjam Rural / East', nameMr: 'Ganjam ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ganjam Rural / West', nameMr: 'Ganjam ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-JAG',
          nameEn: 'Jagatsinghapur',
          nameMr: 'Jagatsinghapur',
          talukas: [
            TalukaInfo(nameEn: 'Jagatsinghapur City / Central', nameMr: 'Jagatsinghapur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jagatsinghapur Rural / East', nameMr: 'Jagatsinghapur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jagatsinghapur Rural / West', nameMr: 'Jagatsinghapur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-JAJ',
          nameEn: 'Jajpur',
          nameMr: 'Jajpur',
          talukas: [
            TalukaInfo(nameEn: 'Jajpur City / Central', nameMr: 'Jajpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jajpur Rural / East', nameMr: 'Jajpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jajpur Rural / West', nameMr: 'Jajpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-JHA',
          nameEn: 'Jharsuguda',
          nameMr: 'Jharsuguda',
          talukas: [
            TalukaInfo(nameEn: 'Jharsuguda City / Central', nameMr: 'Jharsuguda शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jharsuguda Rural / East', nameMr: 'Jharsuguda ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jharsuguda Rural / West', nameMr: 'Jharsuguda ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-KAL',
          nameEn: 'Kalahandi',
          nameMr: 'Kalahandi',
          talukas: [
            TalukaInfo(nameEn: 'Kalahandi City / Central', nameMr: 'Kalahandi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kalahandi Rural / East', nameMr: 'Kalahandi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kalahandi Rural / West', nameMr: 'Kalahandi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-KAN',
          nameEn: 'Kandhamal',
          nameMr: 'Kandhamal',
          talukas: [
            TalukaInfo(nameEn: 'Kandhamal City / Central', nameMr: 'Kandhamal शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kandhamal Rural / East', nameMr: 'Kandhamal ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kandhamal Rural / West', nameMr: 'Kandhamal ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-KEN',
          nameEn: 'Kendrapara',
          nameMr: 'Kendrapara',
          talukas: [
            TalukaInfo(nameEn: 'Kendrapara City / Central', nameMr: 'Kendrapara शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kendrapara Rural / East', nameMr: 'Kendrapara ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kendrapara Rural / West', nameMr: 'Kendrapara ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-KEN',
          nameEn: 'Kendujhar (Keonjhar)',
          nameMr: 'Kendujhar (Keonjhar)',
          talukas: [
            TalukaInfo(nameEn: 'Kendujhar (Keonjhar) City / Central', nameMr: 'Kendujhar (Keonjhar) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kendujhar (Keonjhar) Rural / East', nameMr: 'Kendujhar (Keonjhar) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kendujhar (Keonjhar) Rural / West', nameMr: 'Kendujhar (Keonjhar) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-KHO',
          nameEn: 'Khordha',
          nameMr: 'Khordha',
          talukas: [
            TalukaInfo(nameEn: 'Khordha City / Central', nameMr: 'Khordha शहर / केंद्र'),
            TalukaInfo(nameEn: 'Khordha Rural / East', nameMr: 'Khordha ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Khordha Rural / West', nameMr: 'Khordha ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-KOR',
          nameEn: 'Koraput',
          nameMr: 'Koraput',
          talukas: [
            TalukaInfo(nameEn: 'Koraput City / Central', nameMr: 'Koraput शहर / केंद्र'),
            TalukaInfo(nameEn: 'Koraput Rural / East', nameMr: 'Koraput ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Koraput Rural / West', nameMr: 'Koraput ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-MAL',
          nameEn: 'Malkangiri',
          nameMr: 'Malkangiri',
          talukas: [
            TalukaInfo(nameEn: 'Malkangiri City / Central', nameMr: 'Malkangiri शहर / केंद्र'),
            TalukaInfo(nameEn: 'Malkangiri Rural / East', nameMr: 'Malkangiri ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Malkangiri Rural / West', nameMr: 'Malkangiri ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-MAY',
          nameEn: 'Mayurbhanj',
          nameMr: 'Mayurbhanj',
          talukas: [
            TalukaInfo(nameEn: 'Mayurbhanj City / Central', nameMr: 'Mayurbhanj शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mayurbhanj Rural / East', nameMr: 'Mayurbhanj ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mayurbhanj Rural / West', nameMr: 'Mayurbhanj ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-NAB',
          nameEn: 'Nabarangpur',
          nameMr: 'Nabarangpur',
          talukas: [
            TalukaInfo(nameEn: 'Nabarangpur City / Central', nameMr: 'Nabarangpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Nabarangpur Rural / East', nameMr: 'Nabarangpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Nabarangpur Rural / West', nameMr: 'Nabarangpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-NAY',
          nameEn: 'Nayagarh',
          nameMr: 'Nayagarh',
          talukas: [
            TalukaInfo(nameEn: 'Nayagarh City / Central', nameMr: 'Nayagarh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Nayagarh Rural / East', nameMr: 'Nayagarh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Nayagarh Rural / West', nameMr: 'Nayagarh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-NUA',
          nameEn: 'Nuapada',
          nameMr: 'Nuapada',
          talukas: [
            TalukaInfo(nameEn: 'Nuapada City / Central', nameMr: 'Nuapada शहर / केंद्र'),
            TalukaInfo(nameEn: 'Nuapada Rural / East', nameMr: 'Nuapada ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Nuapada Rural / West', nameMr: 'Nuapada ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-PUR',
          nameEn: 'Puri',
          nameMr: 'Puri',
          talukas: [
            TalukaInfo(nameEn: 'Puri City / Central', nameMr: 'Puri शहर / केंद्र'),
            TalukaInfo(nameEn: 'Puri Rural / East', nameMr: 'Puri ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Puri Rural / West', nameMr: 'Puri ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-RAY',
          nameEn: 'Rayagada',
          nameMr: 'Rayagada',
          talukas: [
            TalukaInfo(nameEn: 'Rayagada City / Central', nameMr: 'Rayagada शहर / केंद्र'),
            TalukaInfo(nameEn: 'Rayagada Rural / East', nameMr: 'Rayagada ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Rayagada Rural / West', nameMr: 'Rayagada ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-SAM',
          nameEn: 'Sambalpur',
          nameMr: 'Sambalpur',
          talukas: [
            TalukaInfo(nameEn: 'Sambalpur City / Central', nameMr: 'Sambalpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sambalpur Rural / East', nameMr: 'Sambalpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sambalpur Rural / West', nameMr: 'Sambalpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-SON',
          nameEn: 'Sonepur',
          nameMr: 'Sonepur',
          talukas: [
            TalukaInfo(nameEn: 'Sonepur City / Central', nameMr: 'Sonepur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sonepur Rural / East', nameMr: 'Sonepur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sonepur Rural / West', nameMr: 'Sonepur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'OD-SUN',
          nameEn: 'Sundargarh',
          nameMr: 'Sundargarh',
          talukas: [
            TalukaInfo(nameEn: 'Sundargarh City / Central', nameMr: 'Sundargarh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sundargarh Rural / East', nameMr: 'Sundargarh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sundargarh Rural / West', nameMr: 'Sundargarh ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'PY',
      nameEn: 'Puducherry (UT)',
      nameMr: 'पुडुचेरी',
      districts: [
        DistrictInfo(
          code: 'PY-KAR',
          nameEn: 'Karaikal',
          nameMr: 'Karaikal',
          talukas: [
            TalukaInfo(nameEn: 'Karaikal City / Central', nameMr: 'Karaikal शहर / केंद्र'),
            TalukaInfo(nameEn: 'Karaikal Rural / East', nameMr: 'Karaikal ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Karaikal Rural / West', nameMr: 'Karaikal ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PY-MAH',
          nameEn: 'Mahe',
          nameMr: 'Mahe',
          talukas: [
            TalukaInfo(nameEn: 'Mahe City / Central', nameMr: 'Mahe शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mahe Rural / East', nameMr: 'Mahe ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mahe Rural / West', nameMr: 'Mahe ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PY-PON',
          nameEn: 'Pondicherry',
          nameMr: 'Pondicherry',
          talukas: [
            TalukaInfo(nameEn: 'Pondicherry City / Central', nameMr: 'Pondicherry शहर / केंद्र'),
            TalukaInfo(nameEn: 'Pondicherry Rural / East', nameMr: 'Pondicherry ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Pondicherry Rural / West', nameMr: 'Pondicherry ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PY-YAN',
          nameEn: 'Yanam',
          nameMr: 'Yanam',
          talukas: [
            TalukaInfo(nameEn: 'Yanam City / Central', nameMr: 'Yanam शहर / केंद्र'),
            TalukaInfo(nameEn: 'Yanam Rural / East', nameMr: 'Yanam ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Yanam Rural / West', nameMr: 'Yanam ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'PB',
      nameEn: 'Punjab',
      nameMr: 'पंजाब',
      districts: [
        DistrictInfo(
          code: 'PB-AMR',
          nameEn: 'Amritsar',
          nameMr: 'Amritsar',
          talukas: [
            TalukaInfo(nameEn: 'Amritsar City / Central', nameMr: 'Amritsar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Amritsar Rural / East', nameMr: 'Amritsar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Amritsar Rural / West', nameMr: 'Amritsar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-BAR',
          nameEn: 'Barnala',
          nameMr: 'Barnala',
          talukas: [
            TalukaInfo(nameEn: 'Barnala City / Central', nameMr: 'Barnala शहर / केंद्र'),
            TalukaInfo(nameEn: 'Barnala Rural / East', nameMr: 'Barnala ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Barnala Rural / West', nameMr: 'Barnala ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-BAT',
          nameEn: 'Bathinda',
          nameMr: 'Bathinda',
          talukas: [
            TalukaInfo(nameEn: 'Bathinda City / Central', nameMr: 'Bathinda शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bathinda Rural / East', nameMr: 'Bathinda ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bathinda Rural / West', nameMr: 'Bathinda ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-FAR',
          nameEn: 'Faridkot',
          nameMr: 'Faridkot',
          talukas: [
            TalukaInfo(nameEn: 'Faridkot City / Central', nameMr: 'Faridkot शहर / केंद्र'),
            TalukaInfo(nameEn: 'Faridkot Rural / East', nameMr: 'Faridkot ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Faridkot Rural / West', nameMr: 'Faridkot ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-FAT',
          nameEn: 'Fatehgarh Sahib',
          nameMr: 'Fatehgarh Sahib',
          talukas: [
            TalukaInfo(nameEn: 'Fatehgarh Sahib City / Central', nameMr: 'Fatehgarh Sahib शहर / केंद्र'),
            TalukaInfo(nameEn: 'Fatehgarh Sahib Rural / East', nameMr: 'Fatehgarh Sahib ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Fatehgarh Sahib Rural / West', nameMr: 'Fatehgarh Sahib ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-FAZ',
          nameEn: 'Fazilka',
          nameMr: 'Fazilka',
          talukas: [
            TalukaInfo(nameEn: 'Fazilka City / Central', nameMr: 'Fazilka शहर / केंद्र'),
            TalukaInfo(nameEn: 'Fazilka Rural / East', nameMr: 'Fazilka ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Fazilka Rural / West', nameMr: 'Fazilka ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-FER',
          nameEn: 'Ferozepur',
          nameMr: 'Ferozepur',
          talukas: [
            TalukaInfo(nameEn: 'Ferozepur City / Central', nameMr: 'Ferozepur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ferozepur Rural / East', nameMr: 'Ferozepur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ferozepur Rural / West', nameMr: 'Ferozepur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-GUR',
          nameEn: 'Gurdaspur',
          nameMr: 'Gurdaspur',
          talukas: [
            TalukaInfo(nameEn: 'Gurdaspur City / Central', nameMr: 'Gurdaspur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Gurdaspur Rural / East', nameMr: 'Gurdaspur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Gurdaspur Rural / West', nameMr: 'Gurdaspur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-HOS',
          nameEn: 'Hoshiarpur',
          nameMr: 'Hoshiarpur',
          talukas: [
            TalukaInfo(nameEn: 'Hoshiarpur City / Central', nameMr: 'Hoshiarpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Hoshiarpur Rural / East', nameMr: 'Hoshiarpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Hoshiarpur Rural / West', nameMr: 'Hoshiarpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-JAL',
          nameEn: 'Jalandhar',
          nameMr: 'Jalandhar',
          talukas: [
            TalukaInfo(nameEn: 'Jalandhar City / Central', nameMr: 'Jalandhar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jalandhar Rural / East', nameMr: 'Jalandhar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jalandhar Rural / West', nameMr: 'Jalandhar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-KAP',
          nameEn: 'Kapurthala',
          nameMr: 'Kapurthala',
          talukas: [
            TalukaInfo(nameEn: 'Kapurthala City / Central', nameMr: 'Kapurthala शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kapurthala Rural / East', nameMr: 'Kapurthala ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kapurthala Rural / West', nameMr: 'Kapurthala ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-LUD',
          nameEn: 'Ludhiana',
          nameMr: 'Ludhiana',
          talukas: [
            TalukaInfo(nameEn: 'Ludhiana City / Central', nameMr: 'Ludhiana शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ludhiana Rural / East', nameMr: 'Ludhiana ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ludhiana Rural / West', nameMr: 'Ludhiana ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-MAN',
          nameEn: 'Mansa',
          nameMr: 'Mansa',
          talukas: [
            TalukaInfo(nameEn: 'Mansa City / Central', nameMr: 'Mansa शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mansa Rural / East', nameMr: 'Mansa ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mansa Rural / West', nameMr: 'Mansa ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-MOG',
          nameEn: 'Moga',
          nameMr: 'Moga',
          talukas: [
            TalukaInfo(nameEn: 'Moga City / Central', nameMr: 'Moga शहर / केंद्र'),
            TalukaInfo(nameEn: 'Moga Rural / East', nameMr: 'Moga ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Moga Rural / West', nameMr: 'Moga ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-MUK',
          nameEn: 'Muktsar',
          nameMr: 'Muktsar',
          talukas: [
            TalukaInfo(nameEn: 'Muktsar City / Central', nameMr: 'Muktsar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Muktsar Rural / East', nameMr: 'Muktsar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Muktsar Rural / West', nameMr: 'Muktsar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-NAW',
          nameEn: 'Nawanshahr (Shahid Bhagat Singh Nagar)',
          nameMr: 'Nawanshahr (Shahid Bhagat Singh Nagar)',
          talukas: [
            TalukaInfo(nameEn: 'Nawanshahr (Shahid Bhagat Singh Nagar) City / Central', nameMr: 'Nawanshahr (Shahid Bhagat Singh Nagar) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Nawanshahr (Shahid Bhagat Singh Nagar) Rural / East', nameMr: 'Nawanshahr (Shahid Bhagat Singh Nagar) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Nawanshahr (Shahid Bhagat Singh Nagar) Rural / West', nameMr: 'Nawanshahr (Shahid Bhagat Singh Nagar) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-PAT',
          nameEn: 'Pathankot',
          nameMr: 'Pathankot',
          talukas: [
            TalukaInfo(nameEn: 'Pathankot City / Central', nameMr: 'Pathankot शहर / केंद्र'),
            TalukaInfo(nameEn: 'Pathankot Rural / East', nameMr: 'Pathankot ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Pathankot Rural / West', nameMr: 'Pathankot ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-PAT',
          nameEn: 'Patiala',
          nameMr: 'Patiala',
          talukas: [
            TalukaInfo(nameEn: 'Patiala City / Central', nameMr: 'Patiala शहर / केंद्र'),
            TalukaInfo(nameEn: 'Patiala Rural / East', nameMr: 'Patiala ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Patiala Rural / West', nameMr: 'Patiala ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-RUP',
          nameEn: 'Rupnagar',
          nameMr: 'Rupnagar',
          talukas: [
            TalukaInfo(nameEn: 'Rupnagar City / Central', nameMr: 'Rupnagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Rupnagar Rural / East', nameMr: 'Rupnagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Rupnagar Rural / West', nameMr: 'Rupnagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-SAH',
          nameEn: 'Sahibzada Ajit Singh Nagar (Mohali)',
          nameMr: 'Sahibzada Ajit Singh Nagar (Mohali)',
          talukas: [
            TalukaInfo(nameEn: 'Sahibzada Ajit Singh Nagar (Mohali) City / Central', nameMr: 'Sahibzada Ajit Singh Nagar (Mohali) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sahibzada Ajit Singh Nagar (Mohali) Rural / East', nameMr: 'Sahibzada Ajit Singh Nagar (Mohali) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sahibzada Ajit Singh Nagar (Mohali) Rural / West', nameMr: 'Sahibzada Ajit Singh Nagar (Mohali) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-SAN',
          nameEn: 'Sangrur',
          nameMr: 'Sangrur',
          talukas: [
            TalukaInfo(nameEn: 'Sangrur City / Central', nameMr: 'Sangrur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sangrur Rural / East', nameMr: 'Sangrur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sangrur Rural / West', nameMr: 'Sangrur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'PB-TAR',
          nameEn: 'Tarn Taran',
          nameMr: 'Tarn Taran',
          talukas: [
            TalukaInfo(nameEn: 'Tarn Taran City / Central', nameMr: 'Tarn Taran शहर / केंद्र'),
            TalukaInfo(nameEn: 'Tarn Taran Rural / East', nameMr: 'Tarn Taran ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Tarn Taran Rural / West', nameMr: 'Tarn Taran ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'RJ',
      nameEn: 'Rajasthan',
      nameMr: 'राजस्थान',
      districts: [
        DistrictInfo(
          code: 'RJ-AJM',
          nameEn: 'Ajmer',
          nameMr: 'Ajmer',
          talukas: [
            TalukaInfo(nameEn: 'Ajmer City / Central', nameMr: 'Ajmer शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ajmer Rural / East', nameMr: 'Ajmer ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ajmer Rural / West', nameMr: 'Ajmer ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-ALW',
          nameEn: 'Alwar',
          nameMr: 'Alwar',
          talukas: [
            TalukaInfo(nameEn: 'Alwar City / Central', nameMr: 'Alwar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Alwar Rural / East', nameMr: 'Alwar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Alwar Rural / West', nameMr: 'Alwar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-BAN',
          nameEn: 'Banswara',
          nameMr: 'Banswara',
          talukas: [
            TalukaInfo(nameEn: 'Banswara City / Central', nameMr: 'Banswara शहर / केंद्र'),
            TalukaInfo(nameEn: 'Banswara Rural / East', nameMr: 'Banswara ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Banswara Rural / West', nameMr: 'Banswara ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-BAR',
          nameEn: 'Baran',
          nameMr: 'Baran',
          talukas: [
            TalukaInfo(nameEn: 'Baran City / Central', nameMr: 'Baran शहर / केंद्र'),
            TalukaInfo(nameEn: 'Baran Rural / East', nameMr: 'Baran ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Baran Rural / West', nameMr: 'Baran ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-BAR',
          nameEn: 'Barmer',
          nameMr: 'Barmer',
          talukas: [
            TalukaInfo(nameEn: 'Barmer City / Central', nameMr: 'Barmer शहर / केंद्र'),
            TalukaInfo(nameEn: 'Barmer Rural / East', nameMr: 'Barmer ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Barmer Rural / West', nameMr: 'Barmer ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-BHA',
          nameEn: 'Bharatpur',
          nameMr: 'Bharatpur',
          talukas: [
            TalukaInfo(nameEn: 'Bharatpur City / Central', nameMr: 'Bharatpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bharatpur Rural / East', nameMr: 'Bharatpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bharatpur Rural / West', nameMr: 'Bharatpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-BHI',
          nameEn: 'Bhilwara',
          nameMr: 'Bhilwara',
          talukas: [
            TalukaInfo(nameEn: 'Bhilwara City / Central', nameMr: 'Bhilwara शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bhilwara Rural / East', nameMr: 'Bhilwara ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bhilwara Rural / West', nameMr: 'Bhilwara ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-BIK',
          nameEn: 'Bikaner',
          nameMr: 'Bikaner',
          talukas: [
            TalukaInfo(nameEn: 'Bikaner City / Central', nameMr: 'Bikaner शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bikaner Rural / East', nameMr: 'Bikaner ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bikaner Rural / West', nameMr: 'Bikaner ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-BUN',
          nameEn: 'Bundi',
          nameMr: 'Bundi',
          talukas: [
            TalukaInfo(nameEn: 'Bundi City / Central', nameMr: 'Bundi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bundi Rural / East', nameMr: 'Bundi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bundi Rural / West', nameMr: 'Bundi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-CHI',
          nameEn: 'Chittorgarh',
          nameMr: 'Chittorgarh',
          talukas: [
            TalukaInfo(nameEn: 'Chittorgarh City / Central', nameMr: 'Chittorgarh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chittorgarh Rural / East', nameMr: 'Chittorgarh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chittorgarh Rural / West', nameMr: 'Chittorgarh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-CHU',
          nameEn: 'Churu',
          nameMr: 'Churu',
          talukas: [
            TalukaInfo(nameEn: 'Churu City / Central', nameMr: 'Churu शहर / केंद्र'),
            TalukaInfo(nameEn: 'Churu Rural / East', nameMr: 'Churu ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Churu Rural / West', nameMr: 'Churu ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-DAU',
          nameEn: 'Dausa',
          nameMr: 'Dausa',
          talukas: [
            TalukaInfo(nameEn: 'Dausa City / Central', nameMr: 'Dausa शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dausa Rural / East', nameMr: 'Dausa ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dausa Rural / West', nameMr: 'Dausa ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-DHO',
          nameEn: 'Dholpur',
          nameMr: 'Dholpur',
          talukas: [
            TalukaInfo(nameEn: 'Dholpur City / Central', nameMr: 'Dholpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dholpur Rural / East', nameMr: 'Dholpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dholpur Rural / West', nameMr: 'Dholpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-DUN',
          nameEn: 'Dungarpur',
          nameMr: 'Dungarpur',
          talukas: [
            TalukaInfo(nameEn: 'Dungarpur City / Central', nameMr: 'Dungarpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dungarpur Rural / East', nameMr: 'Dungarpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dungarpur Rural / West', nameMr: 'Dungarpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-HAN',
          nameEn: 'Hanumangarh',
          nameMr: 'Hanumangarh',
          talukas: [
            TalukaInfo(nameEn: 'Hanumangarh City / Central', nameMr: 'Hanumangarh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Hanumangarh Rural / East', nameMr: 'Hanumangarh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Hanumangarh Rural / West', nameMr: 'Hanumangarh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-JAI',
          nameEn: 'Jaipur',
          nameMr: 'Jaipur',
          talukas: [
            TalukaInfo(nameEn: 'Jaipur City / Central', nameMr: 'Jaipur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jaipur Rural / East', nameMr: 'Jaipur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jaipur Rural / West', nameMr: 'Jaipur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-JAI',
          nameEn: 'Jaisalmer',
          nameMr: 'Jaisalmer',
          talukas: [
            TalukaInfo(nameEn: 'Jaisalmer City / Central', nameMr: 'Jaisalmer शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jaisalmer Rural / East', nameMr: 'Jaisalmer ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jaisalmer Rural / West', nameMr: 'Jaisalmer ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-JAL',
          nameEn: 'Jalore',
          nameMr: 'Jalore',
          talukas: [
            TalukaInfo(nameEn: 'Jalore City / Central', nameMr: 'Jalore शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jalore Rural / East', nameMr: 'Jalore ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jalore Rural / West', nameMr: 'Jalore ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-JHA',
          nameEn: 'Jhalawar',
          nameMr: 'Jhalawar',
          talukas: [
            TalukaInfo(nameEn: 'Jhalawar City / Central', nameMr: 'Jhalawar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jhalawar Rural / East', nameMr: 'Jhalawar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jhalawar Rural / West', nameMr: 'Jhalawar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-JHU',
          nameEn: 'Jhunjhunu',
          nameMr: 'Jhunjhunu',
          talukas: [
            TalukaInfo(nameEn: 'Jhunjhunu City / Central', nameMr: 'Jhunjhunu शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jhunjhunu Rural / East', nameMr: 'Jhunjhunu ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jhunjhunu Rural / West', nameMr: 'Jhunjhunu ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-JOD',
          nameEn: 'Jodhpur',
          nameMr: 'Jodhpur',
          talukas: [
            TalukaInfo(nameEn: 'Jodhpur City / Central', nameMr: 'Jodhpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jodhpur Rural / East', nameMr: 'Jodhpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jodhpur Rural / West', nameMr: 'Jodhpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-KAR',
          nameEn: 'Karauli',
          nameMr: 'Karauli',
          talukas: [
            TalukaInfo(nameEn: 'Karauli City / Central', nameMr: 'Karauli शहर / केंद्र'),
            TalukaInfo(nameEn: 'Karauli Rural / East', nameMr: 'Karauli ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Karauli Rural / West', nameMr: 'Karauli ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-KOT',
          nameEn: 'Kota',
          nameMr: 'Kota',
          talukas: [
            TalukaInfo(nameEn: 'Kota City / Central', nameMr: 'Kota शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kota Rural / East', nameMr: 'Kota ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kota Rural / West', nameMr: 'Kota ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-NAG',
          nameEn: 'Nagaur',
          nameMr: 'Nagaur',
          talukas: [
            TalukaInfo(nameEn: 'Nagaur City / Central', nameMr: 'Nagaur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Nagaur Rural / East', nameMr: 'Nagaur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Nagaur Rural / West', nameMr: 'Nagaur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-PAL',
          nameEn: 'Pali',
          nameMr: 'Pali',
          talukas: [
            TalukaInfo(nameEn: 'Pali City / Central', nameMr: 'Pali शहर / केंद्र'),
            TalukaInfo(nameEn: 'Pali Rural / East', nameMr: 'Pali ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Pali Rural / West', nameMr: 'Pali ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-PRA',
          nameEn: 'Pratapgarh',
          nameMr: 'Pratapgarh',
          talukas: [
            TalukaInfo(nameEn: 'Pratapgarh City / Central', nameMr: 'Pratapgarh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Pratapgarh Rural / East', nameMr: 'Pratapgarh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Pratapgarh Rural / West', nameMr: 'Pratapgarh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-RAJ',
          nameEn: 'Rajsamand',
          nameMr: 'Rajsamand',
          talukas: [
            TalukaInfo(nameEn: 'Rajsamand City / Central', nameMr: 'Rajsamand शहर / केंद्र'),
            TalukaInfo(nameEn: 'Rajsamand Rural / East', nameMr: 'Rajsamand ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Rajsamand Rural / West', nameMr: 'Rajsamand ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-SAW',
          nameEn: 'Sawai Madhopur',
          nameMr: 'Sawai Madhopur',
          talukas: [
            TalukaInfo(nameEn: 'Sawai Madhopur City / Central', nameMr: 'Sawai Madhopur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sawai Madhopur Rural / East', nameMr: 'Sawai Madhopur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sawai Madhopur Rural / West', nameMr: 'Sawai Madhopur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-SIK',
          nameEn: 'Sikar',
          nameMr: 'Sikar',
          talukas: [
            TalukaInfo(nameEn: 'Sikar City / Central', nameMr: 'Sikar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sikar Rural / East', nameMr: 'Sikar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sikar Rural / West', nameMr: 'Sikar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-SIR',
          nameEn: 'Sirohi',
          nameMr: 'Sirohi',
          talukas: [
            TalukaInfo(nameEn: 'Sirohi City / Central', nameMr: 'Sirohi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sirohi Rural / East', nameMr: 'Sirohi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sirohi Rural / West', nameMr: 'Sirohi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-SRI',
          nameEn: 'Sri Ganganagar',
          nameMr: 'Sri Ganganagar',
          talukas: [
            TalukaInfo(nameEn: 'Sri Ganganagar City / Central', nameMr: 'Sri Ganganagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sri Ganganagar Rural / East', nameMr: 'Sri Ganganagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sri Ganganagar Rural / West', nameMr: 'Sri Ganganagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-TON',
          nameEn: 'Tonk',
          nameMr: 'Tonk',
          talukas: [
            TalukaInfo(nameEn: 'Tonk City / Central', nameMr: 'Tonk शहर / केंद्र'),
            TalukaInfo(nameEn: 'Tonk Rural / East', nameMr: 'Tonk ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Tonk Rural / West', nameMr: 'Tonk ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'RJ-UDA',
          nameEn: 'Udaipur',
          nameMr: 'Udaipur',
          talukas: [
            TalukaInfo(nameEn: 'Udaipur City / Central', nameMr: 'Udaipur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Udaipur Rural / East', nameMr: 'Udaipur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Udaipur Rural / West', nameMr: 'Udaipur ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'SK',
      nameEn: 'Sikkim',
      nameMr: 'सिक्कीम',
      districts: [
        DistrictInfo(
          code: 'SK-EAS',
          nameEn: 'East Sikkim',
          nameMr: 'East Sikkim',
          talukas: [
            TalukaInfo(nameEn: 'East Sikkim City / Central', nameMr: 'East Sikkim शहर / केंद्र'),
            TalukaInfo(nameEn: 'East Sikkim Rural / East', nameMr: 'East Sikkim ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'East Sikkim Rural / West', nameMr: 'East Sikkim ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'SK-NOR',
          nameEn: 'North Sikkim',
          nameMr: 'North Sikkim',
          talukas: [
            TalukaInfo(nameEn: 'North Sikkim City / Central', nameMr: 'North Sikkim शहर / केंद्र'),
            TalukaInfo(nameEn: 'North Sikkim Rural / East', nameMr: 'North Sikkim ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'North Sikkim Rural / West', nameMr: 'North Sikkim ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'SK-SOU',
          nameEn: 'South Sikkim',
          nameMr: 'South Sikkim',
          talukas: [
            TalukaInfo(nameEn: 'South Sikkim City / Central', nameMr: 'South Sikkim शहर / केंद्र'),
            TalukaInfo(nameEn: 'South Sikkim Rural / East', nameMr: 'South Sikkim ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'South Sikkim Rural / West', nameMr: 'South Sikkim ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'SK-WES',
          nameEn: 'West Sikkim',
          nameMr: 'West Sikkim',
          talukas: [
            TalukaInfo(nameEn: 'West Sikkim City / Central', nameMr: 'West Sikkim शहर / केंद्र'),
            TalukaInfo(nameEn: 'West Sikkim Rural / East', nameMr: 'West Sikkim ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'West Sikkim Rural / West', nameMr: 'West Sikkim ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'TN',
      nameEn: 'Tamil Nadu',
      nameMr: 'तमिळनाडू',
      districts: [
        DistrictInfo(
          code: 'TN-ARI',
          nameEn: 'Ariyalur',
          nameMr: 'Ariyalur',
          talukas: [
            TalukaInfo(nameEn: 'Ariyalur City / Central', nameMr: 'Ariyalur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ariyalur Rural / East', nameMr: 'Ariyalur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ariyalur Rural / West', nameMr: 'Ariyalur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-CHE',
          nameEn: 'Chennai',
          nameMr: 'Chennai',
          talukas: [
            TalukaInfo(nameEn: 'Chennai City / Central', nameMr: 'Chennai शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chennai Rural / East', nameMr: 'Chennai ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chennai Rural / West', nameMr: 'Chennai ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-COI',
          nameEn: 'Coimbatore',
          nameMr: 'Coimbatore',
          talukas: [
            TalukaInfo(nameEn: 'Coimbatore City / Central', nameMr: 'Coimbatore शहर / केंद्र'),
            TalukaInfo(nameEn: 'Coimbatore Rural / East', nameMr: 'Coimbatore ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Coimbatore Rural / West', nameMr: 'Coimbatore ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-CUD',
          nameEn: 'Cuddalore',
          nameMr: 'Cuddalore',
          talukas: [
            TalukaInfo(nameEn: 'Cuddalore City / Central', nameMr: 'Cuddalore शहर / केंद्र'),
            TalukaInfo(nameEn: 'Cuddalore Rural / East', nameMr: 'Cuddalore ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Cuddalore Rural / West', nameMr: 'Cuddalore ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-DHA',
          nameEn: 'Dharmapuri',
          nameMr: 'Dharmapuri',
          talukas: [
            TalukaInfo(nameEn: 'Dharmapuri City / Central', nameMr: 'Dharmapuri शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dharmapuri Rural / East', nameMr: 'Dharmapuri ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dharmapuri Rural / West', nameMr: 'Dharmapuri ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-DIN',
          nameEn: 'Dindigul',
          nameMr: 'Dindigul',
          talukas: [
            TalukaInfo(nameEn: 'Dindigul City / Central', nameMr: 'Dindigul शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dindigul Rural / East', nameMr: 'Dindigul ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dindigul Rural / West', nameMr: 'Dindigul ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-ERO',
          nameEn: 'Erode',
          nameMr: 'Erode',
          talukas: [
            TalukaInfo(nameEn: 'Erode City / Central', nameMr: 'Erode शहर / केंद्र'),
            TalukaInfo(nameEn: 'Erode Rural / East', nameMr: 'Erode ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Erode Rural / West', nameMr: 'Erode ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-KAN',
          nameEn: 'Kanchipuram',
          nameMr: 'Kanchipuram',
          talukas: [
            TalukaInfo(nameEn: 'Kanchipuram City / Central', nameMr: 'Kanchipuram शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kanchipuram Rural / East', nameMr: 'Kanchipuram ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kanchipuram Rural / West', nameMr: 'Kanchipuram ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-KAN',
          nameEn: 'Kanyakumari',
          nameMr: 'Kanyakumari',
          talukas: [
            TalukaInfo(nameEn: 'Kanyakumari City / Central', nameMr: 'Kanyakumari शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kanyakumari Rural / East', nameMr: 'Kanyakumari ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kanyakumari Rural / West', nameMr: 'Kanyakumari ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-KAR',
          nameEn: 'Karur',
          nameMr: 'Karur',
          talukas: [
            TalukaInfo(nameEn: 'Karur City / Central', nameMr: 'Karur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Karur Rural / East', nameMr: 'Karur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Karur Rural / West', nameMr: 'Karur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-KRI',
          nameEn: 'Krishnagiri',
          nameMr: 'Krishnagiri',
          talukas: [
            TalukaInfo(nameEn: 'Krishnagiri City / Central', nameMr: 'Krishnagiri शहर / केंद्र'),
            TalukaInfo(nameEn: 'Krishnagiri Rural / East', nameMr: 'Krishnagiri ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Krishnagiri Rural / West', nameMr: 'Krishnagiri ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-MAD',
          nameEn: 'Madurai',
          nameMr: 'Madurai',
          talukas: [
            TalukaInfo(nameEn: 'Madurai City / Central', nameMr: 'Madurai शहर / केंद्र'),
            TalukaInfo(nameEn: 'Madurai Rural / East', nameMr: 'Madurai ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Madurai Rural / West', nameMr: 'Madurai ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-NAG',
          nameEn: 'Nagapattinam',
          nameMr: 'Nagapattinam',
          talukas: [
            TalukaInfo(nameEn: 'Nagapattinam City / Central', nameMr: 'Nagapattinam शहर / केंद्र'),
            TalukaInfo(nameEn: 'Nagapattinam Rural / East', nameMr: 'Nagapattinam ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Nagapattinam Rural / West', nameMr: 'Nagapattinam ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-NAM',
          nameEn: 'Namakkal',
          nameMr: 'Namakkal',
          talukas: [
            TalukaInfo(nameEn: 'Namakkal City / Central', nameMr: 'Namakkal शहर / केंद्र'),
            TalukaInfo(nameEn: 'Namakkal Rural / East', nameMr: 'Namakkal ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Namakkal Rural / West', nameMr: 'Namakkal ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-NIL',
          nameEn: 'Nilgiris',
          nameMr: 'Nilgiris',
          talukas: [
            TalukaInfo(nameEn: 'Nilgiris City / Central', nameMr: 'Nilgiris शहर / केंद्र'),
            TalukaInfo(nameEn: 'Nilgiris Rural / East', nameMr: 'Nilgiris ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Nilgiris Rural / West', nameMr: 'Nilgiris ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-PER',
          nameEn: 'Perambalur',
          nameMr: 'Perambalur',
          talukas: [
            TalukaInfo(nameEn: 'Perambalur City / Central', nameMr: 'Perambalur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Perambalur Rural / East', nameMr: 'Perambalur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Perambalur Rural / West', nameMr: 'Perambalur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-PUD',
          nameEn: 'Pudukkottai',
          nameMr: 'Pudukkottai',
          talukas: [
            TalukaInfo(nameEn: 'Pudukkottai City / Central', nameMr: 'Pudukkottai शहर / केंद्र'),
            TalukaInfo(nameEn: 'Pudukkottai Rural / East', nameMr: 'Pudukkottai ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Pudukkottai Rural / West', nameMr: 'Pudukkottai ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-RAM',
          nameEn: 'Ramanathapuram',
          nameMr: 'Ramanathapuram',
          talukas: [
            TalukaInfo(nameEn: 'Ramanathapuram City / Central', nameMr: 'Ramanathapuram शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ramanathapuram Rural / East', nameMr: 'Ramanathapuram ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ramanathapuram Rural / West', nameMr: 'Ramanathapuram ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-SAL',
          nameEn: 'Salem',
          nameMr: 'Salem',
          talukas: [
            TalukaInfo(nameEn: 'Salem City / Central', nameMr: 'Salem शहर / केंद्र'),
            TalukaInfo(nameEn: 'Salem Rural / East', nameMr: 'Salem ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Salem Rural / West', nameMr: 'Salem ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-SIV',
          nameEn: 'Sivaganga',
          nameMr: 'Sivaganga',
          talukas: [
            TalukaInfo(nameEn: 'Sivaganga City / Central', nameMr: 'Sivaganga शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sivaganga Rural / East', nameMr: 'Sivaganga ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sivaganga Rural / West', nameMr: 'Sivaganga ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-THA',
          nameEn: 'Thanjavur',
          nameMr: 'Thanjavur',
          talukas: [
            TalukaInfo(nameEn: 'Thanjavur City / Central', nameMr: 'Thanjavur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Thanjavur Rural / East', nameMr: 'Thanjavur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Thanjavur Rural / West', nameMr: 'Thanjavur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-THE',
          nameEn: 'Theni',
          nameMr: 'Theni',
          talukas: [
            TalukaInfo(nameEn: 'Theni City / Central', nameMr: 'Theni शहर / केंद्र'),
            TalukaInfo(nameEn: 'Theni Rural / East', nameMr: 'Theni ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Theni Rural / West', nameMr: 'Theni ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-THO',
          nameEn: 'Thoothukudi (Tuticorin)',
          nameMr: 'Thoothukudi (Tuticorin)',
          talukas: [
            TalukaInfo(nameEn: 'Thoothukudi (Tuticorin) City / Central', nameMr: 'Thoothukudi (Tuticorin) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Thoothukudi (Tuticorin) Rural / East', nameMr: 'Thoothukudi (Tuticorin) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Thoothukudi (Tuticorin) Rural / West', nameMr: 'Thoothukudi (Tuticorin) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-TIR',
          nameEn: 'Tiruchirappalli',
          nameMr: 'Tiruchirappalli',
          talukas: [
            TalukaInfo(nameEn: 'Tiruchirappalli City / Central', nameMr: 'Tiruchirappalli शहर / केंद्र'),
            TalukaInfo(nameEn: 'Tiruchirappalli Rural / East', nameMr: 'Tiruchirappalli ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Tiruchirappalli Rural / West', nameMr: 'Tiruchirappalli ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-TIR',
          nameEn: 'Tirunelveli',
          nameMr: 'Tirunelveli',
          talukas: [
            TalukaInfo(nameEn: 'Tirunelveli City / Central', nameMr: 'Tirunelveli शहर / केंद्र'),
            TalukaInfo(nameEn: 'Tirunelveli Rural / East', nameMr: 'Tirunelveli ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Tirunelveli Rural / West', nameMr: 'Tirunelveli ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-TIR',
          nameEn: 'Tiruppur',
          nameMr: 'Tiruppur',
          talukas: [
            TalukaInfo(nameEn: 'Tiruppur City / Central', nameMr: 'Tiruppur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Tiruppur Rural / East', nameMr: 'Tiruppur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Tiruppur Rural / West', nameMr: 'Tiruppur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-TIR',
          nameEn: 'Tiruvallur',
          nameMr: 'Tiruvallur',
          talukas: [
            TalukaInfo(nameEn: 'Tiruvallur City / Central', nameMr: 'Tiruvallur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Tiruvallur Rural / East', nameMr: 'Tiruvallur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Tiruvallur Rural / West', nameMr: 'Tiruvallur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-TIR',
          nameEn: 'Tiruvannamalai',
          nameMr: 'Tiruvannamalai',
          talukas: [
            TalukaInfo(nameEn: 'Tiruvannamalai City / Central', nameMr: 'Tiruvannamalai शहर / केंद्र'),
            TalukaInfo(nameEn: 'Tiruvannamalai Rural / East', nameMr: 'Tiruvannamalai ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Tiruvannamalai Rural / West', nameMr: 'Tiruvannamalai ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-TIR',
          nameEn: 'Tiruvarur',
          nameMr: 'Tiruvarur',
          talukas: [
            TalukaInfo(nameEn: 'Tiruvarur City / Central', nameMr: 'Tiruvarur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Tiruvarur Rural / East', nameMr: 'Tiruvarur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Tiruvarur Rural / West', nameMr: 'Tiruvarur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-VEL',
          nameEn: 'Vellore',
          nameMr: 'Vellore',
          talukas: [
            TalukaInfo(nameEn: 'Vellore City / Central', nameMr: 'Vellore शहर / केंद्र'),
            TalukaInfo(nameEn: 'Vellore Rural / East', nameMr: 'Vellore ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Vellore Rural / West', nameMr: 'Vellore ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-VIL',
          nameEn: 'Viluppuram',
          nameMr: 'Viluppuram',
          talukas: [
            TalukaInfo(nameEn: 'Viluppuram City / Central', nameMr: 'Viluppuram शहर / केंद्र'),
            TalukaInfo(nameEn: 'Viluppuram Rural / East', nameMr: 'Viluppuram ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Viluppuram Rural / West', nameMr: 'Viluppuram ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TN-VIR',
          nameEn: 'Virudhunagar',
          nameMr: 'Virudhunagar',
          talukas: [
            TalukaInfo(nameEn: 'Virudhunagar City / Central', nameMr: 'Virudhunagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Virudhunagar Rural / East', nameMr: 'Virudhunagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Virudhunagar Rural / West', nameMr: 'Virudhunagar ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'TG',
      nameEn: 'Telangana',
      nameMr: 'तेलंगणा',
      districts: [
        DistrictInfo(
          code: 'TG-ADI',
          nameEn: 'Adilabad',
          nameMr: 'Adilabad',
          talukas: [
            TalukaInfo(nameEn: 'Adilabad City / Central', nameMr: 'Adilabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Adilabad Rural / East', nameMr: 'Adilabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Adilabad Rural / West', nameMr: 'Adilabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-BHA',
          nameEn: 'Bhadradri Kothagudem',
          nameMr: 'Bhadradri Kothagudem',
          talukas: [
            TalukaInfo(nameEn: 'Bhadradri Kothagudem City / Central', nameMr: 'Bhadradri Kothagudem शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bhadradri Kothagudem Rural / East', nameMr: 'Bhadradri Kothagudem ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bhadradri Kothagudem Rural / West', nameMr: 'Bhadradri Kothagudem ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-HYD',
          nameEn: 'Hyderabad',
          nameMr: 'Hyderabad',
          talukas: [
            TalukaInfo(nameEn: 'Hyderabad City / Central', nameMr: 'Hyderabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Hyderabad Rural / East', nameMr: 'Hyderabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Hyderabad Rural / West', nameMr: 'Hyderabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-JAG',
          nameEn: 'Jagtial',
          nameMr: 'Jagtial',
          talukas: [
            TalukaInfo(nameEn: 'Jagtial City / Central', nameMr: 'Jagtial शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jagtial Rural / East', nameMr: 'Jagtial ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jagtial Rural / West', nameMr: 'Jagtial ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-JAN',
          nameEn: 'Jangaon',
          nameMr: 'Jangaon',
          talukas: [
            TalukaInfo(nameEn: 'Jangaon City / Central', nameMr: 'Jangaon शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jangaon Rural / East', nameMr: 'Jangaon ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jangaon Rural / West', nameMr: 'Jangaon ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-JAY',
          nameEn: 'Jayashankar Bhoopalpally',
          nameMr: 'Jayashankar Bhoopalpally',
          talukas: [
            TalukaInfo(nameEn: 'Jayashankar Bhoopalpally City / Central', nameMr: 'Jayashankar Bhoopalpally शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jayashankar Bhoopalpally Rural / East', nameMr: 'Jayashankar Bhoopalpally ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jayashankar Bhoopalpally Rural / West', nameMr: 'Jayashankar Bhoopalpally ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-JOG',
          nameEn: 'Jogulamba Gadwal',
          nameMr: 'Jogulamba Gadwal',
          talukas: [
            TalukaInfo(nameEn: 'Jogulamba Gadwal City / Central', nameMr: 'Jogulamba Gadwal शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jogulamba Gadwal Rural / East', nameMr: 'Jogulamba Gadwal ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jogulamba Gadwal Rural / West', nameMr: 'Jogulamba Gadwal ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-KAM',
          nameEn: 'Kamareddy',
          nameMr: 'Kamareddy',
          talukas: [
            TalukaInfo(nameEn: 'Kamareddy City / Central', nameMr: 'Kamareddy शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kamareddy Rural / East', nameMr: 'Kamareddy ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kamareddy Rural / West', nameMr: 'Kamareddy ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-KAR',
          nameEn: 'Karimnagar',
          nameMr: 'Karimnagar',
          talukas: [
            TalukaInfo(nameEn: 'Karimnagar City / Central', nameMr: 'Karimnagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Karimnagar Rural / East', nameMr: 'Karimnagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Karimnagar Rural / West', nameMr: 'Karimnagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-KHA',
          nameEn: 'Khammam',
          nameMr: 'Khammam',
          talukas: [
            TalukaInfo(nameEn: 'Khammam City / Central', nameMr: 'Khammam शहर / केंद्र'),
            TalukaInfo(nameEn: 'Khammam Rural / East', nameMr: 'Khammam ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Khammam Rural / West', nameMr: 'Khammam ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-KOM',
          nameEn: 'Komaram Bheem Asifabad',
          nameMr: 'Komaram Bheem Asifabad',
          talukas: [
            TalukaInfo(nameEn: 'Komaram Bheem Asifabad City / Central', nameMr: 'Komaram Bheem Asifabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Komaram Bheem Asifabad Rural / East', nameMr: 'Komaram Bheem Asifabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Komaram Bheem Asifabad Rural / West', nameMr: 'Komaram Bheem Asifabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-MAH',
          nameEn: 'Mahabubabad',
          nameMr: 'Mahabubabad',
          talukas: [
            TalukaInfo(nameEn: 'Mahabubabad City / Central', nameMr: 'Mahabubabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mahabubabad Rural / East', nameMr: 'Mahabubabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mahabubabad Rural / West', nameMr: 'Mahabubabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-MAH',
          nameEn: 'Mahabubnagar',
          nameMr: 'Mahabubnagar',
          talukas: [
            TalukaInfo(nameEn: 'Mahabubnagar City / Central', nameMr: 'Mahabubnagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mahabubnagar Rural / East', nameMr: 'Mahabubnagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mahabubnagar Rural / West', nameMr: 'Mahabubnagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-MAN',
          nameEn: 'Mancherial',
          nameMr: 'Mancherial',
          talukas: [
            TalukaInfo(nameEn: 'Mancherial City / Central', nameMr: 'Mancherial शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mancherial Rural / East', nameMr: 'Mancherial ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mancherial Rural / West', nameMr: 'Mancherial ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-MED',
          nameEn: 'Medak',
          nameMr: 'Medak',
          talukas: [
            TalukaInfo(nameEn: 'Medak City / Central', nameMr: 'Medak शहर / केंद्र'),
            TalukaInfo(nameEn: 'Medak Rural / East', nameMr: 'Medak ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Medak Rural / West', nameMr: 'Medak ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-MED',
          nameEn: 'Medchal',
          nameMr: 'Medchal',
          talukas: [
            TalukaInfo(nameEn: 'Medchal City / Central', nameMr: 'Medchal शहर / केंद्र'),
            TalukaInfo(nameEn: 'Medchal Rural / East', nameMr: 'Medchal ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Medchal Rural / West', nameMr: 'Medchal ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-NAG',
          nameEn: 'Nagarkurnool',
          nameMr: 'Nagarkurnool',
          talukas: [
            TalukaInfo(nameEn: 'Nagarkurnool City / Central', nameMr: 'Nagarkurnool शहर / केंद्र'),
            TalukaInfo(nameEn: 'Nagarkurnool Rural / East', nameMr: 'Nagarkurnool ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Nagarkurnool Rural / West', nameMr: 'Nagarkurnool ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-NAL',
          nameEn: 'Nalgonda',
          nameMr: 'Nalgonda',
          talukas: [
            TalukaInfo(nameEn: 'Nalgonda City / Central', nameMr: 'Nalgonda शहर / केंद्र'),
            TalukaInfo(nameEn: 'Nalgonda Rural / East', nameMr: 'Nalgonda ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Nalgonda Rural / West', nameMr: 'Nalgonda ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-NIR',
          nameEn: 'Nirmal',
          nameMr: 'Nirmal',
          talukas: [
            TalukaInfo(nameEn: 'Nirmal City / Central', nameMr: 'Nirmal शहर / केंद्र'),
            TalukaInfo(nameEn: 'Nirmal Rural / East', nameMr: 'Nirmal ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Nirmal Rural / West', nameMr: 'Nirmal ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-NIZ',
          nameEn: 'Nizamabad',
          nameMr: 'Nizamabad',
          talukas: [
            TalukaInfo(nameEn: 'Nizamabad City / Central', nameMr: 'Nizamabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Nizamabad Rural / East', nameMr: 'Nizamabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Nizamabad Rural / West', nameMr: 'Nizamabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-PED',
          nameEn: 'Peddapalli',
          nameMr: 'Peddapalli',
          talukas: [
            TalukaInfo(nameEn: 'Peddapalli City / Central', nameMr: 'Peddapalli शहर / केंद्र'),
            TalukaInfo(nameEn: 'Peddapalli Rural / East', nameMr: 'Peddapalli ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Peddapalli Rural / West', nameMr: 'Peddapalli ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-RAJ',
          nameEn: 'Rajanna Sircilla',
          nameMr: 'Rajanna Sircilla',
          talukas: [
            TalukaInfo(nameEn: 'Rajanna Sircilla City / Central', nameMr: 'Rajanna Sircilla शहर / केंद्र'),
            TalukaInfo(nameEn: 'Rajanna Sircilla Rural / East', nameMr: 'Rajanna Sircilla ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Rajanna Sircilla Rural / West', nameMr: 'Rajanna Sircilla ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-RAN',
          nameEn: 'Rangareddy',
          nameMr: 'Rangareddy',
          talukas: [
            TalukaInfo(nameEn: 'Rangareddy City / Central', nameMr: 'Rangareddy शहर / केंद्र'),
            TalukaInfo(nameEn: 'Rangareddy Rural / East', nameMr: 'Rangareddy ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Rangareddy Rural / West', nameMr: 'Rangareddy ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-SAN',
          nameEn: 'Sangareddy',
          nameMr: 'Sangareddy',
          talukas: [
            TalukaInfo(nameEn: 'Sangareddy City / Central', nameMr: 'Sangareddy शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sangareddy Rural / East', nameMr: 'Sangareddy ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sangareddy Rural / West', nameMr: 'Sangareddy ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-SID',
          nameEn: 'Siddipet',
          nameMr: 'Siddipet',
          talukas: [
            TalukaInfo(nameEn: 'Siddipet City / Central', nameMr: 'Siddipet शहर / केंद्र'),
            TalukaInfo(nameEn: 'Siddipet Rural / East', nameMr: 'Siddipet ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Siddipet Rural / West', nameMr: 'Siddipet ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-SUR',
          nameEn: 'Suryapet',
          nameMr: 'Suryapet',
          talukas: [
            TalukaInfo(nameEn: 'Suryapet City / Central', nameMr: 'Suryapet शहर / केंद्र'),
            TalukaInfo(nameEn: 'Suryapet Rural / East', nameMr: 'Suryapet ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Suryapet Rural / West', nameMr: 'Suryapet ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-VIK',
          nameEn: 'Vikarabad',
          nameMr: 'Vikarabad',
          talukas: [
            TalukaInfo(nameEn: 'Vikarabad City / Central', nameMr: 'Vikarabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Vikarabad Rural / East', nameMr: 'Vikarabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Vikarabad Rural / West', nameMr: 'Vikarabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-WAN',
          nameEn: 'Wanaparthy',
          nameMr: 'Wanaparthy',
          talukas: [
            TalukaInfo(nameEn: 'Wanaparthy City / Central', nameMr: 'Wanaparthy शहर / केंद्र'),
            TalukaInfo(nameEn: 'Wanaparthy Rural / East', nameMr: 'Wanaparthy ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Wanaparthy Rural / West', nameMr: 'Wanaparthy ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-WAR',
          nameEn: 'Warangal (Rural)',
          nameMr: 'Warangal (Rural)',
          talukas: [
            TalukaInfo(nameEn: 'Warangal (Rural) City / Central', nameMr: 'Warangal (Rural) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Warangal (Rural) Rural / East', nameMr: 'Warangal (Rural) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Warangal (Rural) Rural / West', nameMr: 'Warangal (Rural) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-WAR',
          nameEn: 'Warangal (Urban)',
          nameMr: 'Warangal (Urban)',
          talukas: [
            TalukaInfo(nameEn: 'Warangal (Urban) City / Central', nameMr: 'Warangal (Urban) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Warangal (Urban) Rural / East', nameMr: 'Warangal (Urban) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Warangal (Urban) Rural / West', nameMr: 'Warangal (Urban) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TG-YAD',
          nameEn: 'Yadadri Bhuvanagiri',
          nameMr: 'Yadadri Bhuvanagiri',
          talukas: [
            TalukaInfo(nameEn: 'Yadadri Bhuvanagiri City / Central', nameMr: 'Yadadri Bhuvanagiri शहर / केंद्र'),
            TalukaInfo(nameEn: 'Yadadri Bhuvanagiri Rural / East', nameMr: 'Yadadri Bhuvanagiri ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Yadadri Bhuvanagiri Rural / West', nameMr: 'Yadadri Bhuvanagiri ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'TR',
      nameEn: 'Tripura',
      nameMr: 'त्रिपुरा',
      districts: [
        DistrictInfo(
          code: 'TR-DHA',
          nameEn: 'Dhalai',
          nameMr: 'Dhalai',
          talukas: [
            TalukaInfo(nameEn: 'Dhalai City / Central', nameMr: 'Dhalai शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dhalai Rural / East', nameMr: 'Dhalai ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dhalai Rural / West', nameMr: 'Dhalai ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TR-GOM',
          nameEn: 'Gomati',
          nameMr: 'Gomati',
          talukas: [
            TalukaInfo(nameEn: 'Gomati City / Central', nameMr: 'Gomati शहर / केंद्र'),
            TalukaInfo(nameEn: 'Gomati Rural / East', nameMr: 'Gomati ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Gomati Rural / West', nameMr: 'Gomati ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TR-KHO',
          nameEn: 'Khowai',
          nameMr: 'Khowai',
          talukas: [
            TalukaInfo(nameEn: 'Khowai City / Central', nameMr: 'Khowai शहर / केंद्र'),
            TalukaInfo(nameEn: 'Khowai Rural / East', nameMr: 'Khowai ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Khowai Rural / West', nameMr: 'Khowai ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TR-NOR',
          nameEn: 'North Tripura',
          nameMr: 'North Tripura',
          talukas: [
            TalukaInfo(nameEn: 'North Tripura City / Central', nameMr: 'North Tripura शहर / केंद्र'),
            TalukaInfo(nameEn: 'North Tripura Rural / East', nameMr: 'North Tripura ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'North Tripura Rural / West', nameMr: 'North Tripura ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TR-SEP',
          nameEn: 'Sepahijala',
          nameMr: 'Sepahijala',
          talukas: [
            TalukaInfo(nameEn: 'Sepahijala City / Central', nameMr: 'Sepahijala शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sepahijala Rural / East', nameMr: 'Sepahijala ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sepahijala Rural / West', nameMr: 'Sepahijala ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TR-SOU',
          nameEn: 'South Tripura',
          nameMr: 'South Tripura',
          talukas: [
            TalukaInfo(nameEn: 'South Tripura City / Central', nameMr: 'South Tripura शहर / केंद्र'),
            TalukaInfo(nameEn: 'South Tripura Rural / East', nameMr: 'South Tripura ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'South Tripura Rural / West', nameMr: 'South Tripura ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TR-UNA',
          nameEn: 'Unakoti',
          nameMr: 'Unakoti',
          talukas: [
            TalukaInfo(nameEn: 'Unakoti City / Central', nameMr: 'Unakoti शहर / केंद्र'),
            TalukaInfo(nameEn: 'Unakoti Rural / East', nameMr: 'Unakoti ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Unakoti Rural / West', nameMr: 'Unakoti ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'TR-WES',
          nameEn: 'West Tripura',
          nameMr: 'West Tripura',
          talukas: [
            TalukaInfo(nameEn: 'West Tripura City / Central', nameMr: 'West Tripura शहर / केंद्र'),
            TalukaInfo(nameEn: 'West Tripura Rural / East', nameMr: 'West Tripura ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'West Tripura Rural / West', nameMr: 'West Tripura ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'UK',
      nameEn: 'Uttarakhand',
      nameMr: 'उत्तराखंड',
      districts: [
        DistrictInfo(
          code: 'UK-ALM',
          nameEn: 'Almora',
          nameMr: 'Almora',
          talukas: [
            TalukaInfo(nameEn: 'Almora City / Central', nameMr: 'Almora शहर / केंद्र'),
            TalukaInfo(nameEn: 'Almora Rural / East', nameMr: 'Almora ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Almora Rural / West', nameMr: 'Almora ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UK-BAG',
          nameEn: 'Bageshwar',
          nameMr: 'Bageshwar',
          talukas: [
            TalukaInfo(nameEn: 'Bageshwar City / Central', nameMr: 'Bageshwar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bageshwar Rural / East', nameMr: 'Bageshwar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bageshwar Rural / West', nameMr: 'Bageshwar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UK-CHA',
          nameEn: 'Chamoli',
          nameMr: 'Chamoli',
          talukas: [
            TalukaInfo(nameEn: 'Chamoli City / Central', nameMr: 'Chamoli शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chamoli Rural / East', nameMr: 'Chamoli ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chamoli Rural / West', nameMr: 'Chamoli ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UK-CHA',
          nameEn: 'Champawat',
          nameMr: 'Champawat',
          talukas: [
            TalukaInfo(nameEn: 'Champawat City / Central', nameMr: 'Champawat शहर / केंद्र'),
            TalukaInfo(nameEn: 'Champawat Rural / East', nameMr: 'Champawat ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Champawat Rural / West', nameMr: 'Champawat ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UK-DEH',
          nameEn: 'Dehradun',
          nameMr: 'Dehradun',
          talukas: [
            TalukaInfo(nameEn: 'Dehradun City / Central', nameMr: 'Dehradun शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dehradun Rural / East', nameMr: 'Dehradun ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dehradun Rural / West', nameMr: 'Dehradun ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UK-HAR',
          nameEn: 'Haridwar',
          nameMr: 'Haridwar',
          talukas: [
            TalukaInfo(nameEn: 'Haridwar City / Central', nameMr: 'Haridwar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Haridwar Rural / East', nameMr: 'Haridwar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Haridwar Rural / West', nameMr: 'Haridwar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UK-NAI',
          nameEn: 'Nainital',
          nameMr: 'Nainital',
          talukas: [
            TalukaInfo(nameEn: 'Nainital City / Central', nameMr: 'Nainital शहर / केंद्र'),
            TalukaInfo(nameEn: 'Nainital Rural / East', nameMr: 'Nainital ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Nainital Rural / West', nameMr: 'Nainital ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UK-PAU',
          nameEn: 'Pauri Garhwal',
          nameMr: 'Pauri Garhwal',
          talukas: [
            TalukaInfo(nameEn: 'Pauri Garhwal City / Central', nameMr: 'Pauri Garhwal शहर / केंद्र'),
            TalukaInfo(nameEn: 'Pauri Garhwal Rural / East', nameMr: 'Pauri Garhwal ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Pauri Garhwal Rural / West', nameMr: 'Pauri Garhwal ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UK-PIT',
          nameEn: 'Pithoragarh',
          nameMr: 'Pithoragarh',
          talukas: [
            TalukaInfo(nameEn: 'Pithoragarh City / Central', nameMr: 'Pithoragarh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Pithoragarh Rural / East', nameMr: 'Pithoragarh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Pithoragarh Rural / West', nameMr: 'Pithoragarh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UK-RUD',
          nameEn: 'Rudraprayag',
          nameMr: 'Rudraprayag',
          talukas: [
            TalukaInfo(nameEn: 'Rudraprayag City / Central', nameMr: 'Rudraprayag शहर / केंद्र'),
            TalukaInfo(nameEn: 'Rudraprayag Rural / East', nameMr: 'Rudraprayag ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Rudraprayag Rural / West', nameMr: 'Rudraprayag ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UK-TEH',
          nameEn: 'Tehri Garhwal',
          nameMr: 'Tehri Garhwal',
          talukas: [
            TalukaInfo(nameEn: 'Tehri Garhwal City / Central', nameMr: 'Tehri Garhwal शहर / केंद्र'),
            TalukaInfo(nameEn: 'Tehri Garhwal Rural / East', nameMr: 'Tehri Garhwal ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Tehri Garhwal Rural / West', nameMr: 'Tehri Garhwal ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UK-UDH',
          nameEn: 'Udham Singh Nagar',
          nameMr: 'Udham Singh Nagar',
          talukas: [
            TalukaInfo(nameEn: 'Udham Singh Nagar City / Central', nameMr: 'Udham Singh Nagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Udham Singh Nagar Rural / East', nameMr: 'Udham Singh Nagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Udham Singh Nagar Rural / West', nameMr: 'Udham Singh Nagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UK-UTT',
          nameEn: 'Uttarkashi',
          nameMr: 'Uttarkashi',
          talukas: [
            TalukaInfo(nameEn: 'Uttarkashi City / Central', nameMr: 'Uttarkashi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Uttarkashi Rural / East', nameMr: 'Uttarkashi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Uttarkashi Rural / West', nameMr: 'Uttarkashi ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'UP',
      nameEn: 'Uttar Pradesh',
      nameMr: 'उत्तर प्रदेश',
      districts: [
        DistrictInfo(
          code: 'UP-AGR',
          nameEn: 'Agra',
          nameMr: 'Agra',
          talukas: [
            TalukaInfo(nameEn: 'Agra City / Central', nameMr: 'Agra शहर / केंद्र'),
            TalukaInfo(nameEn: 'Agra Rural / East', nameMr: 'Agra ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Agra Rural / West', nameMr: 'Agra ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-ALI',
          nameEn: 'Aligarh',
          nameMr: 'Aligarh',
          talukas: [
            TalukaInfo(nameEn: 'Aligarh City / Central', nameMr: 'Aligarh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Aligarh Rural / East', nameMr: 'Aligarh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Aligarh Rural / West', nameMr: 'Aligarh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-ALL',
          nameEn: 'Allahabad',
          nameMr: 'Allahabad',
          talukas: [
            TalukaInfo(nameEn: 'Allahabad City / Central', nameMr: 'Allahabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Allahabad Rural / East', nameMr: 'Allahabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Allahabad Rural / West', nameMr: 'Allahabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-AMB',
          nameEn: 'Ambedkar Nagar',
          nameMr: 'Ambedkar Nagar',
          talukas: [
            TalukaInfo(nameEn: 'Ambedkar Nagar City / Central', nameMr: 'Ambedkar Nagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ambedkar Nagar Rural / East', nameMr: 'Ambedkar Nagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ambedkar Nagar Rural / West', nameMr: 'Ambedkar Nagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-AME',
          nameEn: 'Amethi (Chatrapati Sahuji Mahraj Nagar)',
          nameMr: 'Amethi (Chatrapati Sahuji Mahraj Nagar)',
          talukas: [
            TalukaInfo(nameEn: 'Amethi (Chatrapati Sahuji Mahraj Nagar) City / Central', nameMr: 'Amethi (Chatrapati Sahuji Mahraj Nagar) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Amethi (Chatrapati Sahuji Mahraj Nagar) Rural / East', nameMr: 'Amethi (Chatrapati Sahuji Mahraj Nagar) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Amethi (Chatrapati Sahuji Mahraj Nagar) Rural / West', nameMr: 'Amethi (Chatrapati Sahuji Mahraj Nagar) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-AMR',
          nameEn: 'Amroha (J.P. Nagar)',
          nameMr: 'Amroha (J.P. Nagar)',
          talukas: [
            TalukaInfo(nameEn: 'Amroha (J.P. Nagar) City / Central', nameMr: 'Amroha (J.P. Nagar) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Amroha (J.P. Nagar) Rural / East', nameMr: 'Amroha (J.P. Nagar) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Amroha (J.P. Nagar) Rural / West', nameMr: 'Amroha (J.P. Nagar) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-AUR',
          nameEn: 'Auraiya',
          nameMr: 'Auraiya',
          talukas: [
            TalukaInfo(nameEn: 'Auraiya City / Central', nameMr: 'Auraiya शहर / केंद्र'),
            TalukaInfo(nameEn: 'Auraiya Rural / East', nameMr: 'Auraiya ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Auraiya Rural / West', nameMr: 'Auraiya ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-AZA',
          nameEn: 'Azamgarh',
          nameMr: 'Azamgarh',
          talukas: [
            TalukaInfo(nameEn: 'Azamgarh City / Central', nameMr: 'Azamgarh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Azamgarh Rural / East', nameMr: 'Azamgarh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Azamgarh Rural / West', nameMr: 'Azamgarh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-BAG',
          nameEn: 'Baghpat',
          nameMr: 'Baghpat',
          talukas: [
            TalukaInfo(nameEn: 'Baghpat City / Central', nameMr: 'Baghpat शहर / केंद्र'),
            TalukaInfo(nameEn: 'Baghpat Rural / East', nameMr: 'Baghpat ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Baghpat Rural / West', nameMr: 'Baghpat ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-BAH',
          nameEn: 'Bahraich',
          nameMr: 'Bahraich',
          talukas: [
            TalukaInfo(nameEn: 'Bahraich City / Central', nameMr: 'Bahraich शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bahraich Rural / East', nameMr: 'Bahraich ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bahraich Rural / West', nameMr: 'Bahraich ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-BAL',
          nameEn: 'Ballia',
          nameMr: 'Ballia',
          talukas: [
            TalukaInfo(nameEn: 'Ballia City / Central', nameMr: 'Ballia शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ballia Rural / East', nameMr: 'Ballia ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ballia Rural / West', nameMr: 'Ballia ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-BAL',
          nameEn: 'Balrampur',
          nameMr: 'Balrampur',
          talukas: [
            TalukaInfo(nameEn: 'Balrampur City / Central', nameMr: 'Balrampur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Balrampur Rural / East', nameMr: 'Balrampur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Balrampur Rural / West', nameMr: 'Balrampur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-BAN',
          nameEn: 'Banda',
          nameMr: 'Banda',
          talukas: [
            TalukaInfo(nameEn: 'Banda City / Central', nameMr: 'Banda शहर / केंद्र'),
            TalukaInfo(nameEn: 'Banda Rural / East', nameMr: 'Banda ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Banda Rural / West', nameMr: 'Banda ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-BAR',
          nameEn: 'Barabanki',
          nameMr: 'Barabanki',
          talukas: [
            TalukaInfo(nameEn: 'Barabanki City / Central', nameMr: 'Barabanki शहर / केंद्र'),
            TalukaInfo(nameEn: 'Barabanki Rural / East', nameMr: 'Barabanki ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Barabanki Rural / West', nameMr: 'Barabanki ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-BAR',
          nameEn: 'Bareilly',
          nameMr: 'Bareilly',
          talukas: [
            TalukaInfo(nameEn: 'Bareilly City / Central', nameMr: 'Bareilly शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bareilly Rural / East', nameMr: 'Bareilly ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bareilly Rural / West', nameMr: 'Bareilly ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-BAS',
          nameEn: 'Basti',
          nameMr: 'Basti',
          talukas: [
            TalukaInfo(nameEn: 'Basti City / Central', nameMr: 'Basti शहर / केंद्र'),
            TalukaInfo(nameEn: 'Basti Rural / East', nameMr: 'Basti ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Basti Rural / West', nameMr: 'Basti ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-BHA',
          nameEn: 'Bhadohi',
          nameMr: 'Bhadohi',
          talukas: [
            TalukaInfo(nameEn: 'Bhadohi City / Central', nameMr: 'Bhadohi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bhadohi Rural / East', nameMr: 'Bhadohi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bhadohi Rural / West', nameMr: 'Bhadohi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-BIJ',
          nameEn: 'Bijnor',
          nameMr: 'Bijnor',
          talukas: [
            TalukaInfo(nameEn: 'Bijnor City / Central', nameMr: 'Bijnor शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bijnor Rural / East', nameMr: 'Bijnor ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bijnor Rural / West', nameMr: 'Bijnor ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-BUD',
          nameEn: 'Budaun',
          nameMr: 'Budaun',
          talukas: [
            TalukaInfo(nameEn: 'Budaun City / Central', nameMr: 'Budaun शहर / केंद्र'),
            TalukaInfo(nameEn: 'Budaun Rural / East', nameMr: 'Budaun ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Budaun Rural / West', nameMr: 'Budaun ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-BUL',
          nameEn: 'Bulandshahr',
          nameMr: 'Bulandshahr',
          talukas: [
            TalukaInfo(nameEn: 'Bulandshahr City / Central', nameMr: 'Bulandshahr शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bulandshahr Rural / East', nameMr: 'Bulandshahr ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bulandshahr Rural / West', nameMr: 'Bulandshahr ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-CHA',
          nameEn: 'Chandauli',
          nameMr: 'Chandauli',
          talukas: [
            TalukaInfo(nameEn: 'Chandauli City / Central', nameMr: 'Chandauli शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chandauli Rural / East', nameMr: 'Chandauli ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chandauli Rural / West', nameMr: 'Chandauli ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-CHI',
          nameEn: 'Chitrakoot',
          nameMr: 'Chitrakoot',
          talukas: [
            TalukaInfo(nameEn: 'Chitrakoot City / Central', nameMr: 'Chitrakoot शहर / केंद्र'),
            TalukaInfo(nameEn: 'Chitrakoot Rural / East', nameMr: 'Chitrakoot ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Chitrakoot Rural / West', nameMr: 'Chitrakoot ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-DEO',
          nameEn: 'Deoria',
          nameMr: 'Deoria',
          talukas: [
            TalukaInfo(nameEn: 'Deoria City / Central', nameMr: 'Deoria शहर / केंद्र'),
            TalukaInfo(nameEn: 'Deoria Rural / East', nameMr: 'Deoria ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Deoria Rural / West', nameMr: 'Deoria ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-ETA',
          nameEn: 'Etah',
          nameMr: 'Etah',
          talukas: [
            TalukaInfo(nameEn: 'Etah City / Central', nameMr: 'Etah शहर / केंद्र'),
            TalukaInfo(nameEn: 'Etah Rural / East', nameMr: 'Etah ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Etah Rural / West', nameMr: 'Etah ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-ETA',
          nameEn: 'Etawah',
          nameMr: 'Etawah',
          talukas: [
            TalukaInfo(nameEn: 'Etawah City / Central', nameMr: 'Etawah शहर / केंद्र'),
            TalukaInfo(nameEn: 'Etawah Rural / East', nameMr: 'Etawah ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Etawah Rural / West', nameMr: 'Etawah ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-FAI',
          nameEn: 'Faizabad',
          nameMr: 'Faizabad',
          talukas: [
            TalukaInfo(nameEn: 'Faizabad City / Central', nameMr: 'Faizabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Faizabad Rural / East', nameMr: 'Faizabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Faizabad Rural / West', nameMr: 'Faizabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-FAR',
          nameEn: 'Farrukhabad',
          nameMr: 'Farrukhabad',
          talukas: [
            TalukaInfo(nameEn: 'Farrukhabad City / Central', nameMr: 'Farrukhabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Farrukhabad Rural / East', nameMr: 'Farrukhabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Farrukhabad Rural / West', nameMr: 'Farrukhabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-FAT',
          nameEn: 'Fatehpur',
          nameMr: 'Fatehpur',
          talukas: [
            TalukaInfo(nameEn: 'Fatehpur City / Central', nameMr: 'Fatehpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Fatehpur Rural / East', nameMr: 'Fatehpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Fatehpur Rural / West', nameMr: 'Fatehpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-FIR',
          nameEn: 'Firozabad',
          nameMr: 'Firozabad',
          talukas: [
            TalukaInfo(nameEn: 'Firozabad City / Central', nameMr: 'Firozabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Firozabad Rural / East', nameMr: 'Firozabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Firozabad Rural / West', nameMr: 'Firozabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-GAU',
          nameEn: 'Gautam Buddha Nagar',
          nameMr: 'Gautam Buddha Nagar',
          talukas: [
            TalukaInfo(nameEn: 'Gautam Buddha Nagar City / Central', nameMr: 'Gautam Buddha Nagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Gautam Buddha Nagar Rural / East', nameMr: 'Gautam Buddha Nagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Gautam Buddha Nagar Rural / West', nameMr: 'Gautam Buddha Nagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-GHA',
          nameEn: 'Ghaziabad',
          nameMr: 'Ghaziabad',
          talukas: [
            TalukaInfo(nameEn: 'Ghaziabad City / Central', nameMr: 'Ghaziabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ghaziabad Rural / East', nameMr: 'Ghaziabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ghaziabad Rural / West', nameMr: 'Ghaziabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-GHA',
          nameEn: 'Ghazipur',
          nameMr: 'Ghazipur',
          talukas: [
            TalukaInfo(nameEn: 'Ghazipur City / Central', nameMr: 'Ghazipur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Ghazipur Rural / East', nameMr: 'Ghazipur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Ghazipur Rural / West', nameMr: 'Ghazipur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-GON',
          nameEn: 'Gonda',
          nameMr: 'Gonda',
          talukas: [
            TalukaInfo(nameEn: 'Gonda City / Central', nameMr: 'Gonda शहर / केंद्र'),
            TalukaInfo(nameEn: 'Gonda Rural / East', nameMr: 'Gonda ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Gonda Rural / West', nameMr: 'Gonda ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-GOR',
          nameEn: 'Gorakhpur',
          nameMr: 'Gorakhpur',
          talukas: [
            TalukaInfo(nameEn: 'Gorakhpur City / Central', nameMr: 'Gorakhpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Gorakhpur Rural / East', nameMr: 'Gorakhpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Gorakhpur Rural / West', nameMr: 'Gorakhpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-HAM',
          nameEn: 'Hamirpur',
          nameMr: 'Hamirpur',
          talukas: [
            TalukaInfo(nameEn: 'Hamirpur City / Central', nameMr: 'Hamirpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Hamirpur Rural / East', nameMr: 'Hamirpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Hamirpur Rural / West', nameMr: 'Hamirpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-HAP',
          nameEn: 'Hapur (Panchsheel Nagar)',
          nameMr: 'Hapur (Panchsheel Nagar)',
          talukas: [
            TalukaInfo(nameEn: 'Hapur (Panchsheel Nagar) City / Central', nameMr: 'Hapur (Panchsheel Nagar) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Hapur (Panchsheel Nagar) Rural / East', nameMr: 'Hapur (Panchsheel Nagar) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Hapur (Panchsheel Nagar) Rural / West', nameMr: 'Hapur (Panchsheel Nagar) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-HAR',
          nameEn: 'Hardoi',
          nameMr: 'Hardoi',
          talukas: [
            TalukaInfo(nameEn: 'Hardoi City / Central', nameMr: 'Hardoi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Hardoi Rural / East', nameMr: 'Hardoi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Hardoi Rural / West', nameMr: 'Hardoi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-HAT',
          nameEn: 'Hathras',
          nameMr: 'Hathras',
          talukas: [
            TalukaInfo(nameEn: 'Hathras City / Central', nameMr: 'Hathras शहर / केंद्र'),
            TalukaInfo(nameEn: 'Hathras Rural / East', nameMr: 'Hathras ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Hathras Rural / West', nameMr: 'Hathras ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-JAL',
          nameEn: 'Jalaun',
          nameMr: 'Jalaun',
          talukas: [
            TalukaInfo(nameEn: 'Jalaun City / Central', nameMr: 'Jalaun शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jalaun Rural / East', nameMr: 'Jalaun ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jalaun Rural / West', nameMr: 'Jalaun ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-JAU',
          nameEn: 'Jaunpur',
          nameMr: 'Jaunpur',
          talukas: [
            TalukaInfo(nameEn: 'Jaunpur City / Central', nameMr: 'Jaunpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jaunpur Rural / East', nameMr: 'Jaunpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jaunpur Rural / West', nameMr: 'Jaunpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-JHA',
          nameEn: 'Jhansi',
          nameMr: 'Jhansi',
          talukas: [
            TalukaInfo(nameEn: 'Jhansi City / Central', nameMr: 'Jhansi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jhansi Rural / East', nameMr: 'Jhansi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jhansi Rural / West', nameMr: 'Jhansi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-KAN',
          nameEn: 'Kannauj',
          nameMr: 'Kannauj',
          talukas: [
            TalukaInfo(nameEn: 'Kannauj City / Central', nameMr: 'Kannauj शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kannauj Rural / East', nameMr: 'Kannauj ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kannauj Rural / West', nameMr: 'Kannauj ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-KAN',
          nameEn: 'Kanpur Dehat',
          nameMr: 'Kanpur Dehat',
          talukas: [
            TalukaInfo(nameEn: 'Kanpur Dehat City / Central', nameMr: 'Kanpur Dehat शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kanpur Dehat Rural / East', nameMr: 'Kanpur Dehat ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kanpur Dehat Rural / West', nameMr: 'Kanpur Dehat ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-KAN',
          nameEn: 'Kanpur Nagar',
          nameMr: 'Kanpur Nagar',
          talukas: [
            TalukaInfo(nameEn: 'Kanpur Nagar City / Central', nameMr: 'Kanpur Nagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kanpur Nagar Rural / East', nameMr: 'Kanpur Nagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kanpur Nagar Rural / West', nameMr: 'Kanpur Nagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-KAN',
          nameEn: 'Kanshiram Nagar (Kasganj)',
          nameMr: 'Kanshiram Nagar (Kasganj)',
          talukas: [
            TalukaInfo(nameEn: 'Kanshiram Nagar (Kasganj) City / Central', nameMr: 'Kanshiram Nagar (Kasganj) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kanshiram Nagar (Kasganj) Rural / East', nameMr: 'Kanshiram Nagar (Kasganj) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kanshiram Nagar (Kasganj) Rural / West', nameMr: 'Kanshiram Nagar (Kasganj) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-KAU',
          nameEn: 'Kaushambi',
          nameMr: 'Kaushambi',
          talukas: [
            TalukaInfo(nameEn: 'Kaushambi City / Central', nameMr: 'Kaushambi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kaushambi Rural / East', nameMr: 'Kaushambi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kaushambi Rural / West', nameMr: 'Kaushambi ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-KUS',
          nameEn: 'Kushinagar (Padrauna)',
          nameMr: 'Kushinagar (Padrauna)',
          talukas: [
            TalukaInfo(nameEn: 'Kushinagar (Padrauna) City / Central', nameMr: 'Kushinagar (Padrauna) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kushinagar (Padrauna) Rural / East', nameMr: 'Kushinagar (Padrauna) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kushinagar (Padrauna) Rural / West', nameMr: 'Kushinagar (Padrauna) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-LAK',
          nameEn: 'Lakhimpur - Kheri',
          nameMr: 'Lakhimpur - Kheri',
          talukas: [
            TalukaInfo(nameEn: 'Lakhimpur - Kheri City / Central', nameMr: 'Lakhimpur - Kheri शहर / केंद्र'),
            TalukaInfo(nameEn: 'Lakhimpur - Kheri Rural / East', nameMr: 'Lakhimpur - Kheri ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Lakhimpur - Kheri Rural / West', nameMr: 'Lakhimpur - Kheri ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-LAL',
          nameEn: 'Lalitpur',
          nameMr: 'Lalitpur',
          talukas: [
            TalukaInfo(nameEn: 'Lalitpur City / Central', nameMr: 'Lalitpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Lalitpur Rural / East', nameMr: 'Lalitpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Lalitpur Rural / West', nameMr: 'Lalitpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-LUC',
          nameEn: 'Lucknow',
          nameMr: 'Lucknow',
          talukas: [
            TalukaInfo(nameEn: 'Lucknow City / Central', nameMr: 'Lucknow शहर / केंद्र'),
            TalukaInfo(nameEn: 'Lucknow Rural / East', nameMr: 'Lucknow ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Lucknow Rural / West', nameMr: 'Lucknow ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-MAH',
          nameEn: 'Maharajganj',
          nameMr: 'Maharajganj',
          talukas: [
            TalukaInfo(nameEn: 'Maharajganj City / Central', nameMr: 'Maharajganj शहर / केंद्र'),
            TalukaInfo(nameEn: 'Maharajganj Rural / East', nameMr: 'Maharajganj ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Maharajganj Rural / West', nameMr: 'Maharajganj ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-MAH',
          nameEn: 'Mahoba',
          nameMr: 'Mahoba',
          talukas: [
            TalukaInfo(nameEn: 'Mahoba City / Central', nameMr: 'Mahoba शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mahoba Rural / East', nameMr: 'Mahoba ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mahoba Rural / West', nameMr: 'Mahoba ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-MAI',
          nameEn: 'Mainpuri',
          nameMr: 'Mainpuri',
          talukas: [
            TalukaInfo(nameEn: 'Mainpuri City / Central', nameMr: 'Mainpuri शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mainpuri Rural / East', nameMr: 'Mainpuri ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mainpuri Rural / West', nameMr: 'Mainpuri ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-MAT',
          nameEn: 'Mathura',
          nameMr: 'Mathura',
          talukas: [
            TalukaInfo(nameEn: 'Mathura City / Central', nameMr: 'Mathura शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mathura Rural / East', nameMr: 'Mathura ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mathura Rural / West', nameMr: 'Mathura ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-MAU',
          nameEn: 'Mau',
          nameMr: 'Mau',
          talukas: [
            TalukaInfo(nameEn: 'Mau City / Central', nameMr: 'Mau शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mau Rural / East', nameMr: 'Mau ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mau Rural / West', nameMr: 'Mau ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-MEE',
          nameEn: 'Meerut',
          nameMr: 'Meerut',
          talukas: [
            TalukaInfo(nameEn: 'Meerut City / Central', nameMr: 'Meerut शहर / केंद्र'),
            TalukaInfo(nameEn: 'Meerut Rural / East', nameMr: 'Meerut ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Meerut Rural / West', nameMr: 'Meerut ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-MIR',
          nameEn: 'Mirzapur',
          nameMr: 'Mirzapur',
          talukas: [
            TalukaInfo(nameEn: 'Mirzapur City / Central', nameMr: 'Mirzapur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Mirzapur Rural / East', nameMr: 'Mirzapur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Mirzapur Rural / West', nameMr: 'Mirzapur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-MOR',
          nameEn: 'Moradabad',
          nameMr: 'Moradabad',
          talukas: [
            TalukaInfo(nameEn: 'Moradabad City / Central', nameMr: 'Moradabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Moradabad Rural / East', nameMr: 'Moradabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Moradabad Rural / West', nameMr: 'Moradabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-MUZ',
          nameEn: 'Muzaffarnagar',
          nameMr: 'Muzaffarnagar',
          talukas: [
            TalukaInfo(nameEn: 'Muzaffarnagar City / Central', nameMr: 'Muzaffarnagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Muzaffarnagar Rural / East', nameMr: 'Muzaffarnagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Muzaffarnagar Rural / West', nameMr: 'Muzaffarnagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-PIL',
          nameEn: 'Pilibhit',
          nameMr: 'Pilibhit',
          talukas: [
            TalukaInfo(nameEn: 'Pilibhit City / Central', nameMr: 'Pilibhit शहर / केंद्र'),
            TalukaInfo(nameEn: 'Pilibhit Rural / East', nameMr: 'Pilibhit ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Pilibhit Rural / West', nameMr: 'Pilibhit ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-PRA',
          nameEn: 'Pratapgarh',
          nameMr: 'Pratapgarh',
          talukas: [
            TalukaInfo(nameEn: 'Pratapgarh City / Central', nameMr: 'Pratapgarh शहर / केंद्र'),
            TalukaInfo(nameEn: 'Pratapgarh Rural / East', nameMr: 'Pratapgarh ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Pratapgarh Rural / West', nameMr: 'Pratapgarh ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-RAE',
          nameEn: 'RaeBareli',
          nameMr: 'RaeBareli',
          talukas: [
            TalukaInfo(nameEn: 'RaeBareli City / Central', nameMr: 'RaeBareli शहर / केंद्र'),
            TalukaInfo(nameEn: 'RaeBareli Rural / East', nameMr: 'RaeBareli ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'RaeBareli Rural / West', nameMr: 'RaeBareli ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-RAM',
          nameEn: 'Rampur',
          nameMr: 'Rampur',
          talukas: [
            TalukaInfo(nameEn: 'Rampur City / Central', nameMr: 'Rampur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Rampur Rural / East', nameMr: 'Rampur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Rampur Rural / West', nameMr: 'Rampur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-SAH',
          nameEn: 'Saharanpur',
          nameMr: 'Saharanpur',
          talukas: [
            TalukaInfo(nameEn: 'Saharanpur City / Central', nameMr: 'Saharanpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Saharanpur Rural / East', nameMr: 'Saharanpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Saharanpur Rural / West', nameMr: 'Saharanpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-SAM',
          nameEn: 'Sambhal (Bhim Nagar)',
          nameMr: 'Sambhal (Bhim Nagar)',
          talukas: [
            TalukaInfo(nameEn: 'Sambhal (Bhim Nagar) City / Central', nameMr: 'Sambhal (Bhim Nagar) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sambhal (Bhim Nagar) Rural / East', nameMr: 'Sambhal (Bhim Nagar) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sambhal (Bhim Nagar) Rural / West', nameMr: 'Sambhal (Bhim Nagar) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-SAN',
          nameEn: 'Sant Kabir Nagar',
          nameMr: 'Sant Kabir Nagar',
          talukas: [
            TalukaInfo(nameEn: 'Sant Kabir Nagar City / Central', nameMr: 'Sant Kabir Nagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sant Kabir Nagar Rural / East', nameMr: 'Sant Kabir Nagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sant Kabir Nagar Rural / West', nameMr: 'Sant Kabir Nagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-SHA',
          nameEn: 'Shahjahanpur',
          nameMr: 'Shahjahanpur',
          talukas: [
            TalukaInfo(nameEn: 'Shahjahanpur City / Central', nameMr: 'Shahjahanpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Shahjahanpur Rural / East', nameMr: 'Shahjahanpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Shahjahanpur Rural / West', nameMr: 'Shahjahanpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-SHA',
          nameEn: 'Shamali (Prabuddh Nagar)',
          nameMr: 'Shamali (Prabuddh Nagar)',
          talukas: [
            TalukaInfo(nameEn: 'Shamali (Prabuddh Nagar) City / Central', nameMr: 'Shamali (Prabuddh Nagar) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Shamali (Prabuddh Nagar) Rural / East', nameMr: 'Shamali (Prabuddh Nagar) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Shamali (Prabuddh Nagar) Rural / West', nameMr: 'Shamali (Prabuddh Nagar) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-SHR',
          nameEn: 'Shravasti',
          nameMr: 'Shravasti',
          talukas: [
            TalukaInfo(nameEn: 'Shravasti City / Central', nameMr: 'Shravasti शहर / केंद्र'),
            TalukaInfo(nameEn: 'Shravasti Rural / East', nameMr: 'Shravasti ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Shravasti Rural / West', nameMr: 'Shravasti ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-SID',
          nameEn: 'Siddharth Nagar',
          nameMr: 'Siddharth Nagar',
          talukas: [
            TalukaInfo(nameEn: 'Siddharth Nagar City / Central', nameMr: 'Siddharth Nagar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Siddharth Nagar Rural / East', nameMr: 'Siddharth Nagar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Siddharth Nagar Rural / West', nameMr: 'Siddharth Nagar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-SIT',
          nameEn: 'Sitapur',
          nameMr: 'Sitapur',
          talukas: [
            TalukaInfo(nameEn: 'Sitapur City / Central', nameMr: 'Sitapur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sitapur Rural / East', nameMr: 'Sitapur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sitapur Rural / West', nameMr: 'Sitapur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-SON',
          nameEn: 'Sonbhadra',
          nameMr: 'Sonbhadra',
          talukas: [
            TalukaInfo(nameEn: 'Sonbhadra City / Central', nameMr: 'Sonbhadra शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sonbhadra Rural / East', nameMr: 'Sonbhadra ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sonbhadra Rural / West', nameMr: 'Sonbhadra ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-SUL',
          nameEn: 'Sultanpur',
          nameMr: 'Sultanpur',
          talukas: [
            TalukaInfo(nameEn: 'Sultanpur City / Central', nameMr: 'Sultanpur शहर / केंद्र'),
            TalukaInfo(nameEn: 'Sultanpur Rural / East', nameMr: 'Sultanpur ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Sultanpur Rural / West', nameMr: 'Sultanpur ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-UNN',
          nameEn: 'Unnao',
          nameMr: 'Unnao',
          talukas: [
            TalukaInfo(nameEn: 'Unnao City / Central', nameMr: 'Unnao शहर / केंद्र'),
            TalukaInfo(nameEn: 'Unnao Rural / East', nameMr: 'Unnao ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Unnao Rural / West', nameMr: 'Unnao ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'UP-VAR',
          nameEn: 'Varanasi',
          nameMr: 'Varanasi',
          talukas: [
            TalukaInfo(nameEn: 'Varanasi City / Central', nameMr: 'Varanasi शहर / केंद्र'),
            TalukaInfo(nameEn: 'Varanasi Rural / East', nameMr: 'Varanasi ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Varanasi Rural / West', nameMr: 'Varanasi ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'WB',
      nameEn: 'West Bengal',
      nameMr: 'पश्चिम बंगाल',
      districts: [
        DistrictInfo(
          code: 'WB-ALI',
          nameEn: 'Alipurduar',
          nameMr: 'Alipurduar',
          talukas: [
            TalukaInfo(nameEn: 'Alipurduar City / Central', nameMr: 'Alipurduar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Alipurduar Rural / East', nameMr: 'Alipurduar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Alipurduar Rural / West', nameMr: 'Alipurduar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-BAN',
          nameEn: 'Bankura',
          nameMr: 'Bankura',
          talukas: [
            TalukaInfo(nameEn: 'Bankura City / Central', nameMr: 'Bankura शहर / केंद्र'),
            TalukaInfo(nameEn: 'Bankura Rural / East', nameMr: 'Bankura ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Bankura Rural / West', nameMr: 'Bankura ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-BIR',
          nameEn: 'Birbhum',
          nameMr: 'Birbhum',
          talukas: [
            TalukaInfo(nameEn: 'Birbhum City / Central', nameMr: 'Birbhum शहर / केंद्र'),
            TalukaInfo(nameEn: 'Birbhum Rural / East', nameMr: 'Birbhum ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Birbhum Rural / West', nameMr: 'Birbhum ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-BUR',
          nameEn: 'Burdwan (Bardhaman)',
          nameMr: 'Burdwan (Bardhaman)',
          talukas: [
            TalukaInfo(nameEn: 'Burdwan (Bardhaman) City / Central', nameMr: 'Burdwan (Bardhaman) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Burdwan (Bardhaman) Rural / East', nameMr: 'Burdwan (Bardhaman) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Burdwan (Bardhaman) Rural / West', nameMr: 'Burdwan (Bardhaman) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-COO',
          nameEn: 'Cooch Behar',
          nameMr: 'Cooch Behar',
          talukas: [
            TalukaInfo(nameEn: 'Cooch Behar City / Central', nameMr: 'Cooch Behar शहर / केंद्र'),
            TalukaInfo(nameEn: 'Cooch Behar Rural / East', nameMr: 'Cooch Behar ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Cooch Behar Rural / West', nameMr: 'Cooch Behar ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-DAK',
          nameEn: 'Dakshin Dinajpur (South Dinajpur)',
          nameMr: 'Dakshin Dinajpur (South Dinajpur)',
          talukas: [
            TalukaInfo(nameEn: 'Dakshin Dinajpur (South Dinajpur) City / Central', nameMr: 'Dakshin Dinajpur (South Dinajpur) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Dakshin Dinajpur (South Dinajpur) Rural / East', nameMr: 'Dakshin Dinajpur (South Dinajpur) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Dakshin Dinajpur (South Dinajpur) Rural / West', nameMr: 'Dakshin Dinajpur (South Dinajpur) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-DAR',
          nameEn: 'Darjeeling',
          nameMr: 'Darjeeling',
          talukas: [
            TalukaInfo(nameEn: 'Darjeeling City / Central', nameMr: 'Darjeeling शहर / केंद्र'),
            TalukaInfo(nameEn: 'Darjeeling Rural / East', nameMr: 'Darjeeling ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Darjeeling Rural / West', nameMr: 'Darjeeling ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-HOO',
          nameEn: 'Hooghly',
          nameMr: 'Hooghly',
          talukas: [
            TalukaInfo(nameEn: 'Hooghly City / Central', nameMr: 'Hooghly शहर / केंद्र'),
            TalukaInfo(nameEn: 'Hooghly Rural / East', nameMr: 'Hooghly ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Hooghly Rural / West', nameMr: 'Hooghly ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-HOW',
          nameEn: 'Howrah',
          nameMr: 'Howrah',
          talukas: [
            TalukaInfo(nameEn: 'Howrah City / Central', nameMr: 'Howrah शहर / केंद्र'),
            TalukaInfo(nameEn: 'Howrah Rural / East', nameMr: 'Howrah ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Howrah Rural / West', nameMr: 'Howrah ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-JAL',
          nameEn: 'Jalpaiguri',
          nameMr: 'Jalpaiguri',
          talukas: [
            TalukaInfo(nameEn: 'Jalpaiguri City / Central', nameMr: 'Jalpaiguri शहर / केंद्र'),
            TalukaInfo(nameEn: 'Jalpaiguri Rural / East', nameMr: 'Jalpaiguri ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Jalpaiguri Rural / West', nameMr: 'Jalpaiguri ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-KAL',
          nameEn: 'Kalimpong',
          nameMr: 'Kalimpong',
          talukas: [
            TalukaInfo(nameEn: 'Kalimpong City / Central', nameMr: 'Kalimpong शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kalimpong Rural / East', nameMr: 'Kalimpong ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kalimpong Rural / West', nameMr: 'Kalimpong ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-KOL',
          nameEn: 'Kolkata',
          nameMr: 'Kolkata',
          talukas: [
            TalukaInfo(nameEn: 'Kolkata City / Central', nameMr: 'Kolkata शहर / केंद्र'),
            TalukaInfo(nameEn: 'Kolkata Rural / East', nameMr: 'Kolkata ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Kolkata Rural / West', nameMr: 'Kolkata ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-MAL',
          nameEn: 'Malda',
          nameMr: 'Malda',
          talukas: [
            TalukaInfo(nameEn: 'Malda City / Central', nameMr: 'Malda शहर / केंद्र'),
            TalukaInfo(nameEn: 'Malda Rural / East', nameMr: 'Malda ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Malda Rural / West', nameMr: 'Malda ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-MUR',
          nameEn: 'Murshidabad',
          nameMr: 'Murshidabad',
          talukas: [
            TalukaInfo(nameEn: 'Murshidabad City / Central', nameMr: 'Murshidabad शहर / केंद्र'),
            TalukaInfo(nameEn: 'Murshidabad Rural / East', nameMr: 'Murshidabad ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Murshidabad Rural / West', nameMr: 'Murshidabad ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-NAD',
          nameEn: 'Nadia',
          nameMr: 'Nadia',
          talukas: [
            TalukaInfo(nameEn: 'Nadia City / Central', nameMr: 'Nadia शहर / केंद्र'),
            TalukaInfo(nameEn: 'Nadia Rural / East', nameMr: 'Nadia ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Nadia Rural / West', nameMr: 'Nadia ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-NOR',
          nameEn: 'North 24 Parganas',
          nameMr: 'North 24 Parganas',
          talukas: [
            TalukaInfo(nameEn: 'North 24 Parganas City / Central', nameMr: 'North 24 Parganas शहर / केंद्र'),
            TalukaInfo(nameEn: 'North 24 Parganas Rural / East', nameMr: 'North 24 Parganas ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'North 24 Parganas Rural / West', nameMr: 'North 24 Parganas ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-PAS',
          nameEn: 'Paschim Medinipur (West Medinipur)',
          nameMr: 'Paschim Medinipur (West Medinipur)',
          talukas: [
            TalukaInfo(nameEn: 'Paschim Medinipur (West Medinipur) City / Central', nameMr: 'Paschim Medinipur (West Medinipur) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Paschim Medinipur (West Medinipur) Rural / East', nameMr: 'Paschim Medinipur (West Medinipur) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Paschim Medinipur (West Medinipur) Rural / West', nameMr: 'Paschim Medinipur (West Medinipur) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-PUR',
          nameEn: 'Purba Medinipur (East Medinipur)',
          nameMr: 'Purba Medinipur (East Medinipur)',
          talukas: [
            TalukaInfo(nameEn: 'Purba Medinipur (East Medinipur) City / Central', nameMr: 'Purba Medinipur (East Medinipur) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Purba Medinipur (East Medinipur) Rural / East', nameMr: 'Purba Medinipur (East Medinipur) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Purba Medinipur (East Medinipur) Rural / West', nameMr: 'Purba Medinipur (East Medinipur) ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-PUR',
          nameEn: 'Purulia',
          nameMr: 'Purulia',
          talukas: [
            TalukaInfo(nameEn: 'Purulia City / Central', nameMr: 'Purulia शहर / केंद्र'),
            TalukaInfo(nameEn: 'Purulia Rural / East', nameMr: 'Purulia ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Purulia Rural / West', nameMr: 'Purulia ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-SOU',
          nameEn: 'South 24 Parganas',
          nameMr: 'South 24 Parganas',
          talukas: [
            TalukaInfo(nameEn: 'South 24 Parganas City / Central', nameMr: 'South 24 Parganas शहर / केंद्र'),
            TalukaInfo(nameEn: 'South 24 Parganas Rural / East', nameMr: 'South 24 Parganas ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'South 24 Parganas Rural / West', nameMr: 'South 24 Parganas ग्रामीण / पश्चिम'),
          ],
        ),
        DistrictInfo(
          code: 'WB-UTT',
          nameEn: 'Uttar Dinajpur (North Dinajpur)',
          nameMr: 'Uttar Dinajpur (North Dinajpur)',
          talukas: [
            TalukaInfo(nameEn: 'Uttar Dinajpur (North Dinajpur) City / Central', nameMr: 'Uttar Dinajpur (North Dinajpur) शहर / केंद्र'),
            TalukaInfo(nameEn: 'Uttar Dinajpur (North Dinajpur) Rural / East', nameMr: 'Uttar Dinajpur (North Dinajpur) ग्रामीण / पूर्व'),
            TalukaInfo(nameEn: 'Uttar Dinajpur (North Dinajpur) Rural / West', nameMr: 'Uttar Dinajpur (North Dinajpur) ग्रामीण / पश्चिम'),
          ],
        ),
      ],
    ),
    StateInfo(
      code: 'LA',
      nameEn: 'Ladakh',
      nameMr: 'लडाख',
      districts: [
        DistrictInfo(
          code: 'LA-LEH',
          nameEn: 'Leh',
          nameMr: 'लेह',
          talukas: [
            TalukaInfo(nameEn: 'Leh', nameMr: 'लेह'),
          ],
        ),
        DistrictInfo(
          code: 'LA-KAR',
          nameEn: 'Kargil',
          nameMr: 'कारगिल',
          talukas: [
            TalukaInfo(nameEn: 'Kargil', nameMr: 'कारगिल'),
          ],
        ),
      ],
    ),
  ];

  static StateInfo get defaultState => states.first; // Maharashtra

  static StateInfo? findState(String? val) {
    if (val == null || val.trim().isEmpty) return null;
    final clean = val.trim().toLowerCase();
    for (final s in states) {
      if (s.code.toLowerCase() == clean ||
          s.nameEn.toLowerCase() == clean ||
          s.nameMr == val.trim()) {
        return s;
      }
    }
    return null;
  }

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
