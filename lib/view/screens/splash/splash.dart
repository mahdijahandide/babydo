import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     Timer(
      const Duration(seconds: 3),
          () {
        Get.offAndToNamed('/language');
      },

    );
    return Scaffold(body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: SvgPicture.asset('assets/svg/logo.svg',),),
    ),);
  }
}
