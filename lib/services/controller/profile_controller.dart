import 'dart:io';

import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/snackbar/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../view/dialogs/loading_dialogs.dart';
import '../remotes/api_routes.dart';
import 'auth_controller.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  TextEditingController editProfileMobile = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController editProfileFullName = TextEditingController();
  late File image;
  RxString imgPath = 'select_photo'.tr.obs;
  RxString editProfileDOB = ''.obs;
  var user;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    user = Get.find<AuthController>().user;
    editProfileFullName.text = user['name'];
    editProfileMobile.text = user['mobile'];
    editProfileDOB.value = user['date_of_birth'];
    emailTextController.text = user['email'];
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

  editProfileRequest(File image, String dob, email, mobile, name) async {
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
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("logo", image.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var jsonObject = convert.jsonDecode(responseString);
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
  }
}
