import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/buttons/custom_text_button.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/textfields/textfield.dart';

class ResetPasswordScreen extends GetView<AuthController> {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    Get.lazyPut(
      () => AuthController(),
    );
    return Scaffold(
      backgroundColor: AppColors().green,
      appBar: AppBar(
        centerTitle: false,
        title: CustomText().createText(
            title: 'reset_password'.tr,
            size: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        backgroundColor: AppColors().green,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: AppColors().green,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ))),
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 60),
                    width: Get.width,
                    height: Get.height,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(220, 120),
                          topRight: Radius.elliptical(220, 120)),
                      image: DecorationImage(
                        image: AssetImage('assets/png/background.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      offset: const Offset(1, 3),
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ]),
                            margin: const EdgeInsets.only(top: 10),
                            child: Container(
                              padding: const EdgeInsets.all(18.0),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: SvgPicture.asset(
                                'assets/svg/lock.svg',
                                color: Colors.orangeAccent,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          CustomTextField().createTextField(
                              hint: 'new_password'.tr,
                              hintStyle: TextStyle(color: AppColors().green),
                              height: 50,
                              lable: 'new_password'.tr,
                              controller: controller.resetPassTextController,
                              obscure:
                                  controller.resetPassObSecurePassField.value,
                              borderColor: AppColors().green,
                              borderWidth: 2.0,
                              lableColor: AppColors().green,
                              hasSuffixIcon: true,
                              suffixIcon: Icons.remove_red_eye,
                              suffixPress: () {
                                controller.resetPassObSecurePassField.value =
                                    !controller
                                        .resetPassObSecurePassField.value;
                              }),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomTextField().createTextField(
                              hint: 'confirm_password'.tr,
                              height: 50,
                              hintStyle: TextStyle(color: AppColors().green),
                              lable: 'confirm_password'.tr,
                              controller:
                                  controller.resetPassConfirmTextController,
                              obscure: controller
                                  .resetPassObSecureConfirmPassField.value,
                              borderColor: AppColors().green,
                              borderWidth: 2.0,
                              lableColor: AppColors().green,
                              hasSuffixIcon: true,
                              suffixIcon: Icons.remove_red_eye,
                              suffixPress: () {
                                controller.resetPassObSecureConfirmPassField
                                        .value =
                                    !controller
                                        .resetPassObSecureConfirmPassField
                                        .value;
                              }),
                          const SizedBox(
                            height: 250,
                          ),
                          SizedBox(
                            width: Get.width,
                            height: 45,
                            child: CustomTextButton().createTextButton(
                                buttonText: 'reset_password'.tr,
                                buttonColor: AppColors().green,
                                onPress: () {
                                  controller.handleForgetPassRequest(
                                      Get.parameters['num'].toString(),
                                      controller.resetPassTextController.text,
                                      controller
                                          .resetPassConfirmTextController.text,
                                      Get.parameters['code'].toString());
                                },
                                textColor: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
