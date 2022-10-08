import 'package:babydoo/services/controller/home_controller.dart';
import 'package:babydoo/services/model/BusModel.dart';
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
  RxBool acceptTerm = false.obs;

  TextEditingController mobileTextController=TextEditingController();
  TextEditingController emailTextController=TextEditingController();
  TextEditingController passwordTextController=TextEditingController();
  TextEditingController confirmPasswordTextController=TextEditingController();

  TextEditingController loginPasswordTextController=TextEditingController();
  TextEditingController loginMobileTextController=TextEditingController();

  TextEditingController otpTextController=TextEditingController();

  FocusNode otpNode=FocusNode();
  
  String otpVerifyCode='';
  String token='';
   

  handleRegister() async {
    if(mobileTextController.text.isNotEmpty&&emailTextController.text.isNotEmpty&&passwordTextController.text.isNotEmpty&&
    confirmPasswordTextController.text.isNotEmpty){
      LoadingDialog.showCustomDialog(msg: 'loading');
      final response = await Request.userRegister(
          mobileTextController.text, emailTextController.text, passwordTextController.text,
          confirmPasswordTextController.text);
      switch (response.statusCode) {
        case 200:
          var jsonObject = convert.jsonDecode(response.body);
          otpVerifyCode =jsonObject['data']['user']['sms_activation_code'].toString();
          token=jsonObject['data']['token'];
          Get.offAndToNamed('/otp');
          break;
        default:
          debugPrint(response.statusCode.toString());
          break;
      }
    }else{
      Snack().createSnack(title: 'warning',msg: 'Please Fill the Form',icon: Icon(Icons.warning,color: AppColors().maroon,));
    }
  }

  handleLogin() async {
    if(loginMobileTextController.text.isNotEmpty&&loginPasswordTextController.text.isNotEmpty){
      LoadingDialog.showCustomDialog(msg: 'loading');
      final response = await Request.userLogin(
          loginMobileTextController.text, loginPasswordTextController.text, '');
      switch (response.statusCode) {
        case 200:
          var jsonObject=convert.jsonDecode(response.body);
          token=jsonObject['data']['token'];

          jsonObject['data']['buses'].forEach((element){
          Get.find<HomeController>().busses.add(BusModel(name: element['name'],kidsCount: element['kids_count']));
          });
          Get.offAndToNamed('/home');
          break;
        default:
          print(response.statusCode);
          Get.close(1);
          break;
      }
    }else{
      Snack().createSnack(title: 'warning',msg: 'Please Fill the Form',icon: Icon(Icons.warning,color: AppColors().maroon,));
    }
  }
}
