import 'dart:convert';
import 'dart:io';
import 'package:babydoo/services/controller/language_controller.dart';
import 'package:http/http.dart' as http;

import '../controller/auth_controller.dart';
import 'api_routes.dart';
import 'package:get/get.dart';

class Request {
  static Future<http.Response> userRegister(
      String mobile, String email, String password, String confirmPassword) {
    return http.post(
      Uri.parse(
          userRegisterRoute(lang: Get.find<LanguageController>().lang.value)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'mobile': mobile,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
        'device_type': 'android'
      }),
    );
  }

  static Future<http.Response> userLogin(
      String mobile, String password, String pushyDeviceToken) {
    return http.post(
      Uri.parse(
          userLoginRoute(lang: Get.find<LanguageController>().lang.value)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'mobile': mobile,
        'password': password,
        'pushy_device_token': pushyDeviceToken
      }),
    );
  }

  static Future<http.Response> getSliderRequest() {
    return http.post(Uri.parse(
        getSliderRoute(lang: Get.find<LanguageController>().lang.value)));
  }

  static Future<http.Response> getBusRequest() {
    return http.post(Uri.parse(
        getBusRoute(lang: Get.find<LanguageController>().lang.value)));
  }

  static Future<http.Response> getAddressesRequest() {
    return http.post(
      Uri.parse(
          getAddressesRoute(lang: Get.find<LanguageController>().lang.value)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Get.find<AuthController>().token.value}'
      },
    );
  }

  static Future<http.Response> getBookingRequest() {
    return http.post(
      Uri.parse(
          getBookingRoute(lang: Get.find<LanguageController>().lang.value)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Get.find<AuthController>().token.value}'
      },
    );
  }

  static Future<http.Response> changePasswordRequest(
      String currentPassword, String newPassword, String confirmPassword) {
    return http.post(
      Uri.parse(
          changePasswordRoute(lang: Get.find<LanguageController>().lang.value)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Get.find<AuthController>().token.value}'
      },
      body: jsonEncode(<String, String>{
        'password_confirmation': confirmPassword,
        'password': newPassword,
        'old_password': currentPassword
      }),
    );
  }

  static Future<http.Response> getBookingNowRequest(String busId) {
    return http.post(
      Uri.parse(
          getBookingNowRoute(lang: Get.find<LanguageController>().lang.value)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Get.find<AuthController>().token.value}'
      },
      body: jsonEncode(<String, String>{
        'bus_id': busId,
      }),
    );
  }

  static Future<http.Response> getAreasRequest() {
    return http.post(
      Uri.parse(getAreasRoute(lang: Get.find<LanguageController>().lang.value)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
  }

  static Future<http.Response> bookingPaymentRequest(
      String busId,
      dateReserved,
      startTime,
      endTime,
      name,
      phoneNumber,
      block,
      street,
      avenue,
      areaId,
      houseNum,
      spNote,
      delivery,
      bookingType) {
    return http.post(
      Uri.parse(
          bookPaymentRoute(lang: Get.find<LanguageController>().lang.value)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Get.find<AuthController>().token.value}'
      },
      body: jsonEncode(<String, String>{
        'bus_id': busId,
        'date_reserved': dateReserved,
        'start_time': startTime,
        'end_time': endTime,
        'name': name,
        'phone_number': phoneNumber,
        'block': block,
        'street': street,
        'avenue': avenue,
        'area_id': areaId,
        'latitude': '19.0000',
        'longitude': '18,00000',
        'house_number': houseNum,
        'special_note': spNote,
        'delivery_charge': delivery,
        'booking_type': bookingType,
      }),
    );
  }

  static Future<http.Response> getOtpRequest(String mobile) {
    return http.post(
        Uri.parse(getOtpRoute(lang: Get.find<LanguageController>().lang.value)),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{'mobile': mobile}));
  }

  static Future<http.Response> forgetPasswordRequest(
      String mobile, pass, confirm, otp) {
    return http.post(
        Uri.parse(forgetPasswordRoute(
            lang: Get.find<LanguageController>().lang.value)),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'password': pass,
          'password_confirmation': confirm,
          'mobile_number': mobile,
          'sms_activation_code': otp
        }));
  }

  static Future<http.Response> aboutRequest() {
    return http.post(
      Uri.parse(aboutUsRoute(lang: Get.find<LanguageController>().lang.value)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
  }

  static Future<http.Response> contactUsRequest({
    required String name,
    required String num,
    required String email,
    required String subject,
    required String msg,
  }) {
    return http.post(
        Uri.parse(
            contactUsRoute(lang: Get.find<LanguageController>().lang.value)),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Get.find<AuthController>().token.value}'
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'phone': num,
          'subject': subject,
          'message': msg
        }));
  }

  static Future<http.Response> storeAddressRequest({
    required String areaId,
    required String block,
    required String street,
    required String avenue,
    required String houseNumber,
    required String spNote,
    required String lat,
    required String lng,
  }) {
    return http.post(
        Uri.parse(createAddressRoute(
            lang: Get.find<LanguageController>().lang.value)),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Get.find<AuthController>().token.value}'
        },
        body: jsonEncode(<String, String>{
          'area_id': areaId,
          'block': block,
          'street': street,
          'Avenue': avenue,
          'latitude': lat,
          'longitude': lng,
          'house_number': houseNumber,
          'special_note': spNote
        }));
  }
}
