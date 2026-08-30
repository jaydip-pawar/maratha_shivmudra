import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/src/screens/authentication/bloc/auth_bloc.dart';
import 'package:maratha_shivmudra/src/screens/authentication/views/login_view.dart';
import 'package:maratha_shivmudra/src/screens/authentication/views/otp_verification_view.dart';
import 'package:maratha_shivmudra/src/screens/authentication/views/success_view.dart';

class AuthDialog {
  static void show(BuildContext context) {
    showDialog<void>(
      barrierDismissible: false,
      barrierColor: AppColors.black.withValues(alpha: 0.75),
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          insetPadding: context.isMobile
              ? const EdgeInsets.symmetric(horizontal: 16)
              : const EdgeInsets.symmetric(horizontal: 32),
          child: BlocProvider(
            create: (context) => getIt<AuthBloc>(),
            child: BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (previous, current) {
                return previous.runtimeType != current.runtimeType;
              },
              builder: (context, state) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                    child: Container(
                      key: ValueKey(state.runtimeType),
                      constraints: const BoxConstraints(
                        maxWidth: 680,
                        maxHeight: 520,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cardDark,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.gold.withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.saffron.withValues(alpha: 0.15),
                            blurRadius: 30,
                            spreadRadius: 2,
                          ),
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.8),
                            blurRadius: 25,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: () {
                        if (state is AuthVerificationState) {
                          return const OtpVerificationView();
                        } else if (state is AuthSuccessState) {
                          return const SuccessView();
                        } else {
                          return const LoginView();
                        }
                      }(),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
