import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/main.dart';
import 'package:maratha_shivmudra/src/screens/authentication/auth_dialog.dart';

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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 1024;
    final isCompact = !isDesktop;
    final isMobile = width < 700;
    final isMarathi = appLocaleNotifier.value.languageCode == 'mr';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkBg.withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(
            color: AppColors.gold.withValues(alpha: 0.25),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.5),
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
                            style: AppTypography.navBrand(isMobile),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            isMarathi
                                ? '॥ धर्मो रक्षति रक्षितः ॥'
                                : 'Dedicated to Swarajya & Society',
                            style: AppTypography.navTagline(isMobile),
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
              const SizedBox(width: 16),
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
              const SizedBox(width: 16),
            ],

            // Language Switcher Button
            _LanguageToggleButton(),

            // Desktop Join / Login Button
            if (!isCompact) ...[
              const SizedBox(width: 14),
              ElevatedButton.icon(
                onPressed: () => AuthDialog.show(context),
                icon: const Icon(
                  Icons.login_rounded,
                  size: 16,
                  color: Colors.white,
                ),
                label: Text(
                  context.l10n.nav_join,
                  style: const TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.saffron,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: AppColors.saffron.withValues(alpha: 0.6),
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
            ],

            // Mobile & Tablet Menu Toggle Button (Opens Side Menu)
            if (isCompact) ...[
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(
                  Icons.menu_rounded,
                  color: AppColors.gold,
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
                    ? AppColors.white.withValues(alpha: 0.08)
                    : Colors.transparent),
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
              color: AppColors.darkSurface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.gold.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.language_rounded,
                  size: 15,
                  color: AppColors.gold,
                ),
                const SizedBox(width: 5),
                Text(
                  isMarathi ? 'EN' : 'मराठी',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldLight,
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
