import 'package:flutter/services.dart';

class AppStatusbar {
  void statusbarColor({required color}) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: color));
  }
}
