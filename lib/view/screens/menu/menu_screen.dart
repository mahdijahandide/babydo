import 'package:babydoo/services/controller/profile_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../services/controller/auth_controller.dart';

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
                        Get.find<AuthController>().user['user_type'] == 'guest'?const SizedBox(): Container(
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                                leading: SvgPicture.asset('assets/svg/member.svg',width: 30,height: 30,color: Colors.orangeAccent,),
                                tilePadding: const EdgeInsets.all(0),
                                title: CustomText().createText(
                                  title: 'member'.tr,
                                  size: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                collapsedBackgroundColor: Colors.transparent,
                                textColor: AppColors().yellow,
                                collapsedTextColor: AppColors().green,
                                collapsedIconColor: Colors.green,
                                children: [
                                  subIconTextWidget(
                                      ic: 'person_edit',
                                      txt: 'edit_profile'.tr,
                                      listner: () {
                                        Get.toNamed('/editProfile');
                                      }),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  subIconTextWidget(
                                      ic: 'phonebook',
                                      txt: 'address_book'.tr,
                                      listner: () {
                                        Get.toNamed('/addressBook');
                                      }),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  subIconTextWidget(
                                      ic: 'lock',
                                      txt: 'change_password'.tr,
                                      listner: () {
                                        Get.toNamed('/changePassword');
                                      }),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  subIconTextWidget(
                                      ic: 'booking',
                                      txt: 'my_booking'.tr,
                                      listner: () {
                                        Get.toNamed('/myBooking');
                                      }),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  subIconTextWidget(
                                      ic: 'streaming',
                                      txt: 'bus_live_streaming'.tr,
                                      listner: () {
                                        Get.toNamed('/liveStreaming');
                                      }),
                                  const SizedBox(
                                    height: 12,
                                  )
                                ]),
                          ),
                        ),
                        iconTextWidget(
                            ic: 'contactus',
                            txt: 'contact_us'.tr,
                            listner: () {
                              Get.toNamed('/contactUs');
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        iconTextWidget(
                            ic: 'aboutus',
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
                            ic: 'share',
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
          SvgPicture.asset(
            'assets/svg/$ic.svg',
            color: Colors.orangeAccent,
            width: 30,
            height: 30,
          ),
          const SizedBox(
            width: 28,
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

  Widget subIconTextWidget({required ic, required txt, dynamic listner}) {
    return InkWell(
      onTap: listner ?? () {},
      child: Row(
        children: [
          // const SizedBox(
          //   width: 50,
          // ),
          SvgPicture.asset(
            'assets/svg/$ic.svg',
            color: Colors.orangeAccent,
            width: 22,
            height: 22,
          ),
          const SizedBox(
            width: 37,
          ),
          CustomText().createText(
              title: txt,
              size: 16,
              color: AppColors().green,
              fontWeight: FontWeight.normal)
        ],
      ),
    );
  }
}
