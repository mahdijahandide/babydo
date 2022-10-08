import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        return Container(
          width: Get.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(
                  Get.find<HomeController>().imgList[index].url
                  .toString(),
                ),
                fit: BoxFit.fill,
              )),
        );
      },
      itemCount: Get.find<HomeController>().imgList.length,
    );
  }
}
