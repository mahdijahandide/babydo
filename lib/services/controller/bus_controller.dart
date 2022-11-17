import 'dart:async';

import 'package:babydoo/view/dialogs/loading_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
import 'package:webview_flutter/webview_flutter.dart';

import '../../view/widgets/snackbar/snackbar.dart';
import '../remotes/requests.dart';
import '../utils/app_colors.dart';

class BusController extends GetxController {
  RxBool isLiveLoadingDone = false.obs;

  final Completer<WebViewController> liveController =
      Completer<WebViewController>();

  RxString camera1=''.obs;
  RxString camera2=''.obs;
  RxString camera3=''.obs;
  RxString camera4=''.obs;
  RxString mainCamera='https://babydobus.com'.obs;

  JavascriptChannel toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  handleGetCameraRequest() async {
    LoadingDialog.showCustomDialog(msg: 'loading'.tr);
    final response = await Request.getCameraRequest();
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        if (jsonObject['status'].toString() == '200') {
          Get.back();
          var data = jsonObject['data'];
          camera1.value=data['camera-1'].toString();
          camera2.value=data['camera-2'].toString();
          camera3.value=data['camera-3'].toString();
          camera4.value=data['camera-4'].toString();
          mainCamera.value=camera1.value;
          update();
        } else {
          Get.back();
          Snack().createSnack(
              title: 'warning',
              msg: jsonObject['message'].toString(),
              icon: Icon(
                Icons.warning,
                color: AppColors().yellow,
              ));
        }
        break;
      default:
        Get.back();
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
