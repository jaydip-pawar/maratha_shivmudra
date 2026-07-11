import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:maratha_shivmudra/core/di/di.config.dart';

GetIt getIt = GetIt.instance;

@InjectableInit(
  externalPackageModulesBefore: [
    ExternalModule(DomainPackageModule),
    ExternalModule(DataPackageModule),
  ],
)
Future<GetIt> initDependencyInjection() async => getIt.init();
