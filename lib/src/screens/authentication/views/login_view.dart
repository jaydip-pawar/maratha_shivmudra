import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    return BlocBuilder<AuthBloc, AuthState>(
      bloc: bloc,
      builder: (context, blocState) {
        final state = blocState as dynamic;

        if (state.hasError) {
          bloc.formKey.currentState!.validate();
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(32, 48, 32, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.enter_your_mobile_number,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Text(
                context.l10n
                    .we_will_sign_you_in_or_create_an_account_automatically,
                style: TextStyle(fontSize: 18),
              ),
              24.h,
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey, width: .8),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 400),
                        child: Form(
                          key: bloc.formKey,
                          child: PhoneNumberField(
                            controller: bloc.phoneController,
                            validator: (_) {
                              if (state.hasError) {
                                return context.l10n.something_went_wrong;
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      16.h,
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 400),
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
                            child: state.isLoading
                                ? SizedBox(
                                    key: ValueKey('loading'),
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    key: ValueKey('login_text'),
                                    context.l10n.login,
                                  ),
                          ),
                          onTap: () {
                            if (state.isLoading) return;
                            if (bloc.formKey.currentState!.validate()) {
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
              )
            ],
          ),
        );
      },
    );
  }
}
