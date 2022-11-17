import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:babydoo/services/controller/home_controller.dart';
import 'package:babydoo/services/controller/profile_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/dialogs/logout_dialog.dart';
import 'package:babydoo/view/widgets/buttons/custom_text_button.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class DrawerWidgets {
  Widget createUserDrawer(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/svg/members_drawer_bg.svg',
          fit: BoxFit.fill,
          width: Get.width,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Get.close(1);
                    },
                    icon: const Icon(Icons.arrow_back)),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      createCustomTile(
                          ic: Icons.home,
                          title: 'home'.tr,
                          listner: () {
                            Get.close(1);
                          }),
                      const Divider(),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                              leading: const Icon(
                                Icons.group_outlined,
                                color: Colors.grey,
                                size: 30,
                              ),
                              tilePadding: const EdgeInsets.all(0),
                              title: CustomText().createText(
                                title: 'member'.tr,
                              ),
                              collapsedBackgroundColor: Colors.transparent,
                              textColor: AppColors().yellow,
                              collapsedTextColor: Colors.black,
                              collapsedIconColor: Colors.black,
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
                      const Divider(),
                      createCustomTile(
                          ic: Icons.info,
                          title: 'about_us'.tr,
                          listner: () {
                            Get.lazyPut(
                              () => ProfileController(),
                            );
                            Get.find<ProfileController>()
                                .handleAboutUsRequest();
                          }),
                      const Divider(),
                      createCustomTile(
                          ic: Icons.phone,
                          title: 'contact_us'.tr,
                          listner: () {
                            Get.toNamed('/contactUs');
                          }),
                      const Divider(),
                      createCustomTile(
                          ic: Icons.share,
                          title: 'share'.tr,
                          listner: () {
                            Share.share(
                                'check out new version of babydo app https://babydobus.com',
                                subject: 'download babydo app now');
                          }),
                      const Divider(),
                      createCustomTile(
                          ic: Icons.language,
                          title: 'change_language'.tr,
                          listner: () {
                            Get.back();
                            Get.offAndToNamed('/languages', arguments: '/home');
                          }),
                    ],
                  ),
                ),
                // const Expanded(child: SizedBox()),
                Container(
                  margin:
                      const EdgeInsets.only(bottom: 75, left: 12, right: 12),
                  width: Get.width,
                  height: 50,
                  child: CustomTextButton().createTextButton(
                      buttonText: 'logout'.tr,
                      buttonColor: Colors.white,
                      textColor: AppColors().green,
                      borderColor: AppColors().green,
                      textSize: 20,
                      onPress: () {
                        Get.close(1);
                        LogoutDialog.showCustomDialog(context);
                      },
                      borderRadius: 10.0,
                      elevation: 0.0),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget createGuestDrawer(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/svg/guest_drawer_bg.svg',
          width: Get.width,
          fit: BoxFit.fill,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Get.find<HomeController>()
                          .drawerKey
                          .currentState!
                          .closeDrawer();
                    },
                    icon: const Icon(Icons.arrow_back)),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: Get.width,
                  height: 50,
                  child: CustomTextButton().createTextButton(
                      buttonText: 'register'.tr,
                      buttonColor: AppColors().green,
                      textColor: Colors.white,
                      borderColor: AppColors().green,
                      textSize: 20,
                      onPress: () {
                        Get.close(1);
                        Get.toNamed('/auth', arguments: true);
                      },
                      borderRadius: 10.0,
                      elevation: 0.0),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: Get.width,
                  height: 50,
                  child: CustomTextButton().createTextButton(
                      buttonText: 'login'.tr,
                      buttonColor: Colors.transparent,
                      textColor: AppColors().green,
                      borderColor: AppColors().green,
                      textSize: 20,
                      onPress: () {
                        Get.close(1);
                        Get.toNamed('/auth', arguments: true);
                      },
                      borderRadius: 10.0,
                      elevation: 0.0),
                ),
                createCustomTile(
                    ic: Icons.info,
                    title: 'about_us'.tr,
                    listner: () {
                      Get.lazyPut(
                        () => ProfileController(),
                      );
                      Get.find<ProfileController>().handleAboutUsRequest();
                    }),
                const Divider(),
                createCustomTile(
                    ic: Icons.phone,
                    title: 'contact_us'.tr,
                    listner: () {
                      Get.toNamed('/contactUs');
                    }),
                const Divider(),
                createCustomTile(
                    ic: Icons.share,
                    title: 'share'.tr,
                    listner: () {
                      Share.share(
                          'check out new version of babydo app https://babydobus.com',
                          subject: 'download babydo app now');
                    }),
                const Divider(),
                createCustomTile(
                    ic: Icons.language,
                    title: 'change_language'.tr,
                    listner: () {
                      Get.back();
                      Get.offAndToNamed('/languages', arguments: '/home');
                    }),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget createCustomTile({required ic, required title, dynamic listner}) {
    return ListTile(
      leading: Icon(ic),
      title: CustomText().createText(title: title),
      onTap: listner ?? () {},
    );
  }

  Widget subIconTextWidget({required ic, required txt, dynamic listner}) {
    return InkWell(
      onTap: listner ?? () {},
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/svg/$ic.svg',
            color: Colors.grey,
            width: 22,
            height: 22,
          ),
          const SizedBox(
            width: 35,
          ),
          CustomText().createText(
              title: txt,
              size: 16,
              color: Colors.black,
              fontWeight: FontWeight.normal)
        ],
      ),
    );
  }
}
