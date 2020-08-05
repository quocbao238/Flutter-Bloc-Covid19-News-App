part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class FeatchDataSucessState extends HomeState {
  final List<NewsModel> listNews;
  FeatchDataSucessState({this.listNews});
}

class OnChangeGlobalState extends HomeState {
  final bool isGlobal;

  OnChangeGlobalState(this.isGlobal);
}

class FeatchDataFailState extends HomeState {}

class LoadingState extends HomeState {}
