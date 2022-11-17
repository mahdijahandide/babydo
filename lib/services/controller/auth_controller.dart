import 'dart:convert';

import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/dialogs/loading_dialogs.dart';
import 'package:babydoo/view/widgets/snackbar/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../view/dialogs/term_dialog.dart';
import '../remotes/requests.dart';
import 'dart:convert' as convert;

import 'language_controller.dart';

class AuthController extends GetxController {
  final dataStorage = GetStorage();

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

  // Rx<FocusNode> signInNumFocus = Rx(FocusNode());
  // Rx<FocusNode> signInPassFocus = Rx(FocusNode());

  FocusNode signInNumFocus = FocusNode();
  FocusNode signInPassFocus = FocusNode();

  // Rx<FocusNode> signUpNameFocus = Rx(FocusNode());
  // Rx<FocusNode> signUpMobileFocus = Rx(FocusNode());
  // Rx<FocusNode> signUpEmailFocus = Rx(FocusNode());
  // Rx<FocusNode> signUpPassFocus = Rx(FocusNode());
  // Rx<FocusNode> signUpConfirmPassFocus = Rx(FocusNode());

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
            dataStorage.write('user', jsonEncode(user));
            dataStorage.write('token', token.value);
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
            dataStorage.write('user', jsonEncode(user));
            dataStorage.write('token', token.value);
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

  handleGuestLogin({dynamic noLoader}) async {
    if (noLoader != true) {
      LoadingDialog.showCustomDialog(msg: 'loading');
    }

    final response = await Request.guestLogin();
    Get.log(response.body.toString());
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        Get.log(jsonObject.toString());
        if (jsonObject['status'].toString() == '200') {
          if (noLoader != true) {
            Get.close(1);
          }

          token.value = jsonObject['data']['token'];
          user = jsonObject['data']['user'];
          dataStorage.write('user', jsonEncode(user));
          dataStorage.write('token', token.value);
          Get.toNamed('/home');
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

  handleOtpRequest({dynamic register}) async {
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
            if(register==true){
              Get.toNamed('/otp', parameters: {
                "status": "register",
                "code": jsonObject['data']['sms_activation_code'].toString(),
              });
            }else {
              Get.toNamed('/otp', parameters: {
                "status": "forgetPass",
                "code": jsonObject['data']['sms_activation_code'].toString(),
              });
            }
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

  handleRegisterOtpRequest({dynamic register}) async {
    if (mobileTextController.text.isNotEmpty &&
        emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty &&acceptTerm.isTrue&&
        confirmPasswordTextController.text.isNotEmpty) {
      LoadingDialog.showCustomDialog(msg: 'loading');
      final response = await Request.getOtpRequest(
        mobileTextController.text,
      );
      switch (response.statusCode) {
        case 200:
          var jsonObject = convert.jsonDecode(response.body);
          if (jsonObject['status'].toString() == '200') {
            Get.close(1);
              Get.toNamed('/otp', parameters: {
                "status": "register",
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

  handleSplashView(){
    if (dataStorage.hasData('user')) {
      Get.log('read from storage');
      user =jsonDecode(dataStorage.read('user')) ;
      token.value = dataStorage.read('token');
      if (dataStorage.hasData('lang')) {
        Get.find<LanguageController>().changeLocalization(languageCode: dataStorage.read('lang'), countryCode: dataStorage.read('country'));
        Get.find<LanguageController>().lang.value =
            dataStorage.read('lang');
      }
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Get.toNamed('/home');
      });

    } else {
      handleGuestLogin(noLoader: true);
    }
  }
}
