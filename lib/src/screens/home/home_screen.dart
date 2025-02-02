import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/base/base_widget/base_page.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/src/screens/home/bloc/home_bloc.dart';
import 'package:maratha_shivmudra/src/screens/home/home_view.dart';

class HomeScreen extends BasePage<HomeBloc> {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStatefulPage<HomeBloc, HomeScreen> {
  @override
  HomeBloc get provideBase => getIt<HomeBloc>();

  @override
  Widget buildView(BuildContext context, HomeBloc model) {
    return HomeView(model);
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return AppBar();
  }
}
