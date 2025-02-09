part of 'form_bloc.dart';

class MemberFormState extends BaseState {
  final List<ArticleModel> list;

  MemberFormState({this.list = const <ArticleModel>[]});

  MemberFormState copyWith({List<ArticleModel>? list}) {
    return MemberFormState(
      list: list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [];
}
