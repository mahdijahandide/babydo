import 'package:babydoo/services/model/busModel/bus_model.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';

import 'dart:convert' as convert;
import '../../view/screens/home/widgets/carusel.dart';
import '../model/slider_model.dart';
import '../remotes/requests.dart';

class HomeController extends GetxController {
  RxInt caruselIndex = 0.obs;

  ScrollController mainScrollController = ScrollController();
  ScrollController insederScrollController = ScrollController();
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  final Carusel carusel = const Carusel();

  RxList<SliderModel> imgList = RxList([]);

  RxList<BusModel> bussesList = RxList([]);

  @override
  void onInit() {
    super.onInit();

    handleSlider();
    handleBusRequest();
  }

  handleSlider() async {
    final response = await Request.getSliderRequest();
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        var slidersArray = jsonObject['data']['sliders'];
        imgList.clear();
        slidersArray.forEach((element) {
          imgList.add(SliderModel(data: element));
        });
        break;
      default:
        debugPrint(response.statusCode.toString());
        break;
    }
  }

  handleBusRequest() async {
    final response = await Request.getBusRequest();
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        var busArray = jsonObject['data']['buses'];
        bussesList.clear();
        busArray.forEach((element) {
          bussesList.add(BusModel(data: element));
        });
        update();
        break;
      default:
        debugPrint(response.statusCode.toString());
        break;
    }
  }
}
