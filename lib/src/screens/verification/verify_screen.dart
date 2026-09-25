import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';
import 'package:maratha_shivmudra/core/services/member_id_service.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';

@RoutePage()
class VerifyScreen extends StatefulWidget {
  final String? id;

  const VerifyScreen({
    super.key,
    @queryParam this.id,
  });

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final TextEditingController _searchController = TextEditingController();
  Map<String, dynamic>? _memberData;
  bool _isLoading = true;
  bool _searched = false;

  @override
  void initState() {
    super.initState();
    final queryId = widget.id ?? Uri.base.queryParameters['id'];
    if (queryId != null && queryId.trim().isNotEmpty) {
      _searchController.text = queryId.trim().toUpperCase();
      _verify(queryId.trim().toUpperCase());
    } else {
      _isLoading = false;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _verify(String memberId) async {
    setState(() {
      _isLoading = true;
      _searched = true;
    });

    final data = await MemberIdService.instance.verifyMemberId(memberId);

    if (mounted) {
      setState(() {
        _memberData = data;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkSurface,
        title: Row(
          children: [
            Image.asset(AppAssets.logo, width: 32, height: 32),
            const SizedBox(width: 10),
            const Text(
              'सभासद ओळख पडताळणी (ID Verification)',
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.goldLight,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home_rounded, color: AppColors.goldLight),
            onPressed: () => context.router.replaceAll([const LandingRoute()]),
            tooltip: 'मुख्यपृष्ठ',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                // Search Input Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.darkSurface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.darkBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'सभासद ओळखपत्र क्रमांक प्रविष्ट करा',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldLight,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                              decoration: InputDecoration(
                                hintText: 'उदा. MSM-PUN-00001',
                                hintStyle: const TextStyle(color: AppColors.textMuted),
                                filled: true,
                                fillColor: AppColors.darkBgHeroTop,
                                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.gold),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: AppColors.darkBorder),
                                ),
                              ),
                              onSubmitted: (val) {
                                if (val.trim().isNotEmpty) _verify(val.trim().toUpperCase());
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              final text = _searchController.text.trim();
                              if (text.isNotEmpty) _verify(text.toUpperCase());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.saffron,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text('पडताळा', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                if (_isLoading) ...[
                  const CircularProgressIndicator(color: AppColors.saffron),
                ] else if (_searched) ...[
                  if (_memberData != null)
                    _buildVerifiedCard(_memberData!)
                  else
                    _buildNotFoundCard(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerifiedCard(Map<String, dynamic> data) {
    final memberId = data['member_id'] as String? ?? '';
    final name = data['name'] as String? ?? '';
    final district = data['district_en'] as String? ?? '';
    final districtMr = data['district_mr'] as String? ?? '';
    final roleType = data['role_type'] as String? ?? 'member';
    final designation = data['designation'] as String? ?? '';
    final isManager = roleType != 'member';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.greenAccent, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.verified_rounded, color: Colors.greenAccent, size: 56),
          const SizedBox(height: 12),
          const Text(
            'अधिकृत व प्रमाणित सभासद',
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent,
            ),
          ),
          const Text(
            'Verified Official Member of Maratha Shivmudra',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          const Divider(color: AppColors.darkBorder),
          const SizedBox(height: 16),

          _buildRow('सभासद क्र. (Member ID)', memberId, isHighlight: true),
          const SizedBox(height: 10),
          _buildRow('पूर्ण नाव (Name)', name),
          const SizedBox(height: 10),
          _buildRow('जिल्हा (District)', '$districtMr ($district)'),
          const SizedBox(height: 10),
          if (isManager && designation.isNotEmpty) ...[
            _buildRow('हुद्दा / पद (Designation)', '👑 $designation', isHighlight: true),
            const SizedBox(height: 10),
          ],
          _buildRow('स्थिती (Status)', 'सक्रिय (Active / Verified)'),
        ],
      ),
    );
  }

  Widget _buildNotFoundCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.redAccent.shade400, width: 1.2),
      ),
      child: Column(
        children: [
          Icon(Icons.cancel_rounded, color: Colors.redAccent.shade400, size: 52),
          const SizedBox(height: 12),
          const Text(
            'पडताळणी अयशस्वी',
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'हा सभासद ओळख क्रमांक आमच्या डेटाबेसमध्ये आढळला नाही. कृपया क्रमांक तपासून पुन्हा प्रयत्न करा.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.w600,
              color: isHighlight ? AppColors.goldLight : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
