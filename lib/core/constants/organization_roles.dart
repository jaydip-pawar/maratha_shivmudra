import 'package:flutter/foundation.dart';

/// Hierarchy levels of the organization
enum OrganizationLevel {
  core,
  vibhag,
  jilha,
  taluka,
}

extension OrganizationLevelExtension on OrganizationLevel {
  String get code {
    switch (this) {
      case OrganizationLevel.core:
        return 'core';
      case OrganizationLevel.vibhag:
        return 'vibhag';
      case OrganizationLevel.jilha:
        return 'jilha';
      case OrganizationLevel.taluka:
        return 'taluka';
    }
  }

  String get nameMr {
    switch (this) {
      case OrganizationLevel.core:
        return 'राज्य / कोर समिती';
      case OrganizationLevel.vibhag:
        return 'विभाग समिती';
      case OrganizationLevel.jilha:
        return 'जिल्हा समिती';
      case OrganizationLevel.taluka:
        return 'तालुका समिती';
    }
  }

  String get nameEn {
    switch (this) {
      case OrganizationLevel.core:
        return 'State / Core Committee';
      case OrganizationLevel.vibhag:
        return 'Divisional Committee';
      case OrganizationLevel.jilha:
        return 'District Committee';
      case OrganizationLevel.taluka:
        return 'Taluka Committee';
    }
  }
}

/// 6 Administrative Divisions (विभाग) in Maharashtra
class VibhagInfo {
  final String code;
  final String nameEn;
  final String nameMr;
  final List<String> districts; // Names in English matching GeoConstants

  const VibhagInfo({
    required this.code,
    required this.nameEn,
    required this.nameMr,
    required this.districts,
  });

  @override
  String toString() => '$nameMr ($nameEn)';
}

/// Role definition with both formal English and authentic Marathi designations
class RoleDefinition {
  final String code;
  final String nameMr;
  final String nameEn;
  final OrganizationLevel level;
  final int sortOrder;

  const RoleDefinition({
    required this.code,
    required this.nameMr,
    required this.nameEn,
    required this.level,
    required this.sortOrder,
  });

  @override
  String toString() => '$nameMr ($nameEn)';
}

abstract class OrganizationRoles {
  // 6 Maharashtra Administrative Divisions
  static const List<VibhagInfo> maharashtraVibhags = [
    VibhagInfo(
      code: 'KONKAN',
      nameEn: 'Konkan',
      nameMr: 'कोकण',
      districts: [
        'Mumbai City',
        'Mumbai Suburban',
        'Thane',
        'Palghar',
        'Raigad',
        'Ratnagiri',
        'Sindhudurg',
      ],
    ),
    VibhagInfo(
      code: 'PUNE',
      nameEn: 'Pune',
      nameMr: 'पुणे',
      districts: [
        'Pune',
        'Satara',
        'Sangli',
        'Solapur',
        'Kolhapur',
      ],
    ),
    VibhagInfo(
      code: 'NASHIK',
      nameEn: 'Nashik',
      nameMr: 'नाशिक',
      districts: [
        'Nashik',
        'Dhule',
        'Jalgaon',
        'Nandurbar',
        'Ahilyanagar',
      ],
    ),
    VibhagInfo(
      code: 'SAMBHAJINAGAR',
      nameEn: 'Chhatrapati Sambhajinagar',
      nameMr: 'छत्रपती संभाजीनगर',
      districts: [
        'Chhatrapati Sambhajinagar',
        'Jalna',
        'Beed',
        'Dharashiv',
        'Nanded',
        'Latur',
        'Parbhani',
        'Hingoli',
      ],
    ),
    VibhagInfo(
      code: 'AMRAVATI',
      nameEn: 'Amravati',
      nameMr: 'अमरावती',
      districts: [
        'Amravati',
        'Akola',
        'Yavatmal',
        'Buldhana',
        'Washim',
      ],
    ),
    VibhagInfo(
      code: 'NAGPUR',
      nameEn: 'Nagpur',
      nameMr: 'नागपूर',
      districts: [
        'Nagpur',
        'Wardha',
        'Bhandara',
        'Gondia',
        'Chandrapur',
        'Gadchiroli',
      ],
    ),
  ];

  /// 1. Core Committee Roles (राज्य / कोर समिती - 19 पद)
  static const List<RoleDefinition> coreRoles = [
    RoleDefinition(
      code: 'core_adhyaksh',
      nameMr: 'संस्थापक व अध्यक्ष',
      nameEn: 'Founder & President (Super Admin)',
      level: OrganizationLevel.core,
      sortOrder: 1,
    ),
    RoleDefinition(
      code: 'core_upadhyaksh',
      nameMr: 'उपाध्यक्ष',
      nameEn: 'Vice President',
      level: OrganizationLevel.core,
      sortOrder: 2,
    ),
    RoleDefinition(
      code: 'core_karyadhyaksh',
      nameMr: 'कार्याध्यक्ष',
      nameEn: 'Executive President',
      level: OrganizationLevel.core,
      sortOrder: 3,
    ),
    RoleDefinition(
      code: 'core_sampark_pramukh',
      nameMr: 'संपर्क प्रमुख',
      nameEn: 'Head of Public Relations / Liaison Chief',
      level: OrganizationLevel.core,
      sortOrder: 4,
    ),
    RoleDefinition(
      code: 'core_sachiv',
      nameMr: 'सचिव',
      nameEn: 'General Secretary',
      level: OrganizationLevel.core,
      sortOrder: 5,
    ),
    RoleDefinition(
      code: 'core_pradeshadhyaksh',
      nameMr: 'प्रदेशाध्यक्ष',
      nameEn: 'State President',
      level: OrganizationLevel.core,
      sortOrder: 6,
    ),
    RoleDefinition(
      code: 'core_khajindar',
      nameMr: 'खजिनदार',
      nameEn: 'Treasurer',
      level: OrganizationLevel.core,
      sortOrder: 7,
    ),
    RoleDefinition(
      code: 'core_sallagar',
      nameMr: 'सल्लागार',
      nameEn: 'Chief Advisor',
      level: OrganizationLevel.core,
      sortOrder: 8,
    ),
    RoleDefinition(
      code: 'core_aandolan_pramukh',
      nameMr: 'आंदोलन प्रमुख',
      nameEn: 'Head of Public Movements & Agitations',
      level: OrganizationLevel.core,
      sortOrder: 9,
    ),
    RoleDefinition(
      code: 'core_antar_sanghatan_pramukh',
      nameMr: 'अंतर संघटन प्रमुख',
      nameEn: 'Head of Internal Organization',
      level: OrganizationLevel.core,
      sortOrder: 10,
    ),
    RoleDefinition(
      code: 'core_mohim_pramukh',
      nameMr: 'मोहीम प्रमुख',
      nameEn: 'Campaign & Mission Director',
      level: OrganizationLevel.core,
      sortOrder: 11,
    ),
    RoleDefinition(
      code: 'core_prachar_prasar_pramukh',
      nameMr: 'प्रचार प्रसार प्रमुख',
      nameEn: 'Head of Media & Publicity',
      level: OrganizationLevel.core,
      sortOrder: 12,
    ),
    RoleDefinition(
      code: 'core_shetaki_pramukh',
      nameMr: 'शेतकी विभाग प्रमुख',
      nameEn: 'Head of Agriculture & Farmer Affairs',
      level: OrganizationLevel.core,
      sortOrder: 13,
    ),
    RoleDefinition(
      code: 'core_rajya_samanwayak',
      nameMr: 'राज्य समन्वयक',
      nameEn: 'State Coordinator',
      level: OrganizationLevel.core,
      sortOrder: 14,
    ),
    RoleDefinition(
      code: 'core_committee_prabhari',
      nameMr: 'समिती प्रभारी',
      nameEn: 'Committee In-Charge / Supervisor',
      level: OrganizationLevel.core,
      sortOrder: 15,
    ),
    RoleDefinition(
      code: 'core_vidhi_pramukh',
      nameMr: 'विधी विभाग प्रमुख',
      nameEn: 'Head of Legal Affairs',
      level: OrganizationLevel.core,
      sortOrder: 16,
    ),
    RoleDefinition(
      code: 'core_rajya_pravakta',
      nameMr: 'राज्य प्रवक्ता',
      nameEn: 'State Spokesperson',
      level: OrganizationLevel.core,
      sortOrder: 17,
    ),
    RoleDefinition(
      code: 'core_aarogya_mitra',
      nameMr: 'आरोग्य मित्र',
      nameEn: 'Health & Medical Aid In-Charge',
      level: OrganizationLevel.core,
      sortOrder: 18,
    ),
    RoleDefinition(
      code: 'core_naukari_vyavasay_pramukh',
      nameMr: 'नोकरी व व्यवसाय विभाग प्रमुख',
      nameEn: 'Head of Employment & Business Development',
      level: OrganizationLevel.core,
      sortOrder: 19,
    ),
  ];

  /// 2. Vibhag Committee Roles (विभाग समिती - 5 पद per Vibhag)
  static const List<RoleDefinition> vibhagRoles = [
    RoleDefinition(
      code: 'vibhag_adhyaksh',
      nameMr: 'विभाग अध्यक्ष',
      nameEn: 'Divisional President',
      level: OrganizationLevel.vibhag,
      sortOrder: 1,
    ),
    RoleDefinition(
      code: 'vibhag_upadhyaksh',
      nameMr: 'विभाग उपाध्यक्ष',
      nameEn: 'Divisional Vice President',
      level: OrganizationLevel.vibhag,
      sortOrder: 2,
    ),
    RoleDefinition(
      code: 'vibhag_karyadhyaksh',
      nameMr: 'विभाग कार्याध्यक्ष',
      nameEn: 'Divisional Executive President',
      level: OrganizationLevel.vibhag,
      sortOrder: 3,
    ),
    RoleDefinition(
      code: 'vibhag_sampark_pramukh',
      nameMr: 'विभाग संपर्क प्रमुख',
      nameEn: 'Divisional Public Relations Head',
      level: OrganizationLevel.vibhag,
      sortOrder: 4,
    ),
    RoleDefinition(
      code: 'vibhag_sachiv',
      nameMr: 'विभाग सचिव',
      nameEn: 'Divisional Secretary',
      level: OrganizationLevel.vibhag,
      sortOrder: 5,
    ),
  ];

  /// 3. Jilha Committee Roles (जिल्हा समिती - 11 पद per District)
  static const List<RoleDefinition> jilhaRoles = [
    RoleDefinition(
      code: 'jilha_adhyaksh',
      nameMr: 'जिल्हा अध्यक्ष',
      nameEn: 'District President',
      level: OrganizationLevel.jilha,
      sortOrder: 1,
    ),
    RoleDefinition(
      code: 'jilha_upadhyaksh',
      nameMr: 'जिल्हा उपाध्यक्ष',
      nameEn: 'District Vice President',
      level: OrganizationLevel.jilha,
      sortOrder: 2,
    ),
    RoleDefinition(
      code: 'jilha_karyadhyaksh',
      nameMr: 'जिल्हा कार्याध्यक्ष',
      nameEn: 'District Executive President',
      level: OrganizationLevel.jilha,
      sortOrder: 3,
    ),
    RoleDefinition(
      code: 'jilha_sampark_pramukh',
      nameMr: 'जिल्हा संपर्क प्रमुख',
      nameEn: 'District Public Relations Head',
      level: OrganizationLevel.jilha,
      sortOrder: 4,
    ),
    RoleDefinition(
      code: 'jilha_sachiv',
      nameMr: 'जिल्हा सचिव',
      nameEn: 'District Secretary',
      level: OrganizationLevel.jilha,
      sortOrder: 5,
    ),
    RoleDefinition(
      code: 'jilha_khajindar',
      nameMr: 'जिल्हा खजिनदार',
      nameEn: 'District Treasurer',
      level: OrganizationLevel.jilha,
      sortOrder: 6,
    ),
    RoleDefinition(
      code: 'jilha_mohim_pramukh',
      nameMr: 'जिल्हा मोहीम प्रमुख',
      nameEn: 'District Campaign In-Charge',
      level: OrganizationLevel.jilha,
      sortOrder: 7,
    ),
    RoleDefinition(
      code: 'jilha_sallagar',
      nameMr: 'जिल्हा सल्लागार',
      nameEn: 'District Advisor',
      level: OrganizationLevel.jilha,
      sortOrder: 8,
    ),
    RoleDefinition(
      code: 'jilha_aandolan_pramukh',
      nameMr: 'जिल्हा आंदोलन प्रमुख',
      nameEn: 'District Movement In-Charge',
      level: OrganizationLevel.jilha,
      sortOrder: 9,
    ),
    RoleDefinition(
      code: 'jilha_prachar_pramukh',
      nameMr: 'जिल्हा प्रचार प्रसार प्रमुख',
      nameEn: 'District Media & Publicity Head',
      level: OrganizationLevel.jilha,
      sortOrder: 10,
    ),
    RoleDefinition(
      code: 'jilha_shetaki_pramukh',
      nameMr: 'जिल्हा शेतकी विभाग प्रमुख',
      nameEn: 'District Agriculture Affairs Head',
      level: OrganizationLevel.jilha,
      sortOrder: 11,
    ),
  ];

  /// 4. Taluka Committee Roles (तालुका समिती - 5 पद per Taluka)
  static const List<RoleDefinition> talukaRoles = [
    RoleDefinition(
      code: 'taluka_adhyaksh',
      nameMr: 'तालुका अध्यक्ष',
      nameEn: 'Taluka President',
      level: OrganizationLevel.taluka,
      sortOrder: 1,
    ),
    RoleDefinition(
      code: 'taluka_upadhyaksh',
      nameMr: 'तालुका उपाध्यक्ष',
      nameEn: 'Taluka Vice President',
      level: OrganizationLevel.taluka,
      sortOrder: 2,
    ),
    RoleDefinition(
      code: 'taluka_karyadhyaksh',
      nameMr: 'तालुका कार्याध्यक्ष',
      nameEn: 'Taluka Executive President',
      level: OrganizationLevel.taluka,
      sortOrder: 3,
    ),
    RoleDefinition(
      code: 'taluka_sampark_pramukh',
      nameMr: 'तालुका संपर्क प्रमुख',
      nameEn: 'Taluka Public Relations Head',
      level: OrganizationLevel.taluka,
      sortOrder: 4,
    ),
    RoleDefinition(
      code: 'taluka_sachiv',
      nameMr: 'तालुका सचिव',
      nameEn: 'Taluka Secretary',
      level: OrganizationLevel.taluka,
      sortOrder: 5,
    ),
  ];

  /// Get roles by level
  static List<RoleDefinition> getRolesForLevel(OrganizationLevel level) {
    switch (level) {
      case OrganizationLevel.core:
        return coreRoles;
      case OrganizationLevel.vibhag:
        return vibhagRoles;
      case OrganizationLevel.jilha:
        return jilhaRoles;
      case OrganizationLevel.taluka:
        return talukaRoles;
    }
  }

  /// Find Vibhag for a given district name
  static VibhagInfo? getVibhagForDistrict(String districtName) {
    final clean = districtName.trim().toLowerCase();
    for (final v in maharashtraVibhags) {
      for (final d in v.districts) {
        if (d.toLowerCase() == clean ||
            clean.contains(d.toLowerCase()) ||
            d.toLowerCase().contains(clean)) {
          return v;
        }
      }
    }
    return null;
  }

  /// Find RoleDefinition by code
  static RoleDefinition? getRoleByCode(String code) {
    final all = [...coreRoles, ...vibhagRoles, ...jilhaRoles, ...talukaRoles];
    for (final r in all) {
      if (r.code == code) return r;
    }
    return null;
  }
}
