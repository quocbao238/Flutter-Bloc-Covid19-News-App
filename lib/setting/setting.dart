import 'package:bCovid/service/dataService.dart';
import 'package:flutter/material.dart';

class AppSetting {
  AppSetting._();
  static DataService dataService = DataService();

  //Text App

  static const txtLoading = 'Đang tải dữ liệu...';
  static const txtGlobal = 'Thế giới';
  static const txtVn = 'Việt Nam';
  static const title ='Covid-19 News';

  // Url
  static const vnexpressUrl = 'https://vnexpress.net/rss/suc-khoe.rss';

  //Image
  static const iconLoadCovid = 'assets/icon/covidload.svg';
  static const iconCountry = 'assets/icon/country.svg';
  static const icondGlobal = 'assets/icon/global.svg';


  static Color backgroundColor = Color(0xFFBFDBF7);
  static Color backgroundColor1 = Color(0xFF022B3A);
  static Color backgroundColor4 = Colors.blueAccent.withOpacity(0.8);
  static Color backgroundColor2 = Color(0xFF1F7A8C);
  static Color backgroundColor3 = Color(0xFFE1E5F2);
}
