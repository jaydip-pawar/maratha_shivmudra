import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/district_constants.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/models/member_profile.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';
import 'package:maratha_shivmudra/core/services/admin_auth_service.dart';
import 'package:maratha_shivmudra/core/services/member_id_service.dart';
import 'package:maratha_shivmudra/core/services/member_profile_service.dart';
import 'package:maratha_shivmudra/core/services/referral_service.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/constants/organization_roles.dart';
import 'package:maratha_shivmudra/core/models/official_member.dart';
import 'package:maratha_shivmudra/core/services/organization_service.dart';
import 'package:maratha_shivmudra/src/screens/landing/services/landing_firebase_service.dart';
import 'package:maratha_shivmudra/src/widgets/dropdown/app_searchable_dropdown.dart';
import 'package:maratha_shivmudra/src/widgets/id_card/member_id_card_widget.dart';

@RoutePage()
class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Search & Filters for Tab 0 (Overview / डॅशबोर्ड)
  String _overviewSelectedState = 'MH';     // Default: Maharashtra
  String _overviewSelectedDistrict = 'ALL'; // Default: All Districts (सर्व जिल्हे)
  String _overviewSelectedTaluka = 'ALL';   // Default: All Talukas (सर्व तालुके)
  String _overviewSelectedProfileStatus = 'ALL'; // 'ALL', 'COMPLETE', 'PENDING'
  String _appliedOverviewState = 'MH';       // Applied State via 'शोधा'
  String _appliedOverviewDistrict = 'ALL';   // Applied District via 'शोधा'
  String _appliedOverviewTaluka = 'ALL';     // Applied Taluka via 'शोधा'
  String _appliedOverviewProfileStatus = 'ALL'; // Applied Profile Status via 'शोधा'
  final TextEditingController _overviewSearchController = TextEditingController();
  String _overviewSearchQuery = '';

  // Search & Filters for Tab 1 (Officials / कार्यकारिणी)
  final TextEditingController _officialSearchController = TextEditingController();
  String _filterOfficialLevel = 'ALL'; // ALL, core, vibhag, jilha, taluka
  String _filterOfficialVibhag = 'ALL';
  String _filterOfficialDistrict = 'ALL';
  String _filterOfficialTaluka = 'ALL';
  String _officialSearchQuery = '';

  @override
  void initState() {
    super.initState();
    // 3 clean tabs: Overview (डॅशबोर्ड), Officials (कार्यकारिणी), Referrals (रेफरल मोहीम)
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _overviewSearchController.dispose();
    _officialSearchController.dispose();
    super.dispose();
  }

  Future<void> _handleLogout() async {
    await AdminAuthService.instance.signOut();
    if (mounted) {
      context.router.replaceAll([const LandingRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final admin = AdminAuthService.instance.currentAdminNotifier.value;

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkSurface,
        title: Row(
          children: [
            Image.asset(AppAssets.logo, width: 34, height: 34),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'मराठा शिवमुद्रा ॲडमिन कन्सोल',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldLight,
                  ),
                ),
                Text(
                  'Admin: ${admin?.email ?? "Super Admin"} (${admin?.role ?? "Super Admin"})',
                  style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: AppColors.goldLight),
            tooltip: 'डेटा रिफ्रेश करा',
            onPressed: () {
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('डॅशबोर्ड डेटा रिफ्रेश केला आहे.')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            tooltip: 'लॉगआउट करा (Logout)',
            onPressed: _handleLogout,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppColors.saffron,
          labelColor: AppColors.goldLight,
          unselectedLabelColor: AppColors.textMuted,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard_rounded), text: 'डॅशबोर्ड (Overview)'),
            Tab(icon: Icon(Icons.badge_rounded), text: 'कार्यकारिणी (Officials)'),
            Tab(icon: Icon(Icons.link_rounded), text: 'रेफरल मोहीम (Referrals)'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildOverviewTab(),
          _buildOfficialsTab(),
          _buildReferralsTab(),
        ],
      ),
    );
  }

  String _getDocStateCode(Map<String, dynamic> data) {
    final stateCode = (data['state_code'] as String? ?? '').trim().toUpperCase();
    if (stateCode.isNotEmpty) return stateCode;

    final state = (data['state'] as String? ?? '').trim().toLowerCase();
    if (state == 'maharashtra' || state == 'महाराष्ट्र') return 'MH';
    if (state == 'karnataka' || state == 'कर्नाटक') return 'KA';
    if (state == 'gujarat' || state == 'गुजरात') return 'GJ';
    if (state == 'goa' || state == 'गोवा') return 'GA';
    if (state == 'madhya pradesh' || state == 'मध्य प्रदेश') return 'MP';

    final dCode = (data['district_code'] as String? ?? '').trim().toUpperCase();
    if (dCode.startsWith('KA-') || dCode == 'KA-BEL') return 'KA';
    if (dCode.startsWith('GJ-') || dCode == 'GJ-SUR') return 'GJ';
    if (dCode.contains('-')) {
      final prefix = dCode.split('-').first;
      if (GeoConstants.states.any((s) => s.code == prefix)) return prefix;
    }

    final dist = (data['district_en'] as String? ?? data['district'] as String? ?? '').trim().toLowerCase();
    if (dist.contains('belgaum') || dist.contains('belagavi')) return 'KA';
    if (dist.contains('surat')) return 'GJ';

    for (final s in GeoConstants.states) {
      if (s.code == 'MH') continue;
      for (final d in s.districts) {
        if (d.nameEn.toLowerCase() == dist || d.nameMr == dist) {
          return s.code;
        }
      }
    }

    return 'MH';
  }

  bool _isDocInMaharashtra(Map<String, dynamic> data) {
    return _getDocStateCode(data) == 'MH';
  }

  String _getDocDistrictEn(Map<String, dynamic> data) {
    final dCode = (data['district_code'] as String? ?? '').trim().toUpperCase();
    if (dCode.isNotEmpty) {
      for (final s in GeoConstants.states) {
        for (final d in s.districts) {
          if (d.code == dCode || d.code.endsWith(dCode)) return d.nameEn;
        }
      }
    }
    final rawDistrict = (data['district_en'] as String? ?? data['district'] as String? ?? '').trim();
    if (rawDistrict.isNotEmpty) {
      final normalized = rawDistrict.toLowerCase();
      for (final s in GeoConstants.states) {
        for (final d in s.districts) {
          if (d.nameEn.toLowerCase() == normalized || d.nameMr == rawDistrict) {
            return d.nameEn;
          }
        }
      }
      return DistrictConstants.getNameEn(rawDistrict);
    }
    return 'Pune';
  }

  DistrictInfo _getDistrictInfoByNameEn(String districtEn) {
    final lower = districtEn.toLowerCase();
    for (final s in GeoConstants.states) {
      for (final d in s.districts) {
        if (d.nameEn.toLowerCase() == lower || d.nameMr == districtEn) return d;
      }
    }
    return DistrictInfo(code: 'OTH', nameEn: districtEn, nameMr: districtEn);
  }

  String _getDocTaluka(Map<String, dynamic> data) {
    final sub = (data['sub_district'] as String? ?? '').trim();
    if (sub.isNotEmpty) return sub;
    final subMr = (data['sub_district_mr'] as String? ?? '').trim();
    if (subMr.isNotEmpty) return subMr;
    final tEn = (data['taluka_en'] as String? ?? data['taluka'] as String? ?? '').trim();
    if (tEn.isNotEmpty) return tEn;
    return '';
  }

  String _normalizeTalukaName(String rawTaluka, List<TalukaInfo> districtTalukas) {
    if (rawTaluka.isEmpty) return '';
    final trimmed = rawTaluka.trim();
    final lower = trimmed.toLowerCase();

    // 1. Direct match on English or Marathi
    for (final t in districtTalukas) {
      if (t.nameEn.toLowerCase() == lower || t.nameMr == trimmed) {
        return t.nameEn;
      }
    }

    // 2. Known aliases & colloquial variations
    const aliasMap = <String, String>{
      'koregav': 'Koregaon',
      'कोरेगांव': 'Koregaon',
      'dahiwadi': 'Man',
      'दहीवाडी': 'Man',
      'dombivali': 'Kalyan',
      'डोंबिवली': 'Kalyan',
      'मीरारोड': 'Thane',
      'mira road': 'Thane',
      'कांदिवली': 'Borivali',
      'मालाड': 'Borivali',
      'वडाळा': 'Wadala',
      'माटुंगा': 'Matunga',
      'पुणे विभाग': 'Pune City',
      'चांदुर रेल्वे': 'Chandur Railway',
      'जाफराबाद': 'Jafrabad',
    };
    if (aliasMap.containsKey(lower)) {
      final target = aliasMap[lower]!;
      for (final t in districtTalukas) {
        if (t.nameEn.toLowerCase() == target.toLowerCase()) return t.nameEn;
      }
    }
    if (aliasMap.containsKey(trimmed)) {
      final target = aliasMap[trimmed]!;
      for (final t in districtTalukas) {
        if (t.nameEn.toLowerCase() == target.toLowerCase()) return t.nameEn;
      }
    }

    // 3. Phonetic and Devanagari normalizations
    final deAnuswar = trimmed.replaceAll('गांव', 'गाव');
    final gaonNorm = lower.endsWith('gav') ? '${lower.substring(0, lower.length - 3)}gaon' : lower;

    for (final t in districtTalukas) {
      if (t.nameEn.toLowerCase() == gaonNorm ||
          t.nameMr == deAnuswar ||
          t.nameMr.replaceAll('गांव', 'गाव') == deAnuswar) {
        return t.nameEn;
      }
    }

    // 4. Substring containment
    for (final t in districtTalukas) {
      if (lower.contains(t.nameEn.toLowerCase()) ||
          t.nameEn.toLowerCase().contains(lower) ||
          trimmed.contains(t.nameMr) ||
          t.nameMr.contains(trimmed)) {
        return t.nameEn;
      }
    }

    return rawTaluka;
  }

  // ==========================================
  // TAB 1: OVERVIEW & ANALYTICS
  // ==========================================
  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: StreamBuilder<SocialImpactModel>(
        stream: LandingFirebaseService.instance.getSocialImpactStream(),
        builder: (context, impactSnap) {
          final impact = impactSnap.data ?? const SocialImpactModel();
          final int rawRegistered = int.tryParse(impact.volunteers.replaceAll(',', '').replaceAll('+', '').trim()) ?? 0;

          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection('members').snapshots(),
            builder: (context, snapshot) {
              final rawDocs = snapshot.data?.docs ?? [];
              final registeredDocs = rawDocs.where((d) => d.data()['is_registered'] == true).toList();

              final int totalRegistered = registeredDocs.isNotEmpty ? registeredDocs.length : rawRegistered;

              final issued = registeredDocs.where((d) {
                final data = d.data();
                return data['is_card_issued'] == true ||
                    (data['member_id'] != null && data['member_id'] != 'PENDING');
              }).length;
              final pending = totalRegistered - issued;

              // Compute filtered members for Overview tab
              var filteredOverviewDocs = registeredDocs;

              // 1. State Filter (Dynamic per registered state)
              if (_appliedOverviewState != 'ALL_INDIA') {
                filteredOverviewDocs = filteredOverviewDocs.where((doc) {
                  return _getDocStateCode(doc.data()) == _appliedOverviewState;
                }).toList();
              }

              // 2. Specific District Filter (if not 'ALL')
              if (_appliedOverviewDistrict != 'ALL') {
                filteredOverviewDocs = filteredOverviewDocs.where((doc) {
                  final dEn = _getDocDistrictEn(doc.data());
                  return dEn.toLowerCase() == _appliedOverviewDistrict.toLowerCase();
                }).toList();

                // 3. Specific Taluka Filter (if not 'ALL')
                if (_appliedOverviewTaluka != 'ALL') {
                  final talukaTarget = _appliedOverviewTaluka.toLowerCase();
                  final distInfo = _getDistrictInfoByNameEn(_appliedOverviewDistrict);
                  filteredOverviewDocs = filteredOverviewDocs.where((doc) {
                    final raw = _getDocTaluka(doc.data());
                    if (raw.isEmpty) return false;
                    final normEn = _normalizeTalukaName(raw, distInfo.talukas).toLowerCase();
                    return normEn == talukaTarget ||
                        raw.toLowerCase() == talukaTarget ||
                        raw.toLowerCase().contains(talukaTarget);
                  }).toList();
                }
              }

              // 4. Profile Completion Status Filter (100% Complete vs Pending)
              if (_appliedOverviewProfileStatus == 'COMPLETE') {
                filteredOverviewDocs = filteredOverviewDocs.where((doc) {
                  final profile = MemberProfile.fromFirestore(doc.id, doc.data());
                  return profile.isProfileComplete;
                }).toList();
              } else if (_appliedOverviewProfileStatus == 'PENDING') {
                filteredOverviewDocs = filteredOverviewDocs.where((doc) {
                  final profile = MemberProfile.fromFirestore(doc.id, doc.data());
                  return !profile.isProfileComplete;
                }).toList();
              }

              // 5. Live Search Query
              if (_overviewSearchQuery.isNotEmpty) {
                filteredOverviewDocs = filteredOverviewDocs.where((doc) {
                  final data = doc.data();
                  final nameEn = (data['full_name_en'] as String? ?? data['name'] as String? ?? '').toLowerCase();
                  final nameMr = (data['full_name_mr'] as String? ?? data['name_mr'] as String? ?? '').toLowerCase();
                  final phone = (data['phone'] as String? ?? '').toLowerCase();
                  final mId = (data['member_id'] as String? ?? '').toLowerCase();
                  final taluka = (data['sub_district'] as String? ?? '').toLowerCase();
                  final dist = (data['district_en'] as String? ?? data['district'] as String? ?? '').toLowerCase();
                  final distMr = (data['district_mr'] as String? ?? '').toLowerCase();
                  final village = (data['village'] as String? ?? data['city_or_village'] as String? ?? data['city'] as String? ?? '').toLowerCase();
                  final address = (data['address'] as String? ?? '').toLowerCase();
                  final blood = (data['blood_group'] as String? ?? '').toLowerCase();
                  return nameEn.contains(_overviewSearchQuery) ||
                      nameMr.contains(_overviewSearchQuery) ||
                      phone.contains(_overviewSearchQuery) ||
                      mId.contains(_overviewSearchQuery) ||
                      taluka.contains(_overviewSearchQuery) ||
                      dist.contains(_overviewSearchQuery) ||
                      distMr.contains(_overviewSearchQuery) ||
                      village.contains(_overviewSearchQuery) ||
                      address.contains(_overviewSearchQuery) ||
                      blood.contains(_overviewSearchQuery);
                }).toList();
              }

              // Build Active Filter Breadcrumb
              String filterBreadcrumb;
              if (_appliedOverviewState == 'ALL_INDIA') {
                filterBreadcrumb = '🇮🇳 संपूर्ण भारत (सर्व सभासद)';
              } else if (_appliedOverviewState == 'MH') {
                filterBreadcrumb = '🚩 महाराष्ट्र';
              } else {
                final sInfo = GeoConstants.getStateByCode(_appliedOverviewState);
                filterBreadcrumb = '📍 ${sInfo.nameMr} (${sInfo.nameEn})';
              }

              if (_appliedOverviewDistrict != 'ALL') {
                final distInfo = _getDistrictInfoByNameEn(_appliedOverviewDistrict);
                filterBreadcrumb += ' > ${distInfo.nameMr} (${distInfo.nameEn})';

                if (_appliedOverviewTaluka != 'ALL') {
                  final matchedTaluka = distInfo.talukas.where((t) => t.nameEn.toLowerCase() == _appliedOverviewTaluka.toLowerCase()).firstOrNull;
                  final talukaLabel = matchedTaluka != null ? '${matchedTaluka.nameMr} (${matchedTaluka.nameEn})' : _appliedOverviewTaluka;
                  filterBreadcrumb += ' > $talukaLabel';
                } else {
                  filterBreadcrumb += ' • सर्व तालुके';
                }
              } else {
                filterBreadcrumb += ' • सर्व जिल्हे';
              }

              if (_appliedOverviewProfileStatus == 'COMPLETE') {
                filterBreadcrumb += ' • पूर्ण प्रोफाईल (100% / ओळखपत्र जारी)';
              } else if (_appliedOverviewProfileStatus == 'PENDING') {
                filterBreadcrumb += ' • अपूर्ण प्रोफाईल (प्रलंबित अर्ज)';
              }

              if (_overviewSearchQuery.isNotEmpty) {
                filterBreadcrumb += ' • शोध: "$_overviewSearchQuery"';
              }

              final isFilteredActive = _appliedOverviewState != 'MH' ||
                  _appliedOverviewDistrict != 'ALL' ||
                  _appliedOverviewTaluka != 'ALL' ||
                  _appliedOverviewProfileStatus != 'ALL' ||
                  _overviewSearchQuery.isNotEmpty;

              // 1. Build dynamic live-calculated state dropdown options from query docs
              final Map<String, int> stateCounts = {};
              for (final doc in registeredDocs) {
                final sc = _getDocStateCode(doc.data());
                stateCounts[sc] = (stateCounts[sc] ?? 0) + 1;
              }

              final List<AppDropdownItem<String>> stateDropdownItems = [];
              final mhCount = stateCounts['MH'] ?? 0;
              if (mhCount > 0 || stateCounts.isEmpty) {
                stateDropdownItems.add(
                  AppDropdownItem<String>(
                    value: 'MH',
                    label: '🚩 महाराष्ट्र',
                    subtitle: '$mhCount सभासद',
                    searchKey: 'महाराष्ट्र maharashtra mh state राज्य',
                  ),
                );
              }

              final sortedOtherStateCodes = stateCounts.keys.where((k) => k != 'MH').toList()..sort();
              for (final code in sortedOtherStateCodes) {
                final stateInfo = GeoConstants.getStateByCode(code);
                final count = stateCounts[code]!;
                stateDropdownItems.add(
                  AppDropdownItem<String>(
                    value: code,
                    label: '📍 ${stateInfo.nameMr} (${stateInfo.nameEn})',
                    subtitle: '$count सभासद',
                    searchKey: '${stateInfo.nameMr} ${stateInfo.nameEn} $code',
                  ),
                );
              }

              stateDropdownItems.add(
                AppDropdownItem<String>(
                  value: 'ALL_INDIA',
                  label: '🇮🇳 संपूर्ण भारत (All India)',
                  subtitle: 'सर्व $totalRegistered सभासद',
                  searchKey: 'संपूर्ण भारत अखिल भारतीय all india national',
                ),
              );

              // 2. Build dynamic live-calculated district dropdown options
              final List<QueryDocumentSnapshot<Map<String, dynamic>>> stateDocs;
              if (_overviewSelectedState == 'ALL_INDIA') {
                stateDocs = registeredDocs;
              } else {
                stateDocs = registeredDocs.where((d) => _getDocStateCode(d.data()) == _overviewSelectedState).toList();
              }

              final Map<String, int> districtCounts = {};
              for (final doc in stateDocs) {
                final distEn = _getDocDistrictEn(doc.data());
                districtCounts[distEn] = (districtCounts[distEn] ?? 0) + 1;
              }

              final List<AppDropdownItem<String>> districtDropdownItems = [
                AppDropdownItem<String>(
                  value: 'ALL',
                  label: 'सर्व जिल्हे (All Districts)',
                  subtitle: '${stateDocs.length} सभासद',
                  searchKey: 'सर्व all jilha district जिल्हे',
                ),
              ];

              final List<DistrictInfo> districtPool;
              if (_overviewSelectedState == 'ALL_INDIA') {
                districtPool = GeoConstants.states.expand((s) => s.districts).toList();
              } else {
                final sInfo = GeoConstants.getStateByCode(_overviewSelectedState);
                districtPool = sInfo.districts;
              }

              final activeDistricts = <DistrictInfo>[];
              final seenDistCodes = <String>{};

              for (final d in districtPool) {
                final count = districtCounts[d.nameEn] ?? 0;
                if (count > 0 && seenDistCodes.add(d.code)) {
                  activeDistricts.add(d);
                }
              }

              for (final distEn in districtCounts.keys) {
                final count = districtCounts[distEn]!;
                if (count > 0 && !activeDistricts.any((d) => d.nameEn.toLowerCase() == distEn.toLowerCase())) {
                  activeDistricts.add(_getDistrictInfoByNameEn(distEn));
                }
              }

              // Sort active districts by member count descending
              activeDistricts.sort((a, b) {
                final cA = districtCounts[a.nameEn] ?? 0;
                final cB = districtCounts[b.nameEn] ?? 0;
                final comp = cB.compareTo(cA);
                return comp != 0 ? comp : a.nameMr.compareTo(b.nameMr);
              });

              for (final d in activeDistricts) {
                final count = districtCounts[d.nameEn] ?? 0;
                districtDropdownItems.add(
                  AppDropdownItem<String>(
                    value: d.nameEn,
                    label: '${d.nameMr} (${d.nameEn})',
                    subtitle: '$count सभासद',
                    searchKey: '${d.nameMr} ${d.nameEn}',
                  ),
                );
              }

              // 3. Build dynamic live-calculated taluka dropdown options (only if specific district selected)
              final bool showTalukaDropdown = _overviewSelectedDistrict != 'ALL';
              final List<AppDropdownItem<String>> talukaDropdownItems = [];

              if (showTalukaDropdown) {
                final districtDocs = stateDocs.where((d) => _getDocDistrictEn(d.data()).toLowerCase() == _overviewSelectedDistrict.toLowerCase()).toList();
                final districtInfo = _getDistrictInfoByNameEn(_overviewSelectedDistrict);
                final talukas = districtInfo.talukas;

                final Map<String, int> talukaCounts = {};
                final Map<String, String> talukaLabels = {};

                for (final doc in districtDocs) {
                  final raw = _getDocTaluka(doc.data());
                  if (raw.isEmpty) continue;
                  final normEn = _normalizeTalukaName(raw, talukas);
                  talukaCounts[normEn] = (talukaCounts[normEn] ?? 0) + 1;
                  if (!talukaLabels.containsKey(normEn)) {
                    final matched = talukas.where((t) => t.nameEn.toLowerCase() == normEn.toLowerCase()).firstOrNull;
                    talukaLabels[normEn] = matched != null ? '${matched.nameMr} (${matched.nameEn})' : normEn;
                  }
                }

                talukaDropdownItems.add(
                  AppDropdownItem<String>(
                    value: 'ALL',
                    label: 'सर्व तालुके (All Talukas)',
                    subtitle: '${districtDocs.length} सभासद',
                    searchKey: 'सर्व all taluka तालुके',
                  ),
                );

                final sortedTalukaKeys = talukaCounts.keys.toList()
                  ..sort((a, b) => talukaCounts[b]!.compareTo(talukaCounts[a]!));

                for (final tKey in sortedTalukaKeys) {
                  final count = talukaCounts[tKey]!;
                  if (count > 0) {
                    talukaDropdownItems.add(
                      AppDropdownItem<String>(
                        value: tKey,
                        label: talukaLabels[tKey] ?? tKey,
                        subtitle: '$count सभासद',
                        searchKey: '${talukaLabels[tKey]} $tKey',
                      ),
                    );
                  }
                }
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // KPI Cards Row (Interactive filtering on click)
                  Row(
                    children: [
                      Expanded(
                        child: _buildKpiCard(
                          'एकूण नोंदणीकृत सभासद',
                          totalRegistered.toString(),
                          Icons.groups_rounded,
                          AppColors.goldLight,
                          subtitle: 'सर्व सभासद (क्लिक करा)',
                          isSelected: _appliedOverviewProfileStatus == 'ALL',
                          onTap: () {
                            setState(() {
                              _overviewSelectedProfileStatus = 'ALL';
                              _appliedOverviewProfileStatus = 'ALL';
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildKpiCard(
                          'जारी केलेली ओळखपत्रे',
                          issued.toString(),
                          Icons.badge,
                          Colors.greenAccent,
                          subtitle: '100% पूर्ण प्रोफाईल (क्लिक करा)',
                          isSelected: _appliedOverviewProfileStatus == 'COMPLETE',
                          onTap: () {
                            setState(() {
                              _overviewSelectedProfileStatus = 'COMPLETE';
                              _appliedOverviewProfileStatus = 'COMPLETE';
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildKpiCard(
                          'प्रलंबित नोंदण्या',
                          pending.toString(),
                          Icons.pending_actions,
                          Colors.orangeAccent,
                          subtitle: 'अपूर्ण प्रोफाईल (क्लिक करा)',
                          isSelected: _appliedOverviewProfileStatus == 'PENDING',
                          onTap: () {
                            setState(() {
                              _overviewSelectedProfileStatus = 'PENDING';
                              _appliedOverviewProfileStatus = 'PENDING';
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // State, District, Taluka, Profile Status & Search Button Row
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.darkSurface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.darkBorder),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isCompact = constraints.maxWidth < 750;

                        final stateField = AppSearchableDropdown<String>(
                          value: stateDropdownItems.any((s) => s.value == _overviewSelectedState)
                              ? _overviewSelectedState
                              : (stateDropdownItems.isNotEmpty ? stateDropdownItems.first.value : 'MH'),
                          labelText: 'राज्य (State)',
                          searchHint: 'राज्य शोधा... (Search state)',
                          prefixIcon: const Icon(Icons.map_rounded, color: AppColors.gold, size: 18),
                          items: stateDropdownItems,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _overviewSelectedState = val;
                                _overviewSelectedDistrict = 'ALL';
                                _overviewSelectedTaluka = 'ALL';
                              });
                            }
                          },
                        );

                        final districtField = AppSearchableDropdown<String>(
                          key: ValueKey('dist_${_overviewSelectedState}_${districtDropdownItems.length}'),
                          value: districtDropdownItems.any((d) => d.value == _overviewSelectedDistrict)
                              ? _overviewSelectedDistrict
                              : 'ALL',
                          labelText: 'जिल्हा (District)',
                          searchHint: 'जिल्हा शोधा... (Search district)',
                          prefixIcon: const Icon(Icons.location_city_rounded, color: AppColors.gold, size: 18),
                          items: districtDropdownItems,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _overviewSelectedDistrict = val;
                                _overviewSelectedTaluka = 'ALL';
                              });
                            }
                          },
                        );

                        final talukaField = showTalukaDropdown
                            ? AppSearchableDropdown<String>(
                                key: ValueKey('taluka_${_overviewSelectedDistrict}_${talukaDropdownItems.length}'),
                                value: talukaDropdownItems.any((t) => t.value == _overviewSelectedTaluka)
                                    ? _overviewSelectedTaluka
                                    : 'ALL',
                                labelText: 'तालुका (Taluka)',
                                searchHint: 'तालुका शोधा... (Search taluka)',
                                prefixIcon: const Icon(Icons.holiday_village_rounded, color: AppColors.gold, size: 18),
                                items: talukaDropdownItems,
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      _overviewSelectedTaluka = val;
                                    });
                                  }
                                },
                              )
                            : const SizedBox.shrink();

                        final profileStatusField = AppSearchableDropdown<String>(
                          value: _overviewSelectedProfileStatus,
                          labelText: 'प्रोफाईल स्थिती (Profile Status)',
                          searchHint: 'स्थिती शोधा...',
                          prefixIcon: const Icon(Icons.verified_user_rounded, color: AppColors.gold, size: 18),
                          items: [
                            AppDropdownItem<String>(
                              value: 'ALL',
                              label: 'सर्व स्थिती (All Profiles)',
                              subtitle: '$totalRegistered एकूण सभासद',
                              searchKey: 'सर्व all status स्थिती',
                            ),
                            AppDropdownItem<String>(
                              value: 'COMPLETE',
                              label: 'पूर्ण प्रोफाईल (100% / कार्ड जारी)',
                              subtitle: '$issued सभासद (Active Cards)',
                              searchKey: 'पूर्ण complete 100% ओळखपत्र जारी issued सक्रिय',
                            ),
                            AppDropdownItem<String>(
                              value: 'PENDING',
                              label: 'अपूर्ण प्रोफाईल (प्रलंबित अर्ज)',
                              subtitle: '$pending सभासद (Pending)',
                              searchKey: 'अपूर्ण pending incomplete प्रलंबित बाकी',
                            ),
                          ],
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _overviewSelectedProfileStatus = val);
                            }
                          },
                        );

                        final searchBtn = ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _appliedOverviewState = _overviewSelectedState;
                              _appliedOverviewDistrict = _overviewSelectedDistrict;
                              _appliedOverviewTaluka = _overviewSelectedDistrict == 'ALL' ? 'ALL' : _overviewSelectedTaluka;
                              _appliedOverviewProfileStatus = _overviewSelectedProfileStatus;
                            });
                          },
                          icon: const Icon(Icons.search_rounded, color: Colors.white, size: 18),
                          label: const Text(
                            'शोधा',
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.saffron,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 2,
                          ),
                        );

                        if (isCompact) {
                          return Column(
                            children: [
                              stateField,
                              const SizedBox(height: 12),
                              districtField,
                              if (showTalukaDropdown) ...[
                                const SizedBox(height: 12),
                                talukaField,
                              ],
                              const SizedBox(height: 12),
                              profileStatusField,
                              const SizedBox(height: 12),
                              SizedBox(width: double.infinity, child: searchBtn),
                            ],
                          );
                        }

                        return Row(
                          children: [
                            Expanded(flex: 3, child: stateField),
                            const SizedBox(width: 10),
                            Expanded(flex: 3, child: districtField),
                            if (showTalukaDropdown) ...[
                              const SizedBox(width: 10),
                              Expanded(flex: 3, child: talukaField),
                            ],
                            const SizedBox(width: 10),
                            Expanded(flex: 3, child: profileStatusField),
                            const SizedBox(width: 12),
                            searchBtn,
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Counter of that specific search (Before live search field & list)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.darkSurface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.gold.withValues(alpha: 0.35)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.gold.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.people_alt_rounded, color: AppColors.goldLight, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'शोधलेले एकूण सभासद: ',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    '${filteredOverviewDocs.length}',
                                    style: const TextStyle(
                                      fontFamily: AppTypography.fontFamily,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.goldLight,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                filterBreadcrumb,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textMuted,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        if (isFilteredActive) ...[
                          const SizedBox(width: 8),
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                _overviewSelectedState = 'MH';
                                _overviewSelectedDistrict = 'ALL';
                                _overviewSelectedTaluka = 'ALL';
                                _overviewSelectedProfileStatus = 'ALL';
                                _appliedOverviewState = 'MH';
                                _appliedOverviewDistrict = 'ALL';
                                _appliedOverviewTaluka = 'ALL';
                                _appliedOverviewProfileStatus = 'ALL';
                                _overviewSearchController.clear();
                                _overviewSearchQuery = '';
                              });
                            },
                            icon: const Icon(Icons.refresh_rounded, size: 14, color: AppColors.goldLight),
                            label: const Text(
                              'रीसेट',
                              style: TextStyle(fontSize: 12, color: AppColors.goldLight),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Live Search Field
                  TextField(
                    controller: _overviewSearchController,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'नाव, मोबाईल, तालुका, गाव किंवा सभासद क्र. शोधा...',
                      hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                      filled: true,
                      fillColor: AppColors.darkSurface,
                      prefixIcon: const Icon(Icons.search_rounded, color: AppColors.gold),
                      suffixIcon: _overviewSearchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, color: AppColors.textMuted),
                              onPressed: () {
                                _overviewSearchController.clear();
                                setState(() => _overviewSearchQuery = '');
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.darkBorder),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.darkBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    onChanged: (val) => setState(() => _overviewSearchQuery = val.trim().toLowerCase()),
                  ),
                  const SizedBox(height: 16),

                  // Matching Users List
                  if (filteredOverviewDocs.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(36),
                      decoration: BoxDecoration(
                        color: AppColors.darkSurface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.darkBorder),
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.person_search_rounded, color: AppColors.textMuted, size: 48),
                          SizedBox(height: 12),
                          Text(
                            'या निकषांनुसार कोणतेही सभासद आढळले नाहीत.',
                            style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'कृपया जिल्हा/तालुका तपासा किंवा वेगळा शोध शब्द वापरा.',
                            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredOverviewDocs.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final doc = filteredOverviewDocs[index];
                        final data = doc.data();
                        final phone = data['phone'] as String? ?? doc.id;
                        final profile = MemberProfile.fromFirestore(phone, data);
                        final isIssued = profile.isCardIssued ||
                            (profile.memberId != null && profile.memberId != 'PENDING');
                        final displayName = profile.fullNameMr.isNotEmpty
                            ? profile.fullNameMr
                            : (profile.fullNameEn.isNotEmpty ? profile.fullNameEn : 'सभासद');
                        final nameEn = profile.fullNameEn;
                        final subDistrict = profile.subDistrict;
                        final district = profile.districtMr.isNotEmpty ? profile.districtMr : profile.districtEn;
                        final village = profile.village.isNotEmpty ? profile.village : profile.city;
                        final memberId = profile.memberId ?? 'PENDING';

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _showMemberFullDetailsDialog(data, doc),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: AppColors.darkSurface,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.darkBorder),
                              ),
                              child: Row(
                                children: [
                                  _buildMemberAvatar(profile, size: 44),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                displayName,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            if (nameEn.isNotEmpty && nameEn != displayName) ...[
                                              const SizedBox(width: 6),
                                              Flexible(
                                                child: Text(
                                                  '($nameEn)',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.textSecondary,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                            if (data['is_promoted'] == true) ...[
                                              const SizedBox(width: 8),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                                decoration: BoxDecoration(
                                                  color: Colors.amber.shade900.withValues(alpha: 0.3),
                                                  borderRadius: BorderRadius.circular(4),
                                                  border: Border.all(color: Colors.amber, width: 0.8),
                                                ),
                                                child: const Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons.military_tech_rounded, color: Colors.amber, size: 11),
                                                    SizedBox(width: 3),
                                                    Text(
                                                      'पदोन्नतीकृत (Promoted)',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.amber,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                            if (profile.isOfficial || profile.designation.isNotEmpty || profile.roleType != 'member') ...[
                                              const SizedBox(width: 8),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFB8860B),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  profile.officialFullTitleMr ?? (profile.designation.isNotEmpty ? profile.designation : 'पदाधिकारी'),
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          'फोन: ${profile.phone}  •  तालुका: ${subDistrict.isNotEmpty ? subDistrict : "-"}  •  जिल्हा: $district${village.isNotEmpty ? "  •  गाव: $village" : ""}',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: AppColors.textSecondary,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: isIssued
                                          ? Colors.green.withValues(alpha: 0.15)
                                          : Colors.orangeAccent.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      isIssued ? memberId : 'अपूर्ण (Pending)',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: isIssued ? Colors.greenAccent : Colors.orangeAccent,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.chevron_right_rounded, color: AppColors.goldLight, size: 20),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildKpiCard(
    String title,
    String value,
    IconData icon,
    Color color, {
    String? subtitle,
    VoidCallback? onTap,
    bool isSelected = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.darkSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.gold : AppColors.darkBorder,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withValues(alpha: 0.15),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 10,
                          color: isSelected ? AppColors.goldLight : AppColors.textMuted,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (isSelected)
                const Icon(Icons.check_circle_rounded, color: AppColors.goldLight, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // TAB 3: REFERRAL CAMPAIGNS & QUOTAS
  // ==========================================
  Widget _buildReferralsTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'रेफरल मोहिमा व मर्यादा (Referral Campaigns)',
                style: TextStyle(fontFamily: AppTypography.fontFamily, fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.goldLight),
              ),
              ElevatedButton.icon(
                onPressed: _showCreateReferralDialog,
                icon: const Icon(Icons.add_link_rounded, color: Colors.white),
                label: const Text('नवीन रेफरल लिंक तयार करा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.saffron, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Expanded(
            child: StreamBuilder<List<ReferralCampaign>>(
              stream: ReferralService.instance.streamAllCampaigns(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.saffron));
                }

                final campaigns = snapshot.data ?? [];
                if (campaigns.isEmpty) {
                  return const Center(child: Text('कोणतीही सक्रिय रेफरल मोहीम आढळली नाही. वरील बटणावर क्लिक करून तयार करा.', style: TextStyle(color: AppColors.textMuted)));
                }

                return ListView.separated(
                  itemCount: campaigns.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final c = campaigns[index];
                    final link = 'https://marathashivmudra.web.app/?ref=${c.code}';

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.darkSurface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: c.isActive ? AppColors.gold.withValues(alpha: 0.4) : AppColors.darkBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(color: AppColors.saffron, borderRadius: BorderRadius.circular(6)),
                                    child: Text(c.code, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(c.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              Switch(
                                value: c.isActive,
                                activeThumbColor: AppColors.goldLight,
                                activeTrackColor: AppColors.saffron,
                                onChanged: (val) => ReferralService.instance.toggleStatus(c.code, val),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Quota Progress
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'वापर: ${c.usedCount} / ${c.isUnlimited ? "अमर्यादित (Unlimited)" : "${c.maxLimit} सभासद"}',
                                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                              ),
                              if (c.isLimitReached)
                                const Text('⚠️ मर्यादा समाप्त (Limit Reached)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: c.progress,
                              minHeight: 8,
                              backgroundColor: AppColors.darkBorder,
                              valueColor: AlwaysStoppedAnimation<Color>(c.isLimitReached ? Colors.orangeAccent : AppColors.saffron),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Copy Link
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  link,
                                  style: const TextStyle(fontSize: 12, color: AppColors.goldLight),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.copy_rounded, color: AppColors.goldLight, size: 20),
                                tooltip: 'लिंक कॉपी करा',
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(text: link));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('रेफरल लिंक कॉपी झाली: $link')),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateReferralDialog() {
    final codeCtrl = TextEditingController();
    final titleCtrl = TextEditingController();
    final limitCtrl = TextEditingController(text: '50');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkSurface,
        title: const Text('नवीन रेफरल लिंक तयार करा', style: TextStyle(color: AppColors.goldLight)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: codeCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'रेफरल कोड (उदा. PUNE_50, YOUTH_100)', filled: true, fillColor: AppColors.darkBgHeroTop),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: titleCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'मोहीम शीर्षक (Campaign Title)', filled: true, fillColor: AppColors.darkBgHeroTop),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: limitCtrl,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'मर्यादा / कोटा (0 = अमर्यादित)', filled: true, fillColor: AppColors.darkBgHeroTop),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करा', style: TextStyle(color: AppColors.textMuted))),
          ElevatedButton(
            onPressed: () async {
              final code = codeCtrl.text.trim().toUpperCase();
              final title = titleCtrl.text.trim();
              final limit = int.tryParse(limitCtrl.text.trim()) ?? 0;

              if (code.isNotEmpty) {
                await ReferralService.instance.saveCampaign(
                  ReferralCampaign(
                    code: code,
                    title: title.isNotEmpty ? title : code,
                    maxLimit: limit,
                    usedCount: 0,
                    isActive: true,
                  ),
                );
              }
              if (mounted) Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.saffron),
            child: const Text('तयार करा', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // TAB 1: OFFICIALS & COMMITTEES (कार्यकारिणी)
  // ==========================================
  Widget _buildOfficialsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hierarchy Banner
          _buildHierarchyHeader(),
          const SizedBox(height: 20),

          // Live KPI Counters (Interactive)
          _buildOfficialsKpis(),
          const SizedBox(height: 28),

          // Section 1: Promoted Candidates Queue (पदोन्नतीकृत उमेदवार - पदभार वाटप प्रलंबित)
          _buildPromotedCandidatesSection(),
          const SizedBox(height: 32),

          // Section 2: Appointed Officials Directory (नियुक्त संघटनात्मक कार्यकारिणी)
          _buildAppointedOfficialsSection(),
        ],
      ),
    );
  }

  Widget _buildHierarchyHeader() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2E0F0F),
            Color(0xFF1B0808),
            Color(0xFF120505),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.5), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColors.saffron.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gold, width: 1.5),
                ),
                child: const Icon(Icons.account_balance_rounded, color: AppColors.goldLight, size: 24),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'मराठा शिवमुद्रा प्रतिष्ठान — संघटनात्मक कार्यकारिणी रचना',
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldLight,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      '४-स्तरीय अधिकृत रचना: संस्थापक व अध्यक्ष (Super Admin) ➔ राज्य कोर समिती ➔ विभाग ➔ जिल्हा ➔ तालुका',
                      style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.darkBorder, height: 1),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              _buildHierarchyPill('👑 संस्थापक व अध्यक्ष', 'Super Admin (सर्वोच्च प्रमुख)', AppColors.gold),
              _buildHierarchyPill('🏛️ राज्य / कोर समिती', '१९ पदे (राज्यस्तरीय संचालन)', AppColors.saffron),
              _buildHierarchyPill('🏢 विभाग समिती', '६ विभाग (प्रत्येकी ५ पदे)', Colors.purpleAccent),
              _buildHierarchyPill('🚩 जिल्हा समिती', '३६ जिल्हे (प्रत्येकी ११ पदे)', Colors.cyanAccent),
              _buildHierarchyPill('📍 तालुका समिती', 'प्रत्येकी ५ पदे', Colors.greenAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHierarchyPill(String title, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(width: 6),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 10.5, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildOfficialsKpis() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: OrganizationService.instance.getPromotedCandidatesStream(),
      builder: (context, promotedSnap) {
        final promotedCount = promotedSnap.data?.length ?? 0;

        return FutureBuilder<Map<String, int>>(
          future: OrganizationService.instance.getOfficialsCounts(),
          builder: (context, snapshot) {
            final counts = snapshot.data ?? {'total': 0, 'core': 0, 'vibhag': 0, 'jilha': 0, 'taluka': 0};

            return LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 900;
                final cards = [
                  _buildKpiCard(
                    'एकूण नियुक्त पदाधिकारी',
                    counts['total'].toString(),
                    Icons.badge_rounded,
                    AppColors.goldLight,
                    subtitle: 'सक्रिय संघटनात्मक पदे',
                    isSelected: _filterOfficialLevel == 'ALL',
                    onTap: () => setState(() => _filterOfficialLevel = 'ALL'),
                  ),
                  _buildKpiCard(
                    'पदोन्नतीकृत उमेदवार',
                    promotedCount.toString(),
                    Icons.star_rounded,
                    AppColors.saffron,
                    subtitle: 'पदभार वाटप प्रलंबित',
                  ),
                  _buildKpiCard(
                    'कोर समिती (Core)',
                    '${counts['core']} / 19',
                    Icons.account_balance_rounded,
                    AppColors.gold,
                    subtitle: 'राज्यस्तरीय पदे',
                    isSelected: _filterOfficialLevel == 'core',
                    onTap: () => setState(() {
                      _filterOfficialLevel = 'core';
                      _filterOfficialVibhag = 'ALL';
                      _filterOfficialDistrict = 'ALL';
                      _filterOfficialTaluka = 'ALL';
                    }),
                  ),
                  _buildKpiCard(
                    'विभाग समिती',
                    '${counts['vibhag']} / 30',
                    Icons.business_rounded,
                    Colors.purpleAccent,
                    subtitle: '६ महसूल विभाग',
                    isSelected: _filterOfficialLevel == 'vibhag',
                    onTap: () => setState(() {
                      _filterOfficialLevel = 'vibhag';
                      _filterOfficialDistrict = 'ALL';
                      _filterOfficialTaluka = 'ALL';
                    }),
                  ),
                  _buildKpiCard(
                    'जिल्हा व तालुका',
                    '${(counts['jilha'] ?? 0) + (counts['taluka'] ?? 0)}',
                    Icons.location_city_rounded,
                    Colors.cyanAccent,
                    subtitle: 'स्थानिक कार्यकारिणी',
                    isSelected: _filterOfficialLevel == 'jilha' || _filterOfficialLevel == 'taluka',
                    onTap: () => setState(() => _filterOfficialLevel = 'jilha'),
                  ),
                ];

                if (isCompact) {
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: cards.map((c) => SizedBox(
                      width: (constraints.maxWidth - 12) / 2 > 160 ? (constraints.maxWidth - 12) / 2 : constraints.maxWidth,
                      child: c,
                    )).toList(),
                  );
                }

                return Row(
                  children: cards.map((c) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: c,
                    ),
                  )).toList(),
                );
              },
            );
          },
        );
      },
    );
  }

  // ==========================================
  // SECTION 1: PROMOTED CANDIDATES QUEUE
  // ==========================================
  Widget _buildPromotedCandidatesSection() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: OrganizationService.instance.getPromotedCandidatesStream(),
      builder: (context, snapshot) {
        final candidates = snapshot.data ?? [];

        return Container(
          decoration: BoxDecoration(
            color: AppColors.darkSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: candidates.isNotEmpty ? AppColors.gold.withValues(alpha: 0.6) : AppColors.darkBorder,
              width: candidates.isNotEmpty ? 1.5 : 1.0,
            ),
            boxShadow: candidates.isNotEmpty
                ? [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: candidates.isNotEmpty ? AppColors.gold.withValues(alpha: 0.12) : AppColors.darkBgHeroTop,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  border: Border(bottom: BorderSide(color: AppColors.darkBorder.withValues(alpha: 0.8))),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.gold, width: 1.2),
                      ),
                      child: const Icon(Icons.star_rounded, color: AppColors.goldLight, size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '⭐ पदोन्नतीकृत उमेदवार (पदभार वाटप प्रलंबित)',
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldLight,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'डॅशबोर्डवरून पदोन्नती मिळालेले सभासद. खालीलपैकी उमेदवारास योग्य समिती व पदावर नियुक्त करा.',
                            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: candidates.isNotEmpty ? AppColors.saffron : AppColors.darkBorder,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${candidates.length} उमेदवार',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              // Body content
              if (candidates.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.workspace_premium_outlined, size: 40, color: AppColors.textMuted.withValues(alpha: 0.6)),
                        const SizedBox(height: 10),
                        const Text(
                          'सध्या कोणताही पदोन्नतीकृत उमेदवार प्रलंबित नाही.',
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'डॅशबोर्डवरील सभासद कार्डमधील "पदोन्नती करा (Promote to Official)" बटण दाबून येथे उमेदवार पाठवा.',
                          style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.separated(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: candidates.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final candidate = candidates[index];
                    return _buildPromotedCandidateCard(candidate);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPromotedCandidateCard(Map<String, dynamic> candidate) {
    final String nameMr = candidate['name_mr']?.toString().isNotEmpty == true
        ? candidate['name_mr'].toString()
        : (candidate['name_en']?.toString() ?? '');
    final String nameEn = candidate['name_en']?.toString() ?? '';
    final String phone = candidate['phone']?.toString() ?? '';
    final String memberId = candidate['member_id']?.toString() ?? 'PENDING';
    final String district = candidate['district']?.toString() ?? '';
    final String taluka = candidate['taluka']?.toString() ?? '';
    final photoBase64 = candidate['photo_base64'] as String?;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkBgHeroTop,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.darkSurface,
            backgroundImage: (photoBase64 != null && photoBase64.isNotEmpty)
                ? (photoBase64.startsWith('http')
                    ? NetworkImage(photoBase64) as ImageProvider
                    : MemoryImage(base64Decode(photoBase64)))
                : null,
            child: (photoBase64 == null || photoBase64.isEmpty)
                ? const Icon(Icons.person_rounded, color: AppColors.goldLight, size: 24)
                : null,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        nameMr,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (nameEn.isNotEmpty && nameEn != nameMr) ...[
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          '($nameEn)',
                          style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  children: [
                    Text('📞 $phone', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    Text('ID: $memberId', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.greenAccent)),
                    if (district.isNotEmpty)
                      Text('📍 $district${taluka.isNotEmpty ? ', $taluka' : ''}', style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () => _showAppointOfficialDialog(context, initialCandidate: candidate),
                icon: const Icon(Icons.assignment_ind_rounded, size: 16, color: Colors.white),
                label: const Text(
                  'पदभार सोपवा',
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.saffron,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.close_rounded, size: 20, color: Colors.redAccent),
                tooltip: 'पदोन्नती रद्द करा',
                onPressed: () => _confirmUnpromoteMember(candidate),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirmUnpromoteMember(Map<String, dynamic> candidate) {
    final String name = candidate['name_mr']?.toString().isNotEmpty == true
        ? candidate['name_mr'].toString()
        : (candidate['name_en']?.toString() ?? '');
    final String phone = candidate['phone']?.toString() ?? '';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: AppColors.darkBorder)),
        title: const Text('पदोन्नती रद्द करा?', style: TextStyle(color: Colors.redAccent)),
        content: Text(
          'तुम्हाला खरोखर $name यांची पदोन्नती रद्द करायची आहे का? ते पदभार वाटपाच्या यादीतून काढले जातील.',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करा', style: TextStyle(color: AppColors.textMuted))),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final success = await OrganizationService.instance.unpromoteMember(phone);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(success ? 'पदोन्नती यशस्वीरीत्या रद्द केली.' : 'त्रुटी: पदोन्नती रद्द होऊ शकली नाही.')),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('होय, रद्द करा', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // SECTION 2: APPOINTED OFFICIALS DIRECTORY
  // ==========================================
  Widget _buildAppointedOfficialsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header & Body Filter Chips
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '📋 नियुक्त संघटनात्मक कार्यकारिणी',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldLight,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'विविध समित्यांमध्ये कार्यरत असलेले अधिकृत पदाधिकारी',
                  style: TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () => _showAppointOfficialDialog(context),
              icon: const Icon(Icons.person_add_alt_1_rounded, size: 18, color: Colors.white),
              label: const Text(
                'नवीन पदभार सोपवा',
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.saffron,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Body Filters Bar (Filter Chips)
        _buildBodyFilterChips(),
        const SizedBox(height: 16),

        // Filter & Search Toolbar (AppSearchableDropdown)
        _buildOfficialsToolbar(),
        const SizedBox(height: 16),

        // Officials List (Grouped by main body when ALL is selected)
        _buildOfficialsList(),
      ],
    );
  }

  Widget _buildBodyFilterChips() {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: [
        _buildBodyFilterChip('ALL', '🏛️ सर्व समित्या (All)'),
        _buildBodyFilterChip('core', '🏛️ राज्य / कोर समिती'),
        _buildBodyFilterChip('vibhag', '🏢 विभागीय समिती'),
        _buildBodyFilterChip('jilha', '🚩 जिल्हा समिती'),
        _buildBodyFilterChip('taluka', '📍 तालुका समिती'),
      ],
    );
  }

  Widget _buildBodyFilterChip(String levelCode, String label) {
    final isSelected = _filterOfficialLevel == levelCode;
    return FilterChip(
      selected: isSelected,
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isSelected ? Colors.black : Colors.white,
        ),
      ),
      backgroundColor: AppColors.darkSurface,
      selectedColor: AppColors.gold,
      checkmarkColor: Colors.black,
      side: BorderSide(
        color: isSelected ? AppColors.gold : AppColors.darkBorder,
        width: isSelected ? 1.5 : 1.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      onSelected: (selected) {
        setState(() {
          _filterOfficialLevel = levelCode;
          if (levelCode == 'core') {
            _filterOfficialVibhag = 'ALL';
            _filterOfficialDistrict = 'ALL';
            _filterOfficialTaluka = 'ALL';
          } else if (levelCode == 'vibhag') {
            _filterOfficialDistrict = 'ALL';
            _filterOfficialTaluka = 'ALL';
          }
        });
      },
    );
  }

  Widget _buildOfficialsToolbar() {
    final showVibhag = _filterOfficialLevel == 'ALL' || _filterOfficialLevel == 'vibhag' || _filterOfficialLevel == 'jilha' || _filterOfficialLevel == 'taluka';
    final showDistrict = _filterOfficialLevel == 'ALL' || _filterOfficialLevel == 'jilha' || _filterOfficialLevel == 'taluka';
    final showTaluka = (_filterOfficialLevel == 'ALL' || _filterOfficialLevel == 'taluka') && _filterOfficialDistrict != 'ALL';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Field
          TextField(
            controller: _officialSearchController,
            style: const TextStyle(color: Colors.white, fontSize: 13),
            decoration: InputDecoration(
              hintText: 'नाव, फोन, पद किंवा जिल्ह्यानुसार शोधा...',
              hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
              prefixIcon: const Icon(Icons.search, color: AppColors.goldLight, size: 18),
              suffixIcon: _officialSearchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 16, color: AppColors.textMuted),
                      onPressed: () {
                        setState(() {
                          _officialSearchController.clear();
                          _officialSearchQuery = '';
                        });
                      },
                    )
                  : null,
              filled: true,
              fillColor: AppColors.darkBgHeroTop,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            ),
            onChanged: (val) => setState(() => _officialSearchQuery = val.trim()),
          ),

          if (showVibhag || showDistrict || showTaluka) ...[
            const SizedBox(height: 14),
            LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 750;

                final vibhagItems = [
                  const AppDropdownItem<String>(value: 'ALL', label: 'सर्व विभाग (All Divisions)', searchKey: 'all sarva vibhag'),
                  ...OrganizationRoles.maharashtraVibhags.map((v) => AppDropdownItem<String>(
                        value: v.nameEn,
                        label: '${v.nameMr} (${v.nameEn})',
                        searchKey: '${v.nameMr} ${v.nameEn}',
                      )),
                ];

                final districtItems = [
                  const AppDropdownItem<String>(value: 'ALL', label: 'सर्व जिल्हे (All Districts)', searchKey: 'all sarva district jilha'),
                  ...DistrictConstants.districts
                      .where((d) {
                        if (_filterOfficialVibhag == 'ALL') return true;
                        final vibhag = OrganizationRoles.maharashtraVibhags.firstWhere(
                          (v) => v.nameEn == _filterOfficialVibhag,
                          orElse: () => OrganizationRoles.maharashtraVibhags.first,
                        );
                        return vibhag.districts.contains(d.nameEn);
                      })
                      .map((d) => AppDropdownItem<String>(
                            value: d.nameEn,
                            label: '${d.nameMr} (${d.nameEn})',
                            searchKey: '${d.nameMr} ${d.nameEn}',
                          )),
                ];

                final talukaItems = [
                  const AppDropdownItem<String>(value: 'ALL', label: 'सर्व तालुके (All Talukas)', searchKey: 'all sarva taluka'),
                  ..._getTalukasForDistrict(_filterOfficialDistrict).map((t) => AppDropdownItem<String>(
                        value: t.nameEn,
                        label: '${t.nameMr} (${t.nameEn})',
                        searchKey: '${t.nameMr} ${t.nameEn}',
                      )),
                ];

                final vibhagField = showVibhag
                    ? AppSearchableDropdown<String>(
                        value: vibhagItems.any((v) => v.value == _filterOfficialVibhag) ? _filterOfficialVibhag : 'ALL',
                        labelText: 'विभाग (Division)',
                        searchHint: 'विभाग शोधा...',
                        prefixIcon: const Icon(Icons.business_rounded, color: AppColors.gold, size: 18),
                        items: vibhagItems,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _filterOfficialVibhag = val;
                              _filterOfficialDistrict = 'ALL';
                              _filterOfficialTaluka = 'ALL';
                            });
                          }
                        },
                      )
                    : null;

                final districtField = showDistrict
                    ? AppSearchableDropdown<String>(
                        key: ValueKey('off_dist_${_filterOfficialVibhag}_$_filterOfficialDistrict'),
                        value: districtItems.any((d) => d.value == _filterOfficialDistrict) ? _filterOfficialDistrict : 'ALL',
                        labelText: 'जिल्हा (District)',
                        searchHint: 'जिल्हा शोधा...',
                        prefixIcon: const Icon(Icons.location_city_rounded, color: AppColors.gold, size: 18),
                        items: districtItems,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _filterOfficialDistrict = val;
                              _filterOfficialTaluka = 'ALL';
                            });
                          }
                        },
                      )
                    : null;

                final talukaField = showTaluka
                    ? AppSearchableDropdown<String>(
                        key: ValueKey('off_taluka_${_filterOfficialDistrict}_$_filterOfficialTaluka'),
                        value: talukaItems.any((t) => t.value == _filterOfficialTaluka) ? _filterOfficialTaluka : 'ALL',
                        labelText: 'तालुका (Taluka)',
                        searchHint: 'तालुका शोधा...',
                        prefixIcon: const Icon(Icons.holiday_village_rounded, color: AppColors.gold, size: 18),
                        items: talukaItems,
                        onChanged: (val) {
                          if (val != null) setState(() => _filterOfficialTaluka = val);
                        },
                      )
                    : null;

                if (isCompact) {
                  return Column(
                    children: [
                      if (vibhagField != null) vibhagField,
                      if (districtField != null) ...[const SizedBox(height: 10), districtField],
                      if (talukaField != null) ...[const SizedBox(height: 10), talukaField],
                    ],
                  );
                }

                return Row(
                  children: [
                    if (vibhagField != null) Expanded(child: vibhagField),
                    if (districtField != null) ...[const SizedBox(width: 12), Expanded(child: districtField)],
                    if (talukaField != null) ...[const SizedBox(width: 12), Expanded(child: talukaField)],
                  ],
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOfficialsList() {
    OrganizationLevel? lvl;
    if (_filterOfficialLevel == 'core') lvl = OrganizationLevel.core;
    if (_filterOfficialLevel == 'vibhag') lvl = OrganizationLevel.vibhag;
    if (_filterOfficialLevel == 'jilha') lvl = OrganizationLevel.jilha;
    if (_filterOfficialLevel == 'taluka') lvl = OrganizationLevel.taluka;

    return StreamBuilder<List<OfficialMember>>(
      stream: OrganizationService.instance.getOfficialsStream(
        level: lvl,
        vibhag: _filterOfficialVibhag != 'ALL' ? _filterOfficialVibhag : null,
        district: _filterOfficialDistrict != 'ALL' ? _filterOfficialDistrict : null,
        taluka: _filterOfficialTaluka != 'ALL' ? _filterOfficialTaluka : null,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(color: AppColors.goldLight),
            ),
          );
        }

        final allOfficials = snapshot.data ?? [];
        final query = _officialSearchQuery.toLowerCase();

        final filtered = allOfficials.where((o) {
          if (query.isEmpty) return true;
          return o.nameEn.toLowerCase().contains(query) ||
              o.nameMr.toLowerCase().contains(query) ||
              o.phone.contains(query) ||
              o.memberId.toLowerCase().contains(query) ||
              o.roleNameMr.toLowerCase().contains(query) ||
              o.roleNameEn.toLowerCase().contains(query) ||
              (o.district?.toLowerCase().contains(query) ?? false) ||
              (o.taluka?.toLowerCase().contains(query) ?? false);
        }).toList();

        if (filtered.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(40),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.darkBorder),
            ),
            child: Column(
              children: [
                const Icon(Icons.shield_outlined, size: 48, color: AppColors.textMuted),
                const SizedBox(height: 12),
                const Text(
                  'निवडलेल्या निकषांनुसार कोणतेही पदाधिकारी नियुक्त केलेले नाहीत.',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => _showAppointOfficialDialog(context),
                  icon: const Icon(Icons.add, size: 18, color: Colors.white),
                  label: const Text('नवीन नियुक्ती करा', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.saffron),
                ),
              ],
            ),
          );
        }

        // If specific body selected, show simple list
        if (_filterOfficialLevel != 'ALL') {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return _buildOfficialCard(filtered[index]);
            },
          );
        }

        // When 'ALL' selected: Group into committees separated by main body!
        final coreList = filtered.where((o) => o.level == OrganizationLevel.core).toList();
        final vibhagList = filtered.where((o) => o.level == OrganizationLevel.vibhag).toList();
        final jilhaList = filtered.where((o) => o.level == OrganizationLevel.jilha).toList();
        final talukaList = filtered.where((o) => o.level == OrganizationLevel.taluka).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCommitteeGroupSection(
              title: '🏛️ केंद्रीय / राज्य कोर समिती (State Core Committee)',
              subtitle: 'महाराष्ट्र राज्यव्यापी संचालन व मुख्य नेतृत्व (१९ पदे)',
              accentColor: AppColors.gold,
              officials: coreList,
            ),
            const SizedBox(height: 24),
            _buildCommitteeGroupSection(
              title: '🏢 विभागीय समित्या (Divisional Committees)',
              subtitle: '६ प्रशासकीय विभागांचे विभागीय नेतृत्व (प्रत्येकी ५ पदे)',
              accentColor: Colors.purpleAccent,
              officials: vibhagList,
            ),
            const SizedBox(height: 24),
            _buildCommitteeGroupSection(
              title: '🚩 जिल्हा समित्या (District Committees)',
              subtitle: 'जिल्हास्तरीय कार्यकारी मंडळ (प्रत्येकी ११ पदे)',
              accentColor: Colors.cyanAccent,
              officials: jilhaList,
            ),
            const SizedBox(height: 24),
            _buildCommitteeGroupSection(
              title: '📍 तालुका समित्या (Taluka Committees)',
              subtitle: 'तालुका व स्थानिक पातळीवरील संघटनात्मक नेतृत्व (प्रत्येकी ५ पदे)',
              accentColor: Colors.greenAccent,
              officials: talukaList,
            ),
          ],
        );
      },
    );
  }

  Widget _buildCommitteeGroupSection({
    required String title,
    required String subtitle,
    required Color accentColor,
    required List<OfficialMember> officials,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
              border: Border(bottom: BorderSide(color: AppColors.darkBorder.withValues(alpha: 0.8))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: accentColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(subtitle, style: const TextStyle(fontSize: 11.5, color: AppColors.textMuted)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: accentColor.withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    '${officials.length} नियुक्त',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: accentColor),
                  ),
                ),
              ],
            ),
          ),
          // Section Content
          if (officials.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'या समितीमध्ये सध्या कोणतेही पदाधिकारी नियुक्त केलेले नाहीत.',
                  style: TextStyle(color: AppColors.textMuted.withValues(alpha: 0.8), fontSize: 13),
                ),
              ),
            )
          else
            ListView.separated(
              padding: const EdgeInsets.all(14),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: officials.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return _buildOfficialCard(officials[index]);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildOfficialCard(OfficialMember official) {
    Color levelColor = AppColors.gold;
    String levelBadgeText = 'राज्य कोर समिती';
    if (official.level == OrganizationLevel.vibhag) {
      levelColor = Colors.purpleAccent;
      levelBadgeText = 'विभाग: ${official.vibhagMr ?? official.vibhag}';
    } else if (official.level == OrganizationLevel.jilha) {
      levelColor = Colors.cyanAccent;
      levelBadgeText = 'जिल्हा: ${official.districtMr ?? official.district}';
    } else if (official.level == OrganizationLevel.taluka) {
      levelColor = Colors.greenAccent;
      levelBadgeText = 'तालुका: ${official.talukaMr ?? official.taluka}';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Member Photo / Avatar
          CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.darkBgHeroTop,
            backgroundImage: official.photoUrl != null && official.photoUrl!.isNotEmpty
                ? NetworkImage(official.photoUrl!)
                : null,
            child: (official.photoUrl == null || official.photoUrl!.isEmpty)
                ? Icon(Icons.person_rounded, color: levelColor, size: 28)
                : null,
          ),
          const SizedBox(width: 14),

          // Main Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Level & Jurisdiction Row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: levelColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: levelColor.withValues(alpha: 0.6), width: 0.8),
                      ),
                      child: Text(
                        levelBadgeText,
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: levelColor),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'ID: ${official.memberId}',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.greenAccent),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Official Role Designation
                Text(
                  official.roleNameMr,
                  style: const TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldLight,
                  ),
                ),
                Text(
                  '${official.roleNameEn}  •  ${official.fullTitleMr}',
                  style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 4),

                // Member Name & Phone
                Row(
                  children: [
                    Text(
                      '${official.nameMr} (${official.nameEn})',
                      style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '📞 ${official.phone}',
                      style: const TextStyle(fontSize: 11.5, color: AppColors.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Action Buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton.icon(
                onPressed: () async {
                  final prof = await MemberProfileService.instance.getProfile(official.phone);
                  if (prof != null && context.mounted) {
                    showDialog(
                      context: context,
                      builder: (ctx) => Dialog(
                        backgroundColor: Colors.transparent,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 480),
                          child: MemberIdCardWidget(profile: prof),
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.badge_outlined, size: 16, color: AppColors.goldLight),
                label: const Text('ओळखपत्र', style: TextStyle(fontSize: 11, color: AppColors.goldLight)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.gold, width: 0.8),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent, size: 20),
                tooltip: 'पदमुक्ती करा (Revoke Appointment)',
                onPressed: () => _confirmRevokeOfficial(official),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirmRevokeOfficial(OfficialMember official) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkSurface,
        title: const Text('पदमुक्ती निश्चित करा', style: TextStyle(color: Colors.redAccent)),
        content: Text(
          'तुम्हाला खरोखर ${official.nameMr} (${official.roleNameMr}) यांना या पदावरून पदमुक्त करायचे आहे का?',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करा', style: TextStyle(color: AppColors.textMuted))),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final success = await OrganizationService.instance.revokeOfficial(official.phone);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(success ? 'पदाधिकाऱ्यास यशस्वीरीत्या पदमुक्त केले आहे.' : 'त्रुटी: पदमुक्ती होऊ शकली नाही.')),
                );
                setState(() {});
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('होय, पदमुक्त करा', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAppointOfficialDialog(BuildContext context, {Map<String, dynamic>? initialCandidate}) {
    showDialog(
      context: context,
      builder: (ctx) => _AppointOfficialDialog(initialCandidate: initialCandidate),
    ).then((_) {
      if (mounted) setState(() {});
    });
  }

  String _formatDate(DateTime? dt) {
    if (dt == null) return '-';
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
  }

  void _showMemberFullDetailsDialog(Map<String, dynamic> data, DocumentSnapshot<Map<String, dynamic>> doc) {
    final phone = data['phone'] as String? ?? doc.id;
    final profile = MemberProfile.fromFirestore(phone, data);
    final isIssued = profile.isCardIssued || (profile.memberId != null && profile.memberId != 'PENDING');
    final nameMr = profile.fullNameMr.isNotEmpty ? profile.fullNameMr : profile.fullNameEn;
    final nameEn = profile.fullNameEn;

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.darkBorder),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580, maxHeight: 720),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: const BoxDecoration(
                  color: AppColors.darkBgHeroTop,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  border: Border(bottom: BorderSide(color: AppColors.darkBorder)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.badge_rounded, color: AppColors.goldLight, size: 20),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'सभासद संपूर्ण माहिती',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldLight,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: AppColors.textMuted),
                      onPressed: () => Navigator.pop(ctx),
                      splashRadius: 20,
                    ),
                  ],
                ),
              ),

              // Scrollable Details Body
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Identity Banner
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.darkBgHeroTop,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            // Profile Avatar / Photo
                            _buildMemberAvatar(profile, size: 68),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nameMr,
                                    style: const TextStyle(
                                      fontFamily: AppTypography.fontFamily,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  if (nameEn.isNotEmpty && nameEn != nameMr) ...[
                                    const SizedBox(height: 2),
                                    Text(
                                      nameEn,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 6),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 4,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: isIssued
                                              ? Colors.green.withValues(alpha: 0.2)
                                              : Colors.orangeAccent.withValues(alpha: 0.2),
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(
                                            color: isIssued ? Colors.greenAccent : Colors.orangeAccent,
                                            width: 0.8,
                                          ),
                                        ),
                                        child: Text(
                                          isIssued ? 'ID: ${profile.memberId}' : 'नोंदणी: प्रलंबित (Pending)',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: isIssued ? Colors.greenAccent : Colors.orangeAccent,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: profile.isProfileComplete
                                              ? const Color(0xFF10B981).withValues(alpha: 0.2)
                                              : Colors.amber.withValues(alpha: 0.2),
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(
                                            color: profile.isProfileComplete
                                                ? const Color(0xFF10B981)
                                                : Colors.amber,
                                            width: 0.8,
                                          ),
                                        ),
                                        child: Text(
                                          '${(profile.completionProgress * 100).round()}% प्रोफाईल',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: profile.isProfileComplete
                                                ? const Color(0xFF10B981)
                                                : Colors.amber,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '📞 ${profile.phone}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.goldLight,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Official Role Banner (If appointed)
                      if (profile.isOfficial || profile.designation.isNotEmpty || profile.roleType != 'member') ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFB8860B).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFB8860B).withValues(alpha: 0.5)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.military_tech_rounded, color: AppColors.goldLight, size: 28),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'मराठा शिवमुद्रा अधिकृत पदाधिकारी',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.goldLight,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      profile.officialFullTitleMr ?? (profile.designation.isNotEmpty ? profile.designation : 'पदाधिकारी'),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    if (profile.officialFullTitleEn != null && profile.officialFullTitleEn!.isNotEmpty) ...[
                                      Text(
                                        profile.officialFullTitleEn!,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // 1. Current Address Section
                      _buildDetailSection(
                        '📍 सध्याचा पत्ता (Current Address)',
                        [
                          _buildDetailRow('जिल्हा (District)', '${profile.districtMr} (${profile.districtEn})', icon: Icons.location_city_rounded),
                          _buildDetailRow('तालुका (Taluka)', profile.subDistrict.isNotEmpty ? profile.subDistrict : '-', icon: Icons.holiday_village_rounded),
                          _buildDetailRow('गाव / शहर (Village/City)', profile.village.isNotEmpty ? profile.village : (profile.city.isNotEmpty ? profile.city : '-'), icon: Icons.home_rounded),
                          _buildDetailRow('पिनकोड (Pincode)', profile.pincode.isNotEmpty ? profile.pincode : '-', icon: Icons.markunread_mailbox_rounded),
                          _buildDetailRow('राज्य (State)', profile.state.isNotEmpty ? profile.state : 'महाराष्ट्र', icon: Icons.map_rounded),
                          _buildDetailRow('संपूर्ण पत्ता (Full Address)', profile.address.isNotEmpty ? profile.address : '-', icon: Icons.place_rounded),
                        ],
                      ),

                      // 1b. Native Village Address Section
                      _buildDetailSection(
                        '🏡 मूळ गाव पत्ता (Native Village Address)',
                        [
                          if (profile.isNativeAddressSameAsCurrent)
                            _buildDetailRow(
                              'स्थिती',
                              'सध्याचा पत्ता हाच मूळ गाव पत्ता आहे (Same as Current Address)',
                              icon: Icons.check_circle_outline_rounded,
                              valueColor: Colors.greenAccent,
                            )
                          else ...[
                            _buildDetailRow('मूळ राज्य (Native State)', profile.nativeState.isNotEmpty ? profile.nativeState : '-', icon: Icons.map_rounded),
                            _buildDetailRow('मूळ जिल्हा (Native District)', profile.nativeDistrict.isNotEmpty ? profile.nativeDistrict : '-', icon: Icons.location_city_rounded),
                            _buildDetailRow('मूळ तालुका (Native Taluka)', profile.nativeTaluka.isNotEmpty ? profile.nativeTaluka : '-', icon: Icons.holiday_village_rounded),
                            _buildDetailRow('मूळ गाव (Native Village)', profile.nativeVillage.isNotEmpty ? profile.nativeVillage : '-', icon: Icons.home_rounded),
                            _buildDetailRow('मूळ पिनकोड (Native Pincode)', profile.nativePincode.isNotEmpty ? profile.nativePincode : '-', icon: Icons.markunread_mailbox_rounded),
                            _buildDetailRow('मूळ संपूर्ण पत्ता (Native Address)', profile.nativeAddress.isNotEmpty ? profile.nativeAddress : '-', icon: Icons.place_rounded),
                          ],
                        ],
                      ),

                      // 2. Personal Details Section
                      _buildDetailSection(
                        '👤 वैयक्तिक तपशील (Personal Details)',
                        [
                          _buildDetailRow('जन्मतारीख (DOB)', profile.dateOfBirth.isNotEmpty ? profile.dateOfBirth : '-', icon: Icons.cake_rounded),
                          _buildDetailRow('लिंग (Gender)', profile.gender.isNotEmpty ? profile.gender : '-', icon: Icons.person_rounded),
                          _buildDetailRow('रक्तगट (Blood Group)', profile.bloodGroup.isNotEmpty ? profile.bloodGroup : '-', icon: Icons.bloodtype_rounded, valueColor: Colors.redAccent),
                          _buildDetailRow('सद्यस्थिती (Living)', profile.living.isNotEmpty ? profile.living : '-', icon: Icons.home_work_rounded),
                          _buildDetailRow(
                            'मरणोत्तर अवयवदान (Organ Pledge)',
                            profile.isOrganDonorPledged
                                ? 'होय, मरणोत्तर अवयवदान संकल्पित 🫀'
                                : (profile.hasOrganDonationConsentAnswered ? 'नाही' : 'नोंद नाही'),
                            icon: Icons.favorite_rounded,
                            valueColor: profile.isOrganDonorPledged ? const Color(0xFF10B981) : AppColors.textMuted,
                          ),
                        ],
                      ),

                      // 3. Occupation & Education Details
                      _buildDetailSection(
                        '💼 व्यवसाय व शिक्षण तपशील (Occupation & Education)',
                        [
                          _buildDetailRow('मुख्य व्यवसाय (Profession)', profile.profession.isNotEmpty ? profile.profession : '-', icon: Icons.work_rounded),
                          if (profile.profession.contains('नोकरी') || profile.jobDesignation.isNotEmpty || profile.jobCompany.isNotEmpty) ...[
                            _buildDetailRow('नोकरी पद / हुद्दा', profile.jobDesignation.isNotEmpty ? profile.jobDesignation : '-', icon: Icons.badge_rounded),
                            _buildDetailRow('कंपनी / संस्था नाव', profile.jobCompany.isNotEmpty ? profile.jobCompany : '-', icon: Icons.business_rounded),
                          ],
                          if (profile.profession.contains('व्यवसाय') || profile.businessType.isNotEmpty) ...[
                            _buildDetailRow('व्यवसायाचे स्वरूप', profile.businessType.isNotEmpty ? profile.businessType : '-', icon: Icons.storefront_rounded),
                          ],
                          if (profile.profession.contains('विद्यार्थी') || profile.educationLevel.isNotEmpty) ...[
                            _buildDetailRow(
                              'शिक्षण शाखा / स्तर',
                              profile.educationLevel == 'इतर' && profile.educationOther.isNotEmpty
                                  ? 'इतर (${profile.educationOther})'
                                  : (profile.educationLevel.isNotEmpty ? profile.educationLevel : (profile.education.isNotEmpty ? profile.education : '-')),
                              icon: Icons.school_rounded,
                            ),
                          ] else if (profile.education.isNotEmpty) ...[
                            _buildDetailRow('शिक्षण (Education)', profile.education, icon: Icons.school_rounded),
                          ],
                          if (profile.profession.contains('शेती') || profile.cropsProduced.isNotEmpty) ...[
                            _buildDetailRow(
                              'पिकवली जाणारी पिके',
                              profile.cropsProduced.isNotEmpty ? profile.cropsProduced.join(', ') : '-',
                              icon: Icons.agriculture_rounded,
                              valueColor: Colors.lightGreenAccent,
                            ),
                          ],
                          if (profile.profession.contains('बेरोजगार') || profile.unemployedEducation.isNotEmpty) ...[
                            _buildDetailRow('उच्च शिक्षण', profile.unemployedEducation.isNotEmpty ? profile.unemployedEducation : '-', icon: Icons.school_rounded),
                            _buildDetailRow('इच्छित क्षेत्र', profile.unemployedPreferredSector.isNotEmpty ? profile.unemployedPreferredSector : '-', icon: Icons.explore_rounded),
                            _buildDetailRow('कौशल्ये/लायसन्स', profile.unemployedSkills.isNotEmpty ? profile.unemployedSkills : '-', icon: Icons.handyman_rounded),
                            _buildDetailRow('कामासाठी स्थलांतरास तयार', profile.willingToRelocate == true ? 'होय (Yes)' : 'नाही (No)', icon: Icons.transfer_within_a_station_rounded),
                          ],
                        ],
                      ),

                      // 4. Political & NGO Affiliations Section
                      _buildDetailSection(
                        '🏛️ राजकीय व सामाजिक सहभाग (Political & NGO)',
                        [
                          _buildDetailRow(
                            'राजकीय सहभाग (Political Active)',
                            profile.isPoliticallyActive == true
                                ? 'सक्रिय (होय)'
                                : (profile.isPoliticallyActive == false ? 'नाही' : '-'),
                            icon: Icons.how_to_vote_rounded,
                            valueColor: profile.isPoliticallyActive == true ? Colors.amberAccent : null,
                          ),
                          if (profile.isPoliticallyActive == true) ...[
                            _buildDetailRow('पक्ष / संघटना', profile.politicalParty.isNotEmpty ? profile.politicalParty : '-', icon: Icons.flag_rounded),
                            _buildDetailRow('पक्ष पद / जबाबदारी', profile.politicalRole.isNotEmpty ? profile.politicalRole : '-', icon: Icons.military_tech_rounded),
                          ],
                          _buildDetailRow(
                            'सामाजिक संस्था / NGO सहभाग',
                            profile.isAssociatedWithNgo == true
                                ? 'सक्रिय (होय)'
                                : (profile.isAssociatedWithNgo == false ? 'नाही' : '-'),
                            icon: Icons.groups_rounded,
                            valueColor: profile.isAssociatedWithNgo == true ? Colors.lightBlueAccent : null,
                          ),
                          if (profile.isAssociatedWithNgo == true) ...[
                            _buildDetailRow('संस्थेचे नाव (NGO Name)', profile.ngoName.isNotEmpty ? profile.ngoName : '-', icon: Icons.corporate_fare_rounded),
                            _buildDetailRow('संस्थेतील पद / कार्य', profile.ngoRole.isNotEmpty ? profile.ngoRole : '-', icon: Icons.assignment_ind_rounded),
                          ],
                        ],
                      ),

                      // 5. Emergency Contact Section
                      _buildDetailSection(
                        '🚨 आपत्कालीन संपर्क (Emergency Contact)',
                        [
                          _buildDetailRow('संपर्क व्यक्ती नाव', profile.emergencyContactName.isNotEmpty ? profile.emergencyContactName : '-', icon: Icons.contact_phone_rounded),
                          _buildDetailRow('संपर्क मोबाईल', profile.emergencyContactPhone.isNotEmpty ? profile.emergencyContactPhone : '-', icon: Icons.phone_in_talk_rounded, valueColor: AppColors.goldLight),
                        ],
                      ),

                      // 6. Registration & Card Info Section
                      _buildDetailSection(
                        '💳 नोंदणी व ओळखपत्र माहिती (System & ID Card)',
                        [
                          _buildDetailRow('नोंदणी तारीख', _formatDate(profile.createdAt), icon: Icons.calendar_today_rounded),
                          _buildDetailRow('ओळखपत्र स्थिती', profile.isCardIssued ? 'जारी केले (Issued)' : 'प्रलंबित (Pending)', icon: Icons.verified_user_rounded, valueColor: isIssued ? Colors.greenAccent : Colors.orangeAccent),
                          if (profile.cardIssuedDate != null)
                            _buildDetailRow('कार्ड जारी दिनांक', _formatDate(profile.cardIssuedDate), icon: Icons.event_available_rounded),
                          _buildDetailRow('रेफरल कोड (Referral ID)', (profile.referralId != null && profile.referralId!.isNotEmpty) ? profile.referralId! : '-', icon: Icons.share_rounded),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Action Buttons
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.darkBgHeroTop,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                  border: Border(top: BorderSide(color: AppColors.darkBorder)),
                ),
                child: Wrap(
                  alignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('बंद करा', style: TextStyle(color: AppColors.textMuted)),
                    ),
                    if (data['is_promoted'] == true) ...[
                      OutlinedButton.icon(
                        onPressed: () async {
                          await OrganizationService.instance.unpromoteMember(phone);
                          if (context.mounted) {
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$nameMr यांची पदोन्नती रद्द करण्यात आली आहे.'),
                                backgroundColor: Colors.orange.shade800,
                              ),
                            );
                            setState(() {});
                          }
                        },
                        icon: const Icon(Icons.person_remove_rounded, color: Colors.orangeAccent, size: 16),
                        label: const Text(
                          'पदोन्नती रद्द करा',
                          style: TextStyle(color: Colors.orangeAccent, fontSize: 12),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.orangeAccent),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        ),
                      ),
                    ] else if (!profile.isOfficial) ...[
                      ElevatedButton.icon(
                        onPressed: () async {
                          final success = await OrganizationService.instance.promoteMember(phone);
                          if (context.mounted) {
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  success
                                      ? '$nameMr यांना कार्यकारिणीसाठी यशस्वीरीत्या पदोन्नती दिली आहे! आता आपण \'कार्यकारिणी\' टॅबमधून पदभार सोपवू शकता.'
                                      : 'त्रुटी: पदोन्नती करता आली नाही.',
                                ),
                                backgroundColor: success ? Colors.green.shade800 : Colors.red.shade800,
                              ),
                            );
                            setState(() {});
                          }
                        },
                        icon: const Icon(Icons.military_tech_rounded, color: Colors.white, size: 18),
                        label: const Text(
                          'कार्यकारिणीसाठी पदोन्नती द्या (Promote)',
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 12.5,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber.shade900,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        ),
                      ),
                    ],
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _showIdCardPreview(profile);
                      },
                      icon: const Icon(Icons.badge_rounded, color: Colors.white, size: 18),
                      label: const Text(
                        'ओळखपत्र पाहा (View ID Card)',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.saffron,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showIdCardPreview(MemberProfile profile) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: MemberIdCardWidget(profile: profile),
        ),
      ),
    );
  }

  Widget _buildMemberAvatar(MemberProfile profile, {double size = 48}) {
    if (profile.photoBase64 != null && profile.photoBase64!.isNotEmpty) {
      try {
        return ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: Image.memory(
            base64Decode(profile.photoBase64!),
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _buildAvatarInitial(profile, size),
          ),
        );
      } catch (_) {}
    }
    if (profile.photoUrl != null && profile.photoUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: Image.network(
          profile.photoUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildAvatarInitial(profile, size),
        ),
      );
    }
    return _buildAvatarInitial(profile, size);
  }

  Widget _buildAvatarInitial(MemberProfile profile, double size) {
    final name = profile.fullNameMr.isNotEmpty ? profile.fullNameMr : profile.fullNameEn;
    final initial = name.isNotEmpty ? name[0].toUpperCase() : 'M';
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.saffron, Color(0xFFB8860B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(color: AppColors.goldLight, width: 1.5),
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: TextStyle(
          fontSize: size * 0.42,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> rows) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: AppColors.goldLight,
            ),
          ),
          const Divider(color: AppColors.darkBorder, height: 16),
          ...rows,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {IconData? icon, Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: AppColors.goldLight),
            const SizedBox(width: 8),
          ],
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ),
          const Text(': ', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          Expanded(
            child: SelectableText(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<TalukaInfo> _getTalukasForDistrict(String? districtEn) {
  if (districtEn == null || districtEn.isEmpty || districtEn == 'ALL' || districtEn == 'MH') return [];
  final clean = districtEn.trim().toLowerCase();
  for (final s in GeoConstants.states) {
    for (final d in s.districts) {
      if (d.nameEn.toLowerCase() == clean ||
          d.nameMr == districtEn.trim() ||
          d.code.toLowerCase() == clean) {
        return d.talukas;
      }
    }
  }
  return [];
}

/// Interactive modal dialog for appointing officials
class _AppointOfficialDialog extends StatefulWidget {
  final Map<String, dynamic>? initialCandidate;
  const _AppointOfficialDialog({this.initialCandidate});

  @override
  State<_AppointOfficialDialog> createState() => _AppointOfficialDialogState();
}

class _AppointOfficialDialogState extends State<_AppointOfficialDialog> {
  OrganizationLevel _selectedLevel = OrganizationLevel.core;
  String _selectedVibhagEn = 'Pune';
  String _selectedDistrictEn = 'Pune';
  String _selectedTaluka = '';
  RoleDefinition? _selectedRole;

  List<Map<String, dynamic>> _promotedCandidates = [];
  String? _selectedMemberPhone;
  bool _isLoadingMembers = true;
  bool _isSubmitting = false;

  Map<String, dynamic>? get _selectedMember {
    if (_selectedMemberPhone == null) return null;
    for (final m in _promotedCandidates) {
      if (m['phone'] == _selectedMemberPhone) return m;
    }
    if (widget.initialCandidate != null && widget.initialCandidate!['phone'] == _selectedMemberPhone) {
      return widget.initialCandidate;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialCandidate != null) {
      _selectedMemberPhone = widget.initialCandidate!['phone']?.toString();
      final dist = widget.initialCandidate!['district'] as String?;
      if (dist != null && dist.isNotEmpty && dist != 'ALL') {
        _selectedDistrictEn = dist;
        final v = OrganizationRoles.getVibhagForDistrict(dist);
        if (v != null) _selectedVibhagEn = v.nameEn;
      }
      final tal = widget.initialCandidate!['taluka'] as String?;
      if (tal != null && tal.isNotEmpty && tal != 'ALL') {
        _selectedTaluka = tal;
      }
    }
    _loadPromotedCandidates();
    _updateSelectedRole();
    _updateTalukas();
  }

  void _updateSelectedRole() {
    final roles = OrganizationRoles.getRolesForLevel(_selectedLevel);
    if (roles.isNotEmpty) {
      _selectedRole = roles.first;
    } else {
      _selectedRole = null;
    }
  }

  void _updateTalukas() {
    final talukas = _getTalukasForDistrict(_selectedDistrictEn);
    if (talukas.isNotEmpty) {
      if (!talukas.any((t) => t.nameEn == _selectedTaluka)) {
        _selectedTaluka = talukas.first.nameEn;
      }
    } else {
      _selectedTaluka = '';
    }
  }

  Future<void> _loadPromotedCandidates() async {
    try {
      final snap = await FirebaseFirestore.instance
          .collection('members')
          .where('is_promoted', isEqualTo: true)
          .limit(100)
          .get();

      if (mounted) {
        final list = snap.docs.map((d) => d.data()).toList();
        if (widget.initialCandidate != null) {
          final phone = widget.initialCandidate!['phone'];
          if (!list.any((m) => m['phone'] == phone)) {
            list.insert(0, widget.initialCandidate!);
          }
        }
        setState(() {
          _promotedCandidates = list;
          _isLoadingMembers = false;
          if (_selectedMemberPhone == null && list.isNotEmpty) {
            _selectedMemberPhone = list.first['phone']?.toString();
            final firstCandidate = list.first;
            final dist = firstCandidate['district'] as String?;
            if (dist != null && dist.isNotEmpty && dist != 'ALL') {
              _selectedDistrictEn = dist;
              final v = OrganizationRoles.getVibhagForDistrict(dist);
              if (v != null) _selectedVibhagEn = v.nameEn;
            }
            final tal = firstCandidate['taluka'] as String?;
            if (tal != null && tal.isNotEmpty && tal != 'ALL') {
              _selectedTaluka = tal;
            }
            _updateTalukas();
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingMembers = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final roles = OrganizationRoles.getRolesForLevel(_selectedLevel);
    final talukas = _getTalukasForDistrict(_selectedDistrictEn);

    // Generated titles preview
    String previewMr = '';
    String previewEn = '';
    if (_selectedRole != null) {
      switch (_selectedLevel) {
        case OrganizationLevel.core:
          previewMr = 'राज्य ${_selectedRole!.nameMr}';
          previewEn = 'State ${_selectedRole!.nameEn}';
          break;
        case OrganizationLevel.vibhag:
          final vibhag = OrganizationRoles.maharashtraVibhags.firstWhere(
            (v) => v.nameEn == _selectedVibhagEn,
            orElse: () => OrganizationRoles.maharashtraVibhags.first,
          );
          previewMr = '${vibhag.nameMr} विभाग ${_selectedRole!.nameMr}';
          previewEn = '${vibhag.nameEn} Division ${_selectedRole!.nameEn}';
          break;
        case OrganizationLevel.jilha:
          final dist = DistrictConstants.districts.firstWhere(
            (d) => d.nameEn == _selectedDistrictEn,
            orElse: () => DistrictConstants.districts.first,
          );
          previewMr = '${dist.nameMr} जिल्हा ${_selectedRole!.nameMr}';
          previewEn = '${dist.nameEn} District ${_selectedRole!.nameEn}';
          break;
        case OrganizationLevel.taluka:
          final dist = DistrictConstants.districts.firstWhere(
            (d) => d.nameEn == _selectedDistrictEn,
            orElse: () => DistrictConstants.districts.first,
          );
          final talukaItem = talukas.firstWhere(
            (t) => t.nameEn == _selectedTaluka,
            orElse: () => (talukas.isNotEmpty ? talukas.first : const TalukaInfo(nameEn: '', nameMr: '')),
          );
          previewMr = '${talukaItem.nameMr} तालुका ${_selectedRole!.nameMr} (${dist.nameMr} जिल्हा)';
          previewEn = '${talukaItem.nameEn} Taluka ${_selectedRole!.nameEn} (${dist.nameEn} District)';
          break;
      }
    }

    final candidateDropdownItems = _promotedCandidates.map((m) {
      final String nameMr = m['name_mr']?.toString().isNotEmpty == true
          ? m['name_mr'].toString()
          : (m['name_en']?.toString() ?? '');
      final String nameEn = m['name_en']?.toString() ?? '';
      final String phone = m['phone']?.toString() ?? '';
      final String id = m['member_id']?.toString() ?? 'PENDING';
      final String dist = m['district']?.toString() ?? '';
      final String label = '$nameMr ($phone) • ID: $id${dist.isNotEmpty ? ' • $dist' : ''}';

      return AppDropdownItem<String>(
        value: phone,
        label: label,
        searchKey: '$nameMr $nameEn $phone $id $dist',
      );
    }).toList();

    return Dialog(
      backgroundColor: AppColors.darkSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.gold, width: 1.2),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 620, maxHeight: 760),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dialog Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.badge_rounded, color: AppColors.goldLight, size: 24),
                      SizedBox(width: 10),
                      Text(
                        'नवीन पदाधिकारी नियुक्ती',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldLight,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textMuted),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // STEP 1: Select Candidate (Only Promoted Members)
              const Text(
                '१. पदोन्नतीकृत उमेदवार निवडा (Select Promoted Candidate)',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              if (_isLoadingMembers)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: CircularProgressIndicator(color: AppColors.goldLight),
                  ),
                )
              else if (_promotedCandidates.isEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.withValues(alpha: 0.4)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.orangeAccent, size: 18),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'कोणताही पदोन्नतीकृत उमेदवार उपलब्ध नाही. कृपया आधी डॅशबोर्डवरून सभासदास पदोन्नती द्या.',
                          style: TextStyle(color: Colors.orangeAccent, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                )
              else
                AppSearchableDropdown<String>(
                  key: ValueKey('cand_${_selectedMemberPhone}_${_promotedCandidates.length}'),
                  value: _selectedMemberPhone,
                  labelText: 'पदोन्नती मिळालेला उमेदवार',
                  searchHint: 'नाव, फोन किंवा ID शोधा...',
                  prefixIcon: const Icon(Icons.star_rounded, color: AppColors.gold, size: 18),
                  items: candidateDropdownItems,
                  onChanged: (phone) {
                    if (phone != null) {
                      setState(() {
                        _selectedMemberPhone = phone;
                        final cand = _selectedMember;
                        if (cand != null) {
                          final dist = cand['district'] as String?;
                          if (dist != null && dist.isNotEmpty && dist != 'ALL') {
                            _selectedDistrictEn = dist;
                            final v = OrganizationRoles.getVibhagForDistrict(dist);
                            if (v != null) _selectedVibhagEn = v.nameEn;
                          }
                          final tal = cand['taluka'] as String?;
                          if (tal != null && tal.isNotEmpty && tal != 'ALL') {
                            _selectedTaluka = tal;
                          }
                          _updateTalukas();
                        }
                      });
                    }
                  },
                ),
              const SizedBox(height: 18),

              // STEP 2: Organization Level / Main Body
              const Text(
                '२. संघटनात्मक स्तर / समिती निवडा (Organization Level / Body)',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              AppSearchableDropdown<OrganizationLevel>(
                key: ValueKey('level_$_selectedLevel'),
                value: _selectedLevel,
                labelText: 'संघटनात्मक स्तर / समिती',
                showSearch: false,
                prefixIcon: const Icon(Icons.account_tree_rounded, color: AppColors.gold, size: 18),
                items: const [
                  AppDropdownItem(
                    value: OrganizationLevel.core,
                    label: '🏛️ राज्य / कोर समिती (19 Roles)',
                    searchKey: 'core rajya state',
                  ),
                  AppDropdownItem(
                    value: OrganizationLevel.vibhag,
                    label: '🏢 विभागीय समिती (6 Divisions, 5 Roles each)',
                    searchKey: 'vibhag division',
                  ),
                  AppDropdownItem(
                    value: OrganizationLevel.jilha,
                    label: '🚩 जिल्हा समिती (36 Districts, 11 Roles each)',
                    searchKey: 'jilha district',
                  ),
                  AppDropdownItem(
                    value: OrganizationLevel.taluka,
                    label: '📍 तालुका समिती (5 Roles each)',
                    searchKey: 'taluka',
                  ),
                ],
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedLevel = val;
                      _updateSelectedRole();
                    });
                  }
                },
              ),
              const SizedBox(height: 18),

              // STEP 3: Jurisdiction (if applicable)
              if (_selectedLevel == OrganizationLevel.vibhag) ...[
                const Text(
                  '३. विभाग निवडा (Select Division)',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                AppSearchableDropdown<String>(
                  key: ValueKey('vib_$_selectedVibhagEn'),
                  value: _selectedVibhagEn,
                  labelText: 'विभाग (Division)',
                  searchHint: 'विभाग शोधा...',
                  prefixIcon: const Icon(Icons.business_rounded, color: AppColors.gold, size: 18),
                  items: OrganizationRoles.maharashtraVibhags.map((v) => AppDropdownItem<String>(
                        value: v.nameEn,
                        label: '${v.nameMr} (${v.nameEn})',
                        searchKey: '${v.nameMr} ${v.nameEn}',
                      )).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedVibhagEn = val);
                  },
                ),
                const SizedBox(height: 18),
              ],

              if (_selectedLevel == OrganizationLevel.jilha || _selectedLevel == OrganizationLevel.taluka) ...[
                const Text(
                  '३. जिल्हा निवडा (Select District)',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                AppSearchableDropdown<String>(
                  key: ValueKey('dist_appoint_$_selectedDistrictEn'),
                  value: _selectedDistrictEn,
                  labelText: 'जिल्हा (District)',
                  searchHint: 'जिल्हा शोधा...',
                  prefixIcon: const Icon(Icons.location_city_rounded, color: AppColors.gold, size: 18),
                  items: DistrictConstants.districts.map((d) => AppDropdownItem<String>(
                        value: d.nameEn,
                        label: '${d.nameMr} (${d.nameEn})',
                        searchKey: '${d.nameMr} ${d.nameEn}',
                      )).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _selectedDistrictEn = val;
                        _updateTalukas();
                      });
                    }
                  },
                ),
                const SizedBox(height: 18),
              ],

              if (_selectedLevel == OrganizationLevel.taluka && talukas.isNotEmpty) ...[
                const Text(
                  'तालुका निवडा (Select Taluka)',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                AppSearchableDropdown<String>(
                  key: ValueKey('tal_appoint_${_selectedDistrictEn}_$_selectedTaluka'),
                  value: talukas.any((t) => t.nameEn == _selectedTaluka)
                      ? _selectedTaluka
                      : (talukas.isNotEmpty ? talukas.first.nameEn : ''),
                  labelText: 'तालुका (Taluka)',
                  searchHint: 'तालुका शोधा...',
                  prefixIcon: const Icon(Icons.holiday_village_rounded, color: AppColors.gold, size: 18),
                  items: talukas.map((t) => AppDropdownItem<String>(
                        value: t.nameEn,
                        label: '${t.nameMr} (${t.nameEn})',
                        searchKey: '${t.nameMr} ${t.nameEn}',
                      )).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedTaluka = val);
                  },
                ),
                const SizedBox(height: 18),
              ],

              // STEP 4: Select Role / Designation
              const Text(
                '४. पद निवडा (Select Role / Designation)',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              AppSearchableDropdown<RoleDefinition>(
                key: ValueKey('role_${_selectedLevel}_${_selectedRole?.code}'),
                value: roles.contains(_selectedRole) ? _selectedRole : roles.firstOrNull,
                labelText: 'पद / पदनाम (Designation)',
                searchHint: 'पद शोधा...',
                prefixIcon: const Icon(Icons.military_tech_rounded, color: AppColors.gold, size: 18),
                items: roles.map((r) => AppDropdownItem<RoleDefinition>(
                      value: r,
                      label: '${r.nameMr} (${r.nameEn})',
                      searchKey: '${r.nameMr} ${r.nameEn}',
                    )).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedRole = val);
                },
              ),
              const SizedBox(height: 20),

              // PREVIEW BOX
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'पदाधिकारी ओळखपत्र व प्रोफाइलवर दिसणारे शीर्षक:',
                      style: TextStyle(fontSize: 11, color: AppColors.goldLight, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(previewMr, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 2),
                    Text(previewEn, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // ACTION BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('रद्द करा', style: TextStyle(color: AppColors.textMuted)),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: (_selectedMember == null || _selectedRole == null || _isSubmitting)
                        ? null
                        : () async {
                            final candidate = _selectedMember!;
                            final phone = candidate['phone']?.toString() ?? '';
                            final memberId = candidate['member_id']?.toString() ?? '';
                            final nameEn = candidate['name_en']?.toString() ?? '';
                            final nameMr = candidate['name_mr']?.toString() ?? '';
                            final photo = (candidate['photo_url'] as String?) ?? (candidate['photo_base64'] as String?);

                            // Derive Vibhag & District & Taluka details
                            String? vibhagEn;
                            String? vibhagMr;
                            String? districtEn;
                            String? districtMr;
                            String? talukaEn;
                            String? talukaMr;

                            if (_selectedLevel == OrganizationLevel.vibhag) {
                              final vibhag = OrganizationRoles.maharashtraVibhags.firstWhere(
                                (v) => v.nameEn == _selectedVibhagEn,
                                orElse: () => OrganizationRoles.maharashtraVibhags.first,
                              );
                              vibhagEn = vibhag.nameEn;
                              vibhagMr = vibhag.nameMr;
                            } else if (_selectedLevel == OrganizationLevel.jilha || _selectedLevel == OrganizationLevel.taluka) {
                              final dist = DistrictConstants.districts.firstWhere(
                                (d) => d.nameEn == _selectedDistrictEn,
                                orElse: () => DistrictConstants.districts.first,
                              );
                              districtEn = dist.nameEn;
                              districtMr = dist.nameMr;

                              final parentVibhag = OrganizationRoles.getVibhagForDistrict(dist.nameEn);
                              if (parentVibhag != null) {
                                vibhagEn = parentVibhag.nameEn;
                                vibhagMr = parentVibhag.nameMr;
                              }

                              if (_selectedLevel == OrganizationLevel.taluka) {
                                final talukas = _getTalukasForDistrict(dist.nameEn);
                                final talukaItem = talukas.firstWhere(
                                  (t) => t.nameEn == _selectedTaluka,
                                  orElse: () => (talukas.isNotEmpty ? talukas.first : const TalukaInfo(nameEn: '', nameMr: '')),
                                );
                                talukaEn = talukaItem.nameEn;
                                talukaMr = talukaItem.nameMr;
                              }
                            }

                            final navigator = Navigator.of(context);
                            final scaffoldMessenger = ScaffoldMessenger.of(context);

                            setState(() => _isSubmitting = true);

                            final success = await OrganizationService.instance.appointOfficial(
                              phone: phone,
                              memberId: memberId,
                              nameEn: nameEn,
                              nameMr: nameMr,
                              photoUrl: photo,
                              level: _selectedLevel,
                              role: _selectedRole!,
                              vibhag: vibhagEn,
                              vibhagMr: vibhagMr,
                              district: districtEn,
                              districtMr: districtMr,
                              taluka: talukaEn,
                              talukaMr: talukaMr,
                            );

                            if (!mounted) return;
                            navigator.pop();
                            scaffoldMessenger.showSnackBar(
                              SnackBar(
                                content: Text(
                                  success
                                      ? '$nameMr यांना $previewMr पदावर यशस्वीरीत्या नियुक्त केले आहे!'
                                      : 'त्रुटी: नियुक्ती होऊ शकली नाही.',
                                ),
                                backgroundColor: success ? Colors.green.shade800 : Colors.red.shade800,
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.saffron,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Text('पदावर नियुक्त करा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
