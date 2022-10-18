import 'dart:convert';
import 'package:http/http.dart' as http;
import '../controller/auth_controller.dart';
import 'api_routes.dart';
import 'package:get/get.dart';

class Request {
  static Future<http.Response> userRegister(
      String mobile, String email, String password, String confirmPassword) {
    return http.post(
      Uri.parse(userRegisterRoute),
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
      Uri.parse(userLoginRoute),
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
    return http.post(Uri.parse(getSliderRoute));
  }

  static Future<http.Response> getBusRequest() {
    return http.post(Uri.parse(getBusRoute));
  }

  static Future<http.Response> getAddressesRequest() {
    return http.post(
      Uri.parse(getAddressesRoute),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Get.find<AuthController>().token}'
      },
    );
  }
}
