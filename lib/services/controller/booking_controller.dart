import 'dart:developer';

import 'package:babydoo/services/model/booking_model.dart';
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
}
