import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  TextEditingController mobileTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  late File image;
  RxString imgPath = 'select_photo'.tr.obs;

// void uploadImage1(File _image) async {
//     LoadingDialog.showCustomDialog(msg: 'title'.tr);
//     Map<String, String> headers = {
//       'Content-Type':'application/json',
//       'Authorization':'Token ${Get.find<AuthController>().token}'
//     }; // ignore this headers if there is no authentication
//     // open a byteStream
//     var stream =  http.ByteStream(DelegatingStream.typed(_image.openRead()));
//     // get file length
//     var length = await _image.length();
//     // string to uri
//     var uri = Uri.parse(addExperienceRoute);
//     // create multipart request
//     var request =  http.MultipartRequest("POST", uri);
//     // if you need more parameters to parse, add those like this. i added "user_id". here this "user_id" is a key of the API request

//     request.headers.addAll(headers);

//     request.fields['titleFa']=titleControllerFa.text.toString();
//     request.fields['titleEn']=titleControllerEn.text.toString();
//     request.fields['textFa']=descControllerFa.text.toString();
//     request.fields['textEn']=descControllerEn.text.toString();
//     request.fields['accessLevel']=appName;
//     // multipart that takes file.. here this "image_file" is a key of the API request
//     var multipartFile =  http.MultipartFile('image', stream, length, filename: (_image.path));
//     // add file to multipart
//     request.files.add(multipartFile);
//     // send request to upload image
//     await request.send().then((response) async {
//       // listen for response
//       response.stream.transform(utf8.decoder).listen((value) {

//         if (response.statusCode == 200) {
//           Get.back();
//           hasExperienceDetails.value=false;
//           experienceList.value.clear();
//           Get.toNamed('/home');
//           Snack().createSnack(title: '',msg: 'record_success'.tr,icon: const Icon(Icons.check,color: Colors.green,));
//           debugPrint(value.toString());
//         } else {
//           Get.back();
//           RemoteStatusHandler().errorHandler(code: response.statusCode, error: response);
//         }
//       });

//     }).catchError((e) {
//       debugPrint(e.toString());
//     });
//   }

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
}
