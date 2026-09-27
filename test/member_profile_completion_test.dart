import 'package:flutter_test/flutter_test.dart';
import 'package:maratha_shivmudra/core/constants/district_constants.dart';
import 'package:maratha_shivmudra/core/models/member_profile.dart';

void main() {
  group('MemberProfile 100% Criteria & Dynamic Occupation Tests', () {
    test('Legacy member document parses with sensible defaults without error', () {
      final legacyData = {
        'full_name_en': 'Dinesh Pawar',
        'full_name_mr': 'दिनेश पवार',
        'phone': '9876543210',
        'district_mr': 'सातारा',
        'district_en': 'Satara',
        'sub_district': 'कोरेगाव',
        'city': 'कोरेगाव',
        'address': 'मेन रोड, कोरेगाव',
        'profession': 'शेती (Farmer)',
        'photo_url': 'https://example.com/photo.jpg',
      };

      final profile = MemberProfile.fromFirestore('9876543210', legacyData);
      expect(profile.fullNameMr, equals('दिनेश पवार'));
      expect(profile.isNativeAddressSameAsCurrent, isFalse);
      expect(profile.isOrganDonorPledged, isFalse);
      expect(profile.hasOrganDonationConsentAnswered, isFalse);
      expect(profile.cropsProduced, isEmpty);
      expect(profile.isProfileComplete, isFalse);
      expect(profile.completionProgress < 1.0, isTrue);
      expect(profile.missingItems, contains('रक्तगट (Blood Group)'));
      expect(profile.missingItems, contains('आपत्कालीन संपर्क (Emergency Contact)'));
      expect(profile.missingItems, contains('मरणोत्तर अवयवदान संकल्प (Organ Pledge)'));
      expect(profile.missingItems, contains('पिकवत असलेली पिके (Crops Produced)'));
    });

    test('Profile with all criteria reaches 100% completion (Farmer)', () {
      final fullData = {
        'full_name_en': 'Jaydip Pawar',
        'full_name_mr': 'जयदीप पवार',
        'phone': '8691955046',
        'district_mr': 'सातारा',
        'district_en': 'Satara',
        'sub_district': 'कोरेगाव',
        'village': 'कोरेगाव',
        'pincode': '415501',
        'address': 'सदाशिव पेठ, कोरेगाव',
        'date_of_birth': '1995-05-15',
        'gender': 'पुरुष (Male)',
        'living': 'स्वतंत्र घर (Own House)',
        'photo_url': 'https://example.com/avatar.png',
        'blood_group': 'O+',
        'emergency_contact_name': 'संजय पवार',
        'emergency_contact_phone': '9876543210',
        'is_native_address_same': true,
        'is_politically_active': true,
        'political_party': 'शिवसेना',
        'political_role': 'युवा समन्वयक',
        'is_associated_with_ngo': true,
        'ngo_name': 'शिवमुद्रा प्रतिष्ठान',
        'ngo_role': 'सचिव',
        'is_organ_donor_pledged': true,
        'has_organ_donation_answered': true,
        'profession': 'शेती (Farmer)',
        'crops_produced': ['सोयाबीन', 'ऊस', 'हळद'],
      };

      final profile = MemberProfile.fromFirestore('8691955046', fullData);
      expect(profile.completionProgress, equals(1.0));
      expect(profile.isProfileComplete, isTrue);
      expect(profile.missingItems, isEmpty);
    });

    test('Native address separate fields are verified when checkbox is unchecked', () {
      final dataSeparateNative = {
        'full_name_mr': 'अमोल कदम',
        'phone': '9123456789',
        'district_mr': 'पुणे',
        'sub_district': 'हवेली',
        'village': 'पुणे',
        'pincode': '411001',
        'address': 'शिवाजीनगर, पुणे',
        'date_of_birth': '1992-02-10',
        'gender': 'पुरुष (Male)',
        'living': 'भाड्याने (Rented)',
        'photo_url': 'https://example.com/kadam.png',
        'blood_group': 'A+',
        'emergency_contact_name': 'आनंद कदम',
        'emergency_contact_phone': '9123456780',
        'is_native_address_same': false, // Unchecked
        'native_state': 'महाराष्ट्र',
        'native_district': 'सातारा',
        'native_taluka': 'पाटण',
        'native_village': 'चाफोली',
        'native_pincode': '415206',
        'is_politically_active': false,
        'is_associated_with_ngo': false,
        'has_organ_donation_answered': true,
        'is_organ_donor_pledged': false,
        'profession': 'नोकरी (Job)',
        'job_designation': 'सॉफ्टवेअर इंजिनिअर',
        'job_company': 'गुगल',
      };

      final profile = MemberProfile.fromFirestore('9123456789', dataSeparateNative);
      expect(profile.isNativeAddressSameAsCurrent, isFalse);
      expect(profile.nativeDistrict, equals('सातारा'));
      expect(profile.nativeTaluka, equals('पाटण'));
      expect(profile.isProfileComplete, isTrue);
      expect(profile.completionProgress, equals(1.0));
    });

    test('Dynamic occupation validation: Unemployed requires skills and relocation flag', () {
      final unemployedIncomplete = {
        'full_name_mr': 'प्रशांत पाटील',
        'phone': '9988776655',
        'district_mr': 'कोल्हापूर',
        'sub_district': 'करवीर',
        'village': 'कोल्हापूर',
        'pincode': '416001',
        'address': 'राजारामपुरी, कोल्हापूर',
        'date_of_birth': '2000-01-01',
        'gender': 'पुरुष (Male)',
        'living': 'पालकांसोबत (With Parents)',
        'photo_url': 'https://example.com/prashant.png',
        'blood_group': 'B+',
        'emergency_contact_name': 'सुरेश पाटील',
        'emergency_contact_phone': '9988776600',
        'is_native_address_same': true,
        'is_politically_active': false,
        'is_associated_with_ngo': false,
        'has_organ_donation_answered': true,
        'profession': 'बेरोजगार (Unemployed)',
        // Missing unemployed specifics
      };

      final profile = MemberProfile.fromFirestore('9988776655', unemployedIncomplete);
      expect(profile.isProfileComplete, isFalse);
      expect(profile.missingItems, contains('रोजगार सहाय्य माहिती (Career Assistance)'));

      final profileComplete = profile.copyWith(
        unemployedEducation: 'पदवी (Graduate)',
        unemployedPreferredSector: 'आयटी / प्रशासन',
        unemployedSkills: 'MS-CIT, Typing',
        willingToRelocate: true,
      );
      expect(profileComplete.isProfileComplete, isTrue);
      expect(profileComplete.completionProgress, equals(1.0));
    });

    test('Firestore round-trip preserves all new fields', () {
      final original = MemberProfile(
        phone: '9822001122',
        fullNameMrOverride: 'सुनील पवार',
        fullNameEnOverride: 'Sunil Pawar',
        bloodGroup: 'AB+',
        emergencyContactName: 'अनिता पवार',
        emergencyContactPhone: '9822001133',
        isNativeAddressSameAsCurrent: false,
        nativeState: 'महाराष्ट्र',
        nativeDistrict: 'सांगली',
        nativeTaluka: 'कडेगाव',
        nativeVillage: 'कडेगाव',
        nativePincode: '415304',
        nativeAddress: 'मु. पो. कडेगाव',
        isPoliticallyActive: true,
        politicalParty: 'राष्ट्रवादी',
        politicalRole: 'तालुकाध्यक्ष',
        isAssociatedWithNgo: true,
        ngoName: 'मराठा क्रांती मोर्चा',
        ngoRole: 'समन्वयक',
        isOrganDonorPledged: true,
        hasOrganDonationConsentAnswered: true,
        profession: 'व्यवसाय (Business)',
        businessType: 'ऑटोमोबाईल सर्व्हिसिंग',
        cropsProduced: const ['ऊस', 'सोयाबीन'],
      );

      final map = original.toFirestore();
      expect(map['emergency']['blood_group'], equals('AB+'));
      expect(map['emergency']['contact_name'], equals('अनिता पवार'));
      expect(map['emergency']['contact_phone'], equals('9822001133'));
      expect(map['native_place']['is_same_as_current'], isFalse);
      expect(map['native_place']['district'], equals('सांगली'));
      expect(map['affiliations']['is_politically_active'], isTrue);
      expect(map['affiliations']['political_party'], equals('राष्ट्रवादी'));
      expect(map['affiliations']['is_associated_with_ngo'], isTrue);
      expect(map['affiliations']['ngo_name'], equals('मराठा क्रांती मोर्चा'));
      expect(map['pledges']['is_organ_donor_pledged'], isTrue);
      expect(map['pledges']['has_answered_organ_donation'], isTrue);
      expect(map['occupation']['business_details']['business_type'], equals('ऑटोमोबाईल सर्व्हिसिंग'));

      final restored = MemberProfile.fromFirestore(original.phone, map);
      expect(restored.bloodGroup, equals(original.bloodGroup));
      expect(restored.emergencyContactName, equals(original.emergencyContactName));
      expect(restored.nativeDistrict, equals(original.nativeDistrict));
      expect(restored.politicalParty, equals(original.politicalParty));
      expect(restored.ngoName, equals(original.ngoName));
      expect(restored.isOrganDonorPledged, equals(original.isOrganDonorPledged));
      expect(restored.businessType, equals(original.businessType));
      expect(restored.cropsProduced, equals(original.cropsProduced));
    });

    test('Bilingual geo resolution resolves Thane -> Kalyan correctly and repairs legacy taluka_mr mismatch', () {
      final docData = {
        'personal': {
          'first_name_en': 'Jaydip',
          'first_name_mr': 'जयदीप',
          'last_name_en': 'Pawar',
          'last_name_mr': 'पवार',
          'full_name_en': 'Jaydip Balaso Pawar',
          'full_name_mr': 'जयदीप बालासो पवार',
        },
        'residence': {
          'address_en': 'Near Station, Dombivali West',
          'address_mr': 'स्टेशन जवळ, डोंबिवली पश्चिम',
          'village_en': 'Dombivli',
          'village_mr': 'डोंबिवली',
          'taluka_en': 'Kalyan',
          'taluka_mr': 'ठाणे', // previously erroneously saved as district name
          'district_en': 'Thane',
          'district_mr': 'ठाणे',
          'district_code': 'THANE',
          'state_en': 'Maharashtra',
          'state_mr': 'ठाणे', // previously erroneously saved as district name
          'state_code': 'MH',
          'pincode': '421202',
        },
      };

      final profile = MemberProfile.fromFirestore('8691955046', docData);
      expect(profile.subDistrict, equals('Kalyan'));
      // Verifies the bug is fixed and resolved to 'कल्याण' instead of 'ठाणे'
      expect(profile.subDistrictMr, equals('कल्याण'));
      expect(profile.districtEn, equals('Thane'));
      expect(profile.districtMr, equals('ठाणे'));
      expect(profile.state, equals('Maharashtra'));
      expect(profile.stateMr, equals('महाराष्ट्र'));
      expect(profile.village, equals('Dombivli'));
      expect(profile.villageMr, equals('डोंबिवली'));

      final firestoreMap = profile.toFirestore();
      final residence = firestoreMap['residence'] as Map<String, dynamic>;
      expect(residence['taluka_en'], equals('Kalyan'));
      expect(residence['taluka_mr'], equals('कल्याण'));
      expect(residence['district_en'], equals('Thane'));
      expect(residence['district_mr'], equals('ठाणे'));
      expect(residence['state_en'], equals('Maharashtra'));
      expect(residence['state_mr'], equals('महाराष्ट्र'));
    });

    test('Native place state and taluka are NOT defaulted when user provides only district', () {
      final profile = MemberProfile(
        phone: '8691955046',
        nativeDistrict: 'Ahilyanagar',
        nativeState: '',
        nativeTaluka: '',
        isNativeAddressSameAsCurrent: false,
      );

      final map = profile.toFirestore();
      final nativePlace = map['native_place'] as Map<String, dynamic>;
      expect(nativePlace['is_same_as_current'], isFalse);
      expect(nativePlace['district'], equals('Ahilyanagar'));
      expect(nativePlace['district_en'], equals('Ahilyanagar'));
      expect(nativePlace['state'], equals(''), reason: 'State must not default to Maharashtra');
      expect(nativePlace['state_en'], equals(''), reason: 'State EN must not default to Maharashtra');
      expect(nativePlace['taluka'], equals(''), reason: 'Taluka must not default to first taluka');
      expect(nativePlace['taluka_en'], equals(''), reason: 'Taluka EN must not default to first taluka');
    });

    test('When isNativeAddressSameAsCurrent is true, native_place writes empty strings so Firestore merge clears stale values', () {
      final profile = MemberProfile(
        phone: '8691955046',
        state: 'Maharashtra',
        district: 'Thane',
        subDistrict: 'Kalyan',
        isNativeAddressSameAsCurrent: true,
      );

      final map = profile.toFirestore();
      final nativePlace = map['native_place'] as Map<String, dynamic>;
      expect(nativePlace['is_same_as_current'], isTrue);
      expect(nativePlace['state'], equals(''));
      expect(nativePlace['taluka'], equals(''));
      expect(nativePlace['district'], equals(''));
    });

    test('DistrictConstants and GeoConstants do NOT default empty district to Pune or PUN', () {
      expect(DistrictConstants.getCode(''), equals(''));
      expect(DistrictConstants.getCode(null), equals(''));
      expect(DistrictConstants.getNameEn(''), equals(''));
      expect(DistrictConstants.getNameMr(''), equals(''));
      expect(DistrictConstants.getNameEn(null), equals(''));
      expect(DistrictConstants.getNameMr(null), equals(''));
      expect(GeoConstants.getDistrictByCode('').code, equals(''));
      expect(GeoConstants.getDistrictNameEn(''), equals(''));
      expect(GeoConstants.getDistrictNameMr(''), equals(''));
      expect(DistrictConstants.getByCode('').code, equals(''));
    });

    test('When user explicitly provides native state and taluka, they are preserved accurately', () {
      final profile = MemberProfile(
        phone: '8691955046',
        nativeState: 'Maharashtra',
        nativeDistrict: 'Pune',
        nativeTaluka: 'Haveli',
        isNativeAddressSameAsCurrent: false,
      );

      final map = profile.toFirestore();
      final nativePlace = map['native_place'] as Map<String, dynamic>;
      expect(nativePlace['is_same_as_current'], isFalse);
      expect(nativePlace['state'], equals('Maharashtra'));
      expect(nativePlace['district'], equals('Pune'));
      expect(nativePlace['taluka'], equals('Haveli'));
    });

    test('When political active or NGO active is false, associated fields are cleared and empty in toFirestore and fromFirestore', () {
      final profile = MemberProfile(
        phone: '8691955046',
        isPoliticallyActive: false,
        politicalParty: 'Old Party',
        politicalRole: 'Old Role',
        isAssociatedWithNgo: false,
        ngoName: 'Old NGO',
        ngoRole: 'Old Role',
      );

      final map = profile.toFirestore();
      expect(map['affiliations']['is_politically_active'], isFalse);
      expect(map['affiliations']['political_party'], equals(''));
      expect(map['affiliations']['political_role'], equals(''));
      expect(map['affiliations']['is_associated_with_ngo'], isFalse);
      expect(map['affiliations']['ngo_name'], equals(''));
      expect(map['affiliations']['ngo_role'], equals(''));

      // Test fromFirestore with legacy or previously filled data where flag is now false
      final legacyData = {
        'affiliations': {
          'is_politically_active': false,
          'political_party': 'Old Party',
          'political_role': 'Old Role',
          'is_associated_with_ngo': false,
          'ngo_name': 'Old NGO',
          'ngo_role': 'Old Role',
        },
        'political_party': 'Old Party Root',
        'political_role': 'Old Role Root',
      };

      final parsed = MemberProfile.fromFirestore('8691955046', legacyData);
      expect(parsed.isPoliticallyActive, isFalse);
      expect(parsed.politicalParty, equals(''));
      expect(parsed.politicalRole, equals(''));
      expect(parsed.isAssociatedWithNgo, isFalse);
      expect(parsed.ngoName, equals(''));
      expect(parsed.ngoRole, equals(''));
    });
  });
}
