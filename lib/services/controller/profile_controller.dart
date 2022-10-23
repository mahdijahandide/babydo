import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../view/dialogs/loading_dialogs.dart';
import '../remotes/api_routes.dart';
import 'auth_controller.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:async/async.dart';

class ProfileController extends GetxController {
  TextEditingController editProfileMobile = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController editProfileFullName = TextEditingController();
  late File image;
  RxString imgPath = 'select_photo'.tr.obs;
  RxString editProfileDOB = ''.obs;

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

  void editProfileRequest(File image, String dob, email, mobile, name) async {
    LoadingDialog.showCustomDialog(msg: 'title'.tr);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${Get.find<AuthController>().token}'
    }; // ignore this headers if there is no authentication
    // open a byteStream
    var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
    // get file length
    var length = await image.length();
    // string to uri
    var uri = Uri.parse(editProfileRoute);
    // create multipart request
    var request = http.MultipartRequest("POST", uri);
    // if you need more parameters to parse, add those like this. i added "user_id". here this "user_id" is a key of the API request

    request.headers.addAll(headers);

    request.fields['name'] = name;
    request.fields['mobile'] = mobile;
    request.fields['email'] = email;
    request.fields['date_of_birth'] = dob;

    // multipart that takes file.. here this "image_file" is a key of the API request
    var multipartFile =
        http.MultipartFile('logo', stream, length, filename: (image.path));
    // add file to multipart
    request.files.add(multipartFile);
    // send request to upload image
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        if (response.statusCode == 200) {
          Get.back();
          debugPrint(response.toString());
        } else {
          Get.back();
          print(response.statusCode);
          print(response);
        }
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }
}
