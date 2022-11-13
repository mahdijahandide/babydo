import 'dart:io';

import 'package:babydoo/services/controller/language_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/snackbar/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../view/dialogs/loading_dialogs.dart';
import '../remotes/api_routes.dart';
import '../remotes/requests.dart';
import 'auth_controller.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  TextEditingController editProfileMobile = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController editProfileFullName = TextEditingController();

  TextEditingController contactUsFullName = TextEditingController();
  TextEditingController contactUsMobileNumber = TextEditingController();
  TextEditingController contactUsEmailAddress = TextEditingController();
  TextEditingController contactUsSubject = TextEditingController();
  TextEditingController contactUsMsg = TextEditingController();

  File? image;
  RxString imgPath = 'select_photo'.tr.obs;
  RxString editProfileDOB = ''.obs;
  var user;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    user = Get.find<AuthController>().user;
    editProfileFullName.text = user['name'].toString();
    editProfileMobile.text = user['mobile'].toString();
    editProfileDOB.value = user['date_of_birth'].toString();
    emailTextController.text = user['email'].toString();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      this.image = imageTemporary;
      imgPath.value = image.name.toString();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  editProfileRequest(dynamic image,
      {required String dob, email, mobile, name}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Get.find<AuthController>().token.value}'
    };
    LoadingDialog.showCustomDialog(msg: 'title'.tr);
    var request = http.MultipartRequest("POST", Uri.parse(editProfileRoute));
    request.headers.addAll(headers);
    request.fields['name'] = name;
    request.fields['mobile'] = mobile;
    request.fields['email'] = email;
    request.fields['date_of_birth'] = dob;

    if (image != null) {
//create multipart using filepath, string or bytes
      var pic = await http.MultipartFile.fromPath("logo", image.path);
      //add multipart to request
      request.files.add(pic);
    }

    var response = await request.send();
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var jsonObject = convert.jsonDecode(responseString);
    if (jsonObject['status'].toString() == '200') {
      Get.find<AuthController>().user = jsonObject['data']['user'];
      Get.find<AuthController>().update();
      update();
      Get.close(1);
      Snack().createSnack(
          title: 'BabyDo',
          msg: 'Profile Updated Successfully',
          icon: Icon(
            Icons.check,
            color: AppColors().green,
          ));
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
  }

  handleContactUsRequest() async {
    if (contactUsFullName.text.isNotEmpty &&
        contactUsEmailAddress.text.isNotEmpty &&
        contactUsMobileNumber.text.isNotEmpty &&
        contactUsSubject.text.isNotEmpty &&
        contactUsMsg.text.isNotEmpty) {
      LoadingDialog.showCustomDialog(msg: 'loading');
      final response = await Request.contactUsRequest(
          name: contactUsFullName.text,
          num: contactUsMobileNumber.text,
          email: contactUsEmailAddress.text,
          subject: contactUsSubject.text,
          msg: contactUsMsg.text);
      switch (response.statusCode) {
        case 200:
          var jsonObject = convert.jsonDecode(response.body);
          if (jsonObject['status'].toString() == '200') {
            Snack().createSnack(
                title: 'Successful',
                msg: 'Message Sent Successfuly',
                icon: Icon(
                  Icons.check,
                  color: AppColors().green,
                ));
            Get.close(1);
            contactUsFullName.text = '';
            contactUsMobileNumber.text = '';
            contactUsEmailAddress.text = '';
            contactUsSubject.text = '';
            contactUsMsg.text = '';
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
          debugPrint(response.statusCode.toString());
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

  handleAboutUsRequest() async {
    LoadingDialog.showCustomDialog(msg: 'loading');
    final response = await Request.aboutRequest();
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        if (jsonObject['status'].toString() == '200') {
          String about = Get.find<LanguageController>().lang.value == 'en'
              ? jsonObject['data']['about_us']['details_en'].toString()
              : jsonObject['data']['about_us']['details_ar'].toString();
          Get.close(1);
          Get.toNamed('/aboutUs', arguments: about);
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
}
