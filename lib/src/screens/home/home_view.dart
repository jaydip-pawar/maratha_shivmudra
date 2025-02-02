import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maratha_shivmudra/core/base/base_widget/modular_state.dart';
import 'package:maratha_shivmudra/src/screens/home/bloc/home_bloc.dart';

class HomeView extends ModularState<HomeBloc> {
  const HomeView(super.bloc, {super.key});

  @override
  Widget build(BuildContext context, HomeBloc model) {
    return Column(
      children: [
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                return Text(state.list[index].title);
              },
            );
          },
        ),
      ],
    );
  }
}
