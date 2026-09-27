import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

enum ReferralValidationResult {
  valid,
  limitExhausted,
  inactive,
  expired,
  notFound,
}

class ReferralCampaign {
  final String code;
  final String title;
  final int maxLimit;
  final int usedCount;
  final bool isActive;
  final String? district;
  final DateTime? createdAt;
  final DateTime? expiresAt;
  final String? createdBy;
  final String? memberId;
  final String? memberPhone;
  final String? memberNameMr;
  final String? memberNameEn;
  final String? memberPhoto;
  final String? memberTaluka;

  const ReferralCampaign({
    required this.code,
    required this.title,
    this.maxLimit = 0,
    this.usedCount = 0,
    this.isActive = true,
    this.district,
    this.createdAt,
    this.expiresAt,
    this.createdBy,
    this.memberId,
    this.memberPhone,
    this.memberNameMr,
    this.memberNameEn,
    this.memberPhoto,
    this.memberTaluka,
  });

  bool get isUnlimited => maxLimit <= 0;
  bool get isLimitReached => !isUnlimited && usedCount >= maxLimit;
  int get remainingSlots => isUnlimited ? 999999 : (maxLimit - usedCount).clamp(0, maxLimit);
  double get progress => isUnlimited ? 0.0 : (usedCount / maxLimit).clamp(0.0, 1.0);

  factory ReferralCampaign.fromMap(String docId, Map<String, dynamic> data) {
    return ReferralCampaign(
      code: docId,
      title: data['title'] as String? ?? docId,
      maxLimit: (data['max_limit'] as num?)?.toInt() ?? 0,
      usedCount: (data['used_count'] as num?)?.toInt() ?? 0,
      isActive: data['is_active'] as bool? ?? true,
      district: data['district'] as String?,
      createdAt: _parseDateTime(data['created_at']),
      expiresAt: _parseDateTime(data['expires_at']),
      createdBy: data['created_by'] as String?,
      memberId: data['member_id'] as String?,
      memberPhone: data['member_phone'] as String?,
      memberNameMr: data['member_name_mr'] as String?,
      memberNameEn: data['member_name_en'] as String?,
      memberPhoto: data['member_photo'] as String?,
      memberTaluka: data['member_taluka'] as String?,
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

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'title': title,
      'max_limit': maxLimit,
      'used_count': usedCount,
      'is_active': isActive,
      'district': district,
      'created_at': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
      'expires_at': expiresAt != null ? Timestamp.fromDate(expiresAt!) : null,
      'created_by': createdBy,
      'member_id': memberId,
      'member_phone': memberPhone,
      'member_name_mr': memberNameMr,
      'member_name_en': memberNameEn,
      'member_photo': memberPhoto,
      'member_taluka': memberTaluka,
    };
  }
}

class ReferralService {
  static final ReferralService _instance = ReferralService._internal();
  static ReferralService get instance => _instance;
  ReferralService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _refCol =>
      _db.collection('referrals');

  /// Fetch a single campaign by code
  Future<ReferralCampaign?> getCampaign(String rawCode) async {
    try {
      final code = rawCode.trim().toUpperCase();
      final doc = await _refCol.doc(code).get();
      if (!doc.exists || doc.data() == null) return null;
      return ReferralCampaign.fromMap(doc.id, doc.data()!);
    } catch (e) {
      debugPrint('Error getting referral campaign: $e');
      return null;
    }
  }

  /// Validate whether a referral code is currently valid and within limits
  Future<ReferralValidationResult> validateReferral(String rawCode) async {
    if (rawCode.trim().isEmpty || rawCode.trim().toUpperCase() == 'NONE') {
      return ReferralValidationResult.valid;
    }
    final campaign = await getCampaign(rawCode);
    if (campaign == null) return ReferralValidationResult.notFound;
    if (!campaign.isActive) return ReferralValidationResult.inactive;
    if (campaign.expiresAt != null && campaign.expiresAt!.isBefore(DateTime.now())) {
      return ReferralValidationResult.expired;
    }
    if (campaign.isLimitReached) return ReferralValidationResult.limitExhausted;
    return ReferralValidationResult.valid;
  }

  /// Atomically record usage of referral code upon form submission
  Future<bool> recordReferralUse({
    required String rawCode,
    required String userPhone,
    String? userName,
  }) async {
    final code = rawCode.trim().toUpperCase();
    if (code.isEmpty || code == 'NONE') return true;

    final docRef = _refCol.doc(code);

    try {
      return await _db.runTransaction<bool>((transaction) async {
        final snap = await transaction.get(docRef);
        if (!snap.exists) return false;

        final data = snap.data()!;
        final maxLimit = (data['max_limit'] as num?)?.toInt() ?? 0;
        final currentCount = (data['used_count'] as num?)?.toInt() ?? 0;
        final isActive = data['is_active'] as bool? ?? true;

        if (!isActive) return false;
        if (maxLimit > 0 && currentCount >= maxLimit) {
          return false;
        }

        // Record member under sub-collection for admin tracking
        final referredMemberRef = docRef.collection('members').doc(userPhone);
        final referredSnap = await transaction.get(referredMemberRef);

        // Only increment counter if not already counted for this campaign
        if (!referredSnap.exists) {
          transaction.set(
            docRef,
            {
              'used_count': currentCount + 1,
              'last_used_at': FieldValue.serverTimestamp(),
            },
            SetOptions(merge: true),
          );

          transaction.set(referredMemberRef, {
            'phone': userPhone,
            if (userName != null && userName.trim().isNotEmpty)
              'name': userName.trim(),
            'joined_at': FieldValue.serverTimestamp(),
          });
        }

        return true;
      });
    } catch (e) {
      debugPrint('Error recording referral use: $e');
      return false;
    }
  }

  /// Admin: Create or update referral campaign
  Future<bool> saveCampaign(ReferralCampaign campaign) async {
    try {
      final code = campaign.code.trim().toUpperCase();
      await _refCol.doc(code).set(campaign.toMap(), SetOptions(merge: true));
      return true;
    } catch (e) {
      debugPrint('Error saving campaign: $e');
      return false;
    }
  }

  /// Admin: Toggle active status
  Future<bool> toggleStatus(String rawCode, bool isActive) async {
    try {
      final code = rawCode.trim().toUpperCase();
      await _refCol.doc(code).set({'is_active': isActive}, SetOptions(merge: true));
      return true;
    } catch (e) {
      debugPrint('Error toggling referral status: $e');
      return false;
    }
  }

  /// Admin: Delete a referral campaign
  Future<bool> deleteCampaign(String rawCode) async {
    try {
      final code = rawCode.trim().toUpperCase();
      await _refCol.doc(code).delete();
      return true;
    } catch (e) {
      debugPrint('Error deleting referral campaign: $e');
      return false;
    }
  }

  /// Admin: Real-time Stream of all campaigns
  Stream<List<ReferralCampaign>> streamAllCampaigns() {
    return _refCol.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ReferralCampaign.fromMap(doc.id, doc.data()))
          .toList()
        ..sort((a, b) => (b.createdAt ?? DateTime.now())
            .compareTo(a.createdAt ?? DateTime.now()));
    });
  }
}
