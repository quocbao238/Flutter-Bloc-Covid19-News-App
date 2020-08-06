part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class FeatchDataSucessState extends HomeState {
  final List<NewsModel> listNews;
  final List<CovidModel> listCovidModel;
  FeatchDataSucessState({this.listNews, this.listCovidModel});
}

class OnChangeGlobalState extends HomeState {
  final bool isGlobal;
  final txtGlobal;
  OnChangeGlobalState(this.isGlobal, this.txtGlobal);
}

class OnTapCarouselState extends HomeState {
  final String url;
  OnTapCarouselState(this.url);
}

class OnChangeCountryState extends HomeState {
  final String countryName;
  OnChangeCountryState(this.countryName);
}

class FeatchDataFailState extends HomeState {}

class LoadingState extends HomeState {}
