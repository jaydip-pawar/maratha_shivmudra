import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final ss = getIt<SecureStorage>();
    final mobileNumber = await ss.getMobileNumber();
    if (mobileNumber.trim().isNotEmpty) {
      resolver.next(true);
    } else {
      resolver.next(false);
      router.replaceAll([const LandingRoute()]);
    }
  }
}

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LandingRoute.page, path: '/', initial: true),
        AutoRoute(
          page: MemberFormRoute.page,
          path: '/member_form',
          guards: [AuthGuard()],
        ),
      ];

  @override
  List<AutoRouteGuard> get guards => [
        // optionally add root guards here
      ];
}
