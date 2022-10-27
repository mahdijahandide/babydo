class AreaModel {
  // {
  //               "id": 5,
  //               "city_id": 7,
  //               "name": "Sabah Al-Ahmad City",
  //               "delivery_charge": 3,
  //               "type": "fullday",
  //               "created_at": "2020-11-16T03:25:25.000000Z",
  //               "updated_at": "2021-10-03T20:01:35.000000Z"
  //           },
  int? id, cityId;
  String? name, deliveryCharge, type, createdAt, updatedAt;
  AreaModel({data}) {
    id = data['id'];
    cityId = data['city_id'];
    name = data['name'];
    deliveryCharge = data['delivery_charge'].toString();
    type = data['type'];
    createdAt = data['created_at'];
    updatedAt = data['updated_at'];
  }
}
