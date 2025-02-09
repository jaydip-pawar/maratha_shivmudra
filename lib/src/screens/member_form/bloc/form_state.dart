part of 'form_bloc.dart';

class FormState extends BaseState {
  final List<ArticleModel> list;

  FormState({this.list = const <ArticleModel>[]});

  FormState copyWith({List<ArticleModel>? list}) {
    return FormState(
      list: list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [];
}
