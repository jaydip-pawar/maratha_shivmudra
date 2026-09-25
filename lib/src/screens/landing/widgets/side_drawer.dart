import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/district_constants.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/core/models/member_profile.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';
import 'package:maratha_shivmudra/core/services/member_profile_service.dart';
import 'package:maratha_shivmudra/core/services/user_session_service.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/main.dart';
import 'package:maratha_shivmudra/src/screens/authentication/auth_dialog.dart';
import 'package:maratha_shivmudra/src/screens/profile/profile_dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';

class LandingSideDrawer extends StatefulWidget {
  final VoidCallback? onHomeTap;
  final VoidCallback? onPledgeTap;
  final VoidCallback? onPillarsTap;
  final VoidCallback? onImpactTap;
  final VoidCallback? onEventsTap;
  final VoidCallback? onContactTap;

  const LandingSideDrawer({
    super.key,
    this.onHomeTap,
    this.onPledgeTap,
    this.onPillarsTap,
    this.onImpactTap,
    this.onEventsTap,
    this.onContactTap,
  });

  @override
  State<LandingSideDrawer> createState() => _LandingSideDrawerState();
}

class _LandingSideDrawerState extends State<LandingSideDrawer> {
  MemberProfile? _profile;

  @override
  void initState() {
    super.initState();
    _loadProfileIfSubmitted();
    UserSessionService.instance.isFormSubmittedNotifier.addListener(_loadProfileIfSubmitted);
    UserSessionService.instance.isLoggedInNotifier.addListener(_loadProfileIfSubmitted);
  }

  @override
  void dispose() {
    UserSessionService.instance.isFormSubmittedNotifier.removeListener(_loadProfileIfSubmitted);
    UserSessionService.instance.isLoggedInNotifier.removeListener(_loadProfileIfSubmitted);
    super.dispose();
  }

  Future<void> _loadProfileIfSubmitted() async {
    try {
      if (UserSessionService.instance.isFormSubmittedNotifier.value ||
          UserSessionService.instance.isLoggedInNotifier.value) {
        final ss = getIt<SecureStorage>();
        final phone = await ss.getMobileNumber();
        if (phone.trim().isEmpty) {
          if (mounted) setState(() => _profile = null);
          return;
        }
        final userPhone = phone.trim();
        final p = await MemberProfileService.instance.getProfile(userPhone);
        if (mounted) {
          setState(() => _profile = p ?? MemberProfile(phone: userPhone));
        }
      } else {
        if (mounted) setState(() => _profile = null);
      }
    } catch (_) {}
  }

  void _onJoinPressed(BuildContext context) {
    Navigator.of(context).pop();
    if (UserSessionService.instance.isLoggedInNotifier.value) {
      context.router.push(const MemberFormRoute());
    } else {
      AuthDialog.show(context);
    }
  }

  void _openProfile(BuildContext context) {
    Navigator.of(context).pop();
    final width = MediaQuery.sizeOf(context).width;
    if (width < 700) {
      context.router.push(const ProfileRoute());
    } else {
      ProfileModalDialog.showTablet(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMarathi = appLocaleNotifier.value.languageCode == 'mr';

    return Drawer(
      backgroundColor: AppColors.darkBg,
      surfaceTintColor: Colors.transparent,
      child: SafeArea(
        child: Column(
          children: [
            // Side Menu Header: User Picture, Name, Number & Edit Icon
            _buildDrawerUserHeader(context, isMarathi),

            // Conditional Section: Progress Indicator (<100%) OR Mini ID Card (100%)
            ValueListenableBuilder<bool>(
              valueListenable: UserSessionService.instance.isFormSubmittedNotifier,
              builder: (context, isSubmitted, _) {
                if (!isSubmitted || _profile == null) return const SizedBox.shrink();

                final p = _profile!;
                final isComplete = p.isProfileComplete;

                if (isComplete) {
                  // If 100%: Show compact Mini ID Card suited for side menu
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
                    child: _buildMiniIdCard(context, p, isMarathi),
                  );
                } else {
                  // If <100%: Show Profile Completion Progress Indicator
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
                    child: _buildProgressIndicatorCard(context, p, isMarathi),
                  );
                }
              },
            ),

            const Divider(color: AppColors.darkBorder, height: 16),

            // Navigation List Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 4),
                children: [
                  _DrawerItem(
                    icon: Icons.home_rounded,
                    title: context.l10n.nav_home,
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onHomeTap?.call();
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.auto_stories_rounded,
                    title: context.l10n.nav_pledge,
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onPledgeTap?.call();
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.account_balance_rounded,
                    title: context.l10n.nav_pillars,
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onPillarsTap?.call();
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.trending_up_rounded,
                    title: context.l10n.nav_impact,
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onImpactTap?.call();
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.event_rounded,
                    title: context.l10n.nav_events,
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onEventsTap?.call();
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.phone_rounded,
                    title: context.l10n.nav_contact,
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onContactTap?.call();
                    },
                  ),
                ],
              ),
            ),

            // Bottom Section (Join button if not submitted)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: UserSessionService.instance.isFormSubmittedNotifier,
                    builder: (context, isSubmitted, _) {
                      if (isSubmitted) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: TextButton.icon(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await UserSessionService.instance.signOut();
                            },
                            icon: const Icon(
                              Icons.logout_rounded,
                              size: 16,
                              color: AppColors.textMuted,
                            ),
                            label: Text(
                              isMarathi ? 'लॉगआउट (Sign Out)' : 'Sign Out',
                              style: const TextStyle(
                                fontFamily: AppTypography.fontFamily,
                                fontSize: 13,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ),
                        );
                      }

                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _onJoinPressed(context),
                          icon: const Icon(
                            Icons.volunteer_activism,
                            size: 18,
                            color: AppColors.white,
                          ),
                          label: Text(
                            context.l10n.nav_join,
                            style: const TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.saffron,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(
                                color: AppColors.goldLight,
                                width: 1.2,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '🚩 जयोस्तु मराठा शिवमुद्रा 🚩',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.goldLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Header displaying User Picture, Name, Number & Edit Icon
  Widget _buildDrawerUserHeader(BuildContext context, bool isMarathi) {
    return ValueListenableBuilder<bool>(
      valueListenable: UserSessionService.instance.isFormSubmittedNotifier,
      builder: (context, isSubmitted, _) {
        final p = _profile;

        final displayName = (isSubmitted && p != null)
            ? (isMarathi
                ? (p.fullNameMr.isNotEmpty ? p.fullNameMr : p.fullNameEn)
                : (p.fullNameEn.isNotEmpty ? p.fullNameEn : p.fullNameMr))
            : (isMarathi ? 'अतिथी सभासद' : 'Guest Member');

        final phoneText = (isSubmitted && p != null)
            ? p.phone
            : (isMarathi ? 'नोंदणी करा' : 'Not registered');

        return RepaintBoundary(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.gold.withValues(alpha: 0.25),
                ),
              ),
            ),
            child: Row(
              children: [
                // User Picture / Avatar
                GestureDetector(
                  onTap: isSubmitted ? () => _openProfile(context) : () => _onJoinPressed(context),
                  child: _buildUserAvatar(p, isSubmitted),
                ),
                const SizedBox(width: 12),

                // User Name & Phone Number + Inline Edit Button
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        displayName.isNotEmpty ? displayName : (isMarathi ? 'सभासद' : 'Member'),
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              phoneText,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isSubmitted) ...[
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () => _openProfile(context),
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2.5,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.saffron.withValues(alpha: 0.18),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: AppColors.saffron.withValues(alpha: 0.5),
                                    width: 0.8,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.edit_outlined,
                                      size: 11,
                                      color: AppColors.goldLight,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      isMarathi ? 'बदला' : 'Edit',
                                      style: const TextStyle(
                                        fontFamily: AppTypography.fontFamily,
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.goldLight,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                // Clean Close Button at Top Right with compact bounds
                IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColors.goldLight,
                    size: 20,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: isMarathi ? 'बंद करा' : 'Close',
                  visualDensity: VisualDensity.compact,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserAvatar(MemberProfile? p, bool isSubmitted) {
    ImageProvider? imageProvider;
    if (isSubmitted && p != null && p.photoBase64 != null && p.photoBase64!.isNotEmpty) {
      try {
        final clean = p.photoBase64!.contains(',')
            ? p.photoBase64!.split(',').last
            : p.photoBase64!;
        final bytes = base64Decode(clean);
        imageProvider = MemoryImage(bytes);
      } catch (_) {}
    }

    return CircleAvatar(
      radius: 22,
      backgroundColor: AppColors.darkBgHeroTop,
      backgroundImage: imageProvider,
      child: (imageProvider == null)
          ? const Icon(
              Icons.person_rounded,
              size: 24,
              color: AppColors.goldLight,
            )
          : null,
    );
  }

  /// Progress Indicator Card (Shown when profile is < 100%)
  Widget _buildProgressIndicatorCard(
    BuildContext context,
    MemberProfile p,
    bool isMarathi,
  ) {
    final percent = (p.completionProgress * 100).toInt().clamp(0, 100);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.gold.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isMarathi ? 'प्रोफाइल पूर्णता: $percent%' : 'Completion: $percent%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldLight,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                decoration: BoxDecoration(
                  color: AppColors.saffron.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  isMarathi ? 'प्रलंबित' : 'Incomplete',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.saffronLight,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: p.completionProgress.clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor: AppColors.darkBorder,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.saffron),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: InkWell(
              onTap: () => _openProfile(context),
              borderRadius: BorderRadius.circular(6),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.darkBgHeroTop,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColors.saffron.withValues(alpha: 0.5),
                  ),
                ),
                child: Center(
                  child: Text(
                    isMarathi
                        ? 'उर्वरित माहिती भरा (Complete Now) ➔'
                        : 'Complete Profile ➔',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.saffronLight,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Compact Mini ID Card suited specifically for side menu width (Shown ONLY when profile is 100%)
  Widget _buildMiniIdCard(BuildContext context, MemberProfile p, bool isMarathi) {
    final memberId = p.memberId ?? 'MSM-${p.districtCode}-00000';
    final districtName = isMarathi
        ? DistrictConstants.getNameMr(p.district)
        : DistrictConstants.getNameEn(p.district);
    final displayName = isMarathi
        ? (p.fullNameMr.isNotEmpty ? p.fullNameMr : p.fullNameEn)
        : (p.fullNameEn.isNotEmpty ? p.fullNameEn : p.fullNameMr);

    return RepaintBoundary(
      child: InkWell(
        onTap: () => _openProfile(context),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF240C0C),
                Color(0xFF160707),
                Color(0xFF0F0404),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: AppColors.gold,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.saffron.withValues(alpha: 0.18),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mini Header Row
              Row(
                children: [
                  Image.asset(AppAssets.logo, width: 20, height: 20),
                  const SizedBox(width: 6),
                  const Expanded(
                    child: Text(
                      'मराठा शिवमुद्रा प्रतिष्ठाण',
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldLight,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      color: AppColors.saffron,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      p.districtCode,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Divider(color: AppColors.gold, height: 1, thickness: 0.6),
              const SizedBox(height: 6),

              // Mini Card Body
              Row(
                children: [
                  // Mini Photo
                  _buildMiniPhoto(p),
                  const SizedBox(width: 8),

                  // Mini Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.saffron.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            memberId,
                            style: const TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldLight,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          displayName,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '$districtName • ${p.bloodGroup.isNotEmpty ? "🩸 ${p.bloodGroup}" : "महाराष्ट्र"}',
                          style: const TextStyle(
                            fontSize: 9,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Tiny QR Code
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: QrImageView(
                      data: 'https://marathashivmudra.web.app/verify?id=$memberId',
                      version: QrVersions.auto,
                      size: 34,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),
              // Mini Footer Tap Hint
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        size: 10,
                        color: Colors.greenAccent,
                      ),
                      SizedBox(width: 3),
                      Text(
                        'अधिकृत ओळखपत्र',
                        style: TextStyle(
                          fontSize: 8.5,
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    isMarathi ? 'विस्तृत पहा ➔' : 'View Full ➔',
                    style: const TextStyle(
                      fontSize: 8.5,
                      color: AppColors.goldLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniPhoto(MemberProfile p) {
    ImageProvider? imageProvider;
    if (p.photoBase64 != null && p.photoBase64!.isNotEmpty) {
      try {
        final clean = p.photoBase64!.contains(',')
            ? p.photoBase64!.split(',').last
            : p.photoBase64!;
        final bytes = base64Decode(clean);
        imageProvider = MemoryImage(bytes);
      } catch (_) {}
    }

    return Container(
      width: 38,
      height: 46,
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.gold, width: 1),
        image: imageProvider != null
            ? DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imageProvider == null
          ? const Center(
              child: Icon(
                Icons.person_rounded,
                size: 20,
                color: AppColors.goldLight,
              ),
            )
          : null,
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.goldLight, size: 22),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: 15,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      hoverColor: AppColors.saffron.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    );
  }
}
