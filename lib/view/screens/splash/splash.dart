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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           // Image(image: const AssetImage('assets/png/logo.png',),width: Get.width,h,),
            SvgPicture.asset(
              'assets/svg/logo.svg',
              width: 600,
              height: 200,
              allowDrawingOutsideViewBox: true,
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
