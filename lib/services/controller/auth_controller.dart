import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/dialogs/loading_dialogs.dart';
import 'package:babydoo/view/widgets/snackbar/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../remotes/requests.dart';
import 'dart:convert' as convert;

class AuthController extends GetxController {
  RxBool isSignUp = false.obs;
  RxBool obSecurePassField = true.obs;

  RxBool ChangePassObSecureCurrentPassField = true.obs;
  RxBool ChangePassObSecureNewPassField = true.obs;
  RxBool ChangePassObSecureConfirmPassField = true.obs;

  RxBool acceptTerm = false.obs;

  TextEditingController mobileTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  TextEditingController loginPasswordTextController = TextEditingController();
  TextEditingController loginMobileTextController = TextEditingController();

  TextEditingController changePasswordCurrentPass = TextEditingController();
  TextEditingController changePasswordNewPass = TextEditingController();
  TextEditingController changePasswordConfirmPass = TextEditingController();

  TextEditingController otpTextController = TextEditingController();

  FocusNode otpNode = FocusNode();

  String otpVerifyCode = '';
  RxString token = ''.obs;
  var user;

  handleRegister() async {
    if (mobileTextController.text.isNotEmpty &&
        emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty &&
        confirmPasswordTextController.text.isNotEmpty) {
      LoadingDialog.showCustomDialog(msg: 'loading');
      final response = await Request.userRegister(
          mobileTextController.text,
          emailTextController.text,
          passwordTextController.text,
          confirmPasswordTextController.text);
      switch (response.statusCode) {
        case 200:
          var jsonObject = convert.jsonDecode(response.body);
          otpVerifyCode =
              jsonObject['data']['user']['sms_activation_code'].toString();
          token.value = jsonObject['data']['token'];
          Get.offAndToNamed('/otp');
          break;
        default:
          debugPrint(response.statusCode.toString());
          break;
      }
    } else {
      Snack().createSnack(
          title: 'warning',
          msg: 'Please Fill the Form',
          icon: Icon(
            Icons.warning,
            color: AppColors().maroon,
          ));
    }
  }

  handleLogin() async {
    if (loginMobileTextController.text.isNotEmpty &&
        loginPasswordTextController.text.isNotEmpty) {
      LoadingDialog.showCustomDialog(msg: 'loading');
      final response = await Request.userLogin(
          loginMobileTextController.text, loginPasswordTextController.text, '');
      switch (response.statusCode) {
        case 200:
          var jsonObject = convert.jsonDecode(response.body);
          token.value = jsonObject['data']['token'];
          user = jsonObject['data']['user'];
          Get.offAndToNamed('/home');
          break;
        default:
          print(response.statusCode);
          Get.close(1);
          break;
      }
    } else {
      Snack().createSnack(
          title: 'warning',
          msg: 'Please Fill the Form',
          icon: Icon(
            Icons.warning,
            color: AppColors().maroon,
          ));
    }
  }

  handleChangePassword() async {
    if (changePasswordCurrentPass.text.isNotEmpty &&
        changePasswordNewPass.text.isNotEmpty &&
        changePasswordNewPass.text == changePasswordConfirmPass.text) {
      LoadingDialog.showCustomDialog(msg: 'loading');
      final response = await Request.changePasswordRequest(
          changePasswordCurrentPass.text,
          changePasswordNewPass.text,
          changePasswordConfirmPass.text);
      switch (response.statusCode) {
        case 200:
          var jsonObject = convert.jsonDecode(response.body);
          Snack().createSnack(
              title: 'Successful',
              msg: 'Password changed successfuly',
              icon: Icon(
                Icons.check,
                color: AppColors().green,
              ));
          Get.close(1);
          break;
        default:
          print(response.statusCode);
          Get.close(1);
          break;
      }
    } else {
      Snack().createSnack(
          title: 'warning',
          msg: 'Please Fill the Form Correctly',
          icon: Icon(
            Icons.warning,
            color: AppColors().maroon,
          ));
    }
  }
}
