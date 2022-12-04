import 'package:babydoo/services/controller/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../services/utils/app_colors.dart';
import '../../widgets/texts/customText.dart';


class PaymentWebview extends GetView<BookController> {
  const PaymentWebview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: CustomText().createText(title: 'payment'.tr, size: 18, fontWeight: FontWeight.bold),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,leading:  IconButton(icon:const Icon(Icons.close,color: Colors.red,),onPressed: ()=>Get.offAndToNamed('/home')),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(5),
        child: Divider(
          color: AppColors().green,
          thickness: 1.1,
          indent: 12,
          endIndent: 12,
        ),
      ),
    ),
      body: WebView(
      initialUrl: Get.arguments,
      javascriptMode: JavascriptMode.unrestricted,
      // onWebViewCreated:(WebViewController webViewController) {
      //   controller.liveController.complete(webViewController);
      // },
      // onProgress: (int progress) {
      //   print('WebView is loading (progress : $progress%)');
      // },
      javascriptChannels: <JavascriptChannel>{
        controller.toasterJavascriptChannel(context),
      },
      // navigationDelegate:(NavigationRequest request) {
      //   if (request.url.startsWith(Get.arguments)) {
      //     print('blocking navigation to $request}');
      //     return NavigationDecision.prevent;
      //   }
      //   print('allowing navigation to $request');
      //   return NavigationDecision.navigate;
      // },
      // onPageStarted: (String url) {
      //   print('Page started loading: $url');
      //   controller.isLiveLoadingDone.value =false;
      // },
      // onPageFinished: (String url) {
      //   print('Page finished loading: $url');
      //   controller.isLiveLoadingDone.value = true;
      // },
      gestureNavigationEnabled: true,
      backgroundColor: const Color(0x00000000),
    ),

    );
  }
}
