import 'package:bCovid/pages/view/home.dart';
import 'package:bCovid/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MaterialApp(
    title: AppSetting.title,
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}
