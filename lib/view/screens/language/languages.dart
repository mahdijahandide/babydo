import 'package:babydoo/services/controller/language_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/buttons/custom_text_button.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../services/controller/home_controller.dart';
import '../../../services/remotes/api_routes.dart';

class Languages extends GetView<LanguageController> {
  const Languages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LanguageController());
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/svg/bg.svg',
            fit: BoxFit.fill,
            width: Get.width,
          ),
          SingleChildScrollView(
            child: Stack(
              children: [
                SvgPicture.asset(
                  'assets/svg/g.svg',
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 450,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
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
                                    Get.find<LanguageController>()
                                        .changeLocalization(
                                            languageCode: 'en',
                                            countryCode: 'US');
                                  }),
                              const SizedBox(
                                width: 30,
                              ),
                              languageWidget(
                                  imgText: 'ع',
                                  title: 'العربية',
                                  bg: controller.lang.value == 'ar'
                                      ? AppColors().green
                                      : AppColors().gray,
                                  onClick: () {
                                    Get.find<LanguageController>()
                                        .changeLocalization(
                                            languageCode: 'ar',
                                            countryCode: 'KW');
                                  })
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 80,
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
                                if (Get.arguments == '/home') {
                                  Get.back();
                                  // Get.offAndToNamed('/home');
                                  Get.find<HomeController>().handleBusRequest();
                                } else {
                                  Get.offAndToNamed('/auth');
                                }
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
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
