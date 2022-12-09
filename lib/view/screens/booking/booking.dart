import 'package:babydoo/services/controller/address_controller.dart';
import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:babydoo/services/controller/booking_controller.dart';
import 'package:babydoo/services/model/area_model.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/buttons/custom_text_button.dart';
import 'package:babydoo/view/widgets/marquee/marquee_widget.dart';
import 'package:babydoo/view/widgets/snackbar/snackbar.dart';
import 'package:babydoo/view/widgets/textfields/textfield.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../../services/model/address_model.dart';
import '../../drawer/drawer.dart';

class Booking extends GetView<BookController> {
  Booking({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => BookController(),
    );
    controller.handleGetBookingAreasRequest();
    Get.put(AddressController());

    // add selected colors to default settings
    dp.DatePickerRangeStyles styles = dp.DatePickerRangeStyles(
        selectedDateStyle: const TextStyle(
            fontFamily: 'Vibes', fontSize: 26, fontWeight: FontWeight.bold),
        selectedSingleDateDecoration: BoxDecoration(
          color: AppColors().yellow,
          shape: BoxShape.circle,
        ),
        disabledDateStyle: const TextStyle(fontFamily: 'Vibes', fontSize: 18),
        dayHeaderStyle: const DayHeaderStyle(
          textStyle:
              TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Vibes'),
        ),
        defaultDateTextStyle: const TextStyle(
            color: Colors.green, fontSize: 26, fontFamily: 'Vibes'),
        dayHeaderTitleBuilder: controller.dayHeaderTitleBuilder,
        displayedPeriodTitle: const TextStyle(
            fontFamily: 'Vibes', fontSize: 30, fontWeight: FontWeight.bold));

    return Scaffold(
      extendBody: true,
      key: controller.drawerKey,
      appBar: AppBar(
        title: CustomText().createText(
            title: 'booking'.tr, fontWeight: FontWeight.w600, size: 20),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                controller.drawerKey.currentState!.openEndDrawer();
              },
              icon: const Icon(
                Icons.menu,
                size: 35,
              ))
        ],
      ),
      endDrawer: Drawer(
          child: Get.find<AuthController>().user['user_type'] == 'guest'
              ? DrawerWidgets().createGuestDrawer(context)
              : DrawerWidgets().createUserDrawer(context)),
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/svg/shaped_bg.svg',
            fit: BoxFit.fill,
            width: Get.width,
          ),
          GetBuilder(builder: (BookController bController) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Get.find<AuthController>().user['user_type'] == 'guest'
                          ? Row(
                              children: [
                                CustomText().createText(
                                    title: 'already_have_an_account'.tr,
                                    size: 16,
                                    fontWeight: FontWeight.w400),
                                InkWell(
                                  onTap: () =>
                                      Get.toNamed('/auth', arguments: 'pop'),
                                  child: CustomText().createText(
                                      title: 'signin'.tr,
                                      color: AppColors().litePink,
                                      fontWeight: FontWeight.w600,
                                      size: 18),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        width: Get.width,
                        height: 155,
                        decoration: BoxDecoration(
                            color: AppColors().liteGray,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors().gray.withOpacity(0.3),
                                  offset: const Offset(1, 1),
                                  spreadRadius: 1,
                                  blurRadius: 3)
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Image(
                                    image: AssetImage('assets/png/cube.png')),
                                const SizedBox(
                                  width: 8,
                                ),
                                CustomText().createText(
                                    title: 'choose_package'.tr,
                                    size: 16,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 30),
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                // color: AppColors().liteMaroon
                              ),
                              child: CustomText().createText(
                                  title:
                                      'seasons_duration_one_hour_thirty_min'.tr,
                                  size: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors().maroon),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Divider(
                              thickness: 1.2,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.handleSessionSelection();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color:
                                              controller.bookData.packageType ==
                                                      'Session'
                                                  ? AppColors()
                                                      .yellow
                                                      .withOpacity(0.8)
                                                  : AppColors()
                                                      .green
                                                      .withOpacity(0.7)),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/svg/location_tick.svg'),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          CustomText().createText(
                                              title: 'session'.tr,
                                              fontWeight: FontWeight.w500,
                                              size: 16),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  InkWell(
                                    onTap: () {
                                      controller.handleFulldaySelection();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color:
                                              controller.bookData.packageType ==
                                                      'Fullday'
                                                  ? AppColors()
                                                      .yellow
                                                      .withOpacity(0.8)
                                                  : AppColors()
                                                      .green
                                                      .withOpacity(0.7)),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/svg/location_tick.svg'),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          CustomText().createText(
                                              title: 'full_booking'.tr,
                                              size: 16,
                                              fontWeight: FontWeight.w500),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: CustomText().createText(
                            title: 'choose_schedule'.tr,
                            fontWeight: FontWeight.w600,
                            size: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GetBuilder(builder: (BookController bookController) {
                        return Center(
                          child: dp.DayPicker.single(
                            selectedDate: controller.selectedDate,
                            onChanged: (v) {
                              controller.selectedDate = v;
                              controller.bookData.dateReserved =
                                  '${v.year}-${v.month}-${v.day}';
                              controller.bookData.selectedTime = '';
                              controller.bookData.startTime = '';
                              controller.bookData.endTime = '';
                              controller.bookData.bookPrice = '0';
                              controller.update();
                              print(v);
                            },
                            firstDate: controller.startOfPeriod,
                            lastDate: controller.endOfPeriod,
                            datePickerStyles: styles,
                            datePickerLayoutSettings:
                                const dp.DatePickerLayoutSettings(
                              maxDayPickerRowCount: 5,
                              showPrevMonthEnd: true,
                              showNextMonthStart: true,
                              scrollPhysics: NeverScrollableScrollPhysics(),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText().createText(
                          title: 'please_select_time'.tr,
                          fontWeight: FontWeight.w600,
                          size: 18),
                      const SizedBox(
                        height: 10,
                      ),
                      GetBuilder(builder: (BookController bookController) {
                        return SizedBox(
                          height: 50,
                          width: Get.width,
                          child: ListView.builder(
                            itemCount:
                                controller.bookData.packageType == 'Fullday'
                                    ? controller.bookingDetailsList
                                        .where((p0) =>
                                            p0.date.toString() ==
                                            controller.selectedDate.toString())
                                        .first
                                        .fullBookingList
                                        .length
                                    : controller.bookingDetailsList
                                        .where((p0) =>
                                            p0.date.toString() ==
                                            controller.selectedDate.toString())
                                        .first
                                        .sessionList
                                        .length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var current;
                              current = controller.bookData.packageType ==
                                      'Fullday'
                                  ? controller.bookingDetailsList
                                      .where((p0) =>
                                          p0.date.toString() ==
                                          controller.selectedDate.toString())
                                      .first
                                      .fullBookingList[index]
                                  : controller.bookingDetailsList
                                      .where((p0) =>
                                          p0.date.toString() ==
                                          controller.selectedDate.toString())
                                      .first
                                      .sessionList[index];
                              return InkWell(
                                onTap: () {
                                  controller.bookData.selectedTime =
                                      '${current.startTimeShow}-${current.endTimeShow}';
                                  controller.bookData.startTime =
                                      current.startTime;
                                  controller.bookData.endTime = current.endTime;
                                  controller.bookData.bookPrice =
                                      current.weekendPrice != '0'
                                          ? current.weekendPrice.toString()
                                          : current.price.toString();
                                  controller.update();
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 4),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 3),
                                  decoration: BoxDecoration(
                                      color: controller.bookData.selectedTime ==
                                              '${current.startTimeShow}-${current.endTimeShow}'
                                          ? AppColors().yellow
                                          : AppColors().green,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: CustomText().createText(
                                        title:
                                            '${current.startTimeShow}-${current.endTimeShow}'),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 30,
                        child: ListTile(
                          leading: CustomText().createText(
                              size: 16,
                              title: 'booking_price'.tr,
                              color: Colors.black),
                          title: CustomText().createText(
                              size: 16,
                              title:
                                  '${'kd'.tr} ${controller.bookData.bookPrice}',
                              color: AppColors().maroon,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: ListTile(
                          leading: CustomText().createText(
                              size: 16,
                              title: 'delivery_charge'.tr,
                              color: Colors.black),
                          title: CustomText().createText(
                              size: 16,
                              title:
                                  '${'kd'.tr} ${controller.bookData.deliveryCharge}',
                              color: AppColors().maroon,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: ListTile(
                          leading: CustomText().createText(
                            title: 'total'.tr,
                            color: Colors.black,
                            size: 16,
                          ),
                          title: CustomText().createText(
                              size: 16,
                              title:
                                  '${'kd'.tr} ${double.parse(controller.bookData.deliveryCharge.toString()) + double.parse(controller.bookData.bookPrice.toString())}',
                              color: AppColors().maroon,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: CustomText().createText(
                            title: 'contract_details'.tr,
                            fontWeight: FontWeight.w600,
                            size: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  offset: const Offset(1, 1),
                                  spreadRadius: 1,
                                  blurRadius: 1)
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                createCustomField(
                                    name: 'name'.tr,
                                    type: TextInputType.text,
                                    validator: (value) => value.isEmpty
                                        ? 'name_can_not_be_blank'.tr
                                        : null,
                                    controller: controller.nameTxtController),
                                const SizedBox(
                                  width: 8,
                                ),
                                createCustomField(
                                    name: 'mobile_number'.tr,
                                    maxLength: 8,
                                    type: TextInputType.number,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'number_can_not_be_blank'.tr;
                                      } else if (int.parse(value.toString()[0]) == 0 ||
                                          int.parse(value.toString()[0]) == 1 ||
                                          int.parse(value.toString()[0]) == 2 ||
                                          int.parse(value.toString()[0]) == 3 ||
                                          int.parse(value.toString()[0]) == 7 ||
                                          int.parse(value.toString()[0]) == 8) {
                                        return 'check_number_start_char'.tr;
                                      }else if(int.parse(value.toString().length.toString())<8){
                                        return 'number_max_length_error'.tr;
                                      }
                                    },
                                    controller: controller.mobileTxtController)
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Get.find<AddressController>()
                                          .addressList
                                          .isEmpty
                                      ? const SizedBox()
                                      : CustomText().createText(
                                          title: 'saved_address'.tr,
                                          size: 14,
                                          fontWeight: FontWeight.w600),
                                  Get.find<AddressController>()
                                          .addressList
                                          .isEmpty
                                      ? const SizedBox()
                                      : const SizedBox(
                                          height: 8,
                                        ),
                                  Get.find<AddressController>()
                                          .addressList
                                          .isEmpty
                                      ? const SizedBox()
                                      : Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors().green,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: DropdownButtonHideUnderline(
                                            child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: DropdownButton<String>(
                                                focusColor: Colors.white,
                                                isExpanded: true,
                                                hint: Text(Get.find<
                                                        AddressController>()
                                                    .addressData
                                                    .areaName
                                                    .toString()),
                                                onChanged: (val) {
                                                  AddressModel addressModel =
                                                      Get.find<
                                                              AddressController>()
                                                          .addressList
                                                          .where((p0) =>
                                                              p0.id
                                                                  .toString() ==
                                                              val)
                                                          .first;
                                                  Get.find<AddressController>()
                                                          .addressData
                                                          .areaName =
                                                      addressModel.area
                                                          .toString();
                                                  controller.bookData.areaName =
                                                      addressModel.area
                                                          .toString();
                                                  Get.find<AddressController>()
                                                      .addressData
                                                      .areaId = val;
                                                  controller.bookData.areaId =
                                                      val;
                                                  controller.nameTxtController
                                                          .text =
                                                      Get.find<AuthController>()
                                                          .user['name']
                                                          .toString();
                                                  controller.mobileTxtController
                                                          .text =
                                                      Get.find<AuthController>()
                                                          .user['mobile']
                                                          .toString();
                                                  controller.blockTxtController
                                                          .text =
                                                      addressModel.block
                                                          .toString();
                                                  controller.streetTxtController
                                                          .text =
                                                      addressModel.street
                                                          .toString();
                                                  controller.avenueTxtController
                                                          .text =
                                                      addressModel.avenue
                                                          .toString();
                                                  controller.houseTxtController
                                                          .text =
                                                      addressModel.houseNumber
                                                          .toString();
                                                  controller.spNoteTxtController
                                                          .text =
                                                      addressModel.specialNote
                                                          .toString();
                                                  controller.bookData.lat =
                                                      addressModel.lat
                                                          .toString();
                                                  controller.bookData.lng =
                                                      addressModel.lng
                                                          .toString();

                                                  AreaModel areaModel =
                                                      controller
                                                          .bookingAreaList
                                                          .where((p0) =>
                                                              p0
                                                                  .id
                                                                  .toString() ==
                                                              addressModel
                                                                  .areaId)
                                                          .first;
                                                  String pName = controller
                                                              .bookData
                                                              .packageType ==
                                                          'Fullday'
                                                      ? 'fullday'
                                                      : 'session';
                                                  if (areaModel.type
                                                          .toString() !=
                                                      pName) {
                                                    if (areaModel.type
                                                            .toString() !=
                                                        'both') {
                                                      Snack().createSnack(
                                                          title: 'warning',
                                                          msg:
                                                              'you can only select ${areaModel.type} package for ${areaModel.name} area',
                                                          icon: Icon(
                                                            Icons.warning,
                                                            color: AppColors()
                                                                .maroon,
                                                          ));
                                                      if (areaModel.type ==
                                                          'fullday') {
                                                        controller
                                                            .handleFulldaySelection();
                                                      } else if (areaModel
                                                              .type ==
                                                          'session') {
                                                        controller
                                                            .handleSessionSelection();
                                                      }
                                                    } else {
                                                      controller.bookData
                                                              .deliveryCharge =
                                                          areaModel
                                                              .deliveryCharge
                                                              .toString();
                                                      controller.update();
                                                    }
                                                  } else {
                                                    controller.bookData
                                                            .deliveryCharge =
                                                        areaModel.deliveryCharge
                                                            .toString();
                                                    controller.update();
                                                  }

                                                  controller.update();
                                                },
                                                items: Get.find<
                                                        AddressController>()
                                                    .addressList
                                                    .map((AddressModel value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value.id.toString(),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        CustomText().createText(
                                                            title: value.area
                                                                .toString(),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        MarqueeWidget(
                                                            direction:
                                                                Axis.horizontal,
                                                            child: CustomText()
                                                                .createText(
                                                                    title:
                                                                        'Ave: ${value.avenue} St: ${value.street} Block: ${value.block}'))
                                                      ],
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                  const SizedBox(height: 12),
                                  CustomText().createText(
                                      title: 'address'.tr,
                                      size: 14,
                                      fontWeight: FontWeight.w600),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  controller.bookingAreaList.isEmpty
                                      ? Container(
                                          width: Get.width,
                                          height: 45,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors().green,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: const Center(
                                              child:
                                                  CircularProgressIndicator()))
                                      : Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors().green,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: DropdownButtonHideUnderline(
                                            child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: DropdownButton<String>(
                                                focusColor: Colors.white,
                                                isExpanded: true,
                                                hint: Text(controller
                                                    .bookData.areaName
                                                    .toString()),
                                                onChanged: (val) {
                                                  AreaModel areaModel =
                                                      controller.bookingAreaList
                                                          .where((p0) =>
                                                              p0.id
                                                                  .toString() ==
                                                              val)
                                                          .first;
                                                  controller.bookData.areaName =
                                                      areaModel.name.toString();
                                                  controller.bookData.areaId =
                                                      val;
                                                  String pName = controller
                                                              .bookData
                                                              .packageType ==
                                                          'Fullday'
                                                      ? 'fullday'
                                                      : 'session';
                                                  if (areaModel.type
                                                          .toString() !=
                                                      pName) {
                                                    if (areaModel.type
                                                            .toString() !=
                                                        'both') {
                                                      Snack().createSnack(
                                                          title: 'warning',
                                                          msg:
                                                              'you can only select ${areaModel.type} package for ${areaModel.name} area',
                                                          icon: Icon(
                                                            Icons.warning,
                                                            color: AppColors()
                                                                .maroon,
                                                          ));
                                                      if (areaModel.type ==
                                                          'fullday') {
                                                        controller
                                                            .handleFulldaySelection();
                                                      } else if (areaModel
                                                              .type ==
                                                          'session') {
                                                        controller
                                                            .handleSessionSelection();
                                                      }
                                                    } else {
                                                      controller.bookData
                                                              .deliveryCharge =
                                                          areaModel
                                                              .deliveryCharge
                                                              .toString();
                                                      controller.update();
                                                    }
                                                  } else {
                                                    controller.bookData
                                                            .deliveryCharge =
                                                        areaModel.deliveryCharge
                                                            .toString();
                                                    controller.update();
                                                  }
                                                },
                                                items: controller
                                                    .bookingAreaList
                                                    .map((AreaModel value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value.id.toString(),
                                                    child: Text(
                                                        value.name.toString()),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                createCustomField(
                                    name: 'block'.tr,
                                    validator: (value) => value.isEmpty
                                        ? 'block_can_not_be_blank'.tr
                                        : null,
                                    controller: controller.blockTxtController,
                                    type: TextInputType.text),
                                const SizedBox(
                                  width: 8,
                                ),
                                createCustomField(
                                    name: 'street'.tr,
                                    validator: (value) => value.isEmpty
                                        ? 'street_can_not_be_blank'.tr
                                        : null,
                                    type: TextInputType.text,
                                    controller: controller.streetTxtController)
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                createCustomField(
                                    name: 'avenue'.tr,
                                    validator: (value) => value.isEmpty
                                        ? 'avenue_can_not_be_blank'.tr
                                        : null,
                                    controller: controller.avenueTxtController,
                                    type: TextInputType.text),
                                const SizedBox(
                                  width: 8,
                                ),
                                createCustomField(
                                    name: 'house_or_building'.tr,
                                    type: TextInputType.text,
                                    validator: (value) => value.isEmpty
                                        ? 'housebuilding_can_not_be_blank'.tr
                                        : null,
                                    controller: controller.houseTxtController)
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/svg/location_tick.svg'),
                          const SizedBox(
                            width: 12,
                          ),
                          CustomText().createText(
                              title: 'location_map'.tr,
                              fontWeight: FontWeight.w600,
                              size: 14),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          width: Get.width,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: FlutterLocationPicker(
                                selectLocationButtonStyle:
                                    ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                showSearchBar: false,
                                showZoomController: false,
                                selectLocationButtonText: 'Set',
                                initZoom: 11,
                                minZoomLevel: 5,
                                maxZoomLevel: 16,
                                trackMyPosition: true,
                                onError: (e) => print(e),
                                onPicked: (pickedData) {
                                  print(pickedData.latLong.latitude);
                                  print(pickedData.latLong.longitude);
                                  print(pickedData.address);
                                  print(pickedData.addressData['country']);
                                  controller.bookData.lat =
                                      pickedData.latLong.latitude.toString();
                                  controller.bookData.lng =
                                      pickedData.latLong.longitude.toString();
                                }),
                          )),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomText().createText(
                          title: 'special_note'.tr,
                          size: 16,
                          fontWeight: FontWeight.w400),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextField().createCustomTextField(
                          hint: 'special_note_here'.tr,
                          height: 100,
                          controller: controller.spNoteTxtController,
                          maxLines: 3,
                          borderColor: AppColors().green),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: controller.acceptTerm.value,
                            onChanged: (v) {
                              controller.acceptTerm.value = v!;
                              controller.update();
                            },
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return AppColors().green.withOpacity(.32);
                              }
                              return AppColors().green;
                            }),
                          ),
                          InkWell(
                            onTap: () {
                              controller.handleTermAndConditionsRequest();
                            },
                            child: Text.rich(
                              TextSpan(
                                text: 'accept'.tr, // default text style
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                      text: 'term_and_conditions'.tr,
                                      style: TextStyle(
                                          color: AppColors().green,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      SizedBox(
                        width: Get.width,
                        height: 50,
                        child: CustomTextButton().createTextButton(
                            buttonText: 'book_now'.tr,
                            weight: FontWeight.w600,
                            textSize: 16,
                            buttonColor: AppColors().green,
                            textColor: Colors.white,
                            borderRadius: 12.0,
                            onPress: () {
                              final FormState? form = formKey.currentState;
                              print(formKey.currentState);
                              if (!form!.validate()) {
                                return;
                              } else {
                                controller.bookData.name =
                                    controller.nameTxtController.text;
                                controller.bookData.phoneNumber =
                                    controller.mobileTxtController.text;
                                controller.bookData.block =
                                    controller.blockTxtController.text;
                                controller.bookData.street =
                                    controller.streetTxtController.text;
                                controller.bookData.avenue =
                                    controller.avenueTxtController.text;
                                controller.bookData.houseNumber =
                                    controller.houseTxtController.text;
                                controller.bookData.specialNote =
                                    controller.spNoteTxtController.text;
                                if (controller.bookData.dateReserved == '') {
                                  Snack().createSnack(
                                      title: 'warning',
                                      msg: 'please_select_date'.tr,
                                      icon: Icon(
                                        Icons.warning,
                                        color: AppColors().maroon,
                                      ));
                                } else if (controller.bookData.startTime ==
                                        '' ||
                                    controller.bookData.endTime == '') {
                                  Snack().createSnack(
                                      title: 'warning',
                                      msg: 'please_select_reserved_time'.tr,
                                      icon: Icon(
                                        Icons.warning,
                                        color: AppColors().maroon,
                                      ));
                                } else if (controller.bookData.areaId == '') {
                                  Snack().createSnack(
                                      title: 'warning',
                                      msg: 'please_select_area'.tr,
                                      icon: Icon(
                                        Icons.warning,
                                        color: AppColors().maroon,
                                      ));
                                } else if (controller.bookData.packageType ==
                                    '') {
                                  Snack().createSnack(
                                      title: 'warning',
                                      msg: 'please_select_package_type'.tr,
                                      icon: Icon(
                                        Icons.warning,
                                        color: AppColors().maroon,
                                      ));
                                } else if (controller.acceptTerm.isFalse) {
                                  Snack().createSnack(
                                      title: 'warning',
                                      msg:
                                          'please_accept_term_and_condition'.tr,
                                      icon: Icon(
                                        Icons.warning,
                                        color: AppColors().maroon,
                                      ));
                                } else {
                                  controller.handlePaymentRequest();
                                }
                                // if (controller.bookData.busId != '' && controller.bookData.dateReserved != '' &&
                                //     controller.bookData.startTime != '' && controller.bookData.endTime != '' &&
                                //     controller.bookData.name != '' && controller.bookData.phoneNumber != '' &&
                                //     controller.bookData.block != '' && controller.bookData.street != '' &&
                                //     controller.bookData.avenue != '' && controller.bookData.areaId != '' &&
                                //     controller.bookData.houseNumber != '' && controller.bookData.packageType != '' &&
                                //     controller.bookData.deliveryCharge != ''&&controller.acceptTerm.isTrue) {
                                //   controller.handlePaymentRequest();
                                // }
                                // else {
                                //   Snack().createSnack(
                                //       title: 'warning',
                                //       msg: 'you need to fill all the fields correctly to continue',icon: Icon(
                                //     Icons.warning,
                                //     color: AppColors().maroon,
                                //   ));
                                // }
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  Widget createCustomField(
      {required name,
      required controller,
      required type,
      dynamic validator,
      dynamic maxLength}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText()
                .createText(title: name, fontWeight: FontWeight.w600, size: 14),
            CustomText()
                .createText(title: '*', color: AppColors().maroon, size: 20),
          ],
        ),
        SizedBox(
          width: Get.width / 2 - 20,
          child: CustomTextField().createCustomTextField(
            hint: '',
            height: 45,
            validate: validator,
            keyboardType: type,
            maxLength: maxLength,
            controller: controller,
            bg: Colors.transparent,
            borderColor: AppColors().green,
          ),
        ),
      ],
    );
  }
}
