import 'package:auto_route/auto_route.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LandingRoute.page, path: '/member-form'),
        AutoRoute(page: MemberFormRoute.page, path: '/', initial: true),
      ];

  @override
  List<AutoRouteGuard> get guards => [
        // optionally add root guards here
      ];
}
