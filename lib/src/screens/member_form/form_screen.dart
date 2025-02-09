import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide FormState;
import 'package:maratha_shivmudra/core/base/base_widget/base_page.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/src/screens/member_form/bloc/form_bloc.dart';
import 'package:maratha_shivmudra/src/screens/member_form/form_view.dart';

@RoutePage()
class FormScreen extends BasePage<FormBloc> {
  const FormScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FormScreenState();
}

class _FormScreenState extends BaseStatefulPage<FormBloc, FormScreen> {
  @override
  FormBloc get provideBase => getIt<FormBloc>();

  @override
  Widget buildView(BuildContext context, FormBloc model) {
    return FormView(model);
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return AppBar();
  }
}
