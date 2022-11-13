import 'package:babydoo/services/controller/address_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/marquee/marquee_widget.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AddressBook extends GetView<AddressController> {
  const AddressBook({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddressController());
    return Scaffold(
      appBar: AppBar(
        title: CustomText().createText(
            title: 'address_book'.tr, size: 18, fontWeight: FontWeight.bold),
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
                        itemCount: controller.addressList.isEmpty
                            ? 4
                            : controller.addressList.length,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        itemBuilder: (BuildContext context, int index) {
                          var currentItem;
                          if (controller.addressList.isNotEmpty) {
                            currentItem = controller.addressList[index];
                          }
                          return controller.addressList.isEmpty
                              ? SizedBox(
                                  width: Get.width,
                                  height: 100,
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
                                    Slidable(
                                      key: const ValueKey(0),
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            // An action can be bigger than the others.

                                            onPressed: (v) {},
                                            backgroundColor: AppColors().blue,
                                            foregroundColor: Colors.white,
                                            icon: Icons.edit,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            label: 'edit'.tr,
                                          ),
                                          SlidableAction(
                                            onPressed: (v) {},
                                            backgroundColor: AppColors().maroon,
                                            foregroundColor: Colors.white,
                                            icon: Icons.delete,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            label: 'delete'.tr,
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        height: 100,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        decoration: BoxDecoration(
                                            color: AppColors().green,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.4),
                                                  offset: const Offset(1, 1),
                                                  spreadRadius: 1,
                                                  blurRadius: 3)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1),
                                                shape: BoxShape.circle,
                                                color: const Color(0xff99CA4E),
                                              ),
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                      'assets/svg/location.svg')),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  MarqueeWidget(
                                                    direction: Axis.horizontal,
                                                    child: CustomText().createText(
                                                        title:
                                                            '${currentItem.area},${currentItem.block}',
                                                        color: Colors.white,
                                                        size: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  MarqueeWidget(
                                                    direction: Axis.horizontal,
                                                    child: CustomText().createText(
                                                        title:
                                                            '${'avenue'.tr} ${currentItem.avenue}, ${'street'.tr} ${currentItem.street}, ${'house_number'.tr} ${currentItem.houseNumber}',
                                                        color: Colors.white,
                                                        size: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors().green,
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.black,
            size: 30,
          ),
        ),
        onPressed: () {
          Get.toNamed('/addAddress');
        },
      ),
    );
  }
}
