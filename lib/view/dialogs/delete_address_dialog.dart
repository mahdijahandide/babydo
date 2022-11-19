import 'package:babydoo/services/controller/address_controller.dart';
import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAddressDialog {
  static final DeleteAddressDialog _instance = DeleteAddressDialog.internal();

  DeleteAddressDialog.internal();

  factory DeleteAddressDialog() => _instance;

  static void showCustomDialog({required String addressId}) {
    Get.defaultDialog(
        barrierDismissible: true,
        title: 'delete'.tr,
        middleText: '${'are_you_sure?'.tr}\n ${'delete_this_address'.tr}',
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
                .createText(title: 'cancel'.tr, color: Colors.white),
          ),
        ),
        confirm: InkWell(
          onTap: () {
            Get.close(1);
            Get.find<AddressController>()
                .handleDeleteAddressRequest(id: addressId);
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(6)),
            child: CustomText()
                .createText(title: 'delete'.tr, color: Colors.white),
          ),
        ));
  }
}
