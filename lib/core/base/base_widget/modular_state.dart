import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ModularState<T extends BlocBase> extends Widget {
  const ModularState(this._bloc, {super.key});

  final T _bloc;

  @protected
  Widget build(BuildContext context, T model);

  @override
  DataProviderElement<T> createElement() => DataProviderElement<T>(this, _bloc);

  void dispose() {}
}

class DataProviderElement<T extends BlocBase> extends ComponentElement {
  DataProviderElement(ModularState super.widget, this._bloc);

  final T _bloc;

  // @override
  // ModularState get widget => super.widget as ModularState;

  @override
  late final ModularState widget = super.widget as ModularState;

  @override
  Widget build() {
    return BlocProvider<T>(
      create: (context) => _bloc,
      child: widget.build(this, _bloc),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    widget.dispose();
  }
// @override
// void mount() {
//   super.mount();
//   bloc.init(); // Call init function on bloc
// }

// @override
// void unmount() {
//   widget.dispose(); // Dispose bloc resources
//   super.unmount();
// }
}
