import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';
import 'package:maratha_shivmudra/core/theme/theme_service.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/src/widgets/buttons/material_button.dart';

class FormSubmittedDialog {
  static void show(BuildContext context) {
    showDialog<void>(
      barrierDismissible: false,
      barrierColor: AppColors.black.withValues(alpha: 0.75),
      context: context,
      builder: (BuildContext context) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: appThemeModeNotifier,
          builder: (context, _, __) {
            final isDark = ThemeService.instance.isDarkMode(context);
            final isMobile = context.isMobile;

            return Dialog(
              backgroundColor: AppColors.transparent,
              surfaceTintColor: AppColors.transparent,
              insetPadding: isMobile
                  ? const EdgeInsets.symmetric(horizontal: 16)
                  : const EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : AppColors.lightSurface,
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
                          ? AppColors.saffron.withValues(alpha: 0.15)
                          : AppColors.goldShadow.withValues(alpha: 0.15),
                      blurRadius: 30,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: isDark
                          ? AppColors.black.withValues(alpha: 0.8)
                          : AppColors.textDarkPrimary.withValues(alpha: 0.08),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 48,
                  vertical: isMobile ? 36 : 44,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.green.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.green,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.green.withValues(alpha: 0.3),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          CupertinoIcons.checkmark_alt,
                          color: AppColors.green,
                          size: 38,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        context.l10n.thank_you_for_joining,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: isMobile ? 20 : 22,
                          color: isDark
                              ? AppColors.goldLight
                              : AppColors.textDarkPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      context.l10n.joining_message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: isDark
                            ? AppColors.textSecondary
                            : AppColors.textDarkSecondary,
                      ),
                    ),
                    const SizedBox(height: 28),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: CustomMaterialButton(
                        text: context.l10n.go_to_dashboard,
                        onTap: () async {
                          await context.router
                              .replaceAll([const LandingRoute()]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
