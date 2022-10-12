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

  ChewieController? chewieController;

  final Carusel carusel = const Carusel();

  RxList<SliderModel> imgList = RxList([]);

  List<BusModel> busses=[];

  @override
  void onInit() async {
    super.onInit();
    final videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');

    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
    );
   handleSlider();
  }

  handleSlider() async {
      final response = await Request.getSliderRequest();
      switch (response.statusCode) {
        case 200:
          var jsonObject=convert.jsonDecode(response.body);
          var slidersArray=jsonObject['data']['sliders'];
          slidersArray.forEach((element){
            imgList.add(SliderModel(data: element));
          });
          break;
        default:
          print(response.statusCode);
          break;
      }
  }
}
