import 'dart:convert';

import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/snackbar/snackbar.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vk/vk.dart';

class OtpScreen extends GetView<AuthController> {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().green,
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/svg/pink_circles.svg',
            fit: BoxFit.fill,
            width: Get.width,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 170,
                ),
                Align(
                    alignment: Alignment.center,
                    child: CustomText().createText(
                        title: 'hi'.tr,
                        color: Colors.white,
                        size: 20,
                        fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 12,
                ),
                Align(
                    alignment: Alignment.center,
                    child: CustomText().createText(
                        title:
                            'enter_the_year_you_were_born_this_just_verifies_your_age.'
                                .tr,
                        color: Colors.white,
                        size: 14,
                        fontWeight: FontWeight.w400)),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 65),
                      child: CustomText().createText(
                          title: 'enter_otp'.tr,
                          color: Colors.white,
                          size: 12,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 50,
                        ),
                        SizedBox(
                          width: 200,
                          child: PinCodeTextField(
                            length: 5,
                            keyboardType: TextInputType.none,
                            obscureText: false,
                            controller: controller.otpTextController,
                            animationType: AnimationType.fade,
                            focusNode: controller.otpNode,
                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.underline,
                                inactiveFillColor: Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 40,
                                activeFillColor: AppColors().green,
                                disabledColor: Colors.white,
                                selectedColor: Colors.white,
                                selectedFillColor: AppColors().green,
                                errorBorderColor: Colors.white),
                            animationDuration:
                                const Duration(milliseconds: 300),
                            backgroundColor: AppColors().green,
                            enableActiveFill: true,
                            onCompleted: (v) {
                              debugPrint("Completed");
                              debugPrint(controller.otpVerifyCode);
                              if (v == controller.otpVerifyCode) {
                                if (Get.parameters['status'] == 'forgetPass') {
                                  Get.toNamed('/reset_password', parameters: {
                                    "status": "forgetPass",
                                    "code": v.toString(),
                                    "num":
                                        controller.forgotScreenMobileNumber.text
                                  });
                                } else {
                                  Get.toNamed('/home');
                                }
                              } else {
                                Snack().createSnack(
                                    title: 'warning'.tr,
                                    msg: 'wrong number',
                                    icon: const Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                    ));
                              }
                            },
                            onChanged: (value) {
                              debugPrint(value);
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              return true;
                            },
                            appContext: context,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        IconButton(
                            onPressed: () {
                              controller.otpTextController.text =
                                  controller.otpTextController.text.substring(
                                      0,
                                      controller.otpTextController.text.length -
                                          1);
                            },
                            icon: const Icon(
                              Icons.backspace,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    VirtualKeyboard(
                        height: 350,
                        textColor: Colors.white,
                        type: VirtualKeyboardType.Numeric,
                        textController: controller.otpTextController)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
