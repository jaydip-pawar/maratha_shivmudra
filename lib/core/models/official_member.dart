import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maratha_shivmudra/core/constants/organization_roles.dart';

class OfficialMember {
  final String id; // Document ID (usually phone or auto ID)
  final String phone;
  final String memberId;
  final String nameEn;
  final String nameMr;
  final String? photoUrl;
  final OrganizationLevel level;
  final String roleCode;
  final String roleNameMr;
  final String roleNameEn;
  final String? vibhag;
  final String? vibhagMr;
  final String? district;
  final String? districtMr;
  final String? taluka;
  final String? talukaMr;
  final DateTime appointmentDate;
  final bool isActive;

  const OfficialMember({
    required this.id,
    required this.phone,
    required this.memberId,
    required this.nameEn,
    required this.nameMr,
    this.photoUrl,
    required this.level,
    required this.roleCode,
    required this.roleNameMr,
    required this.roleNameEn,
    this.vibhag,
    this.vibhagMr,
    this.district,
    this.districtMr,
    this.taluka,
    this.talukaMr,
    required this.appointmentDate,
    this.isActive = true,
  });

  /// Readable full designation string in Marathi (e.g. "पुणे विभाग - कार्याध्यक्ष")
  String get fullTitleMr {
    final prefix = _getJurisdictionPrefixMr();
    if (prefix.isEmpty) return roleNameMr;
    return '$prefix - $roleNameMr';
  }

  /// Readable full designation string in English (e.g. "Pune Division - Divisional Executive President")
  String get fullTitleEn {
    final prefix = _getJurisdictionPrefixEn();
    if (prefix.isEmpty) return roleNameEn;
    return '$prefix - $roleNameEn';
  }

  String _getJurisdictionPrefixMr() {
    switch (level) {
      case OrganizationLevel.core:
        return 'राज्य / कोर समिती';
      case OrganizationLevel.vibhag:
        return '${vibhagMr ?? vibhag ?? ""} विभाग';
      case OrganizationLevel.jilha:
        return '${districtMr ?? district ?? ""} जिल्हा';
      case OrganizationLevel.taluka:
        return '${talukaMr ?? taluka ?? ""} तालुका';
    }
  }

  String _getJurisdictionPrefixEn() {
    switch (level) {
      case OrganizationLevel.core:
        return 'Core Committee';
      case OrganizationLevel.vibhag:
        return '${vibhag ?? ""} Division';
      case OrganizationLevel.jilha:
        return '${district ?? ""} District';
      case OrganizationLevel.taluka:
        return '${taluka ?? ""} Taluka';
    }
  }

  factory OfficialMember.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    OrganizationLevel parseLevel(String? val) {
      switch (val) {
        case 'core':
          return OrganizationLevel.core;
        case 'vibhag':
          return OrganizationLevel.vibhag;
        case 'jilha':
          return OrganizationLevel.jilha;
        case 'taluka':
          return OrganizationLevel.taluka;
        default:
          return OrganizationLevel.core;
      }
    }

    DateTime parseDate(dynamic val) {
      if (val is Timestamp) return val.toDate();
      if (val is String) {
        final parsed = DateTime.tryParse(val);
        if (parsed != null) return parsed;
      }
      return DateTime.now();
    }

    return OfficialMember(
      id: doc.id,
      phone: data['phone'] as String? ?? doc.id,
      memberId: data['member_id'] as String? ?? '',
      nameEn: data['name_en'] as String? ?? '',
      nameMr: data['name_mr'] as String? ?? '',
      photoUrl: data['photo_url'] as String?,
      level: parseLevel(data['level'] as String?),
      roleCode: data['role_code'] as String? ?? '',
      roleNameMr: data['role_name_mr'] as String? ?? '',
      roleNameEn: data['role_name_en'] as String? ?? '',
      vibhag: data['vibhag'] as String?,
      vibhagMr: data['vibhag_mr'] as String?,
      district: data['district'] as String?,
      districtMr: data['district_mr'] as String?,
      taluka: data['taluka'] as String?,
      talukaMr: data['taluka_mr'] as String?,
      appointmentDate: parseDate(data['appointment_date'] ?? data['created_at']),
      isActive: data['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'member_id': memberId,
      'name_en': nameEn,
      'name_mr': nameMr,
      'photo_url': photoUrl,
      'level': level.code,
      'role_code': roleCode,
      'role_name_mr': roleNameMr,
      'role_name_en': roleNameEn,
      'vibhag': vibhag,
      'vibhag_mr': vibhagMr,
      'district': district,
      'district_mr': districtMr,
      'taluka': taluka,
      'taluka_mr': talukaMr,
      'appointment_date': Timestamp.fromDate(appointmentDate),
      'is_active': isActive,
      'updated_at': FieldValue.serverTimestamp(),
    };
  }
}
