import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';
import 'package:maratha_shivmudra/core/services/user_session_service.dart';
import 'package:maratha_shivmudra/core/theme/theme_service.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/main.dart';
import 'package:maratha_shivmudra/src/screens/authentication/auth_dialog.dart';
import 'package:maratha_shivmudra/src/screens/profile/profile_dialog.dart';

class LandingNavBar extends StatelessWidget {
  final VoidCallback? onHomeTap;
  final VoidCallback? onPledgeTap;
  final VoidCallback? onPillarsTap;
  final VoidCallback? onImpactTap;
  final VoidCallback? onEventsTap;
  final VoidCallback? onContactTap;
  final VoidCallback? onMenuTap;

  const LandingNavBar({
    super.key,
    this.onHomeTap,
    this.onPledgeTap,
    this.onPillarsTap,
    this.onImpactTap,
    this.onEventsTap,
    this.onContactTap,
    this.onMenuTap,
  });

  void _onJoinPressed(BuildContext context) {
    if (UserSessionService.instance.isLoggedInNotifier.value) {
      context.router.push(const MemberFormRoute());
    } else {
      AuthDialog.show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeModeNotifier,
      builder: (context, _, __) {
        final width = MediaQuery.sizeOf(context).width;
        final isDesktop = width >= 1024;
        final isCompact = !isDesktop;
        final isMobile = width < 700;
        final isDark = ThemeService.instance.isDarkMode(context);
        final isMarathi = appLocaleNotifier.value.languageCode == 'mr';

        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkBg.withValues(alpha: 0.95) : AppColors.lightNavBg,
            border: Border(
              bottom: BorderSide(
                color: isDark ? AppColors.gold.withValues(alpha: 0.25) : AppColors.goldBorderMedium,
                width: 1,
              ),
            ),
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.black.withValues(alpha: 0.5) : AppColors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 28,
        vertical: 10,
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Brand Logo & Title
            Expanded(
              child: InkWell(
                onTap: onHomeTap,
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AppAssets.logo,
                      width: isMobile ? 38 : 44,
                      height: isMobile ? 38 : 44,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                        child: Text('🚩', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            context.l10n.maratha_shivmudra,
                            style: AppTypography.navBrand(isMobile, isDark: isDark),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            isMarathi
                                ? '॥ धर्मो रक्षति रक्षितः ॥'
                                : 'Dedicated to Swarajya & Society',
                            style: AppTypography.navTagline(isMobile, isDark: isDark),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Desktop Navigation Links
            if (!isCompact) ...[
              _NavLink(
                title: context.l10n.nav_home,
                onTap: onHomeTap,
              ),
              _NavLink(
                title: context.l10n.nav_pledge,
                onTap: onPledgeTap,
              ),
              _NavLink(
                title: context.l10n.nav_pillars,
                onTap: onPillarsTap,
              ),
              _NavLink(
                title: context.l10n.nav_impact,
                onTap: onImpactTap,
              ),
              _NavLink(
                title: context.l10n.nav_events,
                onTap: onEventsTap,
              ),
              _NavLink(
                title: context.l10n.nav_contact,
                onTap: onContactTap,
              ),
              const SizedBox(width: 12),
            ],

            // Language Switcher Button
            _LanguageToggleButton(),
            const SizedBox(width: 8),

            // Theme Switcher Button (System / Light / Dark)
            _ThemeToggleButton(),

            // Desktop Join / Profile Chip
            if (!isCompact) ...[
              ValueListenableBuilder<bool>(
                valueListenable:
                    UserSessionService.instance.isFormSubmittedNotifier,
                builder: (context, isSubmitted, _) {
                  if (isSubmitted) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: _MemberProfileChip(
                        onTap: () => ProfileModalDialog.showAdaptive(context),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: ElevatedButton.icon(
                      onPressed: () => _onJoinPressed(context),
                      icon: const Icon(
                        Icons.volunteer_activism,
                        size: 16,
                        color: AppColors.white,
                      ),
                      label: Text(
                        context.l10n.nav_join,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: AppColors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.saffron,
                        foregroundColor: AppColors.white,
                        elevation: 4,
                        shadowColor:
                            AppColors.saffron.withValues(alpha: 0.6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: const BorderSide(
                            color: AppColors.goldLight,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],

            // Mobile & Tablet Menu Toggle Button (Opens Side Menu)
            if (isCompact) ...[
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                  color: isDark ? AppColors.gold : AppColors.saffron,
                  size: 28,
                ),
                onPressed: onMenuTap ??
                    () {
                      Scaffold.of(context).openEndDrawer();
                    },
                tooltip: 'Menu',
              ),
            ],
          ],
        ),
      ),
    );
      },
    );
  }
}

class _MemberProfileChip extends StatefulWidget {
  final VoidCallback onTap;

  const _MemberProfileChip({required this.onTap});

  @override
  State<_MemberProfileChip> createState() => _MemberProfileChipState();
}

class _MemberProfileChipState extends State<_MemberProfileChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeService.instance.isDarkMode(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(30),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.saffron.withValues(alpha: 0.18)
                : (isDark ? AppColors.darkSurface : AppColors.lightSurfaceElevated),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: _isHovered
                  ? AppColors.goldLight
                  : (isDark
                      ? AppColors.gold.withValues(alpha: 0.6)
                      : AppColors.goldDark.withValues(alpha: 0.4)),
              width: 1.4,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.25),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Glowing Avatar Icon
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.saffron, AppColors.gold],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.saffron.withValues(alpha: 0.4),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person_rounded,
                  size: 16,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 10),
              // Member Info Label
              ValueListenableBuilder<Locale>(
                valueListenable: appLocaleNotifier,
                builder: (context, locale, _) {
                  final isMarathi = locale.languageCode == 'mr';
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.successLight,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isMarathi ? 'अधिकृत सभासद' : 'Active Member',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.goldLight : AppColors.textDarkGold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        isMarathi ? 'माझे प्रोफाइल' : 'My Profile',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.white : AppColors.textDarkPrimary,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 16,
                color: isDark ? AppColors.goldLight : AppColors.textDarkMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String title;
  final VoidCallback? onTap;
  final bool highlight;

  const _NavLink({
    required this.title,
    this.onTap,
    this.highlight = false,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeService.instance.isDarkMode(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: widget.highlight
                ? AppColors.saffron.withValues(alpha: _isHovered ? 0.25 : 0.12)
                : (_isHovered
                    ? (isDark
                        ? AppColors.white.withValues(alpha: 0.08)
                        : AppColors.black.withValues(alpha: 0.05))
                    : AppColors.transparent),
            border: widget.highlight
                ? Border.all(
                    color: AppColors.saffronLight.withValues(alpha: 0.4),
                    width: 1,
                  )
                : null,
          ),
          child: Text(
            widget.title,
            style: AppTypography.navLink(
              isHovered: _isHovered,
              isHighlight: widget.highlight,
              isDark: isDark,
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = ThemeService.instance.isDarkMode(context);

    return ValueListenableBuilder<Locale>(
      valueListenable: appLocaleNotifier,
      builder: (context, currentLocale, _) {
        final isMarathi = currentLocale.languageCode == 'mr';

        return InkWell(
          onTap: () {
            appLocaleNotifier.value = isMarathi
                ? const Locale('en', '')
                : const Locale('mr', '');
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark
                    ? AppColors.gold.withValues(alpha: 0.5)
                    : AppColors.goldDark.withValues(alpha: 0.35),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.language_rounded,
                  size: 15,
                  color: isDark ? AppColors.gold : AppColors.saffron,
                ),
                const SizedBox(width: 5),
                Text(
                  isMarathi ? 'मराठी' : 'English',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.goldLight : AppColors.textDarkPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ThemeToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeModeNotifier,
      builder: (context, currentMode, _) {
        final isDark = ThemeService.instance.isDarkMode(context);
        final isMarathi = appLocaleNotifier.value.languageCode == 'mr';
        final icon = ThemeService.instance.getIcon(currentMode);
        final label = ThemeService.instance.getLabel(currentMode, isMarathi: isMarathi);

        return Tooltip(
          message: isMarathi
              ? 'थीम: $label (बदलण्यासाठी क्लिक करा)'
              : 'Theme: $label (Click to toggle)',
          child: InkWell(
            onTap: () => ThemeService.instance.cycleThemeMode(),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurface.withValues(alpha: 0.8)
                    : AppColors.lightSurfaceElevated,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark
                      ? AppColors.gold.withValues(alpha: 0.4)
                      : AppColors.goldBorderMedium,
                  width: 1,
                ),
              ),
              child: Icon(
                icon,
                size: 18,
                color: isDark ? AppColors.gold : AppColors.saffron,
              ),
            ),
          ),
        );
      },
    );
  }
}
