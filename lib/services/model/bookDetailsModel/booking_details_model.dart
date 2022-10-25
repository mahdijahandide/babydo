import 'package:babydoo/services/model/bookDetailsModel/book_full_time_model.dart';
import 'package:babydoo/services/model/bookDetailsModel/book_session_model.dart';
import 'package:get/get.dart';

class BookingDetailsModel {
  // {
  //               "sessions": [
  //                   {
  //                       "date": "2022-10-26",
  //                       "startTime": "15:00:00",
  //                       "endTime": "16:30:00",
  //                       "startTimeShow": "03:00 pm",
  //                       "endTimeShow": "04:30 pm",
  //                       "price": 35,
  //                       "weekend_price": 0
  //                   },
  //               ],
  //               "fullday": [
  //                   {
  //                       "date": "2022-10-26",
  //                       "startTime": "15:00:00",
  //                       "endTime": "19:00:00",
  //                       "startTimeShow": "03:00 pm",
  //                       "endTimeShow": "07:00 pm",
  //                       "price": 70,
  //                       "weekend_price": 0
  //                   },
  //               ],
  //               "dayData": {
  //                   "id": 304,
  //                   "bus_id": 22,
  //                   "day_of_week": 2,
  //                   "start_time": "15:00:00",
  //                   "end_time": "00:00:00",
  //                   "type": "main",
  //                   "created_at": "2021-09-28T23:00:41.000000Z",
  //                   "updated_at": "2021-09-28T23:00:41.000000Z",
  //                   "week_day_name": "Wednesday",
  //                   "date": "2022-10-26"
  //               },
  //               "is_available": 1,
  //               "available_status": 0,
  //               "available_type": "S"
  //           },
  var dayData;
  var sessionArray;
  var fulldayArray;
  RxList<BookSessionModel> sessionList = RxList([]);
  RxList<BookFullTimeModel> fullBookingList = RxList([]);
  int? isAvailable, availableStatus, dayDataId, busId, weekDayNum;
  String? availableType,
      startTime,
      endTime,
      type,
      createdAt,
      updatedAt,
      weekDayName,
      date;
  BookingDetailsModel({data}) {
    sessionArray = data['sessions'];
    fulldayArray = data['fullday'];
    dayData = data['dayData'];
    dayDataId = dayData['id'];
    busId = dayData['bus_id'];
    weekDayNum = dayData['day_of_week'];
    startTime = dayData['start_time'];
    endTime = dayData['end_time'];
    type = dayData['type'];
    createdAt = dayData['created_at'];
    updatedAt = dayData['updated_at'];
    weekDayName = dayData['week_day_name'];
    date = dayData['date'];
    isAvailable = data['is_available'];
    availableStatus = data['available_status'];
    availableType = data['available_type'];
    sessionArray.forEach((element) {
      sessionList.add(BookSessionModel(data: element));
    });
    fulldayArray.forEach((element) {
      fullBookingList.add(BookFullTimeModel(data: element));
    });
  }
}
