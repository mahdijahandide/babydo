class BusPriceModel {
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
  //                   }
  int? id, busId, dayOfWeek;
  String? intervalType, startTime, endTime, createdAt, updatedAt;
  double? price, weekendPrice;
  BusPriceModel({data}) {
    id = data['id'];
    busId = data['bus_id'];
    intervalType = data['interval_type'];
    dayOfWeek = data['day_of_week'];
    startTime = data['start_time'];
    endTime = data['end_time'];
    price = double.parse(data['price'].toString());
    weekendPrice = double.parse(data['weekend_price'].toString());
    createdAt = data['created_at'];
    updatedAt = data['updated_at'];
  }
}
