import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';
import 'package:maratha_shivmudra/core/services/member_id_service.dart';
import 'package:maratha_shivmudra/core/theme/theme_service.dart';
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
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeModeNotifier,
      builder: (context, _, __) {
        final isDark = ThemeService.instance.isDarkMode(context);

        return Scaffold(
          backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
          appBar: AppBar(
            backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurfaceElevated,
            elevation: isDark ? 0 : 1,
            title: Row(
              children: [
                Image.asset(AppAssets.logo, width: 32, height: 32),
                const SizedBox(width: 10),
                Text(
                  'सभासद ओळख पडताळणी (ID Verification)',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.goldLight : AppColors.textDarkPrimary,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.home_rounded, color: isDark ? AppColors.goldLight : AppColors.saffronDark),
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
                    color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? AppColors.darkBorder : AppColors.lightCardBorder,
                    ),
                    boxShadow: isDark
                        ? []
                        : [
                            BoxShadow(
                              color: AppColors.textDarkPrimary.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'सभासद ओळखपत्र क्रमांक प्रविष्ट करा',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.goldLight : AppColors.textDarkPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: TextStyle(
                                color: isDark ? AppColors.white : AppColors.textDarkPrimary,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                              decoration: InputDecoration(
                                hintText: 'उदा. MSP-PUN-A0001',
                                hintStyle: TextStyle(
                                  color: isDark ? AppColors.textMuted : AppColors.textDarkMuted,
                                ),
                                filled: true,
                                fillColor: isDark ? AppColors.darkBgHeroTop : AppColors.lightSurfaceElevated,
                                prefixIcon: Icon(
                                  Icons.search_rounded,
                                  color: isDark ? AppColors.gold : AppColors.saffron,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: isDark ? AppColors.darkBorder : AppColors.lightCardBorder,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: isDark ? AppColors.darkBorder : AppColors.lightCardBorder,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: isDark ? AppColors.gold : AppColors.saffron,
                                    width: 1.5,
                                  ),
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
                            child: const Text('पडताळा', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.white)),
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
                    _buildVerifiedCard(_memberData!, isDark)
                  else
                    _buildNotFoundCard(isDark),
                ],
              ],
            ),
          ),
        ),
      ),
    );
      },
    );
  }

  Widget _buildVerifiedCard(Map<String, dynamic> data, bool isDark) {
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
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greenAccent, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.greenAccent.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.verified_rounded, color: AppColors.greenAccent, size: 56),
          const SizedBox(height: 12),
          const Text(
            'अधिकृत व प्रमाणित सभासद',
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.greenAccent,
            ),
          ),
          Text(
            'Verified Official Member of Maratha Shivmudra',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? AppColors.textSecondary : AppColors.textDarkSecondary,
            ),
          ),
          const SizedBox(height: 20),
          Divider(color: isDark ? AppColors.darkBorder : AppColors.lightCardBorder),
          const SizedBox(height: 16),

          _buildRow('सभासद क्र. (Member ID)', memberId, isDark, isHighlight: true),
          const SizedBox(height: 10),
          _buildRow('पूर्ण नाव (Name)', name, isDark),
          const SizedBox(height: 10),
          _buildRow('जिल्हा (District)', '$districtMr ($district)', isDark),
          const SizedBox(height: 10),
          if (isManager && designation.isNotEmpty) ...[
            _buildRow('हुद्दा / पद (Designation)', '👑 $designation', isDark, isHighlight: true),
            const SizedBox(height: 10),
          ],
          _buildRow('स्थिती (Status)', 'सक्रिय (Active / Verified)', isDark),
        ],
      ),
    );
  }

  Widget _buildNotFoundCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.redAccent, width: 1.2),
      ),
      child: Column(
        children: [
          const Icon(Icons.cancel_rounded, color: AppColors.redAccent, size: 52),
          const SizedBox(height: 12),
          const Text(
            'पडताळणी अयशस्वी',
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.redAccent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'हा सभासद ओळख क्रमांक आमच्या डेटाबेसमध्ये आढळला नाही. कृपया क्रमांक तपासून पुन्हा प्रयत्न करा.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? AppColors.textSecondary : AppColors.textDarkSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, bool isDark, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? AppColors.textSecondary : AppColors.textDarkSecondary,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.w600,
              color: isHighlight
                  ? (isDark ? AppColors.goldLight : AppColors.saffronDark)
                  : (isDark ? AppColors.white : AppColors.textDarkPrimary),
            ),
          ),
        ),
      ],
    );
  }
}
