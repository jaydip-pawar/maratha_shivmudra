part of 'form_bloc.dart';

@immutable
sealed class MemberFormEvent extends BaseEvent {}

class GetArticlesEvent extends MemberFormEvent {
  final List<ArticleModel> list;

  GetArticlesEvent(this.list);
}
