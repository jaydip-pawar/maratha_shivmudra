import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maratha_shivmudra/core/base/bloc/state/base_state.dart';
import 'package:maratha_shivmudra/core/utils/request_controller.dart';

abstract class CubitBase<S extends BaseState> extends Cubit<S>
    with RequestController {
  CubitBase(super.state) {
    init();
  }

  void init() {}
}
