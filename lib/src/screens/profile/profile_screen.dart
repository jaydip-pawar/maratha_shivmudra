import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/core/models/member_profile.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';
import 'package:maratha_shivmudra/core/services/member_profile_service.dart';
import 'package:maratha_shivmudra/core/services/user_session_service.dart';
import 'package:maratha_shivmudra/core/theme/theme_service.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/main.dart';
import 'package:maratha_shivmudra/src/screens/profile/widgets/profile_content_view.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userPhone = '';
  MemberProfile? _profile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final ss = getIt<SecureStorage>();
    final phone = await ss.getMobileNumber();
    _userPhone = phone.trim();

    if (_userPhone.isEmpty) {
      if (mounted) {
        setState(() {
          _profile = null;
          _isLoading = false;
        });
        context.router.replaceAll([const LandingRoute()]);
      }
      return;
    }

    final profile = await MemberProfileService.instance.getProfile(_userPhone);

    if (profile == null) {
      // User was deleted or profile does not exist in database!
      await UserSessionService.instance.forceDestruct(
        reason: 'ProfileScreen: Profile for $_userPhone not found in Firestore',
      );
      if (mounted) {
        setState(() {
          _profile = null;
          _isLoading = false;
        });
        context.router.replaceAll([const LandingRoute()]);
      }
      return;
    }

    if (mounted) {
      setState(() {
        _profile = profile;
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

        return ValueListenableBuilder<Locale>(
          valueListenable: appLocaleNotifier,
          builder: (context, locale, _) {
            final isMarathi = locale.languageCode == 'mr';

            if (_isLoading || _profile == null) {
              return Scaffold(
                backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
                body: const Center(
                  child: CircularProgressIndicator(color: AppColors.saffron),
                ),
              );
            }

            final p = _profile!;

            return Scaffold(
              backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
              appBar: AppBar(
                backgroundColor:
                    isDark ? AppColors.darkSurface : AppColors.lightSurface,
                elevation: isDark ? 0 : 1,
                shadowColor: AppColors.goldShadow.withValues(alpha: 0.1),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: isDark ? AppColors.goldLight : AppColors.saffronDark,
                  ),
                  onPressed: () {
                    if (context.router.canPop()) {
                      context.router.maybePop();
                    } else {
                      context.router.replaceAll([const LandingRoute()]);
                    }
                  },
                ),
                title: Row(
                  children: [
                    Image.asset(AppAssets.logo, width: 28, height: 28),
                    const SizedBox(width: 10),
                    Text(
                      'मराठा शिवमुद्रा',
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.goldLight
                            : AppColors.saffronDark,
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      isDark
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                      color:
                          isDark ? AppColors.goldLight : AppColors.saffronDark,
                    ),
                    onPressed: () => ThemeService.instance.cycleThemeMode(),
                    tooltip:
                        isDark ? 'लाइट मोड चालू करा' : 'डार्क मोड चालू करा',
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.home_rounded,
                      color:
                          isDark ? AppColors.goldLight : AppColors.saffronDark,
                    ),
                    onPressed: () =>
                        context.router.replaceAll([const LandingRoute()]),
                    tooltip: isMarathi ? 'मुख्यपृष्ठ' : 'Home',
                  ),
                ],
              ),
              body: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: ProfileContentView(
                    initialProfile: p,
                    onProfileUpdated: _loadUserProfile,
                    isFixedHeader: true,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
