import 'package:babydoo/services/controller/address_controller.dart';
import 'package:babydoo/services/controller/profile_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/buttons/custom_text_button.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../../services/model/area_model.dart';
import '../../widgets/snackbar/snackbar.dart';
import '../../widgets/textfields/textfield.dart';

class UpdateAddressScreen extends GetView<AddressController> {
  const UpdateAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    ProfileController profileController = Get.put(ProfileController());
    controller.handleGetAreasRequest();
    controller.addBlockTxtController.text =
        controller.addressData.block.toString();
    controller.addStreetTxtController.text =
        controller.addressData.street.toString();
    controller.addAvenueTxtController.text =
        controller.addressData.avenue.toString();
    controller.addHouseNumTxtController.text =
        controller.addressData.houseNumber.toString();
    controller.addSpecialNoteTxtController.text =
        controller.addressData.specialNote.toString();
    return Scaffold(
      backgroundColor: AppColors().litePink,
      appBar: AppBar(
        centerTitle: false,
        foregroundColor: Colors.white,
        title: CustomText().createText(
            title: 'update_address'.tr,
            size: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        backgroundColor: AppColors().litePink,
        elevation: 0,
      ),
      body: Obx(
        () => SingleChildScrollView(
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
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
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
                                Icons.location_history,
                                size: 55,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          controller.areaList.isEmpty
                              ? Container(
                                  width: Get.width,
                                  height: 45,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors().green, width: 2),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Center(
                                      child: CircularProgressIndicator()))
                              : GetBuilder(builder: (AddressController ac) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors().green, width: 2),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: DropdownButtonHideUnderline(
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: DropdownButton<String>(
                                          focusColor: Colors.white,
                                          isExpanded: true,
                                          hint: Text(controller
                                              .addressData.areaName
                                              .toString()),
                                          onChanged: (val) {
                                            AreaModel areaModel = controller
                                                .areaList
                                                .where((p0) =>
                                                    p0.id.toString() == val)
                                                .first;
                                            controller.addressData.areaName =
                                                areaModel.name.toString();
                                            controller.addressData.areaId = val;
                                            controller.update();
                                          },
                                          items: controller.areaList
                                              .map((AreaModel value) {
                                            return DropdownMenuItem<String>(
                                              value: value.id.toString(),
                                              child:
                                                  Text(value.name.toString()),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomTextField().createTextField(
                              hint: 'block'.tr,
                              height: 50,
                              hintStyle: TextStyle(color: AppColors().green),
                              lable: 'block'.tr,
                              controller: controller.addBlockTxtController,
                              borderColor: AppColors().green,
                              keyboardType: TextInputType.text,
                              borderWidth: 2.0,
                              lableColor: AppColors().green),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomTextField().createTextField(
                              hint: 'street'.tr,
                              hintStyle: TextStyle(color: AppColors().green),
                              height: 50,
                              lable: 'street'.tr,
                              controller: controller.addStreetTxtController,
                              borderColor: AppColors().green,
                              keyboardType: TextInputType.number,
                              borderWidth: 2.0,
                              lableColor: AppColors().green),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomTextField().createTextField(
                              hint: 'avenue'.tr,
                              height: 50,
                              hintStyle: TextStyle(color: AppColors().green),
                              lable: 'avenue'.tr,
                              controller: controller.addAvenueTxtController,
                              borderColor: AppColors().green,
                              keyboardType: TextInputType.emailAddress,
                              borderWidth: 2.0,
                              lableColor: AppColors().green),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomTextField().createTextField(
                              hint: 'house_number'.tr,
                              hintStyle: TextStyle(color: AppColors().green),
                              height: 50,
                              lable: 'house_number'.tr,
                              controller: controller.addHouseNumTxtController,
                              borderColor: AppColors().green,
                              keyboardType: TextInputType.text,
                              borderWidth: 2.0,
                              lableColor: AppColors().green),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomTextField().createTextField(
                              hint: 'special_note'.tr,
                              height: 120,
                              hintStyle: TextStyle(color: AppColors().green),
                              lable: 'special_note'.tr,
                              controller:
                                  controller.addSpecialNoteTxtController,
                              borderColor: AppColors().green,
                              keyboardType: TextInputType.text,
                              borderWidth: 2.0,
                              maxLines: 5,
                              lableColor: AppColors().green),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12)),
                              width: Get.width,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: FlutterLocationPicker(
                                    initPosition: LatLong(
                                        double.parse(controller.addressData.lat
                                            .toString()),
                                        double.parse(controller.addressData.lng
                                            .toString())),
                                    selectLocationButtonStyle:
                                        ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                    ),
                                    showSearchBar: false,
                                    showZoomController: false,
                                    selectLocationButtonText: 'Set',
                                    initZoom: 11,
                                    minZoomLevel: 5,
                                    maxZoomLevel: 16,
                                    trackMyPosition: false,
                                    onError: (e) => print(e),
                                    onPicked: (pickedData) {
                                      print(pickedData.latLong.latitude);
                                      print(pickedData.latLong.longitude);
                                      print(pickedData.address);
                                      print(pickedData.addressData['country']);
                                      controller.addressData.lat = pickedData
                                          .latLong.latitude
                                          .toString();
                                      controller.addressData.lng = pickedData
                                          .latLong.longitude
                                          .toString();
                                    }),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: Get.width,
                            height: 45,
                            child: CustomTextButton().createTextButton(
                                buttonText: 'update_address'.tr,
                                buttonColor: AppColors().green,
                                onPress: () {
                                  if (controller
                                          .addressData.areaId!.isNotEmpty &&
                                      controller.addStreetTxtController.text
                                          .isNotEmpty &&
                                      controller.addBlockTxtController.text
                                          .isNotEmpty) {
                                    controller.handleUpdateAddressRequest(
                                        id: Get.arguments.toString());
                                  } else {
                                    Snack().createSnack(
                                        title: 'warning',
                                        msg: 'Please fill the form',
                                        icon: Icon(
                                          Icons.warning,
                                          color: AppColors().maroon,
                                        ));
                                  }
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
