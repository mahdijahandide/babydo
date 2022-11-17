import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/textfields/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/buttons/custom_text_button.dart';
import '../../widgets/texts/customText.dart';

class SignupView extends GetView<AuthController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors().blue));
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(672),
      //   child: Stack(children: [
      //     SvgPicture.asset(
      //       'assets/svg/sign_up_header.svg',
      //       fit: BoxFit.fill,
      //       width: Get.width,
      //     )
      //   ]),
      // ),
      body: ListView(children: [
        SvgPicture.asset(
          'assets/svg/sign_up_header.svg',
          fit: BoxFit.fill,
          width: Get.width,
        ),
        Center(
          child: CustomText().createText(
              title: 'signup_with_babydo_bus'.tr,
              size: 22,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomTextField().createTextField(
                    hint: 'mobile_number'.tr,
                    hintStyle: TextStyle(color: AppColors().green),
                    height: 50,
                    lable: 'mobile_number'.tr,
                    controller: controller.mobileTextController,
                    borderColor: AppColors().green,
                    keyboardType: TextInputType.number,
                    borderWidth: 2.0,
                    lableColor: AppColors().green),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField().createTextField(
                    hint: 'email_address'.tr,
                    height: 50,
                    hintStyle: TextStyle(color: AppColors().green),
                    lable: 'email_address'.tr,
                    controller: controller.emailTextController,
                    borderColor: AppColors().green,
                    keyboardType: TextInputType.emailAddress,
                    borderWidth: 2.0,
                    lableColor: AppColors().green),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField().createTextField(
                    hint: 'password'.tr,
                    height: 50,
                    hintStyle: TextStyle(color: AppColors().green),
                    lable: 'password'.tr,
                    controller: controller.passwordTextController,
                    obscure: controller.obSecurePassField.value,
                    borderColor: AppColors().green,
                    borderWidth: 2.0,
                    lableColor: AppColors().green,
                    hasSuffixIcon: true,
                    suffixIcon: Icons.remove_red_eye,
                    suffixPress: () {
                      controller.obSecurePassField.value =
                          !controller.obSecurePassField.value;
                    }),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField().createTextField(
                    hint: 'confirm_password'.tr,
                    height: 50,
                    hintStyle: TextStyle(color: AppColors().green),
                    lable: 'confirm_password'.tr,
                    controller: controller.confirmPasswordTextController,
                    obscure: controller.obSecurePassField.value,
                    borderColor: AppColors().green,
                    borderWidth: 2.0,
                    lableColor: AppColors().green,
                    hasSuffixIcon: true,
                    suffixIcon: Icons.remove_red_eye,
                    suffixPress: () {
                      controller.obSecurePassField.value =
                          !controller.obSecurePassField.value;
                    }),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: controller.acceptTerm.value,
                      onChanged: (v) {
                        controller.acceptTerm.value = v!;
                      },
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return AppColors().green.withOpacity(.32);
                        }
                        return AppColors().green;
                      }),
                    ),
                    InkWell(
                      onTap: () {
                        controller.handleTermAndConditionsRequest();
                      },
                      child: CustomText()
                          .createText(title: 'accept_term_and_conditions'.tr),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                    width: Get.width,
                    height: 45,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: CustomTextButton().createTextButton(
                        buttonText: 'register'.tr,
                        buttonColor: AppColors().green,
                        textColor: Colors.white,
                        onPress: () {
                          controller.handleRegisterOtpRequest();
                        })),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText()
                        .createText(title: 'already_have_an_account'.tr),
                    InkWell(
                      onTap: () => controller.isSignUp.value = false,
                      child: CustomText().createText(
                          title: 'please_login_here'.tr,
                          color: AppColors().green),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
