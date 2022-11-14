import 'package:babydoo/services/model/busModel/bus_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
import '../../view/screens/home/widgets/carusel.dart';
import '../../view/widgets/snackbar/snackbar.dart';
import '../model/slider_model.dart';
import '../remotes/requests.dart';
import '../utils/app_colors.dart';

class HomeController extends GetxController {
  RxInt caruselIndex = 0.obs;

  ScrollController mainScrollController = ScrollController();
  ScrollController insederScrollController = ScrollController();
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

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
        if (jsonObject['status'].toString() == '200') {
          var slidersArray = jsonObject['data']['sliders'];
          imgList.clear();
          slidersArray.forEach((element) {
            imgList.add(SliderModel(data: element));
          });
        } else {
          Snack().createSnack(
              title: 'warning',
              msg: jsonObject['message'].toString(),
              icon: Icon(
                Icons.warning,
                color: AppColors().maroon,
              ));
        }
        break;
      default:
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

  handleBusRequest() async {
    final response = await Request.getBusRequest();
    switch (response.statusCode) {
      case 200:
        var jsonObject = convert.jsonDecode(response.body);
        if (jsonObject['status'].toString() == '200') {
          var busArray = jsonObject['data']['buses'];
          bussesList.clear();
          busArray.forEach((element) {
            bussesList.add(BusModel(data: element));
          });
          update();
        } else {
          Snack().createSnack(
              title: 'warning',
              msg: jsonObject['message'].toString(),
              icon: Icon(
                Icons.warning,
                color: AppColors().maroon,
              ));
        }
        break;
      default:
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
