import 'dart:developer';

import 'package:babydoo/services/model/area_model.dart';
import 'package:babydoo/services/model/bookDetailsModel/book_data_model.dart';
import 'package:babydoo/services/model/bookDetailsModel/booking_details_model.dart';
import 'package:babydoo/services/model/booking_model.dart';
import 'package:babydoo/view/dialogs/loading_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../remotes/requests.dart';
import 'dart:convert' as convert;

class BookController extends GetxController {
  RxBool acceptTerm = false.obs;
  late DateTime startOfPeriod;
  late DateTime endOfPeriod;
  DateTime selectedDate = DateTime.now();

  RxList<BookingModel> bookingList = RxList([]);
  RxList<BookingDetailsModel> bookingDetailsList = RxList([]);
  RxList<AreaModel> bookingAreaList = RxList([]);

  // RxString selectedArea = ''.obs;

  BookDataModel bookData = BookDataModel(
      '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '');

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    handleGetBookingRequest();
  }

  String dayHeaderTitleBuilder(
          int dayOfTheWeek, List<String> localizedHeaders) =>
      localizedHeaders[dayOfTheWeek].substring(0, 3);

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

        startOfPeriod = DateFormat("yyyy-MM-dd hh:mm:ss")
            .parse('${bookingDetailsList.first.date}');
        endOfPeriod = DateFormat("yyyy-MM-dd hh:mm:ss")
            .parse('${bookingDetailsList.last.date}');
        selectedDate = DateFormat("yyyy-MM-dd hh:mm:ss")
            .parse('${bookingDetailsList.first.date}');
        bookData.busId = busId;
        handleSessionSelection();
        update();
        break;
      default:
        debugPrint(response.statusCode.toString());
        break;
    }
  }

  handleGetBookingAreasRequest() async {
    final response = await Request.getAreasRequest();
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        log(jsonObject.toString());
        var areaArray = jsonObject['data']['areas'];
        bookingAreaList.clear();
        areaArray.forEach((element) {
          bookingAreaList.add(AreaModel(data: element));
        });
        update();
        break;
      default:
        debugPrint(response.statusCode.toString());
        break;
    }
  }

  handleSessionSelection() {
    bookData.packageType = 'Session';
  }

  handleFulldaySelection() {
    bookData.packageType = 'FullDay';
  }
}
