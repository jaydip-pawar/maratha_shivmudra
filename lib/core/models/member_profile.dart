import 'package:cloud_firestore/cloud_firestore.dart';

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
  final String stateCode;
  final String district;
  final String districtCode;
  final String districtEn;
  final String districtMr;
  final String subDistrict;
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
  final String nativeState;
  final String nativeStateCode;
  final String nativeDistrict;
  final String nativeTaluka;
  final String nativeVillage;
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
    this.gender = 'Male',
    this.address = '',
    this.addressMr = '',
    this.city = '',
    this.village = '',
    this.villageMr = '',
    this.state = 'Maharashtra',
    this.stateCode = 'MH',
    this.district = 'Pune',
    this.districtCode = 'PUN',
    this.districtEn = 'Pune',
    this.districtMr = 'पुणे',
    this.subDistrict = '',
    this.pincode = '',
    this.email = '',
    this.living = '',
    this.profession = '',
    this.education = '',
    this.bloodGroup = '',
    this.emergencyContactName = '',
    this.emergencyContactPhone = '',
    this.isNativeAddressSameAsCurrent = true,
    this.nativeAddress = '',
    this.nativeState = 'Maharashtra',
    this.nativeStateCode = 'MH',
    this.nativeDistrict = '',
    this.nativeTaluka = '',
    this.nativeVillage = '',
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
    final distEn = data['district_en'] as String? ?? data['district'] as String? ?? 'Pune';
    final distMr = data['district_mr'] as String? ?? 'पुणे';
    final distCode = data['district_code'] as String? ?? 'PUN';

    final isIssued = data['is_card_issued'] as bool? ??
        (data['member_id'] != null &&
            data['member_id'] != 'PENDING' &&
            data['member_id'].toString().trim().isNotEmpty);

    List<String> parsedCrops = [];
    if (data['crops_produced'] != null) {
      if (data['crops_produced'] is List) {
        parsedCrops = (data['crops_produced'] as List).map((e) => e.toString()).toList();
      } else if (data['crops_produced'] is String && (data['crops_produced'] as String).isNotEmpty) {
        parsedCrops = (data['crops_produced'] as String).split(',').map((s) => s.trim()).toList();
      }
    }

    return MemberProfile(
      phone: phone,
      firstName: data['first_name_en'] as String? ?? data['first_name'] as String? ?? data['firstName'] as String? ?? '',
      middleName: data['middle_name_en'] as String? ?? data['middle_name'] as String? ?? data['middleName'] as String? ?? '',
      lastName: data['last_name_en'] as String? ?? data['last_name'] as String? ?? data['lastName'] as String? ?? '',
      firstNameMr: data['first_name_mr'] as String? ?? data['firstName_mr'] as String? ?? '',
      middleNameMr: data['middle_name_mr'] as String? ?? '',
      lastNameMr: data['last_name_mr'] as String? ?? data['lastName_mr'] as String? ?? '',
      fullNameEnOverride: data['full_name_en'] as String? ?? data['name'] as String? ?? '',
      fullNameMrOverride: data['full_name_mr'] as String? ?? data['name_mr'] as String? ?? '',
      dateOfBirth: data['date_of_birth'] as String? ?? data['dateOfBirth'] as String? ?? '',
      gender: data['gender'] as String? ?? 'Male',
      address: data['address'] as String? ?? '',
      addressMr: data['address_mr'] as String? ?? data['addressMr'] as String? ?? '',
      city: data['city'] as String? ?? '',
      village: data['village'] as String? ?? '',
      villageMr: data['village_mr'] as String? ?? '',
      state: data['state'] as String? ?? 'Maharashtra',
      stateCode: data['state_code'] as String? ?? 'MH',
      district: distEn,
      districtCode: distCode,
      districtEn: distEn,
      districtMr: distMr,
      subDistrict: data['sub_district'] as String? ?? data['subDistrict'] as String? ?? '',
      pincode: data['pincode'] as String? ?? '',
      email: data['email'] as String? ?? '',
      living: data['living'] as String? ?? '',
      profession: data['profession'] as String? ?? '',
      education: data['education'] as String? ?? '',
      bloodGroup: data['blood_group'] as String? ?? data['bloodGroup'] as String? ?? '',
      emergencyContactName: data['emergency_contact_name'] as String? ?? '',
      emergencyContactPhone: data['emergency_contact_phone'] as String? ?? '',

      isNativeAddressSameAsCurrent: data['is_native_address_same'] as bool? ?? true,
      nativeAddress: data['native_address'] as String? ?? '',
      nativeState: data['native_state'] as String? ?? 'Maharashtra',
      nativeStateCode: data['native_state_code'] as String? ?? 'MH',
      nativeDistrict: data['native_district'] as String? ?? '',
      nativeTaluka: data['native_taluka'] as String? ?? '',
      nativeVillage: data['native_village'] as String? ?? '',
      nativePincode: data['native_pincode'] as String? ?? '',

      isPoliticallyActive: data['is_politically_active'] as bool?,
      politicalParty: data['political_party'] as String? ?? '',
      politicalRole: data['political_role'] as String? ?? '',

      isAssociatedWithNgo: data['is_associated_with_ngo'] as bool?,
      ngoName: data['ngo_name'] as String? ?? '',
      ngoRole: data['ngo_role'] as String? ?? '',

      isOrganDonorPledged: data['is_organ_donor_pledged'] as bool? ?? false,
      hasOrganDonationConsentAnswered: data['has_organ_donation_answered'] as bool? ?? (data['is_organ_donor_pledged'] != null),

      jobDesignation: data['job_designation'] as String? ?? '',
      jobCompany: data['job_company'] as String? ?? '',
      businessType: data['business_type'] as String? ?? '',
      educationLevel: data['education_level'] as String? ?? '',
      educationOther: data['education_other'] as String? ?? '',
      cropsProduced: parsedCrops,
      unemployedEducation: data['unemployed_education'] as String? ?? '',
      unemployedPreferredSector: data['unemployed_preferred_sector'] as String? ?? '',
      unemployedSkills: data['unemployed_skills'] as String? ?? '',
      willingToRelocate: data['willing_to_relocate'] as bool?,

      roleType: data['role_type'] as String? ?? 'member',
      designation: data['designation'] as String? ?? '',
      isOfficial: data['is_official'] as bool? ?? false,
      officialLevel: data['official_level'] as String?,
      officialRoleCode: data['official_role_code'] as String?,
      officialRoleMr: data['official_role_mr'] as String?,
      officialRoleEn: data['official_role_en'] as String?,
      officialFullTitleMr: data['official_full_title_mr'] as String?,
      officialFullTitleEn: data['official_full_title_en'] as String?,
      officialVibhag: data['official_vibhag'] as String?,
      officialDistrict: data['official_district'] as String?,
      officialTaluka: data['official_taluka'] as String?,
      photoBase64: data['photo_base64'] as String? ?? data['photo'] as String?,
      photoUrl: data['photo_url'] as String?,
      memberId: data['member_id'] as String?,
      referralId: data['referral_id'] as String? ?? 'NONE',
      isCardIssued: isIssued,
      isRegistered: data['is_registered'] as bool? ?? true,
      isValid: data['is_valid'] as bool? ?? true,
      cardIssuedDate: _parseDateTime(data['card_issued_date']),
      createdAt: _parseDateTime(data['created_at']),
      updatedAt: _parseDateTime(data['updated_at']),
    );
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

  Map<String, dynamic> toFirestore() {
    return {
      'phone': phone,
      'first_name_en': firstName,
      'middle_name_en': middleName,
      'last_name_en': lastName,
      'full_name_en': fullNameEn,
      'first_name_mr': firstNameMr,
      'middle_name_mr': middleNameMr,
      'last_name_mr': lastNameMr,
      'full_name_mr': fullNameMr,
      'name': fullNameEn,
      'name_mr': fullNameMr,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'address': address,
      'address_mr': addressMr,
      'city': city,
      'village': village,
      'village_mr': villageMr,
      'sub_district': subDistrict,
      'state': state,
      'state_code': stateCode,
      'district': district,
      'district_code': districtCode,
      'district_en': districtEn,
      'district_mr': districtMr,
      'pincode': pincode,
      'email': email,
      'living': living,
      'profession': profession,
      'education': education,
      'blood_group': bloodGroup,
      'emergency_contact_name': emergencyContactName,
      'emergency_contact_phone': emergencyContactPhone,

      'is_native_address_same': isNativeAddressSameAsCurrent,
      'native_address': nativeAddress,
      'native_state': nativeState,
      'native_state_code': nativeStateCode,
      'native_district': nativeDistrict,
      'native_taluka': nativeTaluka,
      'native_village': nativeVillage,
      'native_pincode': nativePincode,

      if (isPoliticallyActive != null) 'is_politically_active': isPoliticallyActive,
      'political_party': politicalParty,
      'political_role': politicalRole,

      if (isAssociatedWithNgo != null) 'is_associated_with_ngo': isAssociatedWithNgo,
      'ngo_name': ngoName,
      'ngo_role': ngoRole,

      'is_organ_donor_pledged': isOrganDonorPledged,
      'has_organ_donation_answered': hasOrganDonationConsentAnswered,

      'job_designation': jobDesignation,
      'job_company': jobCompany,
      'business_type': businessType,
      'education_level': educationLevel,
      'education_other': educationOther,
      'crops_produced': cropsProduced,
      'unemployed_education': unemployedEducation,
      'unemployed_preferred_sector': unemployedPreferredSector,
      'unemployed_skills': unemployedSkills,
      if (willingToRelocate != null) 'willing_to_relocate': willingToRelocate,

      'role_type': roleType,
      'designation': designation,
      'is_official': isOfficial,
      if (officialLevel != null) 'official_level': officialLevel,
      if (officialRoleCode != null) 'official_role_code': officialRoleCode,
      if (officialRoleMr != null) 'official_role_mr': officialRoleMr,
      if (officialRoleEn != null) 'official_role_en': officialRoleEn,
      if (officialFullTitleMr != null) 'official_full_title_mr': officialFullTitleMr,
      if (officialFullTitleEn != null) 'official_full_title_en': officialFullTitleEn,
      if (officialVibhag != null) 'official_vibhag': officialVibhag,
      if (officialDistrict != null) 'official_district': officialDistrict,
      if (officialTaluka != null) 'official_taluka': officialTaluka,
      if (photoBase64 != null) 'photo_base64': photoBase64,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (memberId != null) 'member_id': memberId,
      'referral_id': referralId ?? 'NONE',
      'is_profile_complete': isProfileComplete,
      'is_card_issued': isCardIssued,
      'is_registered': isRegistered,
      'is_valid': isValid,
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
    String? stateCode,
    String? district,
    String? districtCode,
    String? districtEn,
    String? districtMr,
    String? subDistrict,
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
    String? nativeState,
    String? nativeStateCode,
    String? nativeDistrict,
    String? nativeTaluka,
    String? nativeVillage,
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
      stateCode: stateCode ?? this.stateCode,
      district: district ?? this.district,
      districtCode: districtCode ?? this.districtCode,
      districtEn: districtEn ?? this.districtEn,
      districtMr: districtMr ?? this.districtMr,
      subDistrict: subDistrict ?? this.subDistrict,
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
      nativeState: nativeState ?? this.nativeState,
      nativeStateCode: nativeStateCode ?? this.nativeStateCode,
      nativeDistrict: nativeDistrict ?? this.nativeDistrict,
      nativeTaluka: nativeTaluka ?? this.nativeTaluka,
      nativeVillage: nativeVillage ?? this.nativeVillage,
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
