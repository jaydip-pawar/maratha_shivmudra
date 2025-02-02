part of 'landing_bloc.dart';

class LandingState extends BaseState {
  final List<ArticleModel> list;

  LandingState({this.list = const <ArticleModel>[]});

  LandingState copyWith({List<ArticleModel>? list}) {
    return LandingState(
      list: list ?? this.list,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
