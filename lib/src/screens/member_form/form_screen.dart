import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/base/base_widget/base_page.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/src/screens/member_form/bloc/form_bloc.dart';
import 'package:maratha_shivmudra/src/screens/member_form/form_view.dart';

@RoutePage()
class MemberFormScreen extends BasePage<MemberFormBloc> {
  const MemberFormScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MemberFormScreenState();
}

class _MemberFormScreenState
    extends BaseStatefulPage<MemberFormBloc, MemberFormScreen> {
  @override
  MemberFormBloc get provideBase => getIt<MemberFormBloc>();

  @override
  Widget buildView(BuildContext context, MemberFormBloc model) {
    return MemberFormView(model);
  }
}
