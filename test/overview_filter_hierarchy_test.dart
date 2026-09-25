import 'package:flutter_test/flutter_test.dart';
import 'package:maratha_shivmudra/core/constants/district_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Simulated dataset representing the exact 101 Firestore registered documents
  final List<Map<String, dynamic>> mockRegisteredMembers = [
    // 20 members in Pune (including Dinesh Balasaheb Borade, Haveli)
    ...List.generate(20, (i) => {
      'member_id': 'MS-PUN-${1000 + i}',
      'name_mr': i == 19 ? 'दिनेश बाळासाहेब बोराडे' : 'पुणे सभासद $i',
      'state': 'Maharashtra',
      'state_code': 'MH',
      'district': 'Pune',
      'district_en': 'Pune',
      'sub_district': i < 11 ? 'Haveli' : 'Baramati',
      'is_registered': true,
    }),
    // 21 members in Satara
    ...List.generate(21, (i) => {
      'member_id': 'MS-SAT-${1000 + i}',
      'name_mr': 'सातारा सभासद $i',
      'state': 'Maharashtra',
      'state_code': 'MH',
      'district': 'Satara',
      'district_en': 'Satara',
      'sub_district': i < 14 ? 'Koregaon' : (i < 17 ? 'Patan' : (i < 20 ? 'Khatav' : 'Man')),
      'is_registered': true,
    }),
    // 59 members in other MH districts (e.g. Kolhapur)
    ...List.generate(59, (i) => {
      'member_id': 'MS-KOP-${1000 + i}',
      'name_mr': 'कोल्हापूर सभासद $i',
      'state': 'Maharashtra',
      'state_code': 'MH',
      'district': 'Kolhapur',
      'district_en': 'Kolhapur',
      'sub_district': 'Karveer',
      'is_registered': true,
    }),
    // 1 in Belagavi, Karnataka
    {
      'member_id': 'PENDING',
      'name_mr': 'प्रशांत कल्लाप्पा सांबरेकर',
      'state': 'Karnataka',
      'state_code': 'KA',
      'district': 'Belagavi',
      'district_code': 'KA-BEL',
      'sub_district': 'Belagavi',
      'is_registered': true,
    },
    // 1 in Surat, Gujarat
    {
      'member_id': 'PENDING',
      'name_mr': 'प्रकाश कृष्णा वाघ',
      'state': 'Gujarat',
      'state_code': 'GJ',
      'district': 'Surat',
      'district_code': 'GJ-SUR',
      'sub_district': 'Surat',
      'is_registered': true,
    },
  ];

  String getDocStateCode(Map<String, dynamic> data) {
    final stateCode = (data['state_code'] as String? ?? '').trim().toUpperCase();
    if (stateCode.isNotEmpty) return stateCode;

    final state = (data['state'] as String? ?? '').trim().toLowerCase();
    if (state == 'maharashtra' || state == 'महाराष्ट्र') return 'MH';
    if (state == 'karnataka' || state == 'कर्नाटक') return 'KA';
    if (state == 'gujarat' || state == 'गुजरात') return 'GJ';
    if (state == 'goa' || state == 'गोवा') return 'GA';
    if (state == 'madhya pradesh' || state == 'मध्य प्रदेश') return 'MP';

    final dCode = (data['district_code'] as String? ?? '').trim().toUpperCase();
    if (dCode.startsWith('KA-') || dCode == 'KA-BEL') return 'KA';
    if (dCode.startsWith('GJ-') || dCode == 'GJ-SUR') return 'GJ';
    if (dCode.contains('-')) {
      final prefix = dCode.split('-').first;
      if (GeoConstants.states.any((s) => s.code == prefix)) return prefix;
    }

    final dist = (data['district_en'] as String? ?? data['district'] as String? ?? '').trim().toLowerCase();
    if (dist.contains('belgaum') || dist.contains('belagavi')) return 'KA';
    if (dist.contains('surat')) return 'GJ';

    for (final s in GeoConstants.states) {
      if (s.code == 'MH') continue;
      for (final d in s.districts) {
        if (d.nameEn.toLowerCase() == dist || d.nameMr == dist) {
          return s.code;
        }
      }
    }

    return 'MH';
  }

  String getDocDistrictEn(Map<String, dynamic> data) {
    final dCode = (data['district_code'] as String? ?? '').trim().toUpperCase();
    if (dCode.isNotEmpty) {
      for (final s in GeoConstants.states) {
        for (final d in s.districts) {
          if (d.code == dCode || d.code.endsWith(dCode)) return d.nameEn;
        }
      }
    }
    final rawDistrict = (data['district_en'] as String? ?? data['district'] as String? ?? '').trim();
    if (rawDistrict.isNotEmpty) {
      final normalized = rawDistrict.toLowerCase();
      for (final s in GeoConstants.states) {
        for (final d in s.districts) {
          if (d.nameEn.toLowerCase() == normalized || d.nameMr == rawDistrict) {
            return d.nameEn;
          }
        }
      }
      return DistrictConstants.getNameEn(rawDistrict);
    }
    return 'Pune';
  }

  String getDocTaluka(Map<String, dynamic> data) {
    final sub = (data['sub_district'] as String? ?? '').trim();
    if (sub.isNotEmpty) return sub;
    final subMr = (data['sub_district_mr'] as String? ?? '').trim();
    if (subMr.isNotEmpty) return subMr;
    final tEn = (data['taluka_en'] as String? ?? data['taluka'] as String? ?? '').trim();
    if (tEn.isNotEmpty) return tEn;
    return '';
  }

  group('Automated Dynamic Dropdown Menu Items & Live Counts', () {
    test('Total dataset has exactly 102 registered members', () {
      expect(mockRegisteredMembers.length, 102);
    });

    test('Dynamic State generation derives exact live counts and excludes 0-member states', () {
      final Map<String, int> stateCounts = {};
      for (final doc in mockRegisteredMembers) {
        final sc = getDocStateCode(doc);
        stateCounts[sc] = (stateCounts[sc] ?? 0) + 1;
      }

      // Exact live counts calculated from query docs
      expect(stateCounts['MH'], 100);
      expect(stateCounts['KA'], 1);
      expect(stateCounts['GJ'], 1);

      // States with 0 members are NOT present
      expect(stateCounts.containsKey('MP'), isFalse);
      expect(stateCounts.containsKey('GA'), isFalse);
      expect(stateCounts.containsKey('DL'), isFalse);

      // Generic "OUT_OF_MH" is completely absent
      expect(stateCounts.containsKey('OUT_OF_MH'), isFalse);
    });

    test('New state dynamically appears when a new member registers from Goa', () {
      final dynamicList = List<Map<String, dynamic>>.from(mockRegisteredMembers);
      dynamicList.add({
        'member_id': 'MS-GA-1001',
        'name_mr': 'गोवा सभासद',
        'state': 'Goa',
        'state_code': 'GA',
        'district': 'North Goa',
        'district_code': 'GA-NG',
        'sub_district': 'Panaji',
        'is_registered': true,
      });

      final Map<String, int> stateCounts = {};
      for (final doc in dynamicList) {
        final sc = getDocStateCode(doc);
        stateCounts[sc] = (stateCounts[sc] ?? 0) + 1;
      }

      // Goa now automatically appears with live count 1
      expect(stateCounts.containsKey('GA'), isTrue);
      expect(stateCounts['GA'], 1);
      expect(dynamicList.length, 103);
    });

    test('Dynamic District generation for MH omits 0-member districts (e.g. Nagpur)', () {
      final mhDocs = mockRegisteredMembers.where((d) => getDocStateCode(d) == 'MH').toList();
      final Map<String, int> districtCounts = {};
      for (final doc in mhDocs) {
        final distEn = getDocDistrictEn(doc);
        districtCounts[distEn] = (districtCounts[distEn] ?? 0) + 1;
      }

      // Districts with members are present with exact live counts
      expect(districtCounts['Satara'], 21);
      expect(districtCounts['Pune'], 20);
      expect(districtCounts['Kolhapur'], 59);

      // Districts with 0 members are NOT included
      expect(districtCounts.containsKey('Nagpur'), isFalse);
      expect(districtCounts.containsKey('Gadchiroli'), isFalse);
      expect(districtCounts.containsKey('Wardha'), isFalse);
    });

    test('New district appears automatically when an entry arrives from Nagpur', () {
      final dynamicList = List<Map<String, dynamic>>.from(mockRegisteredMembers);
      dynamicList.add({
        'member_id': 'MS-NAG-1001',
        'name_mr': 'नागपूर सभासद',
        'state': 'Maharashtra',
        'state_code': 'MH',
        'district': 'Nagpur',
        'district_en': 'Nagpur',
        'sub_district': 'Nagpur Urban',
        'is_registered': true,
      });

      final mhDocs = dynamicList.where((d) => getDocStateCode(d) == 'MH').toList();
      final Map<String, int> districtCounts = {};
      for (final doc in mhDocs) {
        final distEn = getDocDistrictEn(doc);
        districtCounts[distEn] = (districtCounts[distEn] ?? 0) + 1;
      }

      // Nagpur now automatically appears with live count 1
      expect(districtCounts.containsKey('Nagpur'), isTrue);
      expect(districtCounts['Nagpur'], 1);
      expect(mhDocs.length, 101);
    });

    test('Dynamic Taluka generation for Satara has live counts and omits 0-member talukas', () {
      final sataraDocs = mockRegisteredMembers.where((d) {
        return getDocStateCode(d) == 'MH' && getDocDistrictEn(d) == 'Satara';
      }).toList();

      final Map<String, int> talukaCounts = {};
      for (final doc in sataraDocs) {
        final t = getDocTaluka(doc);
        talukaCounts[t] = (talukaCounts[t] ?? 0) + 1;
      }

      // Exact live counts
      expect(talukaCounts['Koregaon'], 14);
      expect(talukaCounts['Patan'], 3);
      expect(talukaCounts['Khatav'], 3);
      expect(talukaCounts['Man'], 1);

      // 0-member talukas (e.g. Wai, Mahabaleshwar) are NOT included
      expect(talukaCounts.containsKey('Wai'), isFalse);
      expect(talukaCounts.containsKey('Mahabaleshwar'), isFalse);
    });

    test('New taluka appears automatically when an entry arrives in Satara (e.g. Karad)', () {
      final dynamicList = List<Map<String, dynamic>>.from(mockRegisteredMembers);
      dynamicList.add({
        'member_id': 'MS-SAT-1099',
        'name_mr': 'कराड सभासद',
        'state': 'Maharashtra',
        'state_code': 'MH',
        'district': 'Satara',
        'district_en': 'Satara',
        'sub_district': 'Karad',
        'is_registered': true,
      });

      final sataraDocs = dynamicList.where((d) {
        return getDocStateCode(d) == 'MH' && getDocDistrictEn(d) == 'Satara';
      }).toList();

      final Map<String, int> talukaCounts = {};
      for (final doc in sataraDocs) {
        final t = getDocTaluka(doc);
        talukaCounts[t] = (talukaCounts[t] ?? 0) + 1;
      }

      // Karad now automatically appears with live count 1
      expect(talukaCounts.containsKey('Karad'), isTrue);
      expect(talukaCounts['Karad'], 1);
      expect(sataraDocs.length, 22);
    });

    test('Taluka Normalizer deduplicates all variations of Koregaon into single canonical item', () {
      final sataraInfo = GeoConstants.states
          .firstWhere((s) => s.code == 'MH')
          .districts
          .firstWhere((d) => d.code == 'SAT');
      final sataraTalukas = sataraInfo.talukas;

      String normalizeTalukaName(String rawTaluka, List<TalukaInfo> districtTalukas) {
        if (rawTaluka.isEmpty) return '';
        final trimmed = rawTaluka.trim();
        final lower = trimmed.toLowerCase();

        for (final t in districtTalukas) {
          if (t.nameEn.toLowerCase() == lower || t.nameMr == trimmed) {
            return t.nameEn;
          }
        }

        const aliasMap = <String, String>{
          'koregav': 'Koregaon',
          'कोरेगांव': 'Koregaon',
          'dahiwadi': 'Man',
          'दहीवाडी': 'Man',
        };
        if (aliasMap.containsKey(lower)) {
          final target = aliasMap[lower]!;
          for (final t in districtTalukas) {
            if (t.nameEn.toLowerCase() == target.toLowerCase()) return t.nameEn;
          }
        }
        if (aliasMap.containsKey(trimmed)) {
          final target = aliasMap[trimmed]!;
          for (final t in districtTalukas) {
            if (t.nameEn.toLowerCase() == target.toLowerCase()) return t.nameEn;
          }
        }

        final deAnuswar = trimmed.replaceAll('गांव', 'गाव');
        final gaonNorm = lower.endsWith('gav') ? '${lower.substring(0, lower.length - 3)}gaon' : lower;

        for (final t in districtTalukas) {
          if (t.nameEn.toLowerCase() == gaonNorm ||
              t.nameMr == deAnuswar ||
              t.nameMr.replaceAll('गांव', 'गाव') == deAnuswar) {
            return t.nameEn;
          }
        }

        return rawTaluka;
      }

      // All 4 variations from raw inputs map to 'Koregaon'
      expect(normalizeTalukaName('कोरेगाव', sataraTalukas), 'Koregaon');
      expect(normalizeTalukaName('koregav', sataraTalukas), 'Koregaon');
      expect(normalizeTalukaName('कोरेगांव', sataraTalukas), 'Koregaon');
      expect(normalizeTalukaName('Koregaon', sataraTalukas), 'Koregaon');

      // Coloquial / town name normalization
      expect(normalizeTalukaName('dahiwadi', sataraTalukas), 'Man');
      expect(normalizeTalukaName('दहीवाडी', sataraTalukas), 'Man');
    });
  });
}
