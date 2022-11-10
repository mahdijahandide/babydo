import 'package:babydoo/services/controller/profile_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/buttons/custom_text_button.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/textfields/textfield.dart';

class ContactUsScreen extends GetView<ProfileController> {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
      backgroundColor: AppColors().litePink,
      appBar: AppBar(
        centerTitle: false,
        foregroundColor: Colors.white,
        title: CustomText().createText(
            title: 'Contact_us'.tr,
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
                              Icons.contact_mail,
                              size: 55,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        CustomTextField().createTextField(
                            hint: '',
                            height: 45,
                            lable: 'full_name'.tr,
                            controller: controller.contactUsFullName,
                            borderColor: AppColors().green,
                            keyboardType: TextInputType.text,
                            borderWidth: 2.0,
                            lableColor: AppColors().green),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextField().createTextField(
                            hint: '',
                            height: 45,
                            lable: 'mobile_number'.tr,
                            controller: controller.contactUsMobileNumber,
                            borderColor: AppColors().green,
                            keyboardType: TextInputType.number,
                            borderWidth: 2.0,
                            lableColor: AppColors().green),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextField().createTextField(
                            hint: '',
                            height: 45,
                            lable: 'email_address'.tr,
                            controller: controller.contactUsEmailAddress,
                            borderColor: AppColors().green,
                            keyboardType: TextInputType.emailAddress,
                            borderWidth: 2.0,
                            lableColor: AppColors().green),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextField().createTextField(
                            hint: '',
                            height: 45,
                            lable: 'subject'.tr,
                            controller: controller.contactUsSubject,
                            borderColor: AppColors().green,
                            keyboardType: TextInputType.text,
                            borderWidth: 2.0,
                            lableColor: AppColors().green),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextField().createTextField(
                            hint: '',
                            height: 120,
                            lable: 'message'.tr,
                            controller: controller.contactUsMsg,
                            borderColor: AppColors().green,
                            keyboardType: TextInputType.text,
                            borderWidth: 2.0,
                            maxLines: 5,
                            lableColor: AppColors().green),
                        const SizedBox(
                          height: 150,
                        ),
                        SizedBox(
                          width: Get.width,
                          height: 45,
                          child: CustomTextButton().createTextButton(
                              buttonText: 'send'.tr,
                              buttonColor: AppColors().green,
                              onPress: () {
                                controller.handleContactUsRequest();
                              },
                              textColor: Colors.white),
                        )
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
