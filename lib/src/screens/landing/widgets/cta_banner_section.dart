import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/src/screens/authentication/auth_dialog.dart';

class CtaBannerSection extends StatelessWidget {
  const CtaBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppGradients.ctaBackground,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: AppColors.goldBorderMedium,
            width: 1.5,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 48,
        vertical: isMobile ? 40 : 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              // Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.gold.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: const Text(
                  '🚩 जयोस्तु मराठा शिवमुद्रा 🚩',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldLight,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Title
              Text(
                context.l10n.cta_title,
                textAlign: TextAlign.center,
                style: AppTypography.ctaTitle(isMobile),
              ),

              const SizedBox(height: 14),

              // Subtitle
              Text(
                context.l10n.cta_subtitle,
                textAlign: TextAlign.center,
                style: AppTypography.ctaSubtitle(isMobile),
              ),

              const SizedBox(height: 32),

              // Action Buttons
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 12,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => AuthDialog.show(context),
                    icon: const Icon(Icons.person_add_rounded,
                        size: 18, color: AppColors.white),
                    label: Text(
                      context.l10n.cta_btn_register,
                      style: AppTypography.buttonLabel,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.saffron,
                      elevation: 6,
                      shadowColor: AppColors.saffron.withValues(alpha: 0.6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: AppColors.goldLight,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => AuthDialog.show(context),
                    icon: const Icon(Icons.login_rounded,
                        size: 18, color: AppColors.goldLight),
                    label: Text(
                      context.l10n.cta_btn_login,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldLight,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.gold,
                        width: 1.5,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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
}
