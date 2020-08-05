import 'dart:async';
import 'package:bCovid/model/news_model.dart';
import 'package:bCovid/setting/setting.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FeatchDataEvent) {
      yield LoadingState();
      var lstNews = await AppSetting.dataService.getListNews();
      if (lstNews.length > 0) {
        await Future.delayed(Duration(milliseconds: 20000));
        yield FeatchDataSucessState(listNews: lstNews);
      } else {
        yield FeatchDataFailState();
      }
    } else if (event is OnTapCarouselEvent) {
      print(event.link);
    } else if(event is OnChangeGlobalEvent){
      yield OnChangeGlobalState(!event.isGlobal);
    }
    yield HomeInitial();
  }
}
