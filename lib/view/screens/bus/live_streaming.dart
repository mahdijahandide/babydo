import 'dart:async';

import 'package:babydoo/services/controller/bus_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/buttons/custom_text_button.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveStreaming extends GetView<BusController> {
  const LiveStreaming({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().yellow,
      appBar: AppBar(
        centerTitle: false,
        title: CustomText().createText(
            title: 'bus_live_streaming'.tr,
            size: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        backgroundColor: AppColors().yellow,
        elevation: 0,
      ),
      body: Obx(
        () => Stack(
          children: [
            Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                    color: AppColors().yellow,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ))),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60),
                  width: Get.width,
                  height: Get.height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(220, 120),
                        topRight: Radius.elliptical(220, 120)),
                    image: DecorationImage(
                      image: AssetImage('assets/png/background.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration:
                              BoxDecoration(shape: BoxShape.circle, boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                offset: const Offset(1, 3),
                                spreadRadius: 1,
                                blurRadius: 5)
                          ]),
                          margin: const EdgeInsets.only(top: 10),
                          child: Container(
                            padding: const EdgeInsets.all(18.0),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: SvgPicture.asset(
                              'assets/svg/streaming.svg',
                              color: Colors.orangeAccent,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        offset: const Offset(1, 1),
                                        blurRadius: 3,
                                        spreadRadius: 1)
                                  ],
                                  borderRadius: BorderRadius.circular(12)),
                              width: Get.width,
                              height: Get.height - 430,
                              child: Stack(
                                children: [
                                  WebView(
                                    initialUrl: 'https://google.com/',
                                    javascriptMode: JavascriptMode.unrestricted,
                                    onWebViewCreated:
                                        (WebViewController webViewController) {
                                      controller.liveController
                                          .complete(webViewController);
                                    },
                                    onProgress: (int progress) {
                                      print(
                                          'WebView is loading (progress : $progress%)');
                                    },
                                    javascriptChannels: <JavascriptChannel>{
                                      controller
                                          .toasterJavascriptChannel(context),
                                    },
                                    navigationDelegate:
                                        (NavigationRequest request) {
                                      if (request.url
                                          .startsWith('https://google.com/')) {
                                        print(
                                            'blocking navigation to $request}');
                                        return NavigationDecision.prevent;
                                      }
                                      print('allowing navigation to $request');
                                      return NavigationDecision.navigate;
                                    },
                                    onPageStarted: (String url) {
                                      print('Page started loading: $url');
                                      controller.isLiveLoadingDone.value =
                                          false;
                                    },
                                    onPageFinished: (String url) {
                                      print('Page finished loading: $url');
                                      controller.isLiveLoadingDone.value = true;
                                    },
                                    gestureNavigationEnabled: true,
                                    backgroundColor: const Color(0x00000000),
                                  ),
                                  controller.isLiveLoadingDone.isFalse
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors().yellow,
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomTextButton().createTextButton(
                                    buttonText: '${'camera'.tr} 1',
                                    buttonColor: AppColors().yellow,
                                    textColor: Colors.black),
                                CustomTextButton().createTextButton(
                                    buttonText: '${'camera'.tr} 2',
                                    buttonColor: AppColors().yellow,
                                    textColor: Colors.black),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomTextButton().createTextButton(
                                    buttonText: '${'camera'.tr} 3',
                                    buttonColor: AppColors().yellow,
                                    textColor: Colors.black),
                                CustomTextButton().createTextButton(
                                    buttonText: '${'camera'.tr} 4',
                                    buttonColor: AppColors().yellow,
                                    textColor: Colors.black),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
