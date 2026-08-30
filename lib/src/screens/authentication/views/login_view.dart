import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/src/screens/authentication/bloc/auth_bloc.dart';
import 'package:maratha_shivmudra/src/widgets/buttons/material_button.dart';
import 'package:maratha_shivmudra/src/widgets/textfields/phone_number_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    final isMobile = context.isMobile;

    return BlocBuilder<AuthBloc, AuthState>(
      bloc: bloc,
      builder: (context, blocState) {
        final state = blocState as dynamic;

        if (state.hasError as bool) {
          bloc.formKey.currentState?.validate();
        }
        return Stack(
          children: [
            // Close Button
            Positioned(
              right: 16,
              top: 16,
              child: IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  color: AppColors.goldLight,
                  size: 22,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                isMobile ? 20 : 36,
                isMobile ? 36 : 40,
                isMobile ? 20 : 36,
                isMobile ? 24 : 32,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo + Title Header
                  Row(
                    children: [
                      Image.asset(
                        AppAssets.logo,
                        width: 36,
                        height: 36,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Text('🚩', style: TextStyle(fontSize: 20)),
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.l10n.enter_your_mobile_number,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 20 : 22,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    context
                        .l10n
                        .we_will_sign_you_in_or_create_an_account_automatically,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkSurface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.gold.withValues(alpha: 0.25),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 400),
                          child: Form(
                            key: bloc.formKey,
                            child: PhoneNumberField(
                              controller: bloc.phoneController,
                              validator: (_) {
                                if (state.hasError as bool) {
                                  return (state.errorMessage as String?) ??
                                      context.l10n.something_went_wrong;
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 400),
                          child: CustomMaterialButton(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  ),
                                );
                              },
                              child: state.isLoading as bool
                                  ? const SizedBox(
                                      key: ValueKey('loading'),
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.2,
                                        color: AppColors.white,
                                      ),
                                    )
                                  : Text(
                                      context.l10n.login,
                                      key: const ValueKey('login_text'),
                                      style: const TextStyle(
                                        fontFamily: AppTypography.fontFamily,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white,
                                      ),
                                    ),
                            ),
                            onTap: () {
                              if (state.isLoading as bool) return;
                              if (bloc.formKey.currentState?.validate() ??
                                  false) {
                                bloc.add(
                                  ApiStatusEvent(
                                    isLoading: true,
                                    hasError: false,
                                  ),
                                );
                                bloc.initiateOtp();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
