import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maratha_shivmudra/core/constants/district_constants.dart';
import 'package:maratha_shivmudra/core/constants/geo_constants.dart';
import 'package:maratha_shivmudra/core/utils/bilingual_helper.dart';

class MemberProfile {
  final String phone;
  final String firstName;
  final String middleName;
  final String lastName;
  final String firstNameMr;
  final String middleNameMr;
  final String lastNameMr;
  final String fullNameEnOverride;
  final String fullNameMrOverride;
  final String dateOfBirth;
  final String gender;
  final String address;
  final String addressMr;
  final String city;
  final String village;
  final String villageMr;
  final String state;
  final String stateMr;
  final String stateCode;
  final String district;
  final String districtCode;
  final String districtEn;
  final String districtMr;
  final String subDistrict;
  final String subDistrictMr;
  final String pincode;
  final String email;
  final String living;
  final String profession;
  final String education;
  final String bloodGroup;
  final String emergencyContactName;
  final String emergencyContactPhone;

  // Native Village Address (मूळ गाव पत्ता)
  final bool isNativeAddressSameAsCurrent;
  final String nativeAddress;
  final String nativeAddressMr;
  final String nativeState;
  final String nativeStateMr;
  final String nativeStateCode;
  final String nativeDistrict;
  final String nativeDistrictMr;
  final String nativeTaluka;
  final String nativeTalukaMr;
  final String nativeVillage;
  final String nativeVillageMr;
  final String nativePincode;

  // Political Status (राजकीय क्षेत्रात सक्रिय आहात का?)
  final bool? isPoliticallyActive;
  final String politicalParty;
  final String politicalRole;

  // Social / NGO Affiliation (इतर कोणत्याही सामाजिक / अशासकीय संस्थेत कार्यरत आहात का?)
  final bool? isAssociatedWithNgo;
  final String ngoName;
  final String ngoRole;

  // Organ Donation Pledge (मरणोत्तर अवयवदान संकल्प)
  final bool isOrganDonorPledged;
  final bool hasOrganDonationConsentAnswered;

  // Detailed Occupation Fields
  final String jobDesignation;
  final String jobCompany;
  final String businessType;
  final String educationLevel;
  final String educationOther;
  final List<String> cropsProduced;
  final String unemployedEducation;
  final String unemployedPreferredSector;
  final String unemployedSkills;
  final bool? willingToRelocate;

  final String roleType; // 'member' | 'manager' | 'executive' | 'district_head' | 'core_committee'
  final String designation;
  final bool isOfficial;
  final String? officialLevel;
  final String? officialRoleCode;
  final String? officialRoleMr;
  final String? officialRoleEn;
  final String? officialFullTitleMr;
  final String? officialFullTitleEn;
  final String? officialVibhag;
  final String? officialDistrict;
  final String? officialTaluka;
  final String? photoBase64;
  final String? photoUrl;
  final String? memberId;
  final String? referralId;
  final bool isCardIssued;
  final bool isRegistered;
  final bool isValid;
  final DateTime? cardIssuedDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const MemberProfile({
    required this.phone,
    this.firstName = '',
    this.middleName = '',
    this.lastName = '',
    this.firstNameMr = '',
    this.middleNameMr = '',
    this.lastNameMr = '',
    this.fullNameEnOverride = '',
    this.fullNameMrOverride = '',
    this.dateOfBirth = '',
    this.gender = '',
    this.address = '',
    this.addressMr = '',
    this.city = '',
    this.village = '',
    this.villageMr = '',
    this.state = '',
    this.stateMr = '',
    this.stateCode = '',
    this.district = '',
    this.districtCode = '',
    this.districtEn = '',
    this.districtMr = '',
    this.subDistrict = '',
    this.subDistrictMr = '',
    this.pincode = '',
    this.email = '',
    this.living = '',
    this.profession = '',
    this.education = '',
    this.bloodGroup = '',
    this.emergencyContactName = '',
    this.emergencyContactPhone = '',
    this.isNativeAddressSameAsCurrent = false,
    this.nativeAddress = '',
    this.nativeAddressMr = '',
    this.nativeState = '',
    this.nativeStateMr = '',
    this.nativeStateCode = '',
    this.nativeDistrict = '',
    this.nativeDistrictMr = '',
    this.nativeTaluka = '',
    this.nativeTalukaMr = '',
    this.nativeVillage = '',
    this.nativeVillageMr = '',
    this.nativePincode = '',
    this.isPoliticallyActive,
    this.politicalParty = '',
    this.politicalRole = '',
    this.isAssociatedWithNgo,
    this.ngoName = '',
    this.ngoRole = '',
    this.isOrganDonorPledged = false,
    this.hasOrganDonationConsentAnswered = false,
    this.jobDesignation = '',
    this.jobCompany = '',
    this.businessType = '',
    this.educationLevel = '',
    this.educationOther = '',
    this.cropsProduced = const [],
    this.unemployedEducation = '',
    this.unemployedPreferredSector = '',
    this.unemployedSkills = '',
    this.willingToRelocate,
    this.roleType = 'member',
    this.designation = '',
    this.isOfficial = false,
    this.officialLevel,
    this.officialRoleCode,
    this.officialRoleMr,
    this.officialRoleEn,
    this.officialFullTitleMr,
    this.officialFullTitleEn,
    this.officialVibhag,
    this.officialDistrict,
    this.officialTaluka,
    this.photoBase64,
    this.photoUrl,
    this.memberId,
    this.referralId,
    this.isCardIssued = false,
    this.isRegistered = true,
    this.isValid = true,
    this.cardIssuedDate,
    this.createdAt,
    this.updatedAt,
  });

  bool get isOfficialManager => roleType != 'member';

  String get fullNameEn {
    if (fullNameEnOverride.trim().isNotEmpty) return fullNameEnOverride.trim();
    final parts = [firstName, middleName, lastName].where((s) => s.trim().isNotEmpty).join(' ');
    if (parts.isNotEmpty) return parts;
    if (fullNameMrOverride.trim().isNotEmpty) return fullNameMrOverride.trim();
    final partsMr = [firstNameMr, middleNameMr, lastNameMr].where((s) => s.trim().isNotEmpty).join(' ');
    if (partsMr.isNotEmpty) return partsMr;
    return 'Member';
  }

  String get fullNameMr {
    if (fullNameMrOverride.trim().isNotEmpty) return fullNameMrOverride.trim();
    final partsMr = [firstNameMr, middleNameMr, lastNameMr].where((s) => s.trim().isNotEmpty).join(' ');
    if (partsMr.isNotEmpty) return partsMr;
    if (fullNameEnOverride.trim().isNotEmpty) return fullNameEnOverride.trim();
    final parts = [firstName, middleName, lastName].where((s) => s.trim().isNotEmpty).join(' ');
    if (parts.isNotEmpty) return parts;
    return 'सदस्य';
  }

  String getLocalizedGender({bool isMarathi = true}) {
    return BilingualHelper.localizeGender(gender, isMarathi: isMarathi);
  }

  /// Calculate completion percentage (0.0 to 1.0)
  double get completionProgress {
    int score = 0;
    const int total = 100;

    // 1. Basic Info (15%)
    if ((fullNameMr.isNotEmpty || fullNameEn.isNotEmpty || firstName.isNotEmpty || firstNameMr.isNotEmpty) && dateOfBirth.isNotEmpty) {
      score += 15;
    }

    // 2. Current Address & Location (15%)
    if (district.isNotEmpty && subDistrict.isNotEmpty && (address.isNotEmpty || addressMr.isNotEmpty) && pincode.isNotEmpty) {
      score += 15;
    }

    // 3. Photo (15%)
    if ((photoBase64 != null && photoBase64!.isNotEmpty) || (photoUrl != null && photoUrl!.isNotEmpty)) {
      score += 15;
    }

    // 4. Blood Group (10%)
    if (bloodGroup.isNotEmpty) {
      score += 10;
    }

    // 5. Emergency Contact (10%)
    if (emergencyContactName.trim().isNotEmpty && emergencyContactPhone.trim().isNotEmpty) {
      score += 10;
    }

    // 6. Native Village Address (10%)
    if (isNativeAddressSameAsCurrent || (nativeDistrict.isNotEmpty && nativeTaluka.isNotEmpty)) {
      score += 10;
    }

    // 7. Political Status Answered (10%)
    if (isPoliticallyActive != null) {
      if (!isPoliticallyActive! || (politicalParty.trim().isNotEmpty && politicalRole.trim().isNotEmpty)) {
        score += 10;
      }
    }

    // 8. Social / NGO Involvement Answered (5%)
    if (isAssociatedWithNgo != null) {
      if (!isAssociatedWithNgo! || (ngoName.trim().isNotEmpty && ngoRole.trim().isNotEmpty)) {
        score += 5;
      }
    }

    // 9. Organ Donation Pledge Answered (5%)
    if (hasOrganDonationConsentAnswered || isOrganDonorPledged) {
      score += 5;
    }

    // 10. Occupation Details (5%)
    final occ = (profession.isNotEmpty ? profession : living).toLowerCase().trim();
    if (occ.contains('बेरोजगार') || occ.contains('unemployed') || occ.contains('शोधत')) {
      if (unemployedEducation.isNotEmpty || unemployedPreferredSector.isNotEmpty) score += 5;
    } else if (occ.contains('job') || occ.contains('नोकरी') || (occ.contains('employed') && !occ.contains('unemployed'))) {
      if (jobDesignation.isNotEmpty || jobCompany.isNotEmpty) score += 5;
    } else if (occ.contains('business') || occ.contains('व्यवसाय') || occ.contains('स्वयंरोजगार')) {
      if (businessType.isNotEmpty) score += 5;
    } else if (occ.contains('student') || occ.contains('विद्यार्थी') || occ.contains('शिक्षण')) {
      if (educationLevel.isNotEmpty || education.isNotEmpty) score += 5;
    } else if (occ.contains('farm') || occ.contains('शेती') || occ.contains('शेतकरी')) {
      if (cropsProduced.isNotEmpty) score += 5;
    } else if (occ.isNotEmpty) {
      score += 5;
    }

    return (score / total).clamp(0.0, 1.0);
  }

  bool get isProfileComplete => completionProgress >= 1.0;

  List<String> get missingItems {
    final List<String> list = [];
    if ((fullNameMr.isEmpty && fullNameEn.isEmpty && firstName.isEmpty && firstNameMr.isEmpty) || dateOfBirth.isEmpty) {
      list.add('मूलभूत माहिती (नाव, जन्मतारीख)');
    }
    if (district.isEmpty || subDistrict.isEmpty || (address.isEmpty && addressMr.isEmpty) || pincode.isEmpty) {
      list.add('सध्याचा पत्ता (जिल्हा, तालुका, पिनकोड)');
    }
    if ((photoBase64 == null || photoBase64!.isEmpty) && (photoUrl == null || photoUrl!.isEmpty)) {
      list.add('पासपोर्ट आकाराचा फोटो (Photo)');
    }
    if (bloodGroup.isEmpty) {
      list.add('रक्तगट (Blood Group)');
    }
    if (emergencyContactName.trim().isEmpty || emergencyContactPhone.trim().isEmpty) {
      list.add('आपत्कालीन संपर्क (Emergency Contact)');
    }
    if (!isNativeAddressSameAsCurrent && (nativeDistrict.isEmpty || nativeTaluka.isEmpty)) {
      list.add('मूळ गाव पत्ता (Native Village Address)');
    }
    if (isPoliticallyActive == null || (isPoliticallyActive! && (politicalParty.trim().isEmpty || politicalRole.trim().isEmpty))) {
      list.add('राजकीय सहभाग (Political Details)');
    }
    if (isAssociatedWithNgo == null || (isAssociatedWithNgo! && (ngoName.trim().isEmpty || ngoRole.trim().isEmpty))) {
      list.add('सामाजिक संस्था सहभाग (NGO Details)');
    }
    if (!hasOrganDonationConsentAnswered && !isOrganDonorPledged) {
      list.add('मरणोत्तर अवयवदान संकल्प (Organ Pledge)');
    }

    final occ = (profession.isNotEmpty ? profession : living).toLowerCase().trim();
    if (occ.contains('बेरोजगार') || occ.contains('unemployed') || occ.contains('शोधत')) {
      if (unemployedEducation.isEmpty && unemployedPreferredSector.isEmpty) {
        list.add('रोजगार सहाय्य माहिती (Career Assistance)');
      }
    } else if (occ.contains('job') || occ.contains('नोकरी') || (occ.contains('employed') && !occ.contains('unemployed'))) {
      if (jobDesignation.isEmpty && jobCompany.isEmpty) {
        list.add('नोकरी तपशील (Job Details)');
      }
    } else if (occ.contains('business') || occ.contains('व्यवसाय') || occ.contains('स्वयंरोजगार')) {
      if (businessType.isEmpty) {
        list.add('व्यवसाय तपशील (Business Details)');
      }
    } else if (occ.contains('student') || occ.contains('विद्यार्थी') || occ.contains('शिक्षण')) {
      if (educationLevel.isEmpty && education.isEmpty) {
        list.add('शिक्षण माहिती (Education)');
      }
    } else if (occ.contains('farm') || occ.contains('शेती') || occ.contains('शेतकरी')) {
      if (cropsProduced.isEmpty) {
        list.add('पिकवत असलेली पिके (Crops Produced)');
      }
    }

    return list;
  }

  factory MemberProfile.fromFirestore(String phone, Map<String, dynamic> data) {
    // Nested sections extractors (supports both new nested maps and legacy flat documents)
    Map<String, dynamic> getSection(String key) {
      final val = data[key];
      if (val is Map<String, dynamic>) return val;
      if (val is Map) return Map<String, dynamic>.from(val);
      return const <String, dynamic>{};
    }

    final personal = getSection('personal');
    final residence = getSection('residence');
    final nativePlace = getSection('native_place');
    final occupation = getSection('occupation');
    final emergency = getSection('emergency');
    final affiliations = getSection('affiliations');
    final pledges = getSection('pledges');
    final official = getSection('official');
    final media = getSection('media');
    final membership = getSection('membership');

    final jobDetails = getSectionFrom(occupation, 'job_details');
    final businessDetails = getSectionFrom(occupation, 'business_details');
    final studentDetails = getSectionFrom(occupation, 'student_details');
    final farmingDetails = getSectionFrom(occupation, 'farming_details');
    final unemployedDetails = getSectionFrom(occupation, 'unemployed_details');

    String distEn = residence['district_en'] as String? ??
        data['district_en'] as String? ??
        data['district'] as String? ??
        '';
    String distMr = residence['district_mr'] as String? ??
        data['district_mr'] as String? ??
        '';
    String distCode = residence['district_code'] as String? ??
        data['district_code'] as String? ??
        '';

    if (distEn.isEmpty && distMr.isNotEmpty) {
      distEn = DistrictConstants.getNameEn(distMr);
      if (distCode.isEmpty) distCode = DistrictConstants.getCode(distMr);
    } else if (distMr.isEmpty && distEn.isNotEmpty) {
      distMr = DistrictConstants.getNameMr(distEn);
      if (distCode.isEmpty) distCode = DistrictConstants.getCode(distEn);
    }

    final rawStateEn = residence['state_en'] as String? ?? data['state_en'] as String? ?? data['state'] as String? ?? '';
    final rawStateCode = residence['state_code'] as String? ?? data['state_code'] as String? ?? '';
    final stateInfo = GeoConstants.findState(rawStateEn.isNotEmpty ? rawStateEn : rawStateCode);
    final stateEn = rawStateEn.isNotEmpty ? rawStateEn : (stateInfo?.nameEn ?? '');
    String rawStateMr = residence['state_mr'] as String? ?? data['state_mr'] as String? ?? '';
    if ((rawStateMr.isEmpty || (rawStateMr == distMr && distEn.toLowerCase() != rawStateEn.toLowerCase())) && stateInfo != null && rawStateEn.isNotEmpty) {
      rawStateMr = stateInfo.nameMr;
    }

    final rawTalukaEn = residence['taluka_en'] as String? ??
        data['taluka_en'] as String? ??
        data['sub_district'] as String? ??
        data['subDistrict'] as String? ??
        data['taluka'] as String? ??
        '';

    final matchedTaluka = (distEn.isNotEmpty && stateInfo != null)
        ? stateInfo.districts
            .firstWhere(
              (d) => d.code.toLowerCase() == distCode.toLowerCase() || d.nameEn.toLowerCase() == distEn.toLowerCase() || d.nameMr == distMr,
              orElse: () => DistrictInfo(code: distCode, nameEn: distEn, nameMr: distMr),
            )
            .talukas
            .firstWhere(
              (t) => t.nameEn.toLowerCase() == rawTalukaEn.toLowerCase() || t.nameMr == rawTalukaEn,
              orElse: () => TalukaInfo(nameEn: rawTalukaEn, nameMr: rawTalukaEn),
            )
        : TalukaInfo(nameEn: rawTalukaEn, nameMr: rawTalukaEn);

    String rawTalukaMr = residence['taluka_mr'] as String? ?? data['taluka_mr'] as String? ?? '';
    if ((rawTalukaMr.isEmpty || (rawTalukaMr == distMr && rawTalukaEn.toLowerCase() != distEn.toLowerCase())) && rawTalukaEn.isNotEmpty) {
      rawTalukaMr = matchedTaluka.nameMr;
    }

    final rawNativeStateEn = nativePlace['state_en'] as String? ?? nativePlace['state'] as String? ?? data['native_state'] as String? ?? '';
    final rawNativeStateCode = nativePlace['state_code'] as String? ?? data['native_state_code'] as String? ?? '';
    final nativeStateInfo = GeoConstants.findState(rawNativeStateEn.isNotEmpty ? rawNativeStateEn : rawNativeStateCode);
    final nativeStateEn = rawNativeStateEn.isNotEmpty ? rawNativeStateEn : (nativeStateInfo?.nameEn ?? '');

    final nativeDistEn = nativePlace['district_en'] as String? ?? nativePlace['district'] as String? ?? data['native_district'] as String? ?? '';
    final nativeDistMr = nativePlace['district_mr'] as String? ?? data['native_district_mr'] as String? ?? (nativeDistEn.isNotEmpty ? DistrictConstants.getNameMr(nativeDistEn) : '');

    String rawNativeStateMr = nativePlace['state_mr'] as String? ?? data['native_state_mr'] as String? ?? '';
    if ((rawNativeStateMr.isEmpty || (rawNativeStateMr == nativeDistMr && nativeDistEn.toLowerCase() != rawNativeStateEn.toLowerCase())) && nativeStateInfo != null && rawNativeStateEn.isNotEmpty) {
      rawNativeStateMr = nativeStateInfo.nameMr;
    }
    final nativeStateMr = rawNativeStateMr.isNotEmpty ? rawNativeStateMr : (nativeStateInfo?.nameMr ?? '');

    final rawNativeTalukaEn = nativePlace['taluka_en'] as String? ?? nativePlace['taluka'] as String? ?? data['native_taluka'] as String? ?? '';
    final matchedNativeTaluka = (nativeDistEn.isNotEmpty && nativeStateInfo != null)
        ? nativeStateInfo.districts
            .firstWhere(
              (d) => d.nameEn.toLowerCase() == nativeDistEn.toLowerCase() || d.nameMr == nativeDistEn || d.nameMr == nativeDistMr,
              orElse: () => DistrictInfo(code: '', nameEn: nativeDistEn, nameMr: nativeDistMr),
            )
            .talukas
            .firstWhere(
              (t) => t.nameEn.toLowerCase() == rawNativeTalukaEn.toLowerCase() || t.nameMr == rawNativeTalukaEn,
              orElse: () => TalukaInfo(nameEn: rawNativeTalukaEn, nameMr: rawNativeTalukaEn),
            )
        : TalukaInfo(nameEn: rawNativeTalukaEn, nameMr: rawNativeTalukaEn);
    String rawNativeTalukaMr = nativePlace['taluka_mr'] as String? ?? data['native_taluka_mr'] as String? ?? '';
    if ((rawNativeTalukaMr.isEmpty || (rawNativeTalukaMr == nativeDistMr && rawNativeTalukaEn.toLowerCase() != nativeDistEn.toLowerCase())) && rawNativeTalukaEn.isNotEmpty) {
      rawNativeTalukaMr = matchedNativeTaluka.nameMr;
    }
    final nativeTalukaMr = rawNativeTalukaMr;

    final nativeVillageEn = nativePlace['village_en'] as String? ?? nativePlace['village'] as String? ?? data['native_village'] as String? ?? '';
    final nativeVillageMr = nativePlace['village_mr'] as String? ?? data['native_village_mr'] as String? ?? '';

    final nativeAddressEn = nativePlace['address_en'] as String? ?? nativePlace['address'] as String? ?? data['native_address'] as String? ?? '';
    final nativeAddressMr = nativePlace['address_mr'] as String? ?? data['native_address_mr'] as String? ?? '';

    final memId = membership['member_id'] as String? ?? data['member_id'] as String?;
    final isIssued = membership['is_card_issued'] as bool? ??
        data['is_card_issued'] as bool? ??
        (memId != null &&
            memId != 'PENDING' &&
            memId.toString().trim().isNotEmpty);

    List<String> parsedCrops = [];
    final rawCrops = farmingDetails['crops_produced'] ?? data['crops_produced'];
    if (rawCrops != null) {
      if (rawCrops is List) {
        parsedCrops = rawCrops.map((e) => e.toString()).toList();
      } else if (rawCrops is String && rawCrops.isNotEmpty) {
        parsedCrops = rawCrops.split(',').map((s) => s.trim()).toList();
      }
    }

    return MemberProfile(
      phone: phone,
      firstName: personal['first_name_en'] as String? ??
          data['first_name_en'] as String? ??
          data['first_name'] as String? ??
          data['firstName'] as String? ??
          '',
      middleName: personal['middle_name_en'] as String? ??
          data['middle_name_en'] as String? ??
          data['middle_name'] as String? ??
          data['middleName'] as String? ??
          '',
      lastName: personal['last_name_en'] as String? ??
          data['last_name_en'] as String? ??
          data['last_name'] as String? ??
          data['lastName'] as String? ??
          '',
      firstNameMr: personal['first_name_mr'] as String? ??
          data['first_name_mr'] as String? ??
          data['firstName_mr'] as String? ??
          '',
      middleNameMr: personal['middle_name_mr'] as String? ??
          data['middle_name_mr'] as String? ??
          '',
      lastNameMr: personal['last_name_mr'] as String? ??
          data['last_name_mr'] as String? ??
          data['lastName_mr'] as String? ??
          '',
      fullNameEnOverride: personal['full_name_en'] as String? ??
          data['full_name_en'] as String? ??
          data['name'] as String? ??
          '',
      fullNameMrOverride: personal['full_name_mr'] as String? ??
          data['full_name_mr'] as String? ??
          data['name_mr'] as String? ??
          '',
      dateOfBirth: personal['date_of_birth'] as String? ??
          data['date_of_birth'] as String? ??
          data['dateOfBirth'] as String? ??
          '',
      gender: BilingualHelper.normalizeGenderToEn(
          personal['gender'] as String? ?? data['gender'] as String? ?? ''),
      address: residence['address_en'] as String? ??
          data['address'] as String? ??
          '',
      addressMr: residence['address_mr'] as String? ??
          data['address_mr'] as String? ??
          data['addressMr'] as String? ??
          '',
      city: residence['village_en'] as String? ??
          data['city'] as String? ??
          '',
      village: residence['village_en'] as String? ??
          data['village'] as String? ??
          '',
      villageMr: residence['village_mr'] as String? ??
          data['village_mr'] as String? ??
          '',
      state: stateEn,
      stateMr: rawStateMr,
      stateCode: rawStateCode.isNotEmpty ? rawStateCode : (stateInfo?.code ?? ''),
      district: distEn,
      districtCode: distCode,
      districtEn: distEn,
      districtMr: distMr,
      subDistrict: rawTalukaEn,
      subDistrictMr: rawTalukaMr,
      pincode: residence['pincode'] as String? ??
          data['pincode'] as String? ??
          '',
      email: personal['email'] as String? ??
          data['email'] as String? ??
          '',
      living: personal['living_status'] as String? ??
          data['living'] as String? ??
          '',
      profession: occupation['category_mr'] as String? ??
          occupation['category'] as String? ??
          data['profession'] as String? ??
          data['living'] as String? ??
          '',
      education: studentDetails['qualification'] as String? ??
          data['education'] as String? ??
          '',
      bloodGroup: emergency['blood_group'] as String? ??
          data['blood_group'] as String? ??
          data['bloodGroup'] as String? ??
          '',
      emergencyContactName: emergency['contact_name'] as String? ??
          data['emergency_contact_name'] as String? ??
          '',
      emergencyContactPhone: emergency['contact_phone'] as String? ??
          data['emergency_contact_phone'] as String? ??
          '',

      isNativeAddressSameAsCurrent: nativePlace['is_same_as_current'] as bool? ??
          data['is_native_address_same'] as bool? ??
          false,
      nativeAddress: nativeAddressEn,
      nativeAddressMr: nativeAddressMr,
      nativeState: nativeStateEn,
      nativeStateMr: nativeStateMr,
      nativeStateCode: rawNativeStateCode.isNotEmpty ? rawNativeStateCode : (nativeStateInfo?.code ?? ''),
      nativeDistrict: nativeDistEn,
      nativeDistrictMr: nativeDistMr,
      nativeTaluka: rawNativeTalukaEn,
      nativeTalukaMr: nativeTalukaMr,
      nativeVillage: nativeVillageEn,
      nativeVillageMr: nativeVillageMr,
      nativePincode: nativePlace['pincode'] as String? ??
          data['native_pincode'] as String? ??
          '',

      isPoliticallyActive: affiliations['is_politically_active'] as bool? ??
          data['is_politically_active'] as bool?,
      politicalParty: (affiliations['is_politically_active'] == true || data['is_politically_active'] == true)
          ? (affiliations['political_party'] as String? ?? data['political_party'] as String? ?? '')
          : '',
      politicalRole: (affiliations['is_politically_active'] == true || data['is_politically_active'] == true)
          ? (affiliations['political_role'] as String? ?? data['political_role'] as String? ?? '')
          : '',

      isAssociatedWithNgo: affiliations['is_associated_with_ngo'] as bool? ??
          data['is_associated_with_ngo'] as bool?,
      ngoName: (affiliations['is_associated_with_ngo'] == true || data['is_associated_with_ngo'] == true)
          ? (affiliations['ngo_name'] as String? ?? data['ngo_name'] as String? ?? '')
          : '',
      ngoRole: (affiliations['is_associated_with_ngo'] == true || data['is_associated_with_ngo'] == true)
          ? (affiliations['ngo_role'] as String? ?? data['ngo_role'] as String? ?? '')
          : '',

      isOrganDonorPledged: pledges['is_organ_donor_pledged'] as bool? ??
          data['is_organ_donor_pledged'] as bool? ??
          false,
      hasOrganDonationConsentAnswered: pledges['has_answered_organ_donation'] as bool? ??
          data['has_organ_donation_answered'] as bool? ??
          (pledges['is_organ_donor_pledged'] != null || data['is_organ_donor_pledged'] != null),

      jobDesignation: jobDetails['designation'] as String? ??
          data['job_designation'] as String? ??
          '',
      jobCompany: jobDetails['company'] as String? ??
          data['job_company'] as String? ??
          '',
      businessType: businessDetails['business_type'] as String? ??
          data['business_type'] as String? ??
          '',
      educationLevel: studentDetails['qualification'] as String? ??
          data['education_level'] as String? ??
          '',
      educationOther: studentDetails['qualification_other'] as String? ??
          data['education_other'] as String? ??
          '',
      cropsProduced: parsedCrops,
      unemployedEducation: unemployedDetails['highest_qualification'] as String? ??
          data['unemployed_education'] as String? ??
          '',
      unemployedPreferredSector: unemployedDetails['preferred_sector'] as String? ??
          data['unemployed_preferred_sector'] as String? ??
          '',
      unemployedSkills: unemployedDetails['skills_and_licenses'] as String? ??
          data['unemployed_skills'] as String? ??
          '',
      willingToRelocate: unemployedDetails['willing_to_relocate'] as bool? ??
          data['willing_to_relocate'] as bool?,

      roleType: membership['role_type'] as String? ??
          data['role_type'] as String? ??
          'member',
      designation: membership['designation'] as String? ??
          data['designation'] as String? ??
          '',
      isOfficial: official['is_official'] as bool? ??
          data['is_official'] as bool? ??
          false,
      officialLevel: official['level'] as String? ?? data['official_level'] as String?,
      officialRoleCode: official['role_code'] as String? ?? data['official_role_code'] as String?,
      officialRoleMr: official['role_name_mr'] as String? ?? data['official_role_mr'] as String?,
      officialRoleEn: official['role_name_en'] as String? ?? data['official_role_en'] as String?,
      officialFullTitleMr: official['full_title_mr'] as String? ?? data['official_full_title_mr'] as String?,
      officialFullTitleEn: official['full_title_en'] as String? ?? data['official_full_title_en'] as String?,
      officialVibhag: official['jurisdiction_vibhag'] as String? ?? data['official_vibhag'] as String?,
      officialDistrict: official['jurisdiction_district'] as String? ?? data['official_district'] as String?,
      officialTaluka: official['jurisdiction_taluka'] as String? ?? data['official_taluka'] as String?,
      photoBase64: media['photo_base64'] as String? ?? data['photo_base64'] as String? ?? data['photo'] as String?,
      photoUrl: media['photo_url'] as String? ?? data['photo_url'] as String?,
      memberId: memId,
      referralId: membership['referral_id'] as String? ?? data['referral_id'] as String? ?? 'NONE',
      isCardIssued: isIssued,
      isRegistered: membership['is_registered'] as bool? ?? data['is_registered'] as bool? ?? true,
      isValid: membership['is_valid'] as bool? ?? data['is_valid'] as bool? ?? true,
      cardIssuedDate: _parseDateTime(membership['card_issued_date'] ?? data['card_issued_date']),
      createdAt: _parseDateTime(data['created_at'] ?? membership['created_at']),
      updatedAt: _parseDateTime(data['updated_at'] ?? membership['updated_at']),
    );
  }

  static Map<String, dynamic> getSectionFrom(Map<String, dynamic> parent, String key) {
    final val = parent[key];
    if (val is Map<String, dynamic>) return val;
    if (val is Map) return Map<String, dynamic>.from(val);
    return const <String, dynamic>{};
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    return null;
  }

  /// Converts the profile into the clean, nested Firestore structure
  Map<String, dynamic> toFirestore() {
    final occRaw = (profession.isNotEmpty ? profession : living).trim();
    final occLower = occRaw.toLowerCase();

    final isUnemployed = occLower.contains('बेरोजगार') ||
        occLower.contains('unemployed') ||
        occLower.contains('शोधत') ||
        occLower == 'job-seeker';
    final isSelfEmployed = occLower.contains('स्वयंरोजगार') || occLower.contains('self-employed');
    final isJob = (occLower.contains('नोकरी') || occLower.contains('employed') || occLower == 'job') && !isUnemployed;
    final isBusiness = occLower.contains('व्यवसाय') || occLower.contains('business');
    final isStudent = occLower.contains('विद्यार्थी') || occLower.contains('student') || occLower.contains('शिक्षण');
    final isFarmer = occLower.contains('शेती') || occLower.contains('farmer') || occLower.contains('शेतकरी');
    final isRetired = occLower.contains('निवृत्त') || occLower.contains('retired');
    final isHomemaker = occLower.contains('गृह') || occLower.contains('homemaker');

    String occCategory = 'other';
    if (isSelfEmployed) {
      occCategory = 'self_employed';
    } else if (isJob) {
      occCategory = 'job';
    } else if (isBusiness) {
      occCategory = 'business';
    } else if (isStudent) {
      occCategory = 'student';
    } else if (isFarmer) {
      occCategory = 'farmer';
    } else if (isUnemployed) {
      occCategory = 'unemployed';
    } else if (isRetired) {
      occCategory = 'retired';
    } else if (isHomemaker) {
      occCategory = 'homemaker';
    }

    final Map<String, dynamic> occMap = {
      'category': occCategory,
      'category_mr': occRaw,
    };

    if (isJob || isSelfEmployed) {
      if (jobDesignation.isNotEmpty || jobCompany.isNotEmpty || !isSelfEmployed) {
        occMap['job_details'] = {
          'designation': jobDesignation,
          'company': jobCompany,
        };
      }
    }
    if (isBusiness || isSelfEmployed) {
      if (businessType.isNotEmpty || !isSelfEmployed) {
        occMap['business_details'] = {
          'business_type': businessType,
        };
      }
    }
    if (isStudent) {
      occMap['student_details'] = {
        'qualification': educationLevel.isNotEmpty ? educationLevel : education,
        'qualification_other': educationOther,
      };
    }
    if (isFarmer || cropsProduced.isNotEmpty) {
      occMap['farming_details'] = {
        'crops_produced': cropsProduced,
      };
    }
    if (isUnemployed) {
      occMap['unemployed_details'] = {
        'highest_qualification': unemployedEducation,
        if (unemployedEducation.startsWith('Other') || unemployedEducation.startsWith('इतर'))
          'qualification_other': unemployedEducation,
        'preferred_sector': unemployedPreferredSector,
        'skills_and_licenses': unemployedSkills,
        'willing_to_relocate': willingToRelocate ?? true,
      };
    }

    final stateObj = GeoConstants.findState(state.isNotEmpty ? state : stateCode);
    final stateEnVal = state.isNotEmpty ? state : (stateObj?.nameEn ?? '');
    final stateMrVal = (stateMr.isNotEmpty && stateMr != districtMr) ? stateMr : (stateObj?.nameMr ?? '');
    final stateCodeVal = stateCode.isNotEmpty ? stateCode : (stateObj?.code ?? '');

    final distObj = (district.isNotEmpty || districtEn.isNotEmpty || districtMr.isNotEmpty || districtCode.isNotEmpty) && stateObj != null
        ? stateObj.districts.firstWhere(
            (d) =>
                d.code.toLowerCase() == districtCode.toLowerCase() ||
                d.nameEn.toLowerCase() == districtEn.toLowerCase() ||
                d.nameEn.toLowerCase() == district.toLowerCase() ||
                d.nameMr == districtMr,
            orElse: () => DistrictInfo(code: districtCode, nameEn: districtEn.isNotEmpty ? districtEn : district, nameMr: districtMr),
          )
        : null;
    final distEnVal = districtEn.isNotEmpty ? districtEn : (distObj?.nameEn ?? (district.isNotEmpty ? district : ''));
    final distMrVal = districtMr.isNotEmpty ? districtMr : (distObj?.nameMr ?? '');
    final distCodeVal = districtCode.isNotEmpty ? districtCode : (distObj?.code ?? '');

    final talukaObj = distObj != null && (subDistrict.isNotEmpty || subDistrictMr.isNotEmpty)
        ? distObj.talukas.firstWhere(
            (t) =>
                t.nameEn.toLowerCase() == subDistrict.toLowerCase() ||
                t.nameMr == subDistrict ||
                (subDistrictMr.isNotEmpty && t.nameMr == subDistrictMr),
            orElse: () => TalukaInfo(
              nameEn: subDistrict,
              nameMr: subDistrictMr.isNotEmpty ? subDistrictMr : subDistrict,
            ),
          )
        : null;
    final talukaEnVal = subDistrict.isNotEmpty ? subDistrict : (talukaObj?.nameEn ?? '');
    final talukaMrVal = (subDistrictMr.isNotEmpty && subDistrictMr != districtMr)
        ? subDistrictMr
        : (talukaObj?.nameMr ?? '');

    final nativeStateObj = GeoConstants.findState(nativeState.isNotEmpty ? nativeState : nativeStateCode);
    final nativeStateEnVal = nativeState.isNotEmpty ? nativeState : (nativeStateObj?.nameEn ?? '');
    final nativeStateMrVal = nativeStateMr.isNotEmpty ? nativeStateMr : (nativeStateObj?.nameMr ?? '');
    final nativeStateCodeVal = nativeStateCode.isNotEmpty ? nativeStateCode : (nativeStateObj?.code ?? '');

    final nativeDistObj = (nativeDistrict.isNotEmpty || nativeDistrictMr.isNotEmpty)
        ? (nativeStateObj != null
            ? nativeStateObj.districts.firstWhere(
                (d) =>
                    d.nameEn.toLowerCase() == nativeDistrict.toLowerCase() ||
                    d.nameMr == nativeDistrict ||
                    (nativeDistrictMr.isNotEmpty && d.nameMr == nativeDistrictMr),
                orElse: () => DistrictInfo(code: '', nameEn: nativeDistrict, nameMr: nativeDistrictMr.isNotEmpty ? nativeDistrictMr : nativeDistrict),
              )
            : DistrictConstants.districts.firstWhere(
                (d) =>
                    d.nameEn.toLowerCase() == nativeDistrict.toLowerCase() ||
                    d.code.toLowerCase() == nativeDistrict.toLowerCase() ||
                    d.nameMr == nativeDistrict ||
                    (nativeDistrictMr.isNotEmpty && d.nameMr == nativeDistrictMr),
                orElse: () => DistrictInfo(code: '', nameEn: nativeDistrict, nameMr: nativeDistrictMr.isNotEmpty ? nativeDistrictMr : nativeDistrict),
              ))
        : null;
    final nativeDistEnVal = nativeDistrict.isNotEmpty ? nativeDistrict : (nativeDistObj?.nameEn ?? '');
    final nativeDistMrVal = nativeDistrictMr.isNotEmpty ? nativeDistrictMr : (nativeDistObj?.nameMr ?? '');

    final nativeTalukaObj = nativeDistObj != null && (nativeTaluka.isNotEmpty || nativeTalukaMr.isNotEmpty)
        ? nativeDistObj.talukas.firstWhere(
            (t) =>
                t.nameEn.toLowerCase() == nativeTaluka.toLowerCase() ||
                t.nameMr == nativeTaluka ||
                (nativeTalukaMr.isNotEmpty && t.nameMr == nativeTalukaMr),
            orElse: () => TalukaInfo(nameEn: nativeTaluka, nameMr: nativeTalukaMr.isNotEmpty ? nativeTalukaMr : nativeTaluka),
          )
        : null;
    final nativeTalukaEnVal = nativeTaluka.isNotEmpty ? nativeTaluka : (nativeTalukaObj?.nameEn ?? '');
    final nativeTalukaMrVal = nativeTalukaMr.isNotEmpty ? nativeTalukaMr : (nativeTalukaObj?.nameMr ?? '');

    final Map<String, dynamic> nativeMap = {
      'is_same_as_current': isNativeAddressSameAsCurrent,
      'address': isNativeAddressSameAsCurrent ? '' : nativeAddress,
      'address_en': isNativeAddressSameAsCurrent ? '' : nativeAddress,
      'address_mr': isNativeAddressSameAsCurrent
          ? ''
          : (nativeAddressMr.isNotEmpty ? nativeAddressMr : (nativeAddress.isNotEmpty ? BilingualHelper.transliterateToMarathi(nativeAddress) : '')),
      'village': isNativeAddressSameAsCurrent ? '' : nativeVillage,
      'village_en': isNativeAddressSameAsCurrent ? '' : nativeVillage,
      'village_mr': isNativeAddressSameAsCurrent
          ? ''
          : (nativeVillageMr.isNotEmpty ? nativeVillageMr : (nativeVillage.isNotEmpty ? BilingualHelper.transliterateToMarathi(nativeVillage) : '')),
      'taluka': isNativeAddressSameAsCurrent ? '' : (nativeTaluka.isNotEmpty ? nativeTalukaEnVal : ''),
      'taluka_en': isNativeAddressSameAsCurrent ? '' : (nativeTaluka.isNotEmpty ? nativeTalukaEnVal : ''),
      'taluka_mr': isNativeAddressSameAsCurrent ? '' : ((nativeTaluka.isNotEmpty || nativeTalukaMr.isNotEmpty) ? nativeTalukaMrVal : ''),
      'district': isNativeAddressSameAsCurrent ? '' : (nativeDistrict.isNotEmpty ? nativeDistEnVal : ''),
      'district_en': isNativeAddressSameAsCurrent ? '' : (nativeDistrict.isNotEmpty ? nativeDistEnVal : ''),
      'district_mr': isNativeAddressSameAsCurrent ? '' : ((nativeDistrict.isNotEmpty || nativeDistrictMr.isNotEmpty) ? nativeDistMrVal : ''),
      'state': isNativeAddressSameAsCurrent ? '' : (nativeState.isNotEmpty ? nativeStateEnVal : ''),
      'state_en': isNativeAddressSameAsCurrent ? '' : (nativeState.isNotEmpty ? nativeStateEnVal : ''),
      'state_mr': isNativeAddressSameAsCurrent ? '' : (nativeState.isNotEmpty ? nativeStateMrVal : ''),
      'state_code': isNativeAddressSameAsCurrent ? '' : (nativeState.isNotEmpty ? nativeStateCodeVal : ''),
      'pincode': isNativeAddressSameAsCurrent ? '' : nativePincode,
    };

    final bool polActive = isPoliticallyActive == true;
    final bool ngoActive = isAssociatedWithNgo == true;
    final Map<String, dynamic> affiliationsMap = {
      'is_politically_active': isPoliticallyActive,
      'political_party': polActive ? politicalParty : '',
      'political_role': polActive ? politicalRole : '',
      'is_associated_with_ngo': isAssociatedWithNgo,
      'ngo_name': ngoActive ? ngoName : '',
      'ngo_role': ngoActive ? ngoRole : '',
    };

    final Map<String, dynamic> officialMap = {
      'is_official': isOfficial,
      if (isOfficial) ...{
        if (officialLevel != null) 'level': officialLevel,
        if (officialRoleCode != null) 'role_code': officialRoleCode,
        if (officialRoleMr != null) 'role_name_mr': officialRoleMr,
        if (officialRoleEn != null) 'role_name_en': officialRoleEn,
        if (officialFullTitleMr != null) 'full_title_mr': officialFullTitleMr,
        if (officialFullTitleEn != null) 'full_title_en': officialFullTitleEn,
        if (officialVibhag != null) 'jurisdiction_vibhag': officialVibhag,
        if (officialDistrict != null) 'jurisdiction_district': officialDistrict,
        if (officialTaluka != null) 'jurisdiction_taluka': officialTaluka,
      },
    };

    return {
      'personal': {
        'first_name_en': firstName,
        'first_name_mr': firstNameMr,
        'middle_name_en': middleName,
        'middle_name_mr': middleNameMr,
        'last_name_en': lastName,
        'last_name_mr': lastNameMr,
        'full_name_en': fullNameEn,
        'full_name_mr': fullNameMr,
        'date_of_birth': dateOfBirth,
        'gender': gender.isNotEmpty ? BilingualHelper.normalizeGenderToEn(gender) : null,
        'email': email,
        'living_status': living.isNotEmpty ? living : null,
      },
      'residence': {
        'address_en': address,
        'address_mr': addressMr.isNotEmpty ? addressMr : BilingualHelper.transliterateToMarathi(address),
        'village_en': village.isNotEmpty ? village : city,
        'village_mr': villageMr.isNotEmpty ? villageMr : BilingualHelper.transliterateToMarathi(village.isNotEmpty ? village : city),
        'taluka_en': talukaEnVal,
        'taluka_mr': talukaMrVal,
        'district_en': distEnVal,
        'district_mr': distMrVal,
        'district_code': distCodeVal,
        'state_en': stateEnVal,
        'state_mr': stateMrVal,
        'state_code': stateCodeVal,
        'pincode': pincode,
      },
      'native_place': nativeMap,
      'occupation': occMap,
      'emergency': {
        'blood_group': bloodGroup.isNotEmpty ? bloodGroup : null,
        'contact_name': emergencyContactName.isNotEmpty ? emergencyContactName : null,
        'contact_phone': emergencyContactPhone.isNotEmpty ? emergencyContactPhone : null,
      },
      'affiliations': affiliationsMap,
      'pledges': {
        'has_answered_organ_donation': hasOrganDonationConsentAnswered,
        'is_organ_donor_pledged': isOrganDonorPledged,
      },
      'official': officialMap,
      'media': {
        if (photoBase64 != null) 'photo_base64': photoBase64,
        if (photoUrl != null) 'photo_url': photoUrl,
      },
      'membership': {
        'phone': phone,
        'member_id': memberId ?? 'PENDING',
        'referral_id': referralId ?? 'NONE',
        'role_type': roleType,
        'designation': designation,
        'is_registered': isRegistered,
        'is_profile_complete': isProfileComplete,
        'is_card_issued': isCardIssued,
        if (cardIssuedDate != null) 'card_issued_date': cardIssuedDate,
        'is_valid': isValid,
      },
      'updated_at': FieldValue.serverTimestamp(),
    };
  }

  MemberProfile copyWith({
    String? phone,
    String? firstName,
    String? middleName,
    String? lastName,
    String? firstNameMr,
    String? middleNameMr,
    String? lastNameMr,
    String? fullNameEnOverride,
    String? fullNameMrOverride,
    String? dateOfBirth,
    String? gender,
    String? address,
    String? addressMr,
    String? city,
    String? village,
    String? villageMr,
    String? state,
    String? stateMr,
    String? stateCode,
    String? district,
    String? districtCode,
    String? districtEn,
    String? districtMr,
    String? subDistrict,
    String? subDistrictMr,
    String? pincode,
    String? email,
    String? living,
    String? profession,
    String? education,
    String? bloodGroup,
    String? emergencyContactName,
    String? emergencyContactPhone,
    bool? isNativeAddressSameAsCurrent,
    String? nativeAddress,
    String? nativeAddressMr,
    String? nativeState,
    String? nativeStateMr,
    String? nativeStateCode,
    String? nativeDistrict,
    String? nativeDistrictMr,
    String? nativeTaluka,
    String? nativeTalukaMr,
    String? nativeVillage,
    String? nativeVillageMr,
    String? nativePincode,
    bool? isPoliticallyActive,
    String? politicalParty,
    String? politicalRole,
    bool? isAssociatedWithNgo,
    String? ngoName,
    String? ngoRole,
    bool? isOrganDonorPledged,
    bool? hasOrganDonationConsentAnswered,
    String? jobDesignation,
    String? jobCompany,
    String? businessType,
    String? educationLevel,
    String? educationOther,
    List<String>? cropsProduced,
    String? unemployedEducation,
    String? unemployedPreferredSector,
    String? unemployedSkills,
    bool? willingToRelocate,
    String? roleType,
    String? designation,
    String? photoBase64,
    String? photoUrl,
    String? memberId,
    String? referralId,
    bool? isCardIssued,
    bool? isRegistered,
    bool? isValid,
    DateTime? cardIssuedDate,
  }) {
    return MemberProfile(
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      firstNameMr: firstNameMr ?? this.firstNameMr,
      middleNameMr: middleNameMr ?? this.middleNameMr,
      lastNameMr: lastNameMr ?? this.lastNameMr,
      fullNameEnOverride: fullNameEnOverride ?? this.fullNameEnOverride,
      fullNameMrOverride: fullNameMrOverride ?? this.fullNameMrOverride,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      addressMr: addressMr ?? this.addressMr,
      city: city ?? this.city,
      village: village ?? this.village,
      villageMr: villageMr ?? this.villageMr,
      state: state ?? this.state,
      stateMr: stateMr ?? this.stateMr,
      stateCode: stateCode ?? this.stateCode,
      district: district ?? this.district,
      districtCode: districtCode ?? this.districtCode,
      districtEn: districtEn ?? this.districtEn,
      districtMr: districtMr ?? this.districtMr,
      subDistrict: subDistrict ?? this.subDistrict,
      subDistrictMr: subDistrictMr ?? this.subDistrictMr,
      pincode: pincode ?? this.pincode,
      email: email ?? this.email,
      living: living ?? this.living,
      profession: profession ?? this.profession,
      education: education ?? this.education,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactPhone: emergencyContactPhone ?? this.emergencyContactPhone,
      isNativeAddressSameAsCurrent: isNativeAddressSameAsCurrent ?? this.isNativeAddressSameAsCurrent,
      nativeAddress: nativeAddress ?? this.nativeAddress,
      nativeAddressMr: nativeAddressMr ?? this.nativeAddressMr,
      nativeState: nativeState ?? this.nativeState,
      nativeStateMr: nativeStateMr ?? this.nativeStateMr,
      nativeStateCode: nativeStateCode ?? this.nativeStateCode,
      nativeDistrict: nativeDistrict ?? this.nativeDistrict,
      nativeDistrictMr: nativeDistrictMr ?? this.nativeDistrictMr,
      nativeTaluka: nativeTaluka ?? this.nativeTaluka,
      nativeTalukaMr: nativeTalukaMr ?? this.nativeTalukaMr,
      nativeVillage: nativeVillage ?? this.nativeVillage,
      nativeVillageMr: nativeVillageMr ?? this.nativeVillageMr,
      nativePincode: nativePincode ?? this.nativePincode,
      isPoliticallyActive: isPoliticallyActive ?? this.isPoliticallyActive,
      politicalParty: politicalParty ?? this.politicalParty,
      politicalRole: politicalRole ?? this.politicalRole,
      isAssociatedWithNgo: isAssociatedWithNgo ?? this.isAssociatedWithNgo,
      ngoName: ngoName ?? this.ngoName,
      ngoRole: ngoRole ?? this.ngoRole,
      isOrganDonorPledged: isOrganDonorPledged ?? this.isOrganDonorPledged,
      hasOrganDonationConsentAnswered: hasOrganDonationConsentAnswered ?? this.hasOrganDonationConsentAnswered,
      jobDesignation: jobDesignation ?? this.jobDesignation,
      jobCompany: jobCompany ?? this.jobCompany,
      businessType: businessType ?? this.businessType,
      educationLevel: educationLevel ?? this.educationLevel,
      educationOther: educationOther ?? this.educationOther,
      cropsProduced: cropsProduced ?? this.cropsProduced,
      unemployedEducation: unemployedEducation ?? this.unemployedEducation,
      unemployedPreferredSector: unemployedPreferredSector ?? this.unemployedPreferredSector,
      unemployedSkills: unemployedSkills ?? this.unemployedSkills,
      willingToRelocate: willingToRelocate ?? this.willingToRelocate,
      roleType: roleType ?? this.roleType,
      designation: designation ?? this.designation,
      photoBase64: photoBase64 ?? this.photoBase64,
      photoUrl: photoUrl ?? this.photoUrl,
      memberId: memberId ?? this.memberId,
      referralId: referralId ?? this.referralId,
      isCardIssued: isCardIssued ?? this.isCardIssued,
      isRegistered: isRegistered ?? this.isRegistered,
      isValid: isValid ?? this.isValid,
      cardIssuedDate: cardIssuedDate ?? this.cardIssuedDate,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
