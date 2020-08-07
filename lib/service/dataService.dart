import 'dart:convert';

import 'package:bCovid/helper/helper.dart';
import 'package:bCovid/model/news_model.dart';
import 'package:bCovid/model/covid_model.dart';
import 'package:bCovid/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';

import 'package:http/http.dart' as http;

class DataService {
  Future<List<NewsModel>> getListNews() async {
    var rssFeed = await _loadFeed();
    List<NewsModel> lstNews = [];
    rssFeed.items.forEach((item) {
      if (!item.link.toUpperCase().contains('COVID')) if (!item.link
          .toUpperCase()
          .contains('NCOV')) return;
      var newsModel = NewsModel(
          image: _getImageFromFeed(item.description),
          link: item.link.replaceAll('\'', ""),
          pubDate: item.pubDate.substring(0, item.pubDate.length - 5),
          title: item.title);
      lstNews.add(newsModel);
    });
    return lstNews;
  }

  Future<RssFeed> _loadFeed() async {
    try {
      http.Response response = await http.get(AppSetting.vnexpressUrl);
      String body = utf8.decode(response.bodyBytes);
      print(body.toString());
      var data = RssFeed.parse(body);
      return data != null ? data : null;
    } catch (e) {
      _printCatch(e);
    }
    return null;
  }

  String _getImageFromFeed(String description) {
    int indexStart = description.indexOf('src=\"') + 5;
    int indexEnd = description.indexOf('\" ></a>');
    return description.substring(indexStart, indexEnd);
  }

  Future<List<CovidModel>> getListTotalCovid() async {
    try {
      http.Response response = await http.get(AppSetting.covidApi,
          headers: ({
            "x-rapidapi-host": "covid-19-tracking.p.rapidapi.com",
            "x-rapidapi-key":
                "e48507fe50msh633ab9cb61b128fp1d31dajsnf930bcd0061e",
          }));
      print(response.body);
      return covidModelFromJson(response.body);
    } catch (e) {
      _printCatch(e);
    }
    return null;
  }

  List<GridCovidModel> searchCovidModelFromList(
      List<CovidModel> list, String countryName) {
    CovidModel covidModel =
        list.firstWhere((element) => element.countryText == countryName);
    print(covidModel.toJson().toString());
    List<GridCovidModel> gridCovidList = [];
    gridCovidList.add(GridCovidModel(
        title: AppSetting.newCase,
        urlIcon: AppSetting.iconNewCase,
        value: covidModel.newCasesText));
    gridCovidList.add(GridCovidModel(
        title: AppSetting.totalCase,
        urlIcon: AppSetting.iconTotalCase,
        value: covidModel.totalCasesText));
    gridCovidList.add(GridCovidModel(
        title: AppSetting.totalRecovered,
        urlIcon: AppSetting.icontotalRecovered,
        value: covidModel.totalRecoveredText));
    gridCovidList.add(GridCovidModel(
        title: AppSetting.totalDeath,
        urlIcon: AppSetting.iconTotalDeath,
        value: covidModel.totalDeathsText));

    return gridCovidList;
  }

  List<WorldCovid> getlistWorldCovid(CovidModel covidModel) {
    List<WorldCovid> lstWorldCovid = [];
    String lastUpdate = Helper.convertTimeLastUpdate(covidModel.lastUpdate);
    lstWorldCovid.add(WorldCovid(
        // title: AppSetting.lastUpdate,
        title: "",
        iconUrl: AppSetting.iconLastUpdate,
        value: lastUpdate));
    lstWorldCovid.add(WorldCovid(
        title: AppSetting.newCase,
        iconUrl: AppSetting.iconNewCase,
        value: covidModel.newCasesText));
    lstWorldCovid.add(WorldCovid(
        title: AppSetting.newDeath,
        iconUrl: AppSetting.iconNewDeath,
        value: covidModel.newDeathsText));
    lstWorldCovid.add(WorldCovid(
        title: AppSetting.totalCase,
        iconUrl: AppSetting.iconTotalCase,
        value: covidModel.totalCasesText));
    lstWorldCovid.add(WorldCovid(
        title: AppSetting.totalDeath,
        iconUrl: AppSetting.iconTotalDeath,
        value: covidModel.totalDeathsText));
    lstWorldCovid.add(WorldCovid(
        title: AppSetting.totalRecovered.replaceAll('Total ', ''),
        iconUrl: AppSetting.icontotalRecovered,
        value: covidModel.totalRecoveredText));
    return lstWorldCovid;
  }

  _printCatch(String e) {
    debugPrint('Catch DataService' + e);
  }
}
