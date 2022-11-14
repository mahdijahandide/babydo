import 'package:babydoo/services/model/address/address_view_model.dart';
import 'package:babydoo/services/model/address_model.dart';
import 'package:babydoo/view/dialogs/loading_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:convert' as convert;
import '../../view/widgets/snackbar/snackbar.dart';
import '../model/area_model.dart';
import '../remotes/requests.dart';
import '../utils/app_colors.dart';

class AddressController extends GetxController {
  RxList<AddressModel> addressList = RxList([]);
  RxList<AreaModel> areaList = RxList([]);
  RxBool isEmptyList = false.obs;
  AddressDataModel addressData =
      AddressDataModel('', '', '', '', '', '', '', '', '');

  TextEditingController addBlockTxtController = TextEditingController();
  TextEditingController addStreetTxtController = TextEditingController();
  TextEditingController addAvenueTxtController = TextEditingController();
  TextEditingController addHouseNumTxtController = TextEditingController();
  TextEditingController addSpecialNoteTxtController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    handleGetAddressRequest();
  }

  onCreateInit() {
    addressData = AddressDataModel('', '', '', '', '', '', '', '', '');
    handleGetAreasRequest();
  }

  handleGetAddressRequest() async {
    final response = await Request.getAddressesRequest();
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        if (jsonObject['status'].toString() == '200') {
          var addressArray = jsonObject['data']['addresses'];
          addressList.clear();
          addressArray.forEach((element) {
            addressList.add(AddressModel(data: element));
          });
          if (addressList.isEmpty) {
            isEmptyList.value = true;
          }
          update();
        } else {
          Snack().createSnack(
              title: 'warning',
              msg: jsonObject['message'].toString(),
              icon: Icon(
                Icons.warning,
                color: AppColors().maroon,
              ));
        }
        break;
      default:
        Snack().createSnack(
            title: 'Error',
            msg: 'Server Error',
            icon: Icon(
              Icons.warning,
              color: AppColors().maroon,
            ));
        break;
    }
  }

  handleGetAreasRequest() async {
    final response = await Request.getAreasRequest();
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        if (jsonObject['status'].toString() == '200') {
          var areaArray = jsonObject['data']['areas'];
          areaList.clear();
          areaArray.forEach((element) {
            areaList.add(AreaModel(data: element));
          });
          update();
        } else {
          Snack().createSnack(
              title: 'warning',
              msg: jsonObject['message'].toString(),
              icon: Icon(
                Icons.warning,
                color: AppColors().maroon,
              ));
        }
        break;
      default:
        Snack().createSnack(
            title: 'Error',
            msg: 'Server Error',
            icon: Icon(
              Icons.warning,
              color: AppColors().maroon,
            ));
        break;
    }
  }

  handleStoreAddressRequest() async {
    LoadingDialog.showCustomDialog(msg: 'loading'.tr);
    final response = await Request.storeAddressRequest(
        areaId: addressData.areaId!,
        block: addBlockTxtController.text,
        street: addStreetTxtController.text,
        avenue: addAvenueTxtController.text,
        houseNumber: addHouseNumTxtController.text,
        spNote: addSpecialNoteTxtController.text,
        lat: addressData.lat ?? '',
        lng: addressData.lng ?? '');
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        if (jsonObject['status'].toString() == '200') {
          Get.close(2);
          handleGetAddressRequest();
          update();
        } else {
          Get.close(1);
          Snack().createSnack(
              title: 'warning',
              msg: jsonObject['message'].toString(),
              icon: Icon(
                Icons.warning,
                color: AppColors().maroon,
              ));
        }
        break;
      default:
        Get.close(1);
        Snack().createSnack(
            title: 'Error',
            msg: 'Server Error',
            icon: Icon(
              Icons.warning,
              color: AppColors().maroon,
            ));
        break;
    }
  }

  handleUpdateAddressRequest({required String id}) async {
    LoadingDialog.showCustomDialog(msg: 'loading'.tr);
    final response = await Request.updateAddressRequest(
        areaId: addressData.areaId!,
        block: addBlockTxtController.text,
        street: addStreetTxtController.text,
        avenue: addAvenueTxtController.text,
        houseNumber: addHouseNumTxtController.text,
        spNote: addSpecialNoteTxtController.text,
        lat: addressData.lat ?? '',
        lng: addressData.lng ?? '',
        id: id);
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        if (jsonObject['status'].toString() == '200') {
          Get.close(2);
          handleGetAddressRequest();
          update();
        } else {
          Get.close(1);
          Snack().createSnack(
              title: 'warning',
              msg: jsonObject['message'].toString(),
              icon: Icon(
                Icons.warning,
                color: AppColors().maroon,
              ));
        }
        break;
      default:
        Get.close(1);
        Snack().createSnack(
            title: 'Error',
            msg: 'Server Error',
            icon: Icon(
              Icons.warning,
              color: AppColors().maroon,
            ));
        break;
    }
  }

  handleDeleteAddressRequest({required String id}) async {
    LoadingDialog.showCustomDialog(msg: 'loading'.tr);
    final response = await Request.deleteAddressRequest(id: id);
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        if (jsonObject['status'].toString() == '200') {
          Get.close(1);
          handleGetAddressRequest();
          update();
        } else {
          Get.close(1);
          Snack().createSnack(
              title: 'warning',
              msg: jsonObject['message'].toString(),
              icon: Icon(
                Icons.warning,
                color: AppColors().maroon,
              ));
        }
        break;
      default:
        Get.close(1);
        Snack().createSnack(
            title: 'Error',
            msg: 'Server Error',
            icon: Icon(
              Icons.warning,
              color: AppColors().maroon,
            ));
        break;
    }
  }
}
