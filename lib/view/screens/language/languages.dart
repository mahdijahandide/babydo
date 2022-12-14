import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:babydoo/services/controller/language_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/buttons/custom_text_button.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../services/controller/home_controller.dart';

class Languages extends GetView<LanguageController> {
  const Languages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LanguageController());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/svg/bg.svg',
            fit: BoxFit.fill,
            width: Get.width,
          ),
          Column(
            children: [
              SvgPicture.asset(
                'assets/svg/g.svg',
                width: Get.width,
                fit: BoxFit.cover,
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CustomText().createText(
                      title: 'welcome_to_babydo_bus'.tr,
                      size: 18,
                      fontWeight: FontWeight.bold),
                  const SizedBox(
                    height: 12,
                  ),
                  Obx(
                    () => Row(
                      textDirection: TextDirection.ltr,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        languageWidget(
                            imgText: 'E',
                            title: 'English',
                            bg: controller.lang.value == 'en'
                                ? AppColors().green
                                : AppColors().gray,
                            onClick: () {
                              controller.lang.value = 'en';
                            }),
                        const SizedBox(
                          width: 30,
                        ),
                        languageWidget(
                            imgText: '??',
                            title: '??????????????',
                            bg: controller.lang.value == 'ar'
                                ? AppColors().green
                                : AppColors().gray,
                            onClick: () {
                              controller.lang.value = 'ar';
                            })
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                   Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        width: Get.width,
                        height: 45,
                        child: CustomTextButton().createTextButton(
                            buttonText: 'continue'.tr,
                            buttonColor: AppColors().green,
                            textColor: Colors.white,
                            onPress: () {
                              if (controller.lang.value == 'en') {
                                controller.changeLocalization(languageCode: 'en', countryCode: 'US');
                              } else {
                                controller.changeLocalization(languageCode: 'ar', countryCode: 'KW');
                              }
                            }),
                      )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget languageWidget(
      {required imgText, required title, required bg, dynamic onClick}) {
    return GestureDetector(
      onTap: onClick,
      child: Column(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Stack(
              children: [
                SvgPicture.asset(
                  'assets/svg/palm.svg',
                  color: bg,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: CustomText().createText(
                          title: imgText,
                          size: 22,
                          fontWeight: bg == AppColors().green
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          CustomText().createText(
              title: title,
              fontWeight:
                  bg == AppColors().green ? FontWeight.bold : FontWeight.normal)
        ],
      ),
    );
  }
}
