import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';

class LogoutDialog {
  static final LogoutDialog _instance = LogoutDialog.internal();

  LogoutDialog.internal();

  factory LogoutDialog() => _instance;

  static void showCustomDialog(BuildContext context) {
    Get.lazyPut(() => AuthController());
    Get.defaultDialog(
        barrierDismissible: true,
        title: 'logout'.tr,
        middleText:
            '${'are_you_sure?'.tr}\n ${'you_will_be_signing_out_of_application'.tr}',
        middleTextStyle: const TextStyle(fontSize: 14),
        backgroundColor: Colors.white,
        cancel: InkWell(
          onTap: () => Get.close(1),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(6)),
            child: CustomText()
                .createText(title: 'stay_in_app'.tr, color: Colors.white),
          ),
        ),
        confirm: InkWell(
          onTap: () {
            Get.close(1);
            Get.find<AuthController>().handleGuestLogin();
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(6)),
            child: CustomText()
                .createText(title: 'logout'.tr, color: Colors.white),
          ),
        ));
  }
}
