import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../services/controller/home_controller.dart';

class Carusel extends StatelessWidget {
  const Carusel();

  @override
  Widget build(BuildContext context) {
    // HomeController homeController = Get.put(HomeController());
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 170.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        viewportFraction: 0.9,
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        Get.find<HomeController>().caruselIndex.value = index;
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            Get.find<HomeController>().imgList[index].url.toString(),
            fit: BoxFit.fill,
            width: Get.width,
            // color: Colors.white,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: SizedBox(
                  width: Get.width,
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
                ),
              );
            },
          ),
        );
      },
      itemCount: Get.find<HomeController>().imgList.length,
    );
  }
}
