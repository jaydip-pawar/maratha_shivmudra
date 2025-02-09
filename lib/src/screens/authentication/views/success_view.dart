import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/src/screens/authentication/bloc/auth_bloc.dart';
import 'package:maratha_shivmudra/src/widgets/buttons/material_button.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? 30 : 60,
        vertical: 45,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.green,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                CupertinoIcons.checkmark_alt,
                color: Colors.white,
                size: 45,
              ),
            ),
          ),
          40.h,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              context.l10n.account_verified,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          10.h,
          Text(
            context.l10n.welcome,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          30.h,
          BlocBuilder<AuthBloc, AuthState>(
            bloc: bloc,
            buildWhen: (previous, current) {
              return previous.runtimeType == current.runtimeType;
            },
            builder: (context, blocState) {
              final state = blocState as AuthSuccessState;
              return ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: CustomMaterialButton(
                  text: state.isFormFilled
                      ? context.l10n.go_to_dashboard
                      : context.l10n.fill_the_member_form,
                  onTap: () {
                    if (state.isFormFilled) {
                      Navigator.of(context);
                    } else {
                      context.navigateTo(FormRoute());
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
