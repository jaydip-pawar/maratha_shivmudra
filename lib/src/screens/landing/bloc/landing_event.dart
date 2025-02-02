part of 'landing_bloc.dart';

@immutable
sealed class LandingEvent extends BaseEvent {}

class GetArticlesEvent extends LandingEvent {
  final List<ArticleModel> list;

  GetArticlesEvent(this.list);
}
