import 'dart:convert';

import 'package:bCovid/model/news_model.dart';
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
      return RssFeed.parse(body);
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


  



  _printCatch(String e) {
    debugPrint('Catch DataService' + e);
  }
}
