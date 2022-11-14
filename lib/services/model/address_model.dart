import 'package:babydoo/services/model/area_model.dart';
import 'dart:convert' as convert;

import 'package:get/get.dart';

class AddressModel {
  // {
  //           "id": 172,
  //           "user_id": 1,
  //           "area_id": "2",
  //           "block": "block 1",
  //           "street": "street 1",
  //           "Avenue": "Avenue `1",
  //           "latitude": 12.444444000000000727368387742899358272552490234375,
  //           "longitude": 20.222222200000000924546839087270200252532958984375,
  //           "house_number": "12",
  //           "special_note": "description",
  //           "primary_address": 0,
  //           "created_at": "2022-10-12T07:45:05.000000Z",
  //           "updated_at": "2022-10-12T07:45:05.000000Z",
  //           "area": null
  //       }
  int? id, userId, primaryAddress;
  String? areaId,
      block,
      street,
      avenue,
      houseNumber,
      specialNote,
      createdAt,
      updatedAt,
      area;
  AreaModel? areaObj;
  double? lat, lng;
  AddressModel({data}) {
    id = data['id'];
    userId = data['user_id'];
    areaId = data['area_id'];
    block = data['block'];
    street = data['street'];
    avenue = data['Avenue'];
    lat = data['latitude'];
    lng = data['longitude'];
    houseNumber = data['house_number'];
    specialNote = data['special_note'];
    primaryAddress = data['primary_address'];
    createdAt = data['created_at'];
    updatedAt = data['updated_at'];

    areaObj = AreaModel(data: data['area']);
    area = areaObj!.name.toString();
  }
}
