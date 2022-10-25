import 'dart:developer';

import 'package:babydoo/services/model/bookDetailsModel/book_full_time_model.dart';
import 'package:babydoo/services/model/bookDetailsModel/book_session_model.dart';
import 'package:babydoo/services/model/bookDetailsModel/booking_details_model.dart';
import 'package:babydoo/services/model/booking_model.dart';
import 'package:babydoo/view/dialogs/loading_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../remotes/requests.dart';
import 'dart:convert' as convert;

class BookController extends GetxController {
  RxBool acceptTerm = false.obs;
  DateTime startOfPeriod = DateTime.now().subtract(const Duration(days: 10));
  DateTime endOfPeriod = DateTime.now().add(const Duration(days: 10));
  DateTime selectedDate = DateTime.now().add(const Duration(days: 10));

  RxList<BookingModel> bookingList = RxList([]);
  RxList<BookingDetailsModel> bookingDetailsList = RxList([]);
  RxString selectedPackage = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    handleGetBookingRequest();
  }

  handleGetBookingRequest() async {
    final response = await Request.getBookingRequest();
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        log(jsonObject.toString());
        var bookingArray = jsonObject['data']['bookings'];
        bookingList.clear();
        bookingArray.forEach((element) {
          bookingList.add(BookingModel(data: element));
        });
        update();
        break;
      default:
        debugPrint(response.statusCode.toString());
        break;
    }
  }

  handleGetBookingNowRequest({required String busId}) async {
    LoadingDialog.showCustomDialog(msg: 'title'.tr);
    final response = await Request.getBookingNowRequest(busId);
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        Get.close(1);
        Get.toNamed('/booking');
        var moonDataArray = jsonObject['data']['moonData'];
        bookingDetailsList.clear();
        moonDataArray.forEach((element) {
          bookingDetailsList.add(BookingDetailsModel(data: element));
        });

        update();
        break;
      default:
        debugPrint(response.statusCode.toString());
        break;
    }
  }

  handleSessionSelection() {
    selectedPackage.value = 'session';
    
  }
}
