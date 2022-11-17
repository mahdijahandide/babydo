import 'package:babydoo/services/controller/booking_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/buttons/custom_text_button.dart';
import 'package:babydoo/view/widgets/marquee/marquee_widget.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class MyBooking extends GetView<BookController> {
  const MyBooking({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BookController());
    return Scaffold(
      appBar: AppBar(
        title: CustomText().createText(
            title: 'my_booking'.tr, size: 18, fontWeight: FontWeight.bold),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5),
          child: Divider(
            color: AppColors().green,
            thickness: 1.1,
            indent: 12,
            endIndent: 12,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Image(
          //   image: const AssetImage('assets/png/background.png'),
          //   fit: BoxFit.fill,
          //   height: Get.height,
          //   width: Get.width,
          // ),
          SvgPicture.asset(
            'assets/svg/shaped_bg.svg',
            width: Get.width,
            fit: BoxFit.fill,
          ),
          Obx(
            () => Padding(
                padding: const EdgeInsets.all(12),
                child: controller.isEmptyList.isTrue
                    ? const Center(
                        child:
                            Image(image: AssetImage('assets/png/nodata.png')),
                      )
                    : ListView.builder(
                        itemCount: controller.bookingList.isEmpty
                            ? 4
                            : controller.bookingList.length,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        itemBuilder: (BuildContext context, int index) {
                          var currentItem;
                          if (controller.bookingList.isNotEmpty) {
                            currentItem = controller.bookingList[index];
                          }
                          return controller.bookingList.isEmpty
                              ? SizedBox(
                                  width: Get.width,
                                  height: 280,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor:
                                        Colors.black.withOpacity(0.8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.4),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      margin: const EdgeInsets.fromLTRB(
                                          12, 0, 12, 8),
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: Get.width,
                                          height: 280,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColors().blue,
                                                width: 1.1),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 60),
                                            child: Column(
                                              children: [
                                                CustomText().createText(
                                                    title: currentItem.busName,
                                                    fontWeight: FontWeight.w600,
                                                    size: 16),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    Expanded(
                                                      child: CustomTextButton()
                                                          .createTextButton(
                                                              buttonText:
                                                                  currentItem
                                                                      .dateReserved,
                                                              textSize: 12,
                                                              weight: FontWeight
                                                                  .w600,
                                                              buttonColor:
                                                                  AppColors()
                                                                      .gray
                                                                      .withOpacity(
                                                                          0.5),
                                                              elevation: 0.0,
                                                              textColor:
                                                                  Colors.black),
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    Expanded(
                                                      child: CustomTextButton()
                                                          .createTextButton(
                                                              buttonText:
                                                                  '${currentItem.startTime}- ${currentItem.endTime}',
                                                              textSize: 12,
                                                              weight: FontWeight
                                                                  .w600,
                                                              buttonColor:
                                                                  AppColors()
                                                                      .gray
                                                                      .withOpacity(
                                                                          0.5),
                                                              elevation: 0.0,
                                                              textColor:
                                                                  Colors.black),
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                ListTile(
                                                  leading: CustomText()
                                                      .createText(
                                                          title: 'address'.tr,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          size: 12),
                                                  title: MarqueeWidget(
                                                    direction: Axis.horizontal,
                                                    child: CustomText().createText(
                                                        title:
                                                            '${'area'.tr}: ${currentItem.area} ${'avenue'.tr}: ${currentItem.avenue} ${'street'.tr}: ${currentItem.street} ${'block'.tr}: ${currentItem.block}',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        size: 12),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: CustomText()
                                                      .createText(
                                                          title:
                                                              'special_note'.tr,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          size: 12),
                                                  title: MarqueeWidget(
                                                    direction: Axis.horizontal,
                                                    child: CustomText()
                                                        .createText(
                                                            title: currentItem
                                                                .additionalNote,
                                                            size: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Stack(
                                            fit: StackFit.loose,
                                            children: [
                                              SvgPicture.asset(currentItem
                                                          .status !=
                                                      'completed'
                                                  ? 'assets/svg/red_banner.svg'
                                                  : 'assets/svg/green_banner.svg'),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 50,
                                                        vertical: 4),
                                                child: CustomText().createText(
                                                    title: currentItem.status,
                                                    color: Colors.white,
                                                    size: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    )
                                  ],
                                );
                        },
                      )),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors().green,
      //   child: const Center(
      //     child: Icon(
      //       Icons.add,
      //       color: Colors.black,
      //       size: 30,
      //     ),
      //   ),
      //   onPressed: () {},
      // ),
    );
  }
}
