import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:babydoo/services/controller/language_controller.dart';
import 'package:babydoo/view/screens/auth/signin_view.dart';
import 'package:babydoo/view/screens/auth/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../services/utils/app_statusbar.dart';

class AuthScreen extends GetView<AuthController> {
  bool isOrange=false;
   AuthScreen({super.key,required this.isOrange});

  @override
  Widget build(BuildContext context) {

    Get.lazyPut(() => LanguageController());
    Get.put(AuthController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if(Get.arguments=='pop'){
            AppStatusbar().statusbarColor(color: Colors.transparent);
            return true;
          }
          return false;
        },
        child: Stack(children: [
          SvgPicture.asset(
            'assets/svg/bg.svg',
            fit: BoxFit.fill,
            width: Get.width,
          ),
          Obx(() => controller.isSignUp.isFalse
              ?  SigninView(bg:isOrange,)
              : const SignupView())
        ]),
      ),
    );
  }
}
