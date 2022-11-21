import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/textfields/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/buttons/custom_text_button.dart';
import '../../widgets/texts/customText.dart';

class SigninView extends GetView<AuthController> {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors().litePink));
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(696),
      //   child: Stack(
      //     children: [
      //       SvgPicture.asset('assets/svg/sign_in_bus.svg',
      //           fit: BoxFit.fill, width: Get.width),
      //     ],
      //   ),
      // ),
      body: ListView(children: [
        SvgPicture.asset(
          'assets/svg/sign_in_bus.svg',
          fit: BoxFit.fill,
          width: Get.width,
          height: Get.height / 2,
        ),
        const SizedBox(
          height: 12,
        ),
        Center(
          child: CustomText().createText(
              title: 'welcome_back'.tr, size: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: CustomText().createText(
                title: 'login_and_enjoy_playing_with_babydo_bus'.tr, size: 13),
          ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextField().createTextField(
                      hint: 'mobile_number'.tr,
                      height: 50,
                      lable: 'mobile_number'.tr,
                      hintStyle: TextStyle(color: AppColors().green),
                      node: controller.signInNumFocus,
                      controller: controller.loginMobileTextController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onTap: () => controller.update(),
                      borderColor: AppColors().green,
                      borderWidth: 2.0,
                      lableColor: AppColors().green),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextField().createTextField(
                      hint: 'password'.tr,
                      height: 50,
                      node: controller.signInPassFocus,
                      lable: 'password'.tr,
                      hintStyle: TextStyle(color: AppColors().green),
                      controller: controller.loginPasswordTextController,
                      obscure: controller.obSecurePassField.value,
                      borderColor: AppColors().green,
                      borderWidth: 2.0,
                      lableColor: AppColors().green,
                      textInputAction: TextInputAction.go,
                      onSubmitted: (d) {
                        if (Get.arguments == true) {
                          Phoenix.rebirth(context);
                        }
                        controller.pushyLogin();
                      },
                      hasSuffixIcon: true,
                      suffixIcon: Icons.remove_red_eye,
                      suffixPress: () {
                        controller.obSecurePassField.value =
                            !controller.obSecurePassField.value;
                      }),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: InkWell(
                    onTap: (() => Get.toNamed('/forgotPassword')),
                    child: CustomText().createText(
                        title: 'forget_password'.tr,
                        align: TextAlign.end,
                        size: 12),
                  ),
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
                        buttonText: 'login'.tr,
                        buttonColor: AppColors().green,
                        textColor: Colors.white,
                        onPress: () {
                          print(Get.arguments);
                          if (Get.arguments == true) {
                            Phoenix.rebirth(context);
                          }
                          controller.pushyLogin();
                          // Get.offAndToNamed('/home');
                        })),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText().createText(
                        title: 'don\'t_have_any_account'.tr, size: 13),
                    InkWell(
                      onTap: () {
                        controller.isSignUp.value = true;
                      },
                      child: CustomText().createText(
                          title: 'please_signup_here'.tr,
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
