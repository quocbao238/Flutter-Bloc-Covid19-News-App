part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class FeatchDataEvent extends HomeEvent {}

class OnTapCarouselEvent extends HomeEvent {
  final String link;
  OnTapCarouselEvent(this.link);
}

class OnChangeGlobalEvent extends HomeEvent {
  final bool isGlobal;
  final String txtGlobal;
  OnChangeGlobalEvent(this.isGlobal, this.txtGlobal);
}

class OnChangeCountryEvent extends HomeEvent {
  final String countryName;
  OnChangeCountryEvent(this.countryName);
}
