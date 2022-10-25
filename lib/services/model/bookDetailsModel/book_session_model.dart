class BookSessionModel {
  //  {
  //                       "date": "2022-10-26",
  //                       "startTime": "15:00:00",
  //                       "endTime": "16:30:00",
  //                       "startTimeShow": "03:00 pm",
  //                       "endTimeShow": "04:30 pm",
  //                       "price": 35,
  //                       "weekend_price": 0
  //                   },
  String? date,
      startTime,
      endTime,
      startTimeShow,
      endTimeShow,
      price,
      weekendPrice;
  BookSessionModel({data}) {
    date = data['date'];
    startTime = data['startTime'];
    endTime = data['endTime'];
    startTimeShow = data['startTimeShow'];
    endTimeShow = data['endTimeShow'];
    price = data['price'].toString();
    weekendPrice = data['weekend_price'].toString();
  }
}
