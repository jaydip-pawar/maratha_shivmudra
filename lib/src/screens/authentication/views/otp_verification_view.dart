import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/core/utils/responsive.dart';
import 'package:maratha_shivmudra/src/screens/authentication/bloc/auth_bloc.dart';
import 'package:maratha_shivmudra/src/widgets/animation/loading_text.dart';
import 'package:maratha_shivmudra/src/widgets/textfields/otp_field.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key});

  Widget _buildLoaderErrorWidget(
    BuildContext context, {
    required Widget child,
    required dynamic state,
  }) {
    if (state.hasError as bool || state.isLoading as bool) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state.hasError as bool) ...[
            16.h,
            Text(
              state.invalidOtp as bool
                  ? context.l10n.invalid_otp
                  : context.l10n.something_went_wrong,
              style: const TextStyle(
                color: AppColors.errorColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ] else ...[
            16.h,
            AnimatedLoadingText(text: context.l10n.waiting_for_verification),
          ],
          child,
        ],
      );
    }
    return child;
  }

  Widget _buildOtpFieldSection(BuildContext context) {
    final isMobile = context.isMobile || context.isMobileLarge;
    final bloc = context.read<AuthBloc>();

    return Container(
      constraints: isMobile ? const BoxConstraints(maxWidth: 450) : null,
      width: isMobile ? double.infinity : null,
      child: Padding(
        padding: isMobile
            ? const EdgeInsets.fromLTRB(24, 36, 24, 28)
            : const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.verify_your_account,
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 20 : 22,
                color: AppColors.goldLight,
              ),
              softWrap: true,
            ),
            const SizedBox(height: 6),
            Text(
              context.l10n.enter_the_verification_code_sent_to_your_phone,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 6),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
                children: [
                  TextSpan(text: () {
                    final number =
                        bloc.phoneController.text.replaceAll(' ', '');
                    return '+91 $number. ';
                  }()),
                  TextSpan(
                    text: context.l10n.change_number,
                    style: const TextStyle(
                      color: AppColors.goldLight,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.goldLight,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => bloc.add(BackEvent()),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            OtpField(
              onDone: (otp) {
                bloc.add(ApiStatusEvent(isLoading: true, hasError: false));
                return bloc.verifyOtp(otp);
              },
            ),
            BlocBuilder<AuthBloc, AuthState>(
              bloc: bloc,
              buildWhen: (previous, current) {
                return previous.runtimeType == current.runtimeType;
              },
              builder: (context, blocState) {
                final state = blocState as dynamic;
                return _buildLoaderErrorWidget(
                  context,
                  state: state,
                  child: const SizedBox(height: 18),
                );
              },
            ),
            Wrap(
              spacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  context.l10n.havent_received_the_code,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final bloc = context.read<AuthBloc>();
                    bloc.add(
                      ApiStatusEvent(isLoading: true, hasError: false),
                    );
                    await bloc.initiateOtp();
                  },
                  child: Text(
                    context.l10n.send_again,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.saffronLight,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.saffronLight,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _buildOtpFieldSection(context)),
          const SizedBox(width: 16),
          FittedBox(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [
                    AppColors.maroonDeep,
                    AppColors.darkSurface,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: AppColors.gold.withValues(alpha: 0.25),
                  width: 1,
                ),
              ),
              height: 340,
              width: 240,
              child: DotLottieLoader.fromAsset(
                AppAssets.otpIllustration,
                frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                  if (dotlottie != null) {
                    return Lottie.memory(dotlottie.animations.values.single);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _buildOtpFieldSection(context),
      tablet: _buildTabletView(context),
    );
  }
}
