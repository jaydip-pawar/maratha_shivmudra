import 'package:auto_route/annotations.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/core/mixins/get_it_helper_mixin.dart';
import 'package:maratha_shivmudra/src/screens/authentication/auth_dialog.dart';

@RoutePage()
class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with GetItHelperMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkReferralFlow(context);
    });
  }

  Future<void> _checkReferralFlow(BuildContext context) async {
    final ss = getIt<SecureStorage>();
    final isLoggedIn = await ss.isUserLoggedIn();

    final uri = Uri.base;
    if (uri.queryParameters.containsKey('ref')) {
      if (!isLoggedIn) {
        if (context.mounted) {
          AuthDialog.show(context);
        }
      }
    }
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
              AuthDialog.show(context);
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
