// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:maratha_shivmudra/src/screens/admin/admin_dashboard_screen.dart'
    as _i1;
import 'package:maratha_shivmudra/src/screens/admin/admin_login_screen.dart'
    as _i2;
import 'package:maratha_shivmudra/src/screens/landing/landing_screen.dart'
    as _i3;
import 'package:maratha_shivmudra/src/screens/member_form/form_screen.dart'
    as _i4;
import 'package:maratha_shivmudra/src/screens/profile/profile_screen.dart'
    as _i5;
import 'package:maratha_shivmudra/src/screens/verification/verify_screen.dart'
    as _i6;

/// generated route for
/// [_i1.AdminDashboardScreen]
class AdminDashboardRoute extends _i7.PageRouteInfo<void> {
  const AdminDashboardRoute({List<_i7.PageRouteInfo>? children})
    : super(AdminDashboardRoute.name, initialChildren: children);

  static const String name = 'AdminDashboardRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.AdminDashboardScreen();
    },
  );
}

/// generated route for
/// [_i2.AdminLoginScreen]
class AdminLoginRoute extends _i7.PageRouteInfo<void> {
  const AdminLoginRoute({List<_i7.PageRouteInfo>? children})
    : super(AdminLoginRoute.name, initialChildren: children);

  static const String name = 'AdminLoginRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.AdminLoginScreen();
    },
  );
}

/// generated route for
/// [_i3.LandingScreen]
class LandingRoute extends _i7.PageRouteInfo<void> {
  const LandingRoute({List<_i7.PageRouteInfo>? children})
    : super(LandingRoute.name, initialChildren: children);

  static const String name = 'LandingRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.LandingScreen();
    },
  );
}

/// generated route for
/// [_i4.MemberFormScreen]
class MemberFormRoute extends _i7.PageRouteInfo<void> {
  const MemberFormRoute({List<_i7.PageRouteInfo>? children})
    : super(MemberFormRoute.name, initialChildren: children);

  static const String name = 'MemberFormRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.MemberFormScreen();
    },
  );
}

/// generated route for
/// [_i5.ProfileScreen]
class ProfileRoute extends _i7.PageRouteInfo<void> {
  const ProfileRoute({List<_i7.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i6.VerifyScreen]
class VerifyRoute extends _i7.PageRouteInfo<VerifyRouteArgs> {
  VerifyRoute({_i8.Key? key, String? id, List<_i7.PageRouteInfo>? children})
    : super(
        VerifyRoute.name,
        args: VerifyRouteArgs(key: key, id: id),
        rawQueryParams: {'id': id},
        initialChildren: children,
      );

  static const String name = 'VerifyRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<VerifyRouteArgs>(
        orElse: () => VerifyRouteArgs(id: queryParams.optString('id')),
      );
      return _i6.VerifyScreen(key: args.key, id: args.id);
    },
  );
}

class VerifyRouteArgs {
  const VerifyRouteArgs({this.key, this.id});

  final _i8.Key? key;

  final String? id;

  @override
  String toString() {
    return 'VerifyRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VerifyRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}
