import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';

import 'package:maratha_shivmudra/core/theme/theme_service.dart';

class FooterSection extends StatelessWidget {
  final bool? isDark;

  const FooterSection({super.key, this.isDark});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = isDark ?? ThemeService.instance.isDarkMode(context);
    final isMobile = context.isMobile;

    return Container(
      width: double.infinity,
      color: isDarkMode ? AppColors.footerBg : AppColors.lightFooterBg,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 48,
        vertical: isMobile ? 36 : 56,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildOrgInfo(context, isDarkMode),
                        const SizedBox(height: 32),
                        _buildContactInfo(context, isDarkMode),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: _buildOrgInfo(context, isDarkMode),
                        ),
                        const SizedBox(width: 48),
                        Expanded(
                          flex: 5,
                          child: _buildContactInfo(context, isDarkMode),
                        ),
                      ],
                    ),

              const SizedBox(height: 40),

              // Divider
              Container(
                height: 1,
                color: isDarkMode
                    ? AppColors.white.withValues(alpha: 0.1)
                    : AppColors.lightDivider,
              ),

              const SizedBox(height: 24),

              // Bottom Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            '© ${DateTime.now().year} ${context.l10n.maratha_shivmudra}. ${context.l10n.rights_reserved}',
                            style: AppTypography.footerCopyright(isDark: isDarkMode),
                          ),
                        ),
                        const SizedBox(width: 16),
                        InkWell(
                          onTap: () => context.router.push(const AdminLoginRoute()),
                          child: Text(
                            '• ॲडमिन (Admin)',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDarkMode ? AppColors.textMuted : AppColors.textDarkMuted,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '🚩 जय शिवराय',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? AppColors.saffronLight : AppColors.saffronDark,
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

  Widget _buildOrgInfo(BuildContext context, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              AppAssets.logo,
              width: 38,
              height: 38,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Text('🚩', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                context.l10n.maratha_shivmudra,
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? AppColors.goldLight : AppColors.saffronDark,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          context.l10n.hero_subtitle,
          style: AppTypography.footerBody(isDark: isDarkMode),
        ),
        const SizedBox(height: 14),
        Text(
          context.l10n.made_with_devotion,
          style: AppTypography.footerTribute(isDark: isDarkMode),
        ),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.contact_title,
          style: AppTypography.footerHeading(isDark: isDarkMode),
        ),
        const SizedBox(height: 14),

        // Phone Number
        _buildContactRow(
          icon: Icons.phone_rounded,
          label: context.l10n.phone_number_label,
          value: context.l10n.phone_number,
          iconColor: isDarkMode ? AppColors.saffronLight : AppColors.saffron,
          isDarkMode: isDarkMode,
        ),

        const SizedBox(height: 12),

        // Email
        _buildContactRow(
          icon: Icons.email_rounded,
          label: context.l10n.email_address_label,
          value: context.l10n.email_address,
          iconColor: isDarkMode ? AppColors.gold : AppColors.goldDark,
          isDarkMode: isDarkMode,
        ),

        const SizedBox(height: 12),

        // Location
        _buildContactRow(
          icon: Icons.location_on_rounded,
          label: context.l10n.org_address_label,
          value: context.l10n.org_address_val,
          iconColor: AppColors.locationBlue,
          isDarkMode: isDarkMode,
        ),
      ],
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
    required bool isDarkMode,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: isDarkMode ? 0.12 : 0.14),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 16),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: isDarkMode ? AppColors.textMuted : AppColors.textDarkMuted,
                ),
              ),
              SelectableText(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? AppColors.textPrimary : AppColors.textDarkPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
