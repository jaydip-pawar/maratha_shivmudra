import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Container(
      width: double.infinity,
      color: AppColors.footerBg,
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
                        _buildOrgInfo(context),
                        const SizedBox(height: 32),
                        _buildContactInfo(context),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: _buildOrgInfo(context),
                        ),
                        const SizedBox(width: 48),
                        Expanded(
                          flex: 5,
                          child: _buildContactInfo(context),
                        ),
                      ],
                    ),

              const SizedBox(height: 40),

              // Divider
              Container(
                height: 1,
                color: AppColors.white.withValues(alpha: 0.1),
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
                            style: AppTypography.footerCopyright,
                          ),
                        ),
                        const SizedBox(width: 16),
                        InkWell(
                          onTap: () => context.router.push(const AdminLoginRoute()),
                          child: const Text(
                            '• ॲडमिन (Admin)',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    '🚩 जय शिवराय',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.saffronLight,
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

  Widget _buildOrgInfo(BuildContext context) {
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
                style: const TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldLight,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          context.l10n.hero_subtitle,
          style: AppTypography.footerBody,
        ),
        const SizedBox(height: 14),
        Text(
          context.l10n.made_with_devotion,
          style: AppTypography.footerTribute,
        ),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.contact_title,
          style: AppTypography.footerHeading,
        ),
        const SizedBox(height: 14),

        // Phone Number
        _buildContactRow(
          icon: Icons.phone_rounded,
          label: context.l10n.phone_number_label,
          value: context.l10n.phone_number,
          iconColor: AppColors.saffronLight,
        ),

        const SizedBox(height: 12),

        // Email
        _buildContactRow(
          icon: Icons.email_rounded,
          label: context.l10n.email_address_label,
          value: context.l10n.email_address,
          iconColor: AppColors.gold,
        ),

        const SizedBox(height: 12),

        // Location
        _buildContactRow(
          icon: Icons.location_on_rounded,
          label: context.l10n.org_address_label,
          value: context.l10n.org_address_val,
          iconColor: AppColors.locationBlue,
        ),
      ],
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
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
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textMuted,
                ),
              ),
              SelectableText(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
