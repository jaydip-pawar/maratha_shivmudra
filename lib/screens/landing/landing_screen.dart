import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/screens/authentication/otp_verification.dart';
import 'package:maratha_shivmudra/utils/responsive.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void _showDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: Responsive.isMobile(context)
              ? EdgeInsets.symmetric(horizontal: 16)
              : null,
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
            child: OtpVerification(),
          ),
        );
      },
    );
  }

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
              _showDialog(context, 'Login Dialog');
            },
            child: Text('Login'),
          ),
          MaterialButton(
            onPressed: () {
              _showDialog(context, 'Sign Up Dialog');
            },
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
