// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:data/data.dart' as _i437;
import 'package:domain/domain.dart' as _i494;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:maratha_shivmudra/src/screens/authentication/bloc/auth_bloc.dart'
    as _i218;
import 'package:maratha_shivmudra/src/screens/home/bloc/home_bloc.dart'
    as _i316;
import 'package:maratha_shivmudra/src/screens/landing/bloc/landing_bloc.dart'
    as _i669;
import 'package:maratha_shivmudra/src/screens/member_form/bloc/form_bloc.dart'
    as _i457;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    await _i494.DomainPackageModule().init(gh);
    await _i437.DataPackageModule().init(gh);
    gh.factory<_i218.AuthBloc>(() => _i218.AuthBloc());
    gh.factory<_i669.LandingBloc>(() => _i669.LandingBloc());
    gh.factory<_i457.MemberFormBloc>(() => _i457.MemberFormBloc());
    gh.factory<_i316.HomeBloc>(
      () => _i316.HomeBloc(gh<_i494.GetArticleUseCase>()),
    );
    return this;
  }
}
