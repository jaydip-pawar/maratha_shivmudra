import 'package:maratha_shivmudra/core/di/di.dart';

mixin class GetItHelperMixin {
  void setData<T extends Object>(String instance, T data) {
    if (getIt.isRegistered<T>(instanceName: instance)) {
      getIt.unregister<T>(instanceName: instance);
    }
    getIt.registerFactory<T>(() => data, instanceName: instance);
  }

  void registerFactory<T extends Object>(T data) {
    if (getIt.isRegistered<T>()) {
      getIt.unregister<T>();
    }
    getIt.registerFactory<T>(() => data);
  }

  T? getData<T extends Object>(String instance) {
    if (getIt.isRegistered<T>(instanceName: instance)) {
      return getIt<T>(instanceName: instance);
    }
    return null;
  }

  T? getFactory<T extends Object>() {
    if (getIt.isRegistered<T>()) {
      return getIt<T>();
    }
    return null;
  }
}
