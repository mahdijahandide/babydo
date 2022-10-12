class BusWeekleyScheduleModel {
  // {
  //                       "id": 302,
  //                       "bus_id": 22,
  //                       "day_of_week": 0,
  //                       "start_time": "15:00:00",
  //                       "end_time": "00:00:00",
  //                       "type": "main",
  //                       "created_at": "2021-09-28T23:00:41.000000Z",
  //                       "updated_at": "2021-09-28T23:00:41.000000Z"
  // }
  int? id, busId, dayOfWeek;
  String? startTime, endTime, type, createdAt, updatedAt;
  BusWeekleyScheduleModel({data}) {
    id = data['id'];
    busId = data['bus_id'];
    dayOfWeek = data['day_of_week'];
    startTime = data['start_time'];
    endTime = data['end_time'];
    type = data['type'];
    createdAt = data['created_at'];
    updatedAt = data['updated_at'];
  }
}
