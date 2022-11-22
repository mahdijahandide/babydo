import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Splash extends GetView<AuthController> {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.handleSplashView();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/logo.svg',
              width: Get.width,
              fit: BoxFit.fill,
            ),
            const CircularProgressIndicator(
              color: Colors.yellow,
            )
          ],
        ),
      ),
    );
  }
}
