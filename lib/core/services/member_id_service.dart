import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:maratha_shivmudra/core/constants/district_constants.dart';
import 'package:maratha_shivmudra/core/constants/geo_constants.dart';

class MemberIdService {
  static final MemberIdService _instance = MemberIdService._internal();
  static MemberIdService get instance => _instance;
  MemberIdService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Generate or retrieve an existing unique District-based Member ID
  Future<String?> generateOrGetMemberId({
    required String phoneNumber,
    required String rawDistrict,
    required String fullName,
  }) async {
    try {
      final phone = phoneNumber.trim();
      final memberRef = _db.collection('members').doc(phone);
      final memberSnap = await memberRef.get();

      // Check if user already has an assigned Member ID
      if (memberSnap.exists) {
        final existingId = memberSnap.data()?['member_id'] as String?;
        if (existingId != null &&
            existingId.trim().isNotEmpty &&
            existingId != 'PENDING') {
          return existingId;
        }
      }

      final district = DistrictConstants.getByCode(DistrictConstants.getCode(rawDistrict));
      final districtCode = district.code;
      final counterRef = _db.collection('counters').doc('district_counters');

      // Atomic transaction to ensure zero collisions
      final newSerial = await _db.runTransaction<int>((transaction) async {
        final snapshot = await transaction.get(counterRef);
        int currentCount = 0;
        if (snapshot.exists && snapshot.data() != null) {
          currentCount = (snapshot.data()![districtCode] as num?)?.toInt() ?? 0;
        }
        final nextCount = currentCount + 1;
        transaction.set(
          counterRef,
          {districtCode: nextCount},
          SetOptions(merge: true),
        );
        return nextCount;
      });

      final memberId =
          'MSM-$districtCode-${newSerial.toString().padLeft(5, '0')}';
      final now = FieldValue.serverTimestamp();

      // Save to member document
      await memberRef.set({
        'member_id': memberId,
        'district_code': districtCode,
        'district_en': district.nameEn,
        'district_mr': district.nameMr,
        'serial_number': newSerial,
        'card_issued_date': now,
        'is_card_issued': true,
        'updated_at': now,
      }, SetOptions(merge: true));

      return memberId;
    } catch (e) {
      debugPrint('Error generating Member ID: $e');
      return null;
    }
  }

  /// Assign or generate a Special / Managerial ID (e.g. MSM-HQ-0001 or MSM-PUN-OFF-001)
  Future<String?> assignManagerialOrSpecialId({
    required String phone,
    required String rawDistrict,
    required String fullName,
    required String roleType, // 'manager' | 'district_head' | 'core_committee' | 'executive'
    required String designation,
    String? customSpecialId,
  }) async {
    try {
      final cleanPhone = phone.trim();
      final district = DistrictConstants.getByCode(DistrictConstants.getCode(rawDistrict));
      final districtCode = district.code;
      String specialId = customSpecialId?.trim().toUpperCase() ?? '';

      if (specialId.isEmpty) {
        final counterKey = roleType == 'core_committee'
            ? 'HQ'
            : roleType == 'manager'
                ? 'MGR'
                : '${districtCode}_OFF';

        final counterRef = _db.collection('counters').doc('managerial_counters');
        final newSerial = await _db.runTransaction<int>((transaction) async {
          final snapshot = await transaction.get(counterRef);
          int current = 0;
          if (snapshot.exists && snapshot.data() != null) {
            current = (snapshot.data()![counterKey] as num?)?.toInt() ?? 0;
          }
          final next = current + 1;
          transaction.set(
            counterRef,
            {counterKey: next},
            SetOptions(merge: true),
          );
          return next;
        });

        if (roleType == 'core_committee') {
          specialId = 'MSM-HQ-${newSerial.toString().padLeft(4, '0')}';
        } else if (roleType == 'manager') {
          specialId = 'MSM-MGR-${newSerial.toString().padLeft(4, '0')}';
        } else {
          specialId = 'MSM-$districtCode-OFF-${newSerial.toString().padLeft(3, '0')}';
        }
      }

      final now = FieldValue.serverTimestamp();

      // Update members/{phone}
      await _db.collection('members').doc(cleanPhone).set({
        'member_id': specialId,
        'role_type': roleType,
        'designation': designation,
        'district_code': districtCode,
        'district_en': district.nameEn,
        'district_mr': district.nameMr,
        'is_card_issued': true,
        'card_issued_date': now,
        'updated_at': now,
      }, SetOptions(merge: true));

      return specialId;
    } catch (e) {
      debugPrint('Error assigning special managerial ID: $e');
      return null;
    }
  }

  /// Verify a Member ID directly from canonical `members` collection
  Future<Map<String, dynamic>?> verifyMemberId(String memberId) async {
    try {
      final cleanId = memberId.trim().toUpperCase();
      final query = await _db
          .collection('members')
          .where('member_id', isEqualTo: cleanId)
          .limit(1)
          .get();

      if (query.docs.isEmpty) return null;
      return query.docs.first.data();
    } catch (e) {
      debugPrint('Error verifying member ID: $e');
      return null;
    }
  }
}
