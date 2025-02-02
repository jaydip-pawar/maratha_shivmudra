import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:maratha_shivmudra/core/base/bloc/bloc_base/bloc_base.dart';
import 'package:maratha_shivmudra/core/base/bloc/event/base_event.dart';
import 'package:maratha_shivmudra/core/base/bloc/state/base_state.dart';

part 'landing_event.dart';
part 'landing_state.dart';

@injectable
class LandingBloc extends BlocBase<LandingEvent, LandingState> {
  LandingBloc() : super(LandingState());

  @override
  void init() {
    super.init();
    // apiCall<List<ArticleModel>>(
    //   _getArticleUseCase,
    //   params: GetArticleParams(category: ''),
    //   onSuccess: (data) => add(GetArticlesEvent(data)),
    // );
  }

  @override
  void mapEventToState() {
    on<GetArticlesEvent>((event, emit) {
      emit(state.copyWith(list: event.list));
    });
  }
}
