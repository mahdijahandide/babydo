import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/buttons/custom_text_button.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DrawerWidgets {
  Widget createUserDrawer() {
    return Stack(
      children: [
        SvgPicture.asset('assets/svg/members_drawer_bg.svg',fit: BoxFit.fill,width: Get.width,),
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
                createCustomTile(ic: Icons.home, title: 'Home', listner: () {}),
                const Divider(),
                createCustomTile(
                    ic: Icons.person, title: 'Member', listner: () {}),
                const Divider(),
                createCustomTile(
                    ic: Icons.info, title: 'About Us', listner: () {}),
                const Divider(),
                createCustomTile(
                    ic: Icons.phone, title: 'Contact Us', listner: () {}),
                const Divider(),
                createCustomTile(
                    ic: Icons.share, title: 'Share', listner: () {}),
                const Divider(),
                createCustomTile(
                    ic: Icons.language,
                    title: 'Change Language',
                    listner: () {}),
                const Expanded(child: SizedBox()),
                SizedBox(
                  width: Get.width,
                  height: 50,
                  child: CustomTextButton().createTextButton(
                      buttonText: 'Logout',
                      buttonColor: Colors.transparent,
                      textColor: AppColors().green,
                      borderColor: AppColors().green,
                      textSize: 20,
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

  Widget createGuestDrawer() {
    return Stack(
      children: [
        SvgPicture.asset('assets/svg/guest_drawer_bg.svg'),
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
                SizedBox(
                  width: Get.width,
                  height: 50,
                  child: CustomTextButton().createTextButton(
                      buttonText: 'Register',
                      buttonColor: AppColors().green,
                      textColor: Colors.white,
                      borderColor: AppColors().green,
                      textSize: 20,
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
                      buttonText: 'Login',
                      buttonColor: Colors.transparent,
                      textColor: AppColors().green,
                      borderColor: AppColors().green,
                      textSize: 20,
                      borderRadius: 10.0,
                      elevation: 0.0),
                ),
                createCustomTile(
                    ic: Icons.info, title: 'About Us', listner: () {}),
                const Divider(),
                createCustomTile(
                    ic: Icons.phone, title: 'Contact Us', listner: () {}),
                const Divider(),
                createCustomTile(
                    ic: Icons.share, title: 'Share', listner: () {}),
                const Divider(),
                createCustomTile(
                    ic: Icons.language,
                    title: 'Change Language',
                    listner: () {}),
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
}
