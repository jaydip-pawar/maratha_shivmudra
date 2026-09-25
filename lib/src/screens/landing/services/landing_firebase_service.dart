import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SocialImpactModel {
  final String volunteers;
  final String students;
  final String fortDrives;
  final String reliefDrives;
  final String districts;

  const SocialImpactModel({
    this.volunteers = '10,000',
    this.students = '500',
    this.fortDrives = '50',
    this.reliefDrives = '100',
    this.districts = '25',
  });

  static String _parseVal(dynamic val, String defaultVal) {
    if (val == null) return defaultVal;
    final str = val.toString().trim();
    if (str.isEmpty) return defaultVal;
    return str;
  }

  factory SocialImpactModel.fromFirestore(
    Map<String, dynamic>? data, {
    String? liveVolunteers,
  }) {
    if (data == null) return const SocialImpactModel();
    return SocialImpactModel(
      volunteers: liveVolunteers ??
          _parseVal(
            data['volunteers'] ??
                data['members'] ??
                data['active_members'] ??
                data['member_count'],
            '101',
          ),
      students: _parseVal(data['students'], '360+'),
      fortDrives:
          _parseVal(data['fort_drives'] ?? data['fortDrives'], '50+'),
      reliefDrives:
          _parseVal(data['relief_drives'] ?? data['reliefDrives'], '7'),
      districts: _parseVal(data['districts'], '36'),
    );
  }
}

class EventItemModel {
  final String id;
  final String titleMr;
  final String titleEn;
  final String dateMr;
  final String dateEn;
  final String locationMr;
  final String locationEn;
  final String descriptionMr;
  final String descriptionEn;
  final String categoryMr;
  final String categoryEn;
  final int order;
  final bool isActive;

  const EventItemModel({
    required this.id,
    required this.titleMr,
    required this.titleEn,
    required this.dateMr,
    required this.dateEn,
    required this.locationMr,
    required this.locationEn,
    required this.descriptionMr,
    required this.descriptionEn,
    required this.categoryMr,
    required this.categoryEn,
    this.order = 0,
    this.isActive = true,
  });

  factory EventItemModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return EventItemModel(
      id: doc.id,
      titleMr: (data['title_mr'] as String?)?.trim() ??
          (data['title'] as String?)?.trim() ??
          '',
      titleEn: (data['title_en'] as String?)?.trim() ??
          (data['title'] as String?)?.trim() ??
          '',
      dateMr: (data['date_mr'] as String?)?.trim() ??
          (data['date'] as String?)?.trim() ??
          '',
      dateEn: (data['date_en'] as String?)?.trim() ??
          (data['date'] as String?)?.trim() ??
          '',
      locationMr: (data['location_mr'] as String?)?.trim() ??
          (data['location'] as String?)?.trim() ??
          '',
      locationEn: (data['location_en'] as String?)?.trim() ??
          (data['location'] as String?)?.trim() ??
          '',
      descriptionMr: (data['description_mr'] as String?)?.trim() ??
          (data['description'] as String?)?.trim() ??
          '',
      descriptionEn: (data['description_en'] as String?)?.trim() ??
          (data['description'] as String?)?.trim() ??
          '',
      categoryMr: (data['category_mr'] as String?)?.trim() ??
          (data['category'] as String?)?.trim() ??
          'दुर्ग संवर्धन',
      categoryEn: (data['category_en'] as String?)?.trim() ??
          (data['category'] as String?)?.trim() ??
          'Fort Heritage',
      order: (data['order'] as num?)?.toInt() ?? 0,
      isActive: data['isActive'] as bool? ?? true,
    );
  }
}

class LandingFirebaseService {
  LandingFirebaseService._();
  static final LandingFirebaseService instance = LandingFirebaseService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Stream of Social Impact numbers with live query-based volunteer count
  Stream<SocialImpactModel> getSocialImpactStream() {
    return _firestore
        .collection('site_data')
        .doc('social_impact')
        .snapshots()
        .asyncMap((snapshot) async {
      int liveVolunteers = 101;
      try {
        final countSnap = await _firestore
            .collection('members')
            .where('is_registered', isEqualTo: true)
            .count()
            .get();
        liveVolunteers = countSnap.count ?? 101;
      } catch (_) {}

      final data = snapshot.data();
      return SocialImpactModel.fromFirestore(
        data,
        liveVolunteers: liveVolunteers.toString(),
      );
    }).handleError((Object e) {
      debugPrint('Error loading social impact stats: $e');
      return const SocialImpactModel();
    });
  }

  /// Stream of active upcoming events from `upcoming_events` collection
  Stream<List<EventItemModel>> getUpcomingEventsStream() {
    return _firestore
        .collection('upcoming_events')
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return <EventItemModel>[];
      }
      final events = snapshot.docs
          .map((doc) => EventItemModel.fromFirestore(doc))
          .where((e) => e.isActive)
          .toList();

      events.sort((a, b) => a.order.compareTo(b.order));
      return events;
    }).handleError((Object e) {
      debugPrint('Error loading upcoming events: $e');
      return <EventItemModel>[];
    });
  }
}
