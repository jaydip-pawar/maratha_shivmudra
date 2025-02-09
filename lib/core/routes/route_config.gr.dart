// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:maratha_shivmudra/src/screens/landing/landing_screen.dart'
    as _i2;
import 'package:maratha_shivmudra/src/screens/member_form/form_screen.dart'
    as _i1;

/// generated route for
/// [_i1.FormScreen]
class FormRoute extends _i3.PageRouteInfo<void> {
  const FormRoute({List<_i3.PageRouteInfo>? children})
    : super(FormRoute.name, initialChildren: children);

  static const String name = 'FormRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.FormScreen();
    },
  );
}

/// generated route for
/// [_i2.LandingScreen]
class LandingRoute extends _i3.PageRouteInfo<void> {
  const LandingRoute({List<_i3.PageRouteInfo>? children})
    : super(LandingRoute.name, initialChildren: children);

  static const String name = 'LandingRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.LandingScreen();
    },
  );
}
