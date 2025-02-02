import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/src/screens/authentication/auth_dialog.dart';

@RoutePage()
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withValues(alpha: 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MaterialButton(
            onPressed: () {
              AuthDialog.show(context);
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
