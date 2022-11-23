import 'package:babydoo/services/controller/booking_controller.dart';
import 'package:babydoo/services/controller/home_controller.dart';
import 'package:babydoo/services/controller/language_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/screens/home/widgets/carusel.dart';
import 'package:babydoo/view/widgets/buttons/custom_text_button.dart';
import 'package:babydoo/view/widgets/marquee/marquee_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../../widgets/chewie/chewie.dart';
import '../../widgets/texts/customText.dart';
import 'package:dots_indicator/dots_indicator.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BookController(),);
    Get.put(HomeController());
    controller.onInit();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          title: CustomText().createText(
              title: 'enjoy_the_riding'.tr,
              color: Colors.black,
              size: 16,
              fontWeight: FontWeight.w600),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () {
                controller.drawerKey.currentState!.openEndDrawer();
              },
            )
          ],
        ),
        body: ShaderMask(
          shaderCallback: (Rect rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.grey,
                Colors.transparent,
                Colors.transparent,
                Colors.grey
              ],
              stops: [0.0, 0.01, 0.95, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstOut,
          child: Obx(
            () => ListView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                controller.imgList.isEmpty
                    ? SizedBox(
                        width: Get.width,
                        height: 170,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.black.withOpacity(0.8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                          ),
                        ),
                      )
                    : const Carusel(),
                controller.imgList.isEmpty
                    ? const SizedBox(
                        height: 10,
                      )
                    : DotsIndicator(
                        dotsCount: controller.imgList.length,
                        position: 0,
                        decorator: DotsDecorator(
                          size: const Size.square(9.0),
                          activeSize: const Size(18.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: CustomText().createText(
                        title: 'choose_your_bus'.tr,
                        fontWeight: FontWeight.w600,
                        size: 20)),
                ListView.builder(
                    controller: controller.mainScrollController,
                    itemCount: controller.bussesList.isEmpty
                        ? 4
                        : controller.bussesList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // ignore: prefer_typing_uninitialized_variables
                      var current;
                      if (controller.bussesList.isNotEmpty) {
                        current = controller.bussesList[index];
                      }
                      return controller.bussesList.isEmpty
                          ? SizedBox(
                              width: Get.width,
                              height: 100,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.black.withOpacity(0.8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(20)),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 8),
                                ),
                              ),
                            )
                          : Align(
                              heightFactor: 0.965,
                              alignment: Alignment.topCenter,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(index > 3
                                            ? 'assets/png/box1.png'
                                            : 'assets/png/box${index + 1}.png'),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withAlpha(100),
                                          blurRadius: 10.0),
                                    ]),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    textColor: Colors.black12,
                                    trailing: const Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      size: 0,
                                      color: Colors.white,
                                    ),
                                    title: ListTile(
                                      leading: Lottie.asset(index > 3
                                          ? 'assets/json/bus1.json'
                                          : 'assets/json/bus${index + 1}.json'),
                                      title: MarqueeWidget(
                                        direction: Axis.horizontal,
                                        child: CustomText().createText(
                                            title: current.name.toString(),
                                            size: 22,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              8, 8, 8, 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: Get.width,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/svg/kids.svg',
                                                      width: 25,
                                                      height: 25,
                                                    ),
                                                    const SizedBox(
                                                      width: 6,
                                                    ),
                                                    CustomText().createText(
                                                        title:
                                                            '${current.kidsCount} ${'kids'.tr}',
                                                        color: Colors.white,
                                                        size: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        align:
                                                            TextAlign.center),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              GridView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  crossAxisSpacing: 5.0,
                                                  mainAxisSpacing: 5.0,
                                                  childAspectRatio: 4.0,
                                                ),
                                                itemCount:
                                                    current.featureList.length,
                                                itemBuilder: (context, index) {
                                                  var cf = current
                                                      .featureList[index];
                                                  return createWhiteButton(
                                                      title:
                                                          Get.find<LanguageController>()
                                                                      .lang
                                                                      .value ==
                                                                  'en'
                                                              ? cf.featureEn
                                                              : cf.featureAr);
                                                },
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/svg/price.svg',
                                                        width: 25,
                                                        height: 25,
                                                      ),
                                                      const SizedBox(
                                                        width: 6,
                                                      ),
                                                      CustomText().createText(
                                                          title:
                                                              '${'kd'.tr} ${current.sessionPrice} /${'session'.tr}',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          size: 16,
                                                          color:
                                                              Colors.white),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/svg/kids_age.svg',
                                                        width: 25,
                                                        height: 25,
                                                      ),
                                                      const SizedBox(
                                                        width: 6,
                                                      ),
                                                      CustomText().createText(
                                                          title:
                                                              '${current.startAge} ${'yr'.tr} ${current.endAge} ${'yrs'.tr}',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          size: 16,
                                                          color:
                                                              Colors.white),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                                child: Stack(
                                                  children: [
                                                    Obx(() => ClipRRect(
                                                          borderRadius: BorderRadius.circular(8),
                                                          child: Image.network(
                                                            current.imgBg.value,
                                                            width: Get.width,
                                                            height: 180,
                                                            fit: BoxFit.fill,
                                                            loadingBuilder:
                                                                (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                              if (loadingProgress == null) {
                                                                return child;
                                                              }
                                                              return Center(
                                                                child: SizedBox(
                                                                  width:
                                                                      Get.width,
                                                                  height: 180,
                                                                  child: Center(
                                                                    child: CircularProgressIndicator(
                                                                      value: loadingProgress.expectedTotalBytes != null
                                                                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        )),
                                                    Container(
                                                      width: 70,
                                                      height: 165,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white.withOpacity(0.5),
                                                          borderRadius: BorderRadius.circular(8)),
                                                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                                      child: ShaderMask(
                                                        shaderCallback: (Rect rect) {
                                                          return const LinearGradient(
                                                            begin: Alignment.topCenter,
                                                            end: Alignment.bottomCenter,
                                                            colors: [
                                                              Colors.grey, Colors.transparent,
                                                              Colors.transparent, Colors.grey
                                                            ],
                                                            stops: [0.0, 0.12, 0.9, 1.0],
                                                          ).createShader(rect);
                                                        },
                                                        blendMode:
                                                            BlendMode.dstOut,
                                                        child: ListView.builder(
                                                          itemCount: current.galleryList.length,
                                                          shrinkWrap: true,
                                                          physics: const BouncingScrollPhysics(),
                                                          scrollDirection: Axis.vertical,
                                                          itemBuilder: (BuildContext context, int index) {
                                                            var cg = current.galleryList[index];
                                                            return InkWell(
                                                              onTap: () {
                                                                current.imgBg.value = cg.url;
                                                                controller.update();
                                                              },
                                                              child: Container(
                                                                width: 50,
                                                                height: 60,
                                                                decoration: BoxDecoration(color: Colors.white.withOpacity(0.5),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(4.0),
                                                                  child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(4),
                                                                    child: Image.network(cg.url,
                                                                      fit: BoxFit.fill,
                                                                      loadingBuilder: (BuildContext context, Widget child,
                                                                          ImageChunkEvent?loadingProgress) {
                                                                        if (loadingProgress == null) {
                                                                          return child;
                                                                        }
                                                                        return Center(
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            value: loadingProgress.expectedTotalBytes != null
                                                                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                                                : null,
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              CustomText().createText(
                                                  title: current.name,
                                                  fontWeight: FontWeight.w600,
                                                  size: 16),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              VideoWidget(
                                                play: true,
                                                url: current
                                                    .videoGalleryList[0].url,
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: CustomTextButton()
                                                        .createTextButton(
                                                            buttonText:
                                                                'book_now'.tr,
                                                            textSize: 16,
                                                            weight:
                                                                FontWeight.w600,
                                                            buttonColor:
                                                                AppColors()
                                                                    .darkBlue,
                                                            textColor:
                                                                Colors.white,
                                                            onPress: () {
                                                              Get.find<
                                                                      BookController>()
                                                                  .handleGetBookingNowRequest(
                                                                      busId: current
                                                                          .id
                                                                          .toString());
                                                            }),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ));
                    }),
                const SizedBox(
                  height: 120,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createWhiteButton({required title, dynamic onClick}) {
    return Container(
      width: Get.width / 4,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: MarqueeWidget(
          direction: Axis.horizontal,
          child: CustomText().createText(
              title: '$title',
              color: Colors.pinkAccent,
              align: TextAlign.center,
              size: 16,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget createBlueBox() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
        decoration: BoxDecoration(
            color: AppColors().liteBlue,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors().darkBlue, width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText().createText(title: '25', fontWeight: FontWeight.bold),
            CustomText().createText(title: 'KD'),
            CustomText().createText(title: 'session'),
          ],
        ),
      ),
    );
  }
}
