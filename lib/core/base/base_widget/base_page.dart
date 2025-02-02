import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maratha_shivmudra/core/base/base_widget/core_base_page_state.dart';

/// Every Page/View should be inherited from this
abstract class BasePage<VM extends BlocBase> extends StatefulWidget {
  const BasePage({super.key});
}

abstract class BasePageState<VM extends BlocBase, T extends BasePage<VM>>
    extends CoreBasePageState<VM, T> {
  @mustCallSuper
  @protected
  VM get provideBase;

  late final VM _viewModel = provideBase;
}

abstract class BaseStatefulPage<VM extends BlocBase, B extends BasePage<VM>>
    extends BasePageState<VM, B> {
  @override
  void initState() {
    super.initState();
    onBaseModelReady(_viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return getLayout();
  }
}
