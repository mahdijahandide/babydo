import 'package:babydoo/services/controller/profile_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class MenuScreen extends GetView<ProfileController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileController());
    return Scaffold(
      backgroundColor: AppColors().yellow,
      appBar: AppBar(
        centerTitle: false,
        title: CustomText().createText(
            title: 'more_options'.tr,
            size: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        backgroundColor: AppColors().yellow,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder(builder: (ProfileController profileController) {
        return SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: AppColors().yellow,
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
                    child: Column(
                      children: [
                        Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      offset: const Offset(1, 3),
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ]),
                            margin: const EdgeInsets.only(top: 10),
                            child: const Icon(
                              Icons.apps,
                              size: 55,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomText().createText(
                            title: 'more_options'.tr,
                            size: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.orangeAccent),
                        const SizedBox(
                          height: 25,
                        ),
                        iconTextWidget(
                            ic: Icons.group_outlined,
                            txt: 'member'.tr,
                            listner: () {}),
                        const SizedBox(
                          height: 20,
                        ),
                        iconTextWidget(
                            ic: Icons.contact_phone_outlined,
                            txt: 'contact_us'.tr,
                            listner: () {
                              Get.toNamed('/contactUs');
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        iconTextWidget(
                            ic: Icons.info_outline,
                            txt: 'about_us'.tr,
                            listner: () {
                              Get.lazyPut(
                                () => ProfileController(),
                              );
                              Get.find<ProfileController>()
                                  .handleAboutUsRequest();
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        iconTextWidget(
                            ic: Icons.share_outlined,
                            txt: 'share'.tr,
                            listner: () {
                              Share.share(
                                  'check out new version of babydo app https://babydobus.com',
                                  subject: 'download babydo app now');
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget iconTextWidget({required ic, required txt, dynamic listner}) {
    return InkWell(
      onTap: listner ?? () {},
      child: Row(
        children: [
          const SizedBox(
            width: 50,
          ),
          Icon(
            ic,
            color: Colors.orangeAccent,
            size: 30,
          ),
          const SizedBox(
            width: 20,
          ),
          CustomText().createText(
              title: txt,
              size: 20,
              color: AppColors().green,
              fontWeight: FontWeight.bold)
        ],
      ),
    );
  }
}
