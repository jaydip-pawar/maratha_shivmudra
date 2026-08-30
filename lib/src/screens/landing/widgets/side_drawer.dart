import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/main.dart';
import 'package:maratha_shivmudra/src/screens/authentication/auth_dialog.dart';

class LandingSideDrawer extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final isMarathi = appLocaleNotifier.value.languageCode == 'mr';

    return Drawer(
      backgroundColor: AppColors.darkBg,
      surfaceTintColor: Colors.transparent,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Royal Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.gold.withValues(alpha: 0.25),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    AppAssets.logo,
                    width: 48,
                    height: 48,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Text('🚩', style: TextStyle(fontSize: 24)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.maratha_shivmudra,
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldLight,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          isMarathi
                              ? '॥ धर्मो रक्षति रक्षितः ॥'
                              : 'Dedicated to Swarajya & Society',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded,
                        color: AppColors.goldLight),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Language Switch Tile
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.gold.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.language_rounded,
                            size: 18, color: AppColors.gold),
                        const SizedBox(width: 8),
                        Text(
                          isMarathi ? 'भाषा बदला' : 'Change Language',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    ValueListenableBuilder<Locale>(
                      valueListenable: appLocaleNotifier,
                      builder: (context, currentLocale, _) {
                        final isMr = currentLocale.languageCode == 'mr';
                        return InkWell(
                          onTap: () {
                            appLocaleNotifier.value = isMr
                                ? const Locale('en', '')
                                : const Locale('mr', '');
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.saffron.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.saffronLight,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              isMr ? 'English' : 'मराठी',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.goldLight,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Navigation Links List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                children: [
                  _DrawerItem(
                    icon: Icons.home_rounded,
                    title: context.l10n.nav_home,
                    onTap: () {
                      Navigator.of(context).pop();
                      onHomeTap?.call();
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.shield_moon_rounded,
                    title: context.l10n.nav_pledge,
                    onTap: () {
                      Navigator.of(context).pop();
                      onPledgeTap?.call();
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.flag_rounded,
                    title: context.l10n.nav_pillars,
                    onTap: () {
                      Navigator.of(context).pop();
                      onPillarsTap?.call();
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.trending_up_rounded,
                    title: context.l10n.nav_impact,
                    onTap: () {
                      Navigator.of(context).pop();
                      onImpactTap?.call();
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.event_rounded,
                    title: context.l10n.nav_events,
                    onTap: () {
                      Navigator.of(context).pop();
                      onEventsTap?.call();
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.phone_rounded,
                    title: context.l10n.nav_contact,
                    onTap: () {
                      Navigator.of(context).pop();
                      onContactTap?.call();
                    },
                  ),
                ],
              ),
            ),

            // Bottom CTA & Auth Action
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        AuthDialog.show(context);
                      },
                      icon: const Icon(Icons.login_rounded,
                          size: 18, color: AppColors.white),
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
                  ),
                  const SizedBox(height: 12),
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
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.textMuted,
        size: 18,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: onTap,
    );
  }
}
