import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/src/screens/authentication/bloc/auth_bloc.dart';
import 'package:maratha_shivmudra/src/screens/authentication/views/login_view.dart';
import 'package:maratha_shivmudra/src/screens/authentication/views/otp_verification_view.dart';
import 'package:maratha_shivmudra/src/screens/authentication/views/success_view.dart';

class AuthDialog {
  static void show(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding:
              context.isMobile ? EdgeInsets.symmetric(horizontal: 16) : null,
          child: BlocProvider(
            create: (context) => getIt<AuthBloc>(),
            child: BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (previous, current) {
                return previous.runtimeType != current.runtimeType;
              },
              builder: (context, state) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
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
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    child: Container(
                      key: ValueKey(state.runtimeType),
                      constraints:
                          BoxConstraints(maxWidth: 700, maxHeight: 400),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(0x80),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: () {
                        if (state is AuthVerificationState) {
                          return OtpVerificationView();
                        } else if (state is AuthSuccessState) {
                          return SuccessView();
                        } else {
                          return LoginView();
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
