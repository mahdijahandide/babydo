import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/buttons/custom_text_button.dart';
import 'package:babydoo/view/widgets/chewie/chewie.dart';
import 'package:babydoo/view/widgets/marquee/marquee_widget.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LiveStreaming extends StatelessWidget {
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
      body: SingleChildScrollView(
        child: Stack(
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
                        GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, mainAxisSpacing: 8),
                          children: [
                            liveViewWidget(
                                busName: 'Circus Bus',
                                url:
                                    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
                            liveViewWidget(
                                busName: 'Mini Jungle Bus',
                                url:
                                    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
                            liveViewWidget(
                                busName: 'Arcade Bus',
                                url:
                                    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
                            liveViewWidget(
                                busName: 'Kids Rider Bus Camera',
                                url:
                                    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
                          ],
                        ),
                        // SizedBox(
                        //   width: Get.width,
                        //   height: 45,
                        //   child: CustomTextButton().createTextButton(
                        //       buttonText: 'back_to_profile'.tr,
                        //       buttonColor: AppColors().green,
                        //       onPress: () {},
                        //       textColor: Colors.white),
                        // )
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

  Widget iconTextWidget({required ic, required txt, dynamic listner}) {
    return InkWell(
      onTap: listner ?? () {},
      child: Row(
        children: [
          const SizedBox(
            width: 50,
          ),
          SvgPicture.asset(
            'assets/svg/$ic.svg',
            color: Colors.orangeAccent,
            width: 30,
            height: 30,
          ),
          const SizedBox(
            width: 20,
          ),
          CustomText().createText(
              title: txt,
              size: 20,
              color: AppColors().green,
              fontWeight: FontWeight.bold)
        ],
      ),
    );
  }

  Widget liveViewWidget({required String busName, required String url}) {
    return Column(
      children: [
        MarqueeWidget(
            direction: Axis.horizontal,
            child: CustomText().createText(title: busName)),
        FittedBox(child: VideoWidget(url: url, play: true)),
      ],
    );
  }
}
