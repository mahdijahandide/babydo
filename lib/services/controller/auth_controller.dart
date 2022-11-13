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

  RxBool changePassObSecureCurrentPassField = true.obs;
  RxBool changePassObSecureNewPassField = true.obs;
  RxBool changePassObSecureConfirmPassField = true.obs;

  RxBool resetPassObSecurePassField = true.obs;
  RxBool resetPassObSecureConfirmPassField = true.obs;

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

  TextEditingController forgotScreenMobileNumber = TextEditingController();

  TextEditingController otpTextController = TextEditingController();
  TextEditingController resetPassTextController = TextEditingController();
  TextEditingController resetPassConfirmTextController =
      TextEditingController();

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
          if (jsonObject['status'].toString() == '200') {
            otpVerifyCode =
                jsonObject['data']['user']['sms_activation_code'].toString();
            token.value = jsonObject['data']['token'];
            Get.offAndToNamed('/otp');
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
      Get.log(response.body.toString());
      switch (response.statusCode) {
        case 200:
          var jsonObject = convert.jsonDecode(response.body);
          Get.log(jsonObject.toString());
          if (jsonObject['status'].toString() == '200') {
            token.value = jsonObject['data']['token'];
            user = jsonObject['data']['user'];
            Get.offAndToNamed('/home');
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
          if (jsonObject['status'].toString() == '200') {
            Snack().createSnack(
                title: 'Successful',
                msg: 'Password changed successfuly',
                icon: Icon(
                  Icons.check,
                  color: AppColors().green,
                ));
            Get.close(1);
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

  handleOtpRequest() async {
    if (forgotScreenMobileNumber.text.isNotEmpty &&
        forgotScreenMobileNumber.text.length == 8) {
      LoadingDialog.showCustomDialog(msg: 'loading');
      final response = await Request.getOtpRequest(
        forgotScreenMobileNumber.text,
      );
      switch (response.statusCode) {
        case 200:
          var jsonObject = convert.jsonDecode(response.body);
          if (jsonObject['status'].toString() == '200') {
            Get.close(1);
            Get.toNamed('/otp', parameters: {
              "status": "forgetPass",
              "code": jsonObject['data']['sms_activation_code'].toString(),
            });
            otpVerifyCode =
                jsonObject['data']['sms_activation_code'].toString();
            print(otpVerifyCode);
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

  handleForgetPassRequest(String num, pass, confirm, otp) async {
    if (forgotScreenMobileNumber.text.isNotEmpty &&
        forgotScreenMobileNumber.text.length == 8 &&
        resetPassTextController.text.isNotEmpty &&
        resetPassConfirmTextController.text.isNotEmpty &&
        resetPassTextController.text == resetPassConfirmTextController.text) {
      LoadingDialog.showCustomDialog(msg: 'loading');
      final response =
          await Request.forgetPasswordRequest(num, pass, confirm, otp);
      switch (response.statusCode) {
        case 200:
          var jsonObject = convert.jsonDecode(response.body);
          if (jsonObject['status'].toString() == '200') {
            Get.close(1);
            Snack().createSnack(
                title: 'Successful',
                msg: 'Password changed successfuly',
                icon: Icon(
                  Icons.check,
                  color: AppColors().green,
                ));
            Get.toNamed('/auth');
            print(otpVerifyCode);
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
