import 'package:flutter_test/flutter_test.dart';
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
      expect(profile.isNativeAddressSameAsCurrent, isTrue);
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
      expect(map['blood_group'], equals('AB+'));
      expect(map['emergency_contact_name'], equals('अनिता पवार'));
      expect(map['emergency_contact_phone'], equals('9822001133'));
      expect(map['is_native_address_same'], isFalse);
      expect(map['native_district'], equals('सांगली'));
      expect(map['is_politically_active'], isTrue);
      expect(map['political_party'], equals('राष्ट्रवादी'));
      expect(map['is_associated_with_ngo'], isTrue);
      expect(map['ngo_name'], equals('मराठा क्रांती मोर्चा'));
      expect(map['is_organ_donor_pledged'], isTrue);
      expect(map['has_organ_donation_answered'], isTrue);
      expect(map['business_type'], equals('ऑटोमोबाईल सर्व्हिसिंग'));
      expect(map['crops_produced'], equals(['ऊस', 'सोयाबीन']));

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
  });
}
