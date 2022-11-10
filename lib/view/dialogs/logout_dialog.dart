import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutDialog {
  static final LogoutDialog _instance = LogoutDialog.internal();

  LogoutDialog.internal();

  factory LogoutDialog() => _instance;

  static void showCustomDialog() {
    Get.defaultDialog(
        barrierDismissible: true,
        title: 'Logout'.tr,
        middleText: 'Are You Sure?\n You will be signing out of application',
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
                .createText(title: 'Stay in App', color: Colors.white),
          ),
        ),
        confirm: InkWell(
          onTap: () {
            Get.close(2);
            Get.find<AuthController>().token.value = '';
            Get.toNamed('/auth');
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(6)),
            child:
                CustomText().createText(title: 'Logout', color: Colors.white),
          ),
        ));
  }
}
