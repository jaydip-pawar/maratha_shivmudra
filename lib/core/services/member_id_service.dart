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
        final data = memberSnap.data();
        final mem = data?['membership'] is Map ? data!['membership'] as Map : null;
        final existingId = (mem?['member_id'] ?? data?['member_id']) as String?;
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

      final cleanDistrictCode = districtCode.isNotEmpty ? districtCode : 'GEN';
      final seriesCode = formatSeriesCode(newSerial);
      final memberId = 'MSP-$cleanDistrictCode-$seriesCode';
      final now = FieldValue.serverTimestamp();

      // Save to member document
      await memberRef.set({
        'residence': {
          'district_code': districtCode,
          'district_en': district.nameEn,
          'district_mr': district.nameMr,
        },
        'membership': {
          'member_id': memberId,
          'serial_number': newSerial,
          'card_issued_date': now,
          'is_card_issued': true,
          'is_profile_complete': true,
        },
        'updated_at': now,
      }, SetOptions(merge: true));

      return memberId;
    } catch (e) {
      debugPrint('Error generating Member ID: $e');
      return null;
    }
  }

  /// Formats a 1-based sequential number into the batch series format:
  /// Serial 1 -> A0001
  /// Serial 9999 -> A9999
  /// Serial 10000 -> B0001
  /// Serial 19998 -> B9999
  /// Serial 19999 -> C0001
  static String formatSeriesCode(int serial) {
    if (serial <= 0) serial = 1;
    final batchIndex = (serial - 1) ~/ 9999;
    final numberInBatch = ((serial - 1) % 9999) + 1;

    String seriesLetter;
    if (batchIndex < 26) {
      seriesLetter = String.fromCharCode(65 + batchIndex); // A-Z
    } else {
      // Extended series for ultra-high counts (e.g. AA, AB...)
      final firstLetter = String.fromCharCode(65 + ((batchIndex ~/ 26) - 1));
      final secondLetter = String.fromCharCode(65 + (batchIndex % 26));
      seriesLetter = '$firstLetter$secondLetter';
    }

    final formattedNumber = numberInBatch.toString().padLeft(4, '0');
    return '$seriesLetter$formattedNumber';
  }

  /// Assign or generate a Special / Managerial ID (e.g. MSP-HQ-A0001 or MSP-PUN-OFF-A0001)
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
      final districtCode = district.code.isNotEmpty ? district.code : 'GEN';
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

        final seriesCode = formatSeriesCode(newSerial);
        if (roleType == 'core_committee') {
          specialId = 'MSP-HQ-$seriesCode';
        } else if (roleType == 'manager') {
          specialId = 'MSP-MGR-$seriesCode';
        } else {
          specialId = 'MSP-$districtCode-OFF-$seriesCode';
        }
      }

      final now = FieldValue.serverTimestamp();

      // Update members/{phone}
      await _db.collection('members').doc(cleanPhone).set({
        'residence': {
          'district_code': districtCode,
          'district_en': district.nameEn,
          'district_mr': district.nameMr,
        },
        'membership': {
          'member_id': specialId,
          'role_type': roleType,
          'designation': designation,
          'is_card_issued': true,
          'card_issued_date': now,
        },
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
      QuerySnapshot<Map<String, dynamic>> query = await _db
          .collection('members')
          .where('membership.member_id', isEqualTo: cleanId)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        query = await _db
            .collection('members')
            .where('member_id', isEqualTo: cleanId)
            .limit(1)
            .get();
      }

      if (query.docs.isEmpty) return null;
      return query.docs.first.data();
    } catch (e) {
      debugPrint('Error verifying member ID: $e');
      return null;
    }
  }
}
