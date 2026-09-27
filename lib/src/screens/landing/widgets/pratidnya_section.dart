import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/theme/theme_service.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';

class PratidnyaSection extends StatelessWidget {
  final bool? isDark;

  const PratidnyaSection({super.key, this.isDark});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final darkMode = isDark ?? ThemeService.instance.isDarkMode(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: darkMode ? AppColors.deepMaroonBg : AppColors.lightSurfaceElevated,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 48,
        vertical: isMobile ? 40 : 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              // Regal Parchment Oath Card
              Container(
                decoration: BoxDecoration(
                  gradient: AppGradients.pledgeCardGradientAdaptive(darkMode),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: darkMode
                        ? AppColors.gold.withValues(alpha: 0.5)
                        : AppColors.goldMetallic.withValues(alpha: 0.55),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.saffron.withValues(alpha: darkMode ? 0.15 : 0.12),
                      blurRadius: darkMode ? 30 : 24,
                      spreadRadius: darkMode ? 2 : 1,
                      offset: Offset(0, darkMode ? 0 : 8),
                    ),
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: darkMode ? 0.7 : 0.07),
                      blurRadius: darkMode ? 20 : 16,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : 40,
                  vertical: isMobile ? 24 : 36,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top Card Header with Logo
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            AppAssets.logo,
                            width: 72,
                            height: 72,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                              child: Text('🚩', style: TextStyle(fontSize: 28)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            context.l10n.pledge_heading,
                            textAlign: TextAlign.center,
                            style: AppTypography.pledgeHeading(isMobile, isDark: darkMode),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            context.l10n.pledge_subheading,
                            textAlign: TextAlign.center,
                            style: AppTypography.pledgeSubheading(isMobile, isDark: darkMode),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            width: 140,
                            height: 2,
                            decoration: const BoxDecoration(
                              gradient: AppGradients.goldDivider,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Paragraph 1 - The Invocation
                    _buildPledgeClause(
                      context,
                      text: context.l10n.pledge_p1,
                      isInvocation: true,
                      isMobile: isMobile,
                      isDark: darkMode,
                    ),

                    const SizedBox(height: 20),

                    // Paragraph 2 - Dharma & Social Welfare
                    _buildPledgeClause(
                      context,
                      text: context.l10n.pledge_p2,
                      number: '१',
                      isMobile: isMobile,
                      isDark: darkMode,
                    ),

                    const SizedBox(height: 20),

                    // Paragraph 3 - Authentic History
                    _buildPledgeClause(
                      context,
                      text: context.l10n.pledge_p3,
                      number: '२',
                      isMobile: isMobile,
                      isDark: darkMode,
                    ),

                    const SizedBox(height: 20),

                    // Paragraph 4 - Lifelong Dedication to Organization
                    _buildPledgeClause(
                      context,
                      text: context.l10n.pledge_p4,
                      number: '३',
                      isMobile: isMobile,
                      isDark: darkMode,
                    ),

                    const SizedBox(height: 32),

                    // Slogans Footer Strip
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: darkMode
                              ? [
                                  AppColors.saffronDark.withValues(alpha: 0.4),
                                  AppColors.goldDark.withValues(alpha: 0.2),
                                ]
                              : [
                                  AppColors.saffron.withValues(alpha: 0.15),
                                  AppColors.goldLight.withValues(alpha: 0.2),
                                ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: darkMode
                              ? AppColors.gold.withValues(alpha: 0.4)
                              : AppColors.goldMetallic.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          context.l10n.pledge_slogans,
                          textAlign: TextAlign.center,
                          style: AppTypography.pledgeSlogans(isMobile, isDark: darkMode),
                        ),
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

  Widget _buildPledgeClause(
    BuildContext context, {
    required String text,
    String? number,
    bool isInvocation = false,
    required bool isMobile,
    required bool isDark,
  }) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 14 : 18),
      decoration: BoxDecoration(
        color: isDark
            ? (isInvocation
                ? AppColors.gold.withValues(alpha: 0.06)
                : AppColors.white.withValues(alpha: 0.03))
            : (isInvocation
                ? AppColors.saffron.withValues(alpha: 0.08)
                : AppColors.lightSurface),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? (isInvocation
                  ? AppColors.gold.withValues(alpha: 0.3)
                  : AppColors.white.withValues(alpha: 0.08))
              : (isInvocation
                  ? AppColors.goldMetallic.withValues(alpha: 0.4)
                  : AppColors.lightCardBorder),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (number != null) ...[
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark
                    ? AppColors.saffron.withValues(alpha: 0.25)
                    : AppColors.saffron.withValues(alpha: 0.18),
                border: Border.all(
                  color: isDark ? AppColors.saffronLight : AppColors.saffronDark,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  number,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.goldLight : AppColors.saffronDark,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ] else if (isInvocation) ...[
            Icon(
              Icons.stars_rounded,
              color: isDark ? AppColors.gold : AppColors.saffronDark,
              size: 22,
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              text,
              style: isInvocation
                  ? AppTypography.pledgeInvocation(isMobile, isDark: isDark)
                  : AppTypography.pledgeBody(isMobile, isDark: isDark),
            ),
          ),
        ],
      ),
    );
  }
}
