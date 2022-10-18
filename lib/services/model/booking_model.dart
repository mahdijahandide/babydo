class BookingModel {
  //  {
  //               "id": 6213,
  //               "user_id": 1,
  //               "status": "completed",
  //               "unique_number": null,
  //               "total_price": "61",
  //               "phone": "12345678",
  //               "name": "hooman",
  //               "area": null,
  //               "block": "1",
  //               "street": "1",
  //               "avenue": "1",
  //               "additional_note": "1111",
  //               "building_number": "1",
  //               "created_at": "2022-10-12T10:36:44.000000Z",
  //               "updated_at": "2022-10-12T10:36:44.000000Z",
  //               "order_item": {
  //                   "id": 6210,
  //                   "order_id": 6213,
  //                   "bus_id": 22,
  //                   "bus_title": "Circus Bus",
  //                   "booking_type": "Fullday",
  //                   "date_reserved": "2022-06-06",
  //                   "start_time": "12:00:00",
  //                   "end_time": "14:00:00",
  //                   "price": "60",
  //                   "delivery_charge": 1,
  //                   "created_at": "2022-10-12T10:36:44.000000Z",
  //                   "updated_at": "2022-10-12T10:36:44.000000Z",
  //                   "bus": {
  //                       "id": 22,
  //                       "driver_id": 15,
  //                       "image": "resources/assets/medias/1633543406.4E96498F-B588-4701-9126-2B4EA70855CB.jpeg",
  //                       "tumbnailVideos": "resources/assets/medias/1633543406.00389F1E-E404-44D5-8A68-185F9085ED0B.jpeg",
  //                       "start_age": 1,
  //                       "end_age": 10,
  //                       "kids_count": 10,
  //                       "session_time": "1:30:00",
  //                       "session_price": "25",
  //                       "fullday_price": "60",
  //                       "weekend_session_price": "35",
  //                       "weekend_fullday_price": "80",
  //                       "edit_session_time": null,
  //                       "edit_date_session_time": "2021-10-03T21:00:00.000000Z",
  //                       "youtube_link": null,
  //                       "live_video_first": null,
  //                       "live_video_second": null,
  //                       "live_video_third": null,
  //                       "live_video_fourth": null,
  //                       "status": 1,
  //                       "created_at": "2021-09-28T23:00:41.000000Z",
  //                       "updated_at": "2022-10-12T07:42:22.000000Z",
  //                       "name": "باص السيرك",
  //                       "description": "يحتوي على ألعاب المتاهات و لوح التسلق و الزحلاقيات و الكور و السينما، العمر المناسب من 1 إلى 10 سنوات، عدد الأطفال 10 أطفال",
  //                   }
  //               }
  //           }
  int? id,
      userId,
      orderItemId,
      orderId,
      orderItemBusId,
      busId,
      driverId,
      startAge,
      endAge,
      kidsCount,
      status;
  String? bookingStatus,
      uniqueNumber,
      totalPrice,
      phone,
      name,
      area,
      block,
      street,
      avenue,
      additionalNote,
      buildingNumber,
      createdAt,
      updatedAt,
      busTitle,
      bookingType,
      dateReserved,
      startTime,
      endTime,
      price,
      deliveryCharge,
      orderCreatedAt,
      orderUpdatedAt,
      busImage,
      busThumbnailVideo,
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
      busCreatedAt,
      busUpdatedAt,
      busName,
      busDescription;
  BookingModel({data}) {
    id = data[id];
    userId = data['user_id'];
    status = data['status'];
    uniqueNumber = data['unique_number'];
    totalPrice = data['total_price'];
    phone = data['phone'];
    name = data['name'];
    area = data['area'];
    block = data['block'];
    street = data['street'];
    avenue = data['avenue'];
    additionalNote = data['additional_note'];
  }
}
