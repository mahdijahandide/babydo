import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController{

  RxString lang='en'.obs;

  void changeLocalization({required String languageCode,required String countryCode}){
    Get.updateLocale(Locale(languageCode,countryCode));
    lang.value=languageCode;
    print(lang.value);
  }
}