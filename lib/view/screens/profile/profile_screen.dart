import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().blue,
      appBar: AppBar(
        centerTitle: false,
        title: CustomText().createText(
            title: 'Profile',
            size: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        backgroundColor: AppColors().blue,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.power_settings_new_rounded,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
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
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              offset: const Offset(1, 3),
                              spreadRadius: 1,
                              blurRadius: 5)
                        ]),
                        margin: const EdgeInsets.only(top: 10),
                        child: const CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/png/baby.png',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText().createText(
                          title: 'Abdul Rehman',
                          size: 18,
                          fontWeight: FontWeight.w500),
                      CustomText().createText(
                          title: 'abdulrehman22@gmail.com',
                          size: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      CustomText().createText(
                          title: '+965 96018811',
                          size: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText().createText(
                          title: 'View & Edit profile',
                          size: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.orangeAccent),
                      const SizedBox(
                        height: 25,
                      ),
                      iconTextWidget(ic: 'person_edit', txt: 'Edit Profile'),
                      const SizedBox(
                        height: 20,
                      ),
                      iconTextWidget(
                          ic: 'phonebook',
                          txt: 'Address Book',
                          listner: () {
                            Get.toNamed('/addressBook');
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      iconTextWidget(ic: 'lock', txt: 'Change Password'),
                      const SizedBox(
                        height: 20,
                      ),
                      iconTextWidget(
                          ic: 'booking',
                          txt: 'My Booking',
                          listner: () {
                            Get.toNamed('/myBooking');
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      iconTextWidget(
                          ic: 'streaming', txt: 'Bus Live Streaming'),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
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
            'assets/svg/$ic.svg',color: Colors.orangeAccent,width: 30,height: 30,
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
