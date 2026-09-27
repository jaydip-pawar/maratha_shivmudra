import 'package:auto_route/annotations.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/core/mixins/get_it_helper_mixin.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/src/screens/authentication/auth_dialog.dart';
import 'package:maratha_shivmudra/src/screens/landing/widgets/cta_banner_section.dart';
import 'package:maratha_shivmudra/src/screens/landing/widgets/footer_section.dart';
import 'package:maratha_shivmudra/src/screens/landing/widgets/hero_section.dart';
import 'package:maratha_shivmudra/src/screens/landing/widgets/impact_stats_section.dart';
import 'package:maratha_shivmudra/src/screens/landing/widgets/nav_bar.dart';
import 'package:maratha_shivmudra/src/screens/landing/widgets/pillars_section.dart';
import 'package:maratha_shivmudra/src/screens/landing/widgets/pratidnya_section.dart';
import 'package:maratha_shivmudra/src/screens/landing/widgets/side_drawer.dart';
import 'package:maratha_shivmudra/src/screens/landing/widgets/upcoming_events_section.dart';
import 'package:maratha_shivmudra/src/screens/landing/widgets/scroll_reveal.dart';

import 'package:maratha_shivmudra/core/theme/theme_service.dart';
import 'package:maratha_shivmudra/main.dart';

@RoutePage()
class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with GetItHelperMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _pledgeKey = GlobalKey();
  final GlobalKey _pillarsKey = GlobalKey();
  final GlobalKey _impactKey = GlobalKey();
  final GlobalKey _eventsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final show = _scrollController.offset > 400;
      if (show != _showBackToTop) {
        setState(() => _showBackToTop = show);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkReferralFlow(context);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _checkReferralFlow(BuildContext context) async {
    final ss = getIt<SecureStorage>();
    final isLoggedIn = await ss.isUserLoggedIn();

    final uri = Uri.base;
    if (uri.queryParameters.containsKey('ref')) {
      if (!isLoggedIn) {
        if (context.mounted) {
          AuthDialog.show(context);
        }
      }
    }
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeModeNotifier,
      builder: (context, _, __) {
        final isDark = ThemeService.instance.isDarkMode(context);

        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
          endDrawer: LandingSideDrawer(
            onHomeTap: _scrollToTop,
            onPledgeTap: () => _scrollToSection(_pledgeKey),
            onPillarsTap: () => _scrollToSection(_pillarsKey),
            onImpactTap: () => _scrollToSection(_impactKey),
            onEventsTap: () => _scrollToSection(_eventsKey),
            onContactTap: () => _scrollToSection(_contactKey),
          ),
          body: Stack(
            children: [
              // Main Scrollable Content
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    // Top Padding for fixed Navbar height
                    const SizedBox(height: 72),

                    // Hero Section with smooth entrance
                    Container(
                      key: _homeKey,
                      child: ScrollReveal(
                        duration: const Duration(milliseconds: 800),
                        slideOffset: const Offset(0, 0.05),
                        child: HeroSection(
                          isDark: isDark,
                          onExploreTap: () => _scrollToSection(_pillarsKey),
                          onContactTap: () => _scrollToSection(_contactKey),
                          onPledgeTap: () => _scrollToSection(_pledgeKey),
                        ),
                      ),
                    ),

                    // Sacred Pledge Section (संघटनेची प्रतिज्ञा)
                    Container(
                      key: _pledgeKey,
                      child: ScrollReveal(
                        duration: const Duration(milliseconds: 750),
                        slideOffset: const Offset(0, 0.08),
                        child: PratidnyaSection(isDark: isDark),
                      ),
                    ),

                    // 7 Core Pillars (Health, Education, Forts, Dharma, History, Entrepreneurship, Disaster Relief)
                    Container(
                      key: _pillarsKey,
                      child: ScrollReveal(
                        duration: const Duration(milliseconds: 750),
                        slideOffset: const Offset(0, 0.08),
                        child: PillarsSection(isDark: isDark),
                      ),
                    ),

                    // Impact Metrics Section
                    Container(
                      key: _impactKey,
                      child: ScrollReveal(
                        duration: const Duration(milliseconds: 700),
                        slideOffset: const Offset(0, 0.06),
                        child: ImpactStatsSection(isDark: isDark),
                      ),
                    ),

                    // Upcoming Events & Campaigns
                    Container(
                      key: _eventsKey,
                      child: ScrollReveal(
                        duration: const Duration(milliseconds: 700),
                        slideOffset: const Offset(0, 0.06),
                        child: UpcomingEventsSection(isDark: isDark),
                      ),
                    ),

                    // Call to Action Banner
                    ScrollReveal(
                      duration: const Duration(milliseconds: 700),
                      slideOffset: const Offset(0, 0.06),
                      child: CtaBannerSection(isDark: isDark),
                    ),

                    // Footer Section with Official Contact Details
                    Container(
                      key: _contactKey,
                      child: FooterSection(isDark: isDark),
                    ),
                  ],
                ),
              ),

              // Fixed / Sticky Top Royal Navbar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: LandingNavBar(
                  onHomeTap: _scrollToTop,
                  onPledgeTap: () => _scrollToSection(_pledgeKey),
                  onPillarsTap: () => _scrollToSection(_pillarsKey),
                  onImpactTap: () => _scrollToSection(_impactKey),
                  onEventsTap: () => _scrollToSection(_eventsKey),
                  onContactTap: () => _scrollToSection(_contactKey),
                  onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
                ),
              ),
            ],
          ),
          // Floating Back to Top Button
          floatingActionButton: _showBackToTop
              ? FloatingActionButton.small(
                  onPressed: _scrollToTop,
                  backgroundColor: AppColors.saffron,
                  foregroundColor: AppColors.white,
                  tooltip: 'Back to Top',
                  child: const Icon(Icons.arrow_upward_rounded),
                )
              : null,
        );
      },
    );
  }
}
