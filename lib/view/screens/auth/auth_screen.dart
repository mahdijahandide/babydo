import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:babydoo/services/controller/language_controller.dart';
import 'package:babydoo/view/screens/auth/signin_view.dart';
import 'package:babydoo/view/screens/auth/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LanguageController());
    Get.put(AuthController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Get.toNamed('/language');
          return true;
        },
        child: Stack(children: [
          SvgPicture.asset(
            'assets/svg/bg.svg',
            fit: BoxFit.fill,
            width: Get.width,
          ),
          Obx(() => controller.isSignUp.isFalse
              ? const SigninView()
              : const SignupView())
        ]),
      ),
    );
  }
}
