import 'dart:async';
import 'package:bCovid/model/news_model.dart';
import 'package:bCovid/model/covid_model.dart';
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
      var listCovidModel = await AppSetting.dataService.getListTotalCovid();
      if (lstNews.length > 0 && listCovidModel.length > 0) {
        //Để load 5s xem hiệu ứng loading =))
        await Future.delayed(Duration(milliseconds: 5000)); 
        yield FeatchDataSucessState(
            listNews: lstNews, listCovidModel: listCovidModel);
      } else {
        yield FeatchDataFailState();
      }
    } else if (event is OnTapCarouselEvent) {
      // print(event.link);
      yield OnTapCarouselState(event.link);
    } else if (event is OnChangeGlobalEvent) {
      yield OnChangeGlobalState(event.isGlobal, event.txtGlobal);
    } else if (event is OnChangeCountryEvent) {
      yield OnChangeCountryState(event.countryName);
    }
    yield HomeInitial();
  }

  // isGlobal = false -> IndexState = 0;
  // isGlobal = true -> GlobalSearch
  // !GlobalSearch -> GLobalSearch
  // VN -> IndexState = 0;
  // GlobalSearch -> IndexState = 1;
  // GlobalDetail -> IndexState = 2;

}
