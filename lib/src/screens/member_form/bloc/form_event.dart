part of 'form_bloc.dart';

@immutable
sealed class FormEvent extends BaseEvent {}

class GetArticlesEvent extends FormEvent {
  final List<ArticleModel> list;

  GetArticlesEvent(this.list);
}
