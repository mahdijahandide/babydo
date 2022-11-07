import 'dart:developer';

import 'package:babydoo/services/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:convert' as convert;
import '../remotes/requests.dart';

class AddressController extends GetxController {
  RxList<AddressModel> addressList = RxList([]);
  RxBool isEmptyList = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    handleGetAddressRequest();
  }

  handleGetAddressRequest() async {
    final response = await Request.getAddressesRequest();
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        log(jsonObject.toString());
        var addressArray = jsonObject['data']['addresses'];
        addressList.clear();
        addressArray.forEach((element) {
          addressList.add(AddressModel(data: element));
        });
        if (addressList.isEmpty) {
          isEmptyList.value = true;
        }
        update();
        break;
      default:
        debugPrint(response.statusCode.toString());
        break;
    }
  }
}
