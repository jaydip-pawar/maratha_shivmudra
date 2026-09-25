import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:maratha_shivmudra/core/constants/organization_roles.dart';
import 'package:maratha_shivmudra/core/models/official_member.dart';

class OrganizationService {
  static final OrganizationService _instance = OrganizationService._internal();
  static OrganizationService get instance => _instance;
  OrganizationService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _officialsCol =>
      _db.collection('officials');
  CollectionReference<Map<String, dynamic>> get _membersCol =>
      _db.collection('members');

  /// Stream of all active officials with optional level & jurisdiction filters
  Stream<List<OfficialMember>> getOfficialsStream({
    OrganizationLevel? level,
    String? vibhag,
    String? district,
    String? taluka,
  }) {
    Query<Map<String, dynamic>> query =
        _officialsCol.where('is_active', isEqualTo: true);

    if (level != null) {
      query = query.where('level', isEqualTo: level.code);
    }
    if (vibhag != null && vibhag.isNotEmpty && vibhag != 'ALL') {
      query = query.where('vibhag', isEqualTo: vibhag);
    }
    if (district != null && district.isNotEmpty && district != 'ALL') {
      query = query.where('district', isEqualTo: district);
    }
    if (taluka != null && taluka.isNotEmpty && taluka != 'ALL') {
      query = query.where('taluka', isEqualTo: taluka);
    }

    return query.snapshots().map((snap) {
      return snap.docs.map((doc) => OfficialMember.fromFirestore(doc)).toList();
    });
  }

  /// Appoint or update a member's official post
  Future<bool> appointOfficial({
    required String phone,
    required String memberId,
    required String nameEn,
    required String nameMr,
    String? photoUrl,
    required OrganizationLevel level,
    required RoleDefinition role,
    String? vibhag,
    String? vibhagMr,
    String? district,
    String? districtMr,
    String? taluka,
    String? talukaMr,
  }) async {
    try {
      final docRef = _officialsCol.doc(phone);
      final memberRef = _membersCol.doc(phone);

      final official = OfficialMember(
        id: phone,
        phone: phone,
        memberId: memberId,
        nameEn: nameEn,
        nameMr: nameMr,
        photoUrl: photoUrl,
        level: level,
        roleCode: role.code,
        roleNameMr: role.nameMr,
        roleNameEn: role.nameEn,
        vibhag: vibhag,
        vibhagMr: vibhagMr,
        district: district,
        districtMr: districtMr,
        taluka: taluka,
        talukaMr: talukaMr,
        appointmentDate: DateTime.now(),
        isActive: true,
      );

      final batch = _db.batch();

      // Set official doc
      batch.set(docRef, official.toMap(), SetOptions(merge: true));

      // Synchronize flags to member profile
      batch.set(
        memberRef,
        {
          'is_official': true,
          'is_promoted': false,
          'official_level': level.code,
          'official_role_code': role.code,
          'official_role_mr': role.nameMr,
          'official_role_en': role.nameEn,
          'official_full_title_mr': official.fullTitleMr,
          'official_full_title_en': official.fullTitleEn,
          'official_vibhag': vibhag,
          'official_vibhag_mr': vibhagMr,
          'official_district': district,
          'official_district_mr': districtMr,
          'official_taluka': taluka,
          'official_taluka_mr': talukaMr,
        },
        SetOptions(merge: true),
      );

      await batch.commit();
      return true;
    } catch (e) {
      debugPrint('Error appointing official: $e');
      return false;
    }
  }

  /// Promote a member as an official candidate
  Future<bool> promoteMember(String phone) async {
    try {
      await _membersCol.doc(phone).set({
        'is_promoted': true,
        'promoted_at': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      debugPrint('Error promoting member: $e');
      return false;
    }
  }

  /// Remove promotion status from a candidate
  Future<bool> unpromoteMember(String phone) async {
    try {
      await _membersCol.doc(phone).set({
        'is_promoted': false,
        'promoted_at': FieldValue.delete(),
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      debugPrint('Error unpromoting member: $e');
      return false;
    }
  }

  /// Stream of candidates promoted from dashboard awaiting official appointment
  Stream<List<Map<String, dynamic>>> getPromotedCandidatesStream() {
    return _membersCol
        .where('is_promoted', isEqualTo: true)
        .snapshots()
        .map((snap) {
      return snap.docs
          .map((doc) => doc.data())
          .where((data) => data['is_official'] != true)
          .toList();
    });
  }

  /// Revoke or deactivate an official appointment
  Future<bool> revokeOfficial(String phone) async {
    try {
      final batch = _db.batch();
      final docRef = _officialsCol.doc(phone);
      final memberRef = _membersCol.doc(phone);

      batch.delete(docRef);

      batch.update(memberRef, {
        'is_official': false,
        'official_role_code': FieldValue.delete(),
        'official_role_mr': FieldValue.delete(),
        'official_role_en': FieldValue.delete(),
        'official_full_title_mr': FieldValue.delete(),
        'official_full_title_en': FieldValue.delete(),
        'official_level': FieldValue.delete(),
      });

      await batch.commit();
      return true;
    } catch (e) {
      debugPrint('Error revoking official: $e');
      return false;
    }
  }

  /// Fetch stats count of officials by level using server-side query count (no doc payloads downloaded)
  Future<Map<String, int>> getOfficialsCounts() async {
    try {
      final totalFuture = _officialsCol.where('is_active', isEqualTo: true).count().get();
      final coreFuture = _officialsCol.where('is_active', isEqualTo: true).where('level', isEqualTo: 'core').count().get();
      final vibhagFuture = _officialsCol.where('is_active', isEqualTo: true).where('level', isEqualTo: 'vibhag').count().get();
      final jilhaFuture = _officialsCol.where('is_active', isEqualTo: true).where('level', isEqualTo: 'jilha').count().get();
      final talukaFuture = _officialsCol.where('is_active', isEqualTo: true).where('level', isEqualTo: 'taluka').count().get();

      final results = await Future.wait([
        totalFuture,
        coreFuture,
        vibhagFuture,
        jilhaFuture,
        talukaFuture,
      ]);

      return {
        'total': results[0].count ?? 0,
        'core': results[1].count ?? 0,
        'vibhag': results[2].count ?? 0,
        'jilha': results[3].count ?? 0,
        'taluka': results[4].count ?? 0,
      };
    } catch (e) {
      debugPrint('Error getting officials counts via query: $e');
      return {'total': 0, 'core': 0, 'vibhag': 0, 'jilha': 0, 'taluka': 0};
    }
  }
}
