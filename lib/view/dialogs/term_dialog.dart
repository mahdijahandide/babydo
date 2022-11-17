import 'package:babydoo/services/controller/address_controller.dart';
import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermAndConditionDialog {
  static final TermAndConditionDialog _instance =
      TermAndConditionDialog.internal();

  TermAndConditionDialog.internal();

  factory TermAndConditionDialog() => _instance;

  static void showCustomDialog({required String title, required String text}) {
    Get.defaultDialog(
        barrierDismissible: true,
        title: title,
        content: SingleChildScrollView(
          child: CustomText().createText(
              title: text,
              fontWeight: FontWeight.normal,
              size: 14,
              align: TextAlign.justify),
        ),
        backgroundColor: Colors.white,
        confirm: InkWell(
          onTap: () {
            Get.close(1);
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: AppColors().green,
                borderRadius: BorderRadius.circular(6)),
            child: CustomText()
                .createText(title: 'accept'.tr, color: Colors.white),
          ),
        ));
  }
}
