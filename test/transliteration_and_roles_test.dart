import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maratha_shivmudra/core/constants/district_constants.dart';
import 'package:maratha_shivmudra/core/constants/organization_roles.dart';
import 'package:maratha_shivmudra/core/utils/bilingual_helper.dart';
import 'package:maratha_shivmudra/src/widgets/textfields/text_field.dart';

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

  group('Gender Localization & DB Normalization', () {
    test('DB stores canonical English and Frontend localizes to Marathi correctly', () {
      // Normalization to DB (English)
      expect(BilingualHelper.normalizeGenderToEn('Male'), 'Male');
      expect(BilingualHelper.normalizeGenderToEn('female'), 'Female');
      expect(BilingualHelper.normalizeGenderToEn('Other'), 'Other');
      expect(BilingualHelper.normalizeGenderToEn('पुरुष'), 'Male');
      expect(BilingualHelper.normalizeGenderToEn('स्त्री'), 'Female');
      expect(BilingualHelper.normalizeGenderToEn('इतर'), 'Other');
      expect(BilingualHelper.normalizeGenderToEn('पुरुष (Male)'), 'Male');
      expect(BilingualHelper.normalizeGenderToEn(''), '');
      expect(BilingualHelper.normalizeGenderToEn(null), '');

      // Localization to Marathi
      expect(BilingualHelper.localizeGender('Male', isMarathi: true), 'पुरुष');
      expect(BilingualHelper.localizeGender('Female', isMarathi: true), 'स्त्री');
      expect(BilingualHelper.localizeGender('Other', isMarathi: true), 'इतर');
      expect(BilingualHelper.localizeGender('पुरुष', isMarathi: true), 'पुरुष');
      expect(BilingualHelper.localizeGender('स्त्री', isMarathi: true), 'स्त्री');

      // Localization to English
      expect(BilingualHelper.localizeGender('Male', isMarathi: false), 'Male');
      expect(BilingualHelper.localizeGender('Female', isMarathi: false), 'Female');
      expect(BilingualHelper.localizeGender('Other', isMarathi: false), 'Other');
      expect(BilingualHelper.localizeGender('पुरुष', isMarathi: false), 'Male');
      expect(BilingualHelper.localizeGender('स्त्री', isMarathi: false), 'Female');
    });
  });

  group('MarathiPhoneticInputFormatter Pre-filled Text Editing', () {
    test('Typing in an already filled textfield does NOT clear existing text', () {
      final formatter = MarathiPhoneticInputFormatter();

      // Field starts with existing Marathi text "राहुल" (length 5)
      var current = const TextEditingValue(
        text: 'राहुल',
        selection: TextSelection.collapsed(offset: 5),
      );

      // User types 'k' at the end of "राहुल"
      var next = const TextEditingValue(
        text: 'राहुलk',
        selection: TextSelection.collapsed(offset: 6),
      );
      current = formatter.formatEditUpdate(current, next);

      // Must append transliterated "क" to "राहुल" -> "राहुलक", NOT clear to "क"
      expect(current.text, 'राहुलक');
      expect(current.selection.baseOffset, 6);

      // User types 'i' -> "राहुलki" -> "राहुलकि"
      next = const TextEditingValue(
        text: 'राहुलकi',
        selection: TextSelection.collapsed(offset: 7),
      );
      current = formatter.formatEditUpdate(current, next);

      expect(current.text, 'राहुलकि');
      expect(current.selection.baseOffset, 7);
    });

    test('Typing in the middle of pre-filled text preserves both prefix and suffix', () {
      final formatter = MarathiPhoneticInputFormatter();

      // Field starts with "पुणे शहर"
      var current = const TextEditingValue(
        text: 'पुणे शहर',
        selection: TextSelection.collapsed(offset: 4), // right after 'पुणे'
      );

      // User types 'k' at offset 4
      var next = const TextEditingValue(
        text: 'पुणेk शहर',
        selection: TextSelection.collapsed(offset: 5),
      );
      current = formatter.formatEditUpdate(current, next);

      expect(current.text, 'पुणेक शहर');

      // User types 'i' -> "पुणेki शहर" -> "पुणेकि शहर"
      next = const TextEditingValue(
        text: 'पुणेकi शहर',
        selection: TextSelection.collapsed(offset: 6),
      );
      current = formatter.formatEditUpdate(current, next);

      expect(current.text, 'पुणेकि शहर');
    });

    test('Single character backspace removes only the last typed character', () {
      final formatter = MarathiPhoneticInputFormatter();

      var current = const TextEditingValue(
        text: 'पुणेक',
        selection: TextSelection.collapsed(offset: 5),
      );

      // Backspace 'क' from "पुणेक"
      var next = const TextEditingValue(
        text: 'पुणे',
        selection: TextSelection.collapsed(offset: 4),
      );
      current = formatter.formatEditUpdate(current, next);

      expect(current.text, 'पुणे');
    });
  });
}
