import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:babydoo/services/controller/booking_controller.dart';
import 'package:babydoo/services/model/area_model.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/buttons/custom_text_button.dart';
import 'package:babydoo/view/widgets/snackbar/snackbar.dart';
import 'package:babydoo/view/widgets/textfields/textfield.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class Booking extends GetView<BookController> {
  const Booking({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => BookController(),
    );
    controller.handleGetBookingAreasRequest();

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
      appBar: AppBar(
        title: CustomText().createText(
            title: 'booking'.tr, fontWeight: FontWeight.w600, size: 20),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
      ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Get.find<AuthController>().token.value == ''
                        ? Row(
                            children: [
                              CustomText().createText(
                                  title: 'already_have_an_account?'.tr,
                                  size: 16,
                                  fontWeight: FontWeight.w400),
                              CustomText().createText(
                                  title: 'signin'.tr,
                                  color: AppColors().litePink,
                                  fontWeight: FontWeight.w600,
                                  size: 18),
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
                      height: 150,
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
                                color: AppColors().liteMaroon),
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
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.handleSessionSelection();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color:
                                            controller.bookData.packageType ==
                                                    'Session'
                                                ? AppColors()
                                                    .yellow
                                                    .withOpacity(0.8)
                                                : Colors.transparent),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/svg/location_tick.svg'),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        CustomText().createText(
                                            title: 'Session',
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
                                        borderRadius: BorderRadius.circular(8),
                                        color:
                                            controller.bookData.packageType ==
                                                    'Fullday'
                                                ? AppColors()
                                                    .yellow
                                                    .withOpacity(0.8)
                                                : Colors.transparent),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/svg/location_tick.svg'),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        CustomText().createText(
                                            title: 'Full booking',
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
                            current =
                                controller.bookData.packageType == 'Fullday'
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
                                        : AppColors().gray.withOpacity(0.5),
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
                            title: 'booking_price'.tr, color: Colors.black),
                        title: CustomText().createText(
                            title: 'KD ${controller.bookData.bookPrice}',
                            color: AppColors().maroon,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: ListTile(
                        leading: CustomText().createText(
                            title: 'delivery_charge'.tr, color: Colors.black),
                        title: CustomText().createText(
                            title: 'KD ${controller.bookData.deliveryCharge}',
                            color: AppColors().maroon,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: ListTile(
                        leading: CustomText()
                            .createText(title: 'total'.tr, color: Colors.black),
                        title: CustomText().createText(
                            title:
                                'KD ${double.parse(controller.bookData.deliveryCharge.toString()) + double.parse(controller.bookData.bookPrice.toString())}',
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
                    Row(
                      children: [
                        createCustomField(
                            name: 'name'.tr,
                            controller: controller.nameTxtController),
                        const SizedBox(
                          width: 8,
                        ),
                        createCustomField(
                            name: 'mobile_number'.tr,
                            controller: controller.mobileTxtController)
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomText().createText(
                        title: 'address'.tr,
                        size: 10,
                        fontWeight: FontWeight.w600),
                    const SizedBox(
                      height: 8,
                    ),
                    controller.bookingAreaList.isEmpty
                        ? Container(
                            width: Get.width,
                            height: 45,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors().green, width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: const Center(
                                child: CircularProgressIndicator()))
                        : Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors().green, width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: DropdownButtonHideUnderline(
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: DropdownButton<String>(
                                  focusColor: Colors.white,
                                  isExpanded: true,
                                  hint: Text(
                                      controller.bookData.areaName.toString()),
                                  onChanged: (val) {
                                    AreaModel areaModel = controller
                                        .bookingAreaList
                                        .where((p0) => p0.id.toString() == val)
                                        .first;
                                    controller.bookData.areaName =
                                        areaModel.name.toString();
                                    controller.bookData.areaId = val;
                                    String pName =
                                        controller.bookData.packageType ==
                                                'Fullday'
                                            ? 'fullday'
                                            : 'session';
                                    if (areaModel.type.toString() != pName) {
                                      if (areaModel.type.toString() != 'both') {
                                        Snack().createSnack(
                                            title: 'warning',
                                            msg:
                                                'you can only select ${areaModel.type} package for ${areaModel.name} area');
                                        if (areaModel.type == 'fullday') {
                                          controller.handleFulldaySelection();
                                        } else if (areaModel.type ==
                                            'session') {
                                          controller.handleSessionSelection();
                                        }
                                      } else {
                                        controller.bookData.deliveryCharge =
                                            areaModel.deliveryCharge.toString();
                                        controller.update();
                                      }
                                    } else {
                                      controller.bookData.deliveryCharge =
                                          areaModel.deliveryCharge.toString();
                                      controller.update();
                                    }
                                  },
                                  items: controller.bookingAreaList
                                      .map((AreaModel value) {
                                    return DropdownMenuItem<String>(
                                      value: value.id.toString(),
                                      child: Text(value.name.toString()),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        createCustomField(
                            name: 'block'.tr,
                            controller: controller.blockTxtController),
                        const SizedBox(
                          width: 8,
                        ),
                        createCustomField(
                            name: 'street'.tr,
                            controller: controller.streetTxtController)
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        createCustomField(
                            name: 'avenue'.tr,
                            controller: controller.avenueTxtController),
                        const SizedBox(
                          width: 8,
                        ),
                        createCustomField(
                            name: 'house_or_building'.tr,
                            controller: controller.houseTxtController)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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
                      height: 300,
                      child: FlutterMap(
                        options: MapOptions(
                          center: LatLng(51.5, -0.09),
                          zoom: 5,
                        ),
                        nonRotatedChildren: [
                          AttributionWidget.defaultWidget(
                            source: 'OpenStreetMap contributors',
                            onSourceTapped: () {},
                          ),
                        ],
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                          ),
                          // MarkerLayer(markers: markers),
                        ],
                      ),
                    ),
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
                        // CustomText().createText(
                        //     title: 'Accept Terms & Conditions',
                        //     size: 11,
                        //     fontWeight: FontWeight.w500)
                        Text.rich(
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
                            if (controller.bookData.busId != '' &&
                                controller.bookData.dateReserved != '' &&
                                controller.bookData.startTime != '' &&
                                controller.bookData.endTime != '' &&
                                controller.bookData.name != '' &&
                                controller.bookData.phoneNumber != '' &&
                                controller.bookData.block != '' &&
                                controller.bookData.street != '' &&
                                controller.bookData.avenue != '' &&
                                controller.bookData.areaId != '' &&
                                controller.bookData.houseNumber != '' &&
                                controller.bookData.packageType != '' &&
                                controller.bookData.deliveryCharge != '') {
                              controller.handlePaymentRequest();
                            } else {
                              Snack().createSnack(
                                  title: 'warning',
                                  msg:
                                      'you need to fill all the fields correctly to continue');
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  Widget createCustomField({required name, required controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText()
                .createText(title: name, fontWeight: FontWeight.w600, size: 10),
            CustomText()
                .createText(title: '*', color: AppColors().maroon, size: 20),
          ],
        ),
        SizedBox(
          width: Get.width / 2 - 20,
          child: CustomTextField().createCustomTextField(
            hint: '',
            height: 45,
            controller: controller,
            bg: Colors.transparent,
            borderColor: AppColors().green,
          ),
        ),
      ],
    );
  }
}
