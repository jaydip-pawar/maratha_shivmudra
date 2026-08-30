import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/core/mixins/get_it_helper_mixin.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/src/screens/authentication/bloc/auth_bloc.dart';
import 'package:maratha_shivmudra/src/widgets/buttons/material_button.dart';

class SuccessView extends StatelessWidget with GetItHelperMixin {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    final isMobile = context.isMobile;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: 36,
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
              context.l10n.account_verified,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 20 : 22,
                color: AppColors.goldLight,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.welcome,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 28),
          BlocBuilder<AuthBloc, AuthState>(
            bloc: bloc,
            buildWhen: (previous, current) {
              return previous.runtimeType == current.runtimeType;
            },
            builder: (context, blocState) {
              final state = blocState as AuthSuccessState;
              return ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: CustomMaterialButton(
                  text: state.isFormFilled
                      ? context.l10n.go_to_dashboard
                      : context.l10n.fill_the_member_form,
                  onTap: () async {
                    final ss = getIt<SecureStorage>();
                    final phoneNumber = getData<String>('mobileNumber');
                    if (phoneNumber != null) {
                      await ss.setMobileNumber(phoneNumber);
                    }
                    if (state.isFormFilled) {
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    } else {
                      if (context.mounted) {
                        context.router.replaceAll([MemberFormRoute()]);
                      }
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
