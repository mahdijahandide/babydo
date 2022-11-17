import 'dart:async';
import 'dart:developer';

import 'package:babydoo/services/model/area_model.dart';
import 'package:babydoo/services/model/bookDetailsModel/book_data_model.dart';
import 'package:babydoo/services/model/bookDetailsModel/booking_details_model.dart';
import 'package:babydoo/services/model/booking_model.dart';
import 'package:babydoo/view/dialogs/loading_dialogs.dart';
import 'package:babydoo/view/dialogs/term_dialog.dart';
import 'package:babydoo/view/widgets/snackbar/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../remotes/requests.dart';
import 'dart:convert' as convert;

import '../utils/app_colors.dart';
import 'language_controller.dart';

class BookController extends GetxController {
  RxBool acceptTerm = false.obs;
  RxBool isEmptyList = false.obs;
  late DateTime startOfPeriod;
  late DateTime endOfPeriod;
  DateTime selectedDate = DateTime.now();
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  RxList<BookingModel> bookingList = RxList([]);
  RxList<BookingDetailsModel> bookingDetailsList = RxList([]);
  RxList<AreaModel> bookingAreaList = RxList([]);

  TextEditingController nameTxtController = TextEditingController();
  TextEditingController mobileTxtController = TextEditingController();
  TextEditingController blockTxtController = TextEditingController();
  TextEditingController streetTxtController = TextEditingController();
  TextEditingController avenueTxtController = TextEditingController();
  TextEditingController houseTxtController = TextEditingController();
  TextEditingController spNoteTxtController = TextEditingController();

  BookDataModel bookData = BookDataModel('', '', '', '', '', '', '', '', '', '',
      '', '', '', '', '', '', '', '', '');

  final Completer<WebViewController> liveController =
  Completer<WebViewController>();
  RxBool isLiveLoadingDone = false.obs;


  JavascriptChannel toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

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
        if (jsonObject['status'].toString() == '200') {
          var bookingArray = jsonObject['data']['bookings'];
          bookingList.clear();
          bookingArray.forEach((element) {
            bookingList.add(BookingModel(data: element));
          });
          if (bookingList.isEmpty) {
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

  handleGetBookingNowRequest({required String busId}) async {
    LoadingDialog.showCustomDialog(msg: 'title'.tr);
    final response = await Request.getBookingNowRequest(busId);
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        if (jsonObject['status'].toString() == '200') {
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

          bookData = BookDataModel('', '', '', '', '', '', '', '', '', '', '',
              '', '', '', '', '', '', '', '');
          nameTxtController.text = '';
          mobileTxtController.text = '';
          blockTxtController.text = '';
          streetTxtController.text = '';
          avenueTxtController.text = '';
          houseTxtController.text = '';
          spNoteTxtController.text = '';
          bookData.busId = busId;
          bookData.dateReserved =
              '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
          handleSessionSelection();
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

  handleGetBookingAreasRequest() async {
    final response = await Request.getAreasRequest();
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        if (jsonObject['status'].toString() == '200') {
          log(jsonObject.toString());
          var areaArray = jsonObject['data']['areas'];
          bookingAreaList.clear();
          areaArray.forEach((element) {
            bookingAreaList.add(AreaModel(data: element));
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

  handleSessionSelection() {
    bookData.packageType = 'Session';
    bookData.selectedTime = '';
    bookData.startTime = '';
    bookData.endTime = '';
    bookData.bookPrice = '0';
    bookData.areaId = '';
    bookData.areaName = '';
    bookData.deliveryCharge = '0';
    update();
  }

  handleFulldaySelection() {
    bookData.packageType = 'Fullday';
    bookData.selectedTime = '';
    bookData.startTime = '';
    bookData.endTime = '';
    bookData.bookPrice = '0';
    bookData.areaId = '';
    bookData.areaName = '';
    bookData.deliveryCharge = '0';
    update();
  }

  handlePaymentRequest() async {
    LoadingDialog.showCustomDialog(msg: 'title'.tr);
    final response = await Request.bookingPaymentRequest(

      busId:  bookData.busId.toString(),
       dateReserved: bookData.dateReserved.toString(),
       startTime: bookData.startTime.toString(),
       endTime: bookData.endTime.toString(),
       name: bookData.name.toString(),
       phoneNumber: bookData.phoneNumber.toString(),
       block: bookData.block.toString(),
        street:bookData.street.toString(),
        avenue:bookData.avenue.toString(),
        areaId:bookData.areaId.toString(),
        lat:bookData.lat.toString(),
        lng:bookData.lng.toString(),
        houseNum:bookData.houseNumber.toString(),
        spNote:bookData.specialNote.toString(),
        delivery: bookData.deliveryCharge.toString(),
        bookingType:bookData.packageType.toString());
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        if (jsonObject['status'].toString() == '200') {
          Get.close(1);
          Get.log(jsonObject.toString());

          String url = jsonObject['data']['webViewUrl'].toString();
          Get.toNamed('/payment',arguments: url.toString());
          // _launchUrl(url);

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

  handleTermAndConditionsRequest() async {
    LoadingDialog.showCustomDialog(msg: 'title'.tr);
    final response = await Request.termAndConditionsRequest();
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        if (jsonObject['status'].toString() == '200') {
          Get.close(1);

          TermAndConditionDialog.showCustomDialog(
              title: jsonObject['data']['terms_and_conditions']
                      ['title_${Get.find<LanguageController>().lang.value}']
                  .toString(),
              text: jsonObject['data']['terms_and_conditions']
                      ['details_${Get.find<LanguageController>().lang.value}']
                  .toString());

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

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
    )) {
      throw 'Could not launch $url';
    }
  }
}
