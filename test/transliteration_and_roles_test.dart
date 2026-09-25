import 'package:flutter_test/flutter_test.dart';
import 'package:maratha_shivmudra/core/constants/district_constants.dart';
import 'package:maratha_shivmudra/core/constants/organization_roles.dart';
import 'package:maratha_shivmudra/core/utils/bilingual_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Transliteration & Marathi Grammar Re-ranking', () {
    test('i vs ee produces correct velanti (रस्व vs दीर्घ)', () async {
      // For Jaydip (with i), must select/prefer पहिली वेलांटी: जयदिप
      final jaydip = await BilingualHelper.transliterateLive('Jaydip');
      expect(jaydip, contains('जयदिप'));

      // For Jaydeep (with ee), must prefer दुसरी वेलांटी: जयदीप
      final jaydeep = await BilingualHelper.transliterateLive('Jaydeep');
      expect(jaydeep, contains('जयदीप'));
    });

    test('u vs oo produces correct ukar (पहिला vs दुसरा उकार)', () async {
      // With u -> पहिला उकार (ु)
      final kumar = await BilingualHelper.transliterateLive('kumar');
      expect(kumar.contains('ु'), isTrue);

      // With oo -> दुसरा उकार (ू)
      final poonam = await BilingualHelper.transliterateLive('poonam');
      expect(poonam.contains('ू'), isTrue);
    });

    test('antar starts with simple Anuswar without Kaana (अं, not आं)', () async {
      final antar = await BilingualHelper.transliterateLive('antar');
      expect(antar.startsWith('अं'), isTrue);
      expect(antar.startsWith('आं'), isFalse);
    });
  });

  group('4-Tier Organizational Hierarchy Roles', () {
    test('Maharashtra has exactly 6 Vibhags', () {
      expect(OrganizationRoles.maharashtraVibhags.length, 6);
      final vibhagCodes = OrganizationRoles.maharashtraVibhags.map((v) => v.code).toList();
      expect(vibhagCodes, containsAll(['KONKAN', 'PUNE', 'NASHIK', 'SAMBHAJINAGAR', 'AMRAVATI', 'NAGPUR']));
    });

    test('Core Committee has 19 official roles', () {
      expect(OrganizationRoles.coreRoles.length, 19);
    });

    test('Role #10 is अंतर संघटन प्रमुख (no kaana on A) with formal English designation', () {
      final role = OrganizationRoles.getRoleByCode('core_antar_sanghatan_pramukh');
      expect(role, isNotNull);
      expect(role!.nameMr, 'अंतर संघटन प्रमुख');
      expect(role.nameMr.contains('आंतर'), isFalse);
      expect(role.nameEn, 'Head of Internal Organization');
    });

    test('Vibhag Committee has 5 official roles', () {
      expect(OrganizationRoles.vibhagRoles.length, 5);
      expect(OrganizationRoles.vibhagRoles.first.nameMr, 'विभाग अध्यक्ष');
      expect(OrganizationRoles.vibhagRoles.first.nameEn, 'Divisional President');
    });

    test('Jilha Committee has 11 official roles', () {
      expect(OrganizationRoles.jilhaRoles.length, 11);
      expect(OrganizationRoles.jilhaRoles.first.nameMr, 'जिल्हा अध्यक्ष');
      expect(OrganizationRoles.jilhaRoles.first.nameEn, 'District President');
    });

    test('Taluka Committee has 5 official roles', () {
      expect(OrganizationRoles.talukaRoles.length, 5);
      expect(OrganizationRoles.talukaRoles.first.nameMr, 'तालुका अध्यक्ष');
      expect(OrganizationRoles.talukaRoles.first.nameEn, 'Taluka President');
    });
  });

  group('Geographic & Out-of-State Detection', () {
    test('Maharashtra has 36 districts with full talukas', () {
      expect(DistrictConstants.districts.length, 36);
      int totalTalukas = 0;
      for (final d in DistrictConstants.districts) {
        totalTalukas = totalTalukas + (d.talukas.length as int);
      }
      expect(totalTalukas, greaterThan(300));
    });

    test('Out-of-state codes correctly identified as not in Maharashtra', () {
      bool isDocInMaharashtra(Map<String, dynamic> data) {
        final stateCode = (data['state_code'] as String? ?? '').trim().toUpperCase();
        final state = (data['state'] as String? ?? '').trim().toLowerCase();
        final dCode = (data['district_code'] as String? ?? '').trim().toUpperCase();
        final dist = (data['district_en'] as String? ?? data['district'] as String? ?? '').trim().toLowerCase();

        if (stateCode.isNotEmpty && stateCode != 'MH') return false;
        if (dCode.startsWith('KA-') || dCode.startsWith('GJ-') || dCode == 'KA-BEL' || dCode == 'GJ-SUR') {
          return false;
        }
        if (state.isNotEmpty && state != 'maharashtra' && state != 'महाराष्ट्र') {
          return false;
        }
        if (dist.contains('belgaum') || dist.contains('belagavi') || dist.contains('surat')) {
          return false;
        }
        return true;
      }

      // Pune member -> in Maharashtra
      expect(isDocInMaharashtra({'state_code': 'MH', 'district_code': 'PUN', 'district_en': 'Pune'}), isTrue);

      // Belgaum (Karnataka) member -> NOT in Maharashtra
      expect(isDocInMaharashtra({'state_code': 'KA', 'district_code': 'KA-BEL', 'district_en': 'Belagavi', 'state': 'Karnataka'}), isFalse);

      // Surat (Gujarat) member -> NOT in Maharashtra
      expect(isDocInMaharashtra({'state_code': 'GJ', 'district_code': 'GJ-SUR', 'district_en': 'Surat', 'state': 'Gujarat'}), isFalse);
    });
  });
}
