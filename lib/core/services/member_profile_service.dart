import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:maratha_shivmudra/core/constants/geo_constants.dart';
import 'package:maratha_shivmudra/core/models/member_profile.dart';
import 'package:maratha_shivmudra/core/services/member_id_service.dart';
import 'package:maratha_shivmudra/core/utils/bilingual_helper.dart';

class MemberProfileService {
  static final MemberProfileService _instance = MemberProfileService._internal();
  static MemberProfileService get instance => _instance;
  MemberProfileService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Stream a member's real-time profile from canonical `members/{phone}`
  Stream<MemberProfile?> streamProfile(String phone) {
    final cleanPhone = phone.trim();
    return _db
        .collection('members')
        .doc(cleanPhone)
        .snapshots()
        .map((snap) {
      if (!snap.exists || snap.data() == null) return null;
      return MemberProfile.fromFirestore(cleanPhone, snap.data()!);
    });
  }

  /// Get a snapshot of member's profile from canonical `members/{phone}`
  Future<MemberProfile?> getProfile(String phone) async {
    try {
      final cleanPhone = phone.trim();
      final snap = await _db.collection('members').doc(cleanPhone).get();
      if (!snap.exists || snap.data() == null) return null;
      return MemberProfile.fromFirestore(cleanPhone, snap.data()!);
    } catch (e) {
      debugPrint('Error getting member profile: $e');
      return null;
    }
  }

  /// Save and update member profile with automatic 100% ID Card generation gate
  Future<MemberProfile?> updateProfile(MemberProfile profile) async {
    try {
      final phone = profile.phone.trim();
      final memberRef = _db.collection('members').doc(phone);

      String? issuedMemberId = profile.memberId;

      // Gate: If profile is 100% complete and memberId not yet issued, generate it!
      if (profile.isProfileComplete &&
          (issuedMemberId == null || issuedMemberId.isEmpty || issuedMemberId == 'PENDING')) {
        issuedMemberId = await MemberIdService.instance.generateOrGetMemberId(
          phoneNumber: phone,
          rawDistrict: profile.district,
          fullName: profile.fullNameEn.isNotEmpty ? profile.fullNameEn : profile.fullNameMr,
        );
      }

      final searchTokens = BilingualHelper.generateSearchTokens(
        nameEn: profile.fullNameEn,
        nameMr: profile.fullNameMr,
        phone: phone,
        memberId: issuedMemberId ?? 'PENDING',
        district: profile.districtEn,
        taluka: profile.subDistrict,
        village: '${profile.village} ${profile.villageMr}'.trim(),
      );

      final dataToSave = profile.toFirestore();
      dataToSave['search_tokens'] = searchTokens;
      if (issuedMemberId != null && issuedMemberId != 'PENDING') {
        final membership = dataToSave['membership'] as Map<String, dynamic>? ?? {};
        membership['member_id'] = issuedMemberId;
        membership['is_card_issued'] = true;
        dataToSave['membership'] = membership;
      }

      // If political or NGO active is false, explicitly delete associated fields from Firestore
      if (profile.isPoliticallyActive == false) {
        dataToSave['political_party'] = FieldValue.delete();
        dataToSave['political_role'] = FieldValue.delete();
        final aff = dataToSave['affiliations'] as Map<String, dynamic>?;
        if (aff != null) {
          aff['political_party'] = FieldValue.delete();
          aff['political_role'] = FieldValue.delete();
        }
      }
      if (profile.isAssociatedWithNgo == false) {
        dataToSave['ngo_name'] = FieldValue.delete();
        dataToSave['ngo_role'] = FieldValue.delete();
        final aff = dataToSave['affiliations'] as Map<String, dynamic>?;
        if (aff != null) {
          aff['ngo_name'] = FieldValue.delete();
          aff['ngo_role'] = FieldValue.delete();
        }
      }

      await memberRef.set(dataToSave, SetOptions(merge: true));
      return getProfile(phone);
    } catch (e) {
      debugPrint('Error updating profile: $e');
      return null;
    }
  }

  /// Store profile photo as compressed base64 data uri directly in Firestore
  Future<bool> uploadProfilePhoto(String phone, Uint8List bytes) async {
    final cleanPhone = phone.trim();
    try {
      final base64String = 'data:image/jpeg;base64,${base64Encode(bytes)}';
      await _db.collection('members').doc(cleanPhone).set({
        'media': {
          'photo_base64': base64String,
        },
        'updated_at': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      debugPrint('Error saving photo: $e');
      return false;
    }
  }

  /// Store profile photo as compressed base64 data uri
  Future<bool> savePhotoBase64(String phone, Uint8List bytes) async {
    return uploadProfilePhoto(phone, bytes);
  }

  /// Server-side Aggregate Count of registered members (zero document data downloaded)
  Future<int> getRegisteredCount() async {
    try {
      final snap = await _db
          .collection('members')
          .where('membership.is_registered', isEqualTo: true)
          .count()
          .get();
      if ((snap.count ?? 0) > 0) return snap.count ?? 0;
      final fallbackSnap = await _db
          .collection('members')
          .where('is_registered', isEqualTo: true)
          .count()
          .get();
      return fallbackSnap.count ?? 0;
    } catch (e) {
      debugPrint('Error getting registered count via query: $e');
      return 0;
    }
  }

  /// Server-side Aggregate Count of issued cards (zero document data downloaded)
  Future<int> getIssuedCardCount() async {
    try {
      final snap = await _db
          .collection('members')
          .where('membership.is_registered', isEqualTo: true)
          .where('membership.is_card_issued', isEqualTo: true)
          .count()
          .get();
      if ((snap.count ?? 0) > 0) return snap.count ?? 0;
      final fallbackSnap = await _db
          .collection('members')
          .where('is_registered', isEqualTo: true)
          .where('is_card_issued', isEqualTo: true)
          .count()
          .get();
      return fallbackSnap.count ?? 0;
    } catch (e) {
      debugPrint('Error getting issued card count via query: $e');
      return 0;
    }
  }

  /// Server-side Aggregate Count for filtered queries
  Future<int> getFilterCount({
    String? stateCode,
    String? districtEn,
    String? taluka,
  }) async {
    try {
      Query<Map<String, dynamic>> q = _db
          .collection('members')
          .where('membership.is_registered', isEqualTo: true);

      if (stateCode != null && stateCode.isNotEmpty && stateCode != 'ALL_INDIA') {
        q = q.where('residence.state_code', isEqualTo: stateCode);
      }
      if (districtEn != null && districtEn.isNotEmpty && districtEn != 'ALL') {
        q = q.where('residence.district_en', isEqualTo: districtEn);
      }
      if (taluka != null && taluka.isNotEmpty && taluka != 'ALL') {
        q = q.where('residence.taluka_en', isEqualTo: taluka);
      }

      final snap = await q.count().get();
      return snap.count ?? 0;
    } catch (e) {
      debugPrint('Error getting filter count via query: $e');
      return 0;
    }
  }
}
