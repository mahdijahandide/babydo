import 'package:babydoo/services/controller/profile_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';

import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

class AboutUsScreen extends GetView<ProfileController> {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    Get.put(ProfileController());
    return Scaffold(
      backgroundColor: AppColors().litePink,
      appBar: AppBar(
        centerTitle: false,
        foregroundColor: Colors.white,
        title: CustomText().createText(
            title: 'about_us'.tr,
            size: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        backgroundColor: AppColors().litePink,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                    color: AppColors().litePink,
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
                          decoration:
                              BoxDecoration(shape: BoxShape.circle, boxShadow: [
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
                            child: const Icon(
                              Icons.info,
                              size: 55,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        CustomText()
                            .createText(title: Get.arguments ?? '', size: 22)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
