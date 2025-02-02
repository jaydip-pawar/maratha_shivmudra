import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/src/widgets/buttons/material_button.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
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
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: CustomMaterialButton(
              text: context.l10n.go_to_dashboard,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
