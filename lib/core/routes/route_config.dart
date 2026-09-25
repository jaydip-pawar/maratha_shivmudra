import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';
import 'package:maratha_shivmudra/core/services/admin_auth_service.dart';

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

class AdminGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (AdminAuthService.instance.isAdminLoggedIn) {
      resolver.next(true);
    } else {
      resolver.next(false);
      router.replaceAll([const AdminLoginRoute()]);
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
        AutoRoute(
          page: ProfileRoute.page,
          path: '/profile',
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: VerifyRoute.page,
          path: '/verify',
        ),
        AutoRoute(
          page: AdminLoginRoute.page,
          path: '/admin/login',
        ),
        AutoRoute(
          page: AdminDashboardRoute.page,
          path: '/admin/dashboard',
          guards: [AdminGuard()],
        ),
        RedirectRoute(path: '/admin', redirectTo: '/admin/dashboard'),
      ];

  @override
  List<AutoRouteGuard> get guards => [
        // optionally add root guards here
      ];
}
