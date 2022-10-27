import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:babydoo/services/controller/booking_controller.dart';
import 'package:babydoo/services/model/area_model.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/screens/booking/date_picker.dart';
import 'package:babydoo/view/widgets/buttons/custom_text_button.dart';
import 'package:babydoo/view/widgets/dropdowns/custom_drop_down.dart';
import 'package:babydoo/view/widgets/textfields/textfield.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: CustomText().createText(
              title: 'Booking', fontWeight: FontWeight.w600, size: 20),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
        ),
        body: Obx(
          () => Stack(
            children: [
              SvgPicture.asset(
                'assets/svg/shaped_bg.svg',
                fit: BoxFit.fill,
                width: Get.width,
              ),
              SingleChildScrollView(
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
                                    title: 'Already have account? ',
                                    size: 16,
                                    fontWeight: FontWeight.w400),
                                CustomText().createText(
                                    title: 'Signin',
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
                                    title: 'Choose Package',
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
                                  title: 'Seasons duration 1 hour 30 minute',
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
                                          color: controller
                                                      .selectedPackage.value ==
                                                  'session'
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: controller
                                                      .selectedPackage.value ==
                                                  'fullDay'
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
                            title: 'Choose Schedule',
                            fontWeight: FontWeight.w600,
                            size: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GetBuilder(builder: (BookController bookController) {
                        return Center(
                          child: buildWeekDatePicker(
                              controller.selectedDate,
                              controller.startOfPeriod,
                              controller.endOfPeriod, (value) {
                            print(value);
                            // controller.selectedDate = value;
                          }),
                        );
                      }),
                      Center(
                        child: CustomText().createText(
                            title: 'Contract details',
                            fontWeight: FontWeight.w600,
                            size: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          createCustomField(name: 'Name'),
                          const SizedBox(
                            width: 8,
                          ),
                          createCustomField(name: 'Mobile number')
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText().createText(
                          title: 'Address',
                          size: 10,
                          fontWeight: FontWeight.w600),
                      const SizedBox(
                        height: 8,
                      ),
                      controller.bookingAreaList.isEmpty
                          ? Container(
                              width: Get.width,
                              height: 45,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors().green, width: 1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Center(
                                  child: CircularProgressIndicator()))
                          : Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
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
                                    hint: Text(controller.selectedArea.value),
                                    onChanged: (val) {
                                      controller.selectedArea.value = controller
                                          .bookingAreaList
                                          .where(
                                              (p0) => p0.id.toString() == val)
                                          .first
                                          .name
                                          .toString();
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
                          createCustomField(name: 'Name'),
                          const SizedBox(
                            width: 8,
                          ),
                          createCustomField(name: 'Mobile number')
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          createCustomField(name: 'Name'),
                          const SizedBox(
                            width: 8,
                          ),
                          createCustomField(name: 'Mobile number')
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
                              title: 'Location Map',
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
                          title: 'Special note',
                          size: 16,
                          fontWeight: FontWeight.w400),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextField().createCustomTextField(
                          hint: 'special note here',
                          height: 100,
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
                              text: 'Accept', // default text style
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                    text: ' Terms & Conditions',
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
                          buttonText: 'Book Now',
                          weight: FontWeight.w600,
                          textSize: 16,
                          buttonColor: AppColors().green,
                          textColor: Colors.white,
                          borderRadius: 12.0,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget createCustomField({
    required name,
  }) {
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
            bg: Colors.transparent,
            borderColor: AppColors().green,
          ),
        ),
      ],
    );
  }
}
