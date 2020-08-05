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
  OnChangeGlobalEvent(this.isGlobal);
}
