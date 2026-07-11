// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:data/src/di/network_module.dart' as _i377;
import 'package:data/src/network/retrofit_service.dart' as _i1066;
import 'package:data/src/repository/article_repository/article_repository_impl.dart'
    as _i503;
import 'package:data/src/repository/auth_repository/auth_repository_impl.dart'
    as _i831;
import 'package:data/src/repository/secure_storage/secure_storage_impl.dart'
    as _i746;
import 'package:data/src/source/article_data_source/article_ds.dart' as _i492;
import 'package:data/src/source/article_data_source/article_ds_impl.dart'
    as _i634;
import 'package:data/src/source/auth_data_source/auth_ds.dart' as _i1059;
import 'package:data/src/source/auth_data_source/auth_ds_impl.dart' as _i894;
import 'package:data/src/util/api_interceptor.dart' as _i519;
import 'package:dio/dio.dart' as _i361;
import 'package:domain/domain.dart' as _i494;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

class DataPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    final networkModule = _$NetworkModule();
    gh.singleton<_i528.PrettyDioLogger>(() => networkModule.logger());
    gh.singleton<_i519.ApiInterceptor>(
        () => networkModule.provideApiInterceptor());
    gh.singleton<List<_i361.Interceptor>>(
        () => networkModule.providerInterceptors(gh<_i519.ApiInterceptor>()));
    gh.factory<_i494.SecureStorage>(() => _i746.SecureStorageImpl());
    gh.lazySingleton<_i361.Dio>(
        () => networkModule.providerDio(gh<List<_i361.Interceptor>>()));
    gh.lazySingleton<_i1066.RetrofitService>(
        () => networkModule.providerRetrofitService(gh<_i361.Dio>()));
    gh.factory<_i492.ArticleDataSource>(
        () => _i634.ArticleDataSourceImpl(gh<_i1066.RetrofitService>()));
    gh.factory<_i1059.AuthDataSource>(
        () => _i894.AuthDataSourceImpl(gh<_i1066.RetrofitService>()));
    gh.factory<_i494.AuthRepository>(() =>
        _i831.AuthRepositoryImpl(authDataSource: gh<_i1059.AuthDataSource>()));
    gh.factory<_i494.ArticleRepository>(() => _i503.ArticleRepositoryImpl(
        articleDataSource: gh<_i492.ArticleDataSource>()));
  }
}

class _$NetworkModule extends _i377.NetworkModule {}
