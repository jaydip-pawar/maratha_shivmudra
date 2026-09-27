import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';
import 'package:maratha_shivmudra/core/services/admin_auth_service.dart';
import 'package:maratha_shivmudra/core/theme/theme_service.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';

@RoutePage()
class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'कृपया ईमेल आणि पासवर्ड प्रविष्ट करा.');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final admin = await AdminAuthService.instance.signIn(email, password);

    if (mounted) {
      setState(() => _isLoading = false);
      if (admin != null) {
        context.router.replaceAll([const AdminDashboardRoute()]);
      } else {
        setState(() {
          _errorMessage =
              'लॉगिन अयशस्वी! कृपया आपला ईमेल किंवा पासवर्ड तपासा.';
        });
      }
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
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color:
                        isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark
                          ? AppColors.gold.withValues(alpha: 0.4)
                          : AppColors.goldBorderMedium,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? AppColors.black.withValues(alpha: 0.6)
                            : AppColors.goldShadow.withValues(alpha: 0.15),
                        blurRadius: 30,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Top Row with Theme Toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 40),
                          Image.asset(AppAssets.logo, width: 64, height: 64),
                          IconButton(
                            icon: Icon(
                              isDark
                                  ? Icons.light_mode_rounded
                                  : Icons.dark_mode_rounded,
                              color: isDark
                                  ? AppColors.goldLight
                                  : AppColors.saffronDark,
                              size: 20,
                            ),
                            onPressed: () =>
                                ThemeService.instance.cycleThemeMode(),
                            tooltip: isDark
                                ? 'लाइट मोड चालू करा'
                                : 'डार्क मोड चालू करा',
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Text(
                        'मराठा शिवमुद्रा ॲडमिन पोर्टल',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.goldLight
                              : AppColors.saffronDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Admin Management Console',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? AppColors.textSecondary
                              : AppColors.textDarkSecondary,
                        ),
                      ),
                      const SizedBox(height: 28),

                      if (_errorMessage != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.redAccent.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.redAccent),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline_rounded,
                                  color: AppColors.redAccent, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _errorMessage!,
                                  style: const TextStyle(
                                      color: AppColors.redAccent,
                                      fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Email Input
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ॲडमिन ईमेल (Email)',
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark
                                  ? AppColors.textSecondary
                                  : AppColors.textDarkSecondary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _emailController,
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.white
                                  : AppColors.textDarkPrimary,
                              fontSize: 14,
                            ),
                            decoration: _inputDecoration(
                              Icons.email_outlined,
                              'admin@marathashivmudra.org',
                              isDark,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Password Input
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'पासवर्ड (Password)',
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark
                                  ? AppColors.textSecondary
                                  : AppColors.textDarkSecondary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.white
                                  : AppColors.textDarkPrimary,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_outline_rounded,
                                color: isDark
                                    ? AppColors.gold
                                    : AppColors.saffron,
                                size: 20,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                  color: isDark
                                      ? AppColors.textMuted
                                      : AppColors.textDarkSecondary,
                                  size: 20,
                                ),
                                onPressed: () => setState(() =>
                                    _obscurePassword = !_obscurePassword),
                              ),
                              filled: true,
                              fillColor: isDark
                                  ? AppColors.darkBgHeroTop
                                  : AppColors.lightSurfaceElevated,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: isDark
                                      ? AppColors.darkBorder
                                      : AppColors.lightCardBorder,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: isDark
                                      ? AppColors.darkBorder
                                      : AppColors.lightCardBorder,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: isDark
                                      ? AppColors.gold
                                      : AppColors.saffron,
                                  width: 1.2,
                                ),
                              ),
                            ),
                            onSubmitted: (_) => _handleLogin(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.saffron,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: isDark
                                    ? AppColors.goldLight
                                    : AppColors.goldBorderMedium,
                                width: 1,
                              ),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.white),
                                )
                              : const Text(
                                  'लॉगिन करा (Login)',
                                  style: TextStyle(
                                    fontFamily: AppTypography.fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: AppColors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      TextButton(
                        onPressed: () => context.router
                            .replaceAll([const LandingRoute()]),
                        child: Text(
                          'मुख्यपृष्ठावर परत जा (Back to Home)',
                          style: TextStyle(
                            color: isDark
                                ? AppColors.textMuted
                                : AppColors.textDarkSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  InputDecoration _inputDecoration(IconData icon, String hint, bool isDark) {
    return InputDecoration(
      prefixIcon: Icon(
        icon,
        color: isDark ? AppColors.gold : AppColors.saffron,
        size: 20,
      ),
      hintText: hint,
      hintStyle: TextStyle(
        color: isDark ? AppColors.textMuted : AppColors.textDarkSecondary,
      ),
      filled: true,
      fillColor:
          isDark ? AppColors.darkBgHeroTop : AppColors.lightSurfaceElevated,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
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
          width: 1.2,
        ),
      ),
    );
  }
}

