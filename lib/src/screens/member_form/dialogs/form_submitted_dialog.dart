import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/src/widgets/buttons/material_button.dart';

class FormSubmittedDialog {
  static void show(BuildContext context) {
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding:
              context.isMobile ? EdgeInsets.symmetric(horizontal: 16) : null,
          child: Container(
            constraints: BoxConstraints(maxWidth: 700, maxHeight: 400),
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
            child: Padding(
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
                      context.l10n.thank_you_for_joining,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  10.h,
                  Text(
                    context.l10n.joining_message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  30.h,
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 400),
                    child: CustomMaterialButton(
                      text: context.l10n.go_to_dashboard,
                      onTap: () async {
                        context.router.replaceAll([LandingRoute()]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
