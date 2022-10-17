// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:babydoo/services/model/busModel/bus_feature_model.dart';
import 'package:babydoo/services/model/busModel/bus_gallery_model.dart';
import 'package:babydoo/services/model/busModel/bus_price_model.dart';
import 'package:babydoo/services/model/busModel/bus_video_gallery_model.dart';
import 'package:babydoo/services/model/busModel/bus_weekley_schedule_model.dart';
import 'package:babydoo/services/remotes/api_routes.dart';
import 'package:get/get.dart';

class BusModel {
  // {
  //               "id": 22,
  //               "driver_id": 15,
  //               "image": "resources/assets/medias/1633543406.4E96498F-B588-4701-9126-2B4EA70855CB.jpeg",
  //               "tumbnailVideos": "resources/assets/medias/1633543406.00389F1E-E404-44D5-8A68-185F9085ED0B.jpeg",
  //               "start_age": 1,
  //               "end_age": 10,
  //               "kids_count": 10,
  //               "session_time": "1:30:00",
  //               "session_price": "25",
  //               "fullday_price": "60",
  //               "weekend_session_price": "35",
  //               "weekend_fullday_price": "80",
  //               "edit_session_time": null,
  //               "edit_date_session_time": "2021-10-03T21:00:00.000000Z",
  //               "youtube_link": null,
  //               "live_video_first": null,
  //               "live_video_second": null,
  //               "live_video_third": null,
  //               "live_video_fourth": null,
  //               "status": 1,
  //               "created_at": "2021-09-28T23:00:41.000000Z",
  //               "updated_at": "2022-10-12T07:42:22.000000Z",
  //               "name": "Circus Bus",
  //               "description": "It includes soft playground with mazes, climbing stairs, double slide, soft balls and cinema. Age recommended between 1 and 10 years. Number of kids allowed 10 max.",
  //               "gallery": [
  //                   {
  //                       "id": 199,
  //                       "bus_id": 22,
  //                       "type": "gallery",
  //                       "name": "3C997D9E-091F-4F53-B925-B57080FF9E76.jpeg",
  //                       "url": "resources/assets/medias/1633427715.3C997D9E-091F-4F53-B925-B57080FF9E76.jpeg",
  //                       "size": "23",
  //                       "extention": "jpeg",
  //                       "created_at": "2021-10-05T10:25:15.000000Z",
  //                       "updated_at": "2021-10-05T10:25:22.000000Z"
  //                   },
  //               ],
  //               "video_gallery": [
  //                   {
  //                       "id": 236,
  //                       "bus_id": 22,
  //                       "type": "video_gallery",
  //                       "name": "IMG_1487.MP4",
  //                       "url": "resources/assets/medias/1633437585.IMG_1487.MP4",
  //                       "size": "23",
  //                       "extention": "MP4",
  //                       "created_at": "2021-10-05T13:09:45.000000Z",
  //                       "updated_at": "2021-10-05T13:09:50.000000Z"
  //                   }
  //               ],
  //               "weekly_schedule": [
  //                   {
  //                       "id": 302,
  //                       "bus_id": 22,
  //                       "day_of_week": 0,
  //                       "start_time": "15:00:00",
  //                       "end_time": "00:00:00",
  //                       "type": "main",
  //                       "created_at": "2021-09-28T23:00:41.000000Z",
  //                       "updated_at": "2021-09-28T23:00:41.000000Z"
  //                   },
  //               ],
  //               "price": [
  //                   {
  //                       "id": 40,
  //                       "bus_id": 22,
  //                       "interval_type": "session",
  //                       "day_of_week": 6,
  //                       "start_time": "10:00:00",
  //                       "end_time": "11:30:00",
  //                       "price": 40,
  //                       "weekend_price": 0,
  //                       "created_at": "2021-09-29T10:37:02.000000Z",
  //                       "updated_at": "2021-09-29T10:37:02.000000Z"
  //                   },
  //               ],
  //               "feature": [
  //                   {
  //                       "id": 17,
  //                       "bus_id": 22,
  //                       "feature_en": "Slides",
  //                       "feature_ar": "زحلاقيات",
  //                       "created_at": "2021-10-16T14:48:53.000000Z",
  //                       "updated_at": "2021-10-16T14:48:53.000000Z"
  //                   },
  //               ],
  //           },
  int? id, driverId, startAge, endAge, kidsCount, status;
  RxString imgBg=''.obs;
  String? image,
      thumbnailVideo,
      sessionTime,
      sessionPrice,
      fulldayPrice,
      weekendSessionPrice,
      weekendFulldayPrice,
      editSessionTime,
      editDateSessionTime,
      youtubeLink,
      liveVideoFirst,
      liveVideoSecond,
      liveVideoThird,
      liveVideoFourth,
      createdAt,
      updatedAt,
      name,
      description;
  var galleryArray;
  var videoGalleryArray;
  var weekleyScheduleArray;
  var priceArray;
  var featureArray;
  List<BusGalleryModel> galleryList = [];
  List<BusVideoGalleryModel> videoGalleryList = [];
  List<BusWeekleyScheduleModel> weekleyScheduleList = [];
  List<BusPriceModel> priceList = [];
  List<BusFeatureModel> featureList = [];
  BusModel({data}) {
    id = data['id'];
    driverId = data['driver_id'];
    image = baseUrl + data['image'];
    thumbnailVideo = baseUrl + data['tumbnailVideos'];
    startAge = data['start_age'];
    endAge = data['end_age'];
    kidsCount = data['kids_count'];
    sessionTime = data['session_time'];
    sessionPrice = data['session_price'];
    fulldayPrice = data['fullday_price'];
    weekendSessionPrice = data['weekend_session_price'];
    weekendFulldayPrice = data['weekend_fullday_price'];
    editSessionTime = data['edit_session_time'];
    editDateSessionTime = data['edit_date_session_time'];
    youtubeLink = data['youtube_link'];
    liveVideoFirst = data['live_video_first'];
    liveVideoSecond = data['live_video_second'];
    liveVideoThird = data['live_video_third'];
    liveVideoFourth = data['live_video_fourth'];
    status = data['status'];
    createdAt = data['created_at'];
    updatedAt = data['updated_at'];
    name = data['name'];
    description = data['description'];
    galleryArray = data['gallery'];
    videoGalleryArray = data['video_gallery'];
    weekleyScheduleArray = data['weekly_schedule'];
    priceArray = data['price'];
    featureArray = data['feature'];
    imgBg.value = baseUrl + galleryArray[0]['url'];

    galleryArray.forEach((element) {
      galleryList.add(BusGalleryModel(data: element));
    });
    videoGalleryArray.forEach((element) {
      videoGalleryList.add(BusVideoGalleryModel(data: element));
    });
    weekleyScheduleArray.forEach((element) {
      weekleyScheduleList.add(BusWeekleyScheduleModel(data: element));
    });
    priceArray.forEach((element) {
      priceList.add(BusPriceModel(data: element));
    });
    featureArray.forEach((element) {
      featureList.add(BusFeatureModel(data: element));
    });
  }
}
