import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:babydoo/services/controller/profile_controller.dart';
import 'package:babydoo/services/remotes/api_routes.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../dialogs/logout_dialog.dart';
import '../../widgets/snackbar/snackbar.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileController());
    return Scaffold(
      backgroundColor: AppColors().blue,
      appBar: AppBar(
        centerTitle: false,
        title: CustomText().createText(
            title: 'profile'.tr,
            size: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        backgroundColor: AppColors().blue,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
        Get.find<AuthController>().user['user_type']=='guest'?const SizedBox():  IconButton(
              onPressed: () {
                LogoutDialog.showCustomDialog(context);
              },
              icon: const Icon(
                Icons.power_settings_new_rounded,
                color: Colors.white,
              ))
        ],
      ),
      body: GetBuilder(builder: (ProfileController profileController) {
        return SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: AppColors().blue,
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              baseUrl +
                                  Get.find<AuthController>()
                                      .user['icon']
                                      .toString(),
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                          // NetworkImage(

                          //   )
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomText().createText(
                            title:
                                Get.find<AuthController>().user['name'] ?? '',
                            size: 18,
                            fontWeight: FontWeight.w500),
                        CustomText().createText(
                            title:
                                Get.find<AuthController>().user['email'] ?? '',
                            size: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                        CustomText().createText(
                            title:
                                Get.find<AuthController>().user['mobile'] ?? '',
                            size: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomText().createText(
                            title: 'view_and_edit_profile'.tr,
                            size: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.orangeAccent),
                        const SizedBox(
                          height: 25,
                        ),
                        iconTextWidget(
                            ic: 'person_edit',
                            txt: 'edit_profile'.tr,
                            listner: () {
                              Get.toNamed('/editProfile');
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        iconTextWidget(
                            ic: 'phonebook',
                            txt: 'address_book'.tr,
                            listner: () {
                              Get.toNamed('/addressBook');
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        iconTextWidget(
                            ic: 'lock',
                            txt: 'change_password'.tr,
                            listner: () {
                              Get.toNamed('/changePassword');
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        iconTextWidget(
                            ic: 'booking',
                            txt: 'my_booking'.tr,
                            listner: () {
                              Get.toNamed('/myBooking');
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        iconTextWidget(
                            ic: 'streaming',
                            txt: 'bus_live_streaming'.tr,
                            listner: () {
                              Get.find<AuthController>().user['user_type']=='guest'? Snack().createSnack(
                                  icon: const Icon(Icons.warning,color: Colors.yellow,),
                                  title: 'warning',msg: 'please login first to use this part') :  Get.toNamed('/liveStreaming',);
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
}
