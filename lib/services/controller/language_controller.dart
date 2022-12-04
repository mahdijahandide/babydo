import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';
import 'home_controller.dart';


class LanguageController extends GetxController {
  RxString lang = 'en'.obs;

    changeLocalization({required String languageCode, required String countryCode,dynamic time}) async{
        Get.updateLocale(Locale(languageCode, countryCode));
     Get.find<AuthController>().dataStorage.write('lang', languageCode);
     Get.find<AuthController>().dataStorage.write('country', countryCode);
     lang.value = languageCode;
        Future.delayed(Duration(milliseconds:time??100), () {
              Get.offAllNamed('/home');
        });
     // Get.offAndToNamed('/home');
   }
}
