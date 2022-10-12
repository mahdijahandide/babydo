import 'package:babydoo/services/remotes/api_routes.dart';

class BusVideoGalleryModel {
  //  {
  //                       "id": 236,
  //                       "bus_id": 22,
  //                       "type": "video_gallery",
  //                       "name": "IMG_1487.MP4",
  //                       "url": "resources/assets/medias/1633437585.IMG_1487.MP4",
  //                       "size": "23",
  //                       "extention": "MP4",
  //                       "created_at": "2021-10-05T13:09:45.000000Z",
  //                       "updated_at": "2021-10-05T13:09:50.000000Z"
  //  }
  int? id, busId;
  String? type, name, url, size, extention, createdAt, updatedAt;
  BusVideoGalleryModel({data}) {
    id = data['id'];
    busId = data['bus_id'];
    type = data['type'];
    name = data['name'];
    url = baseUrl + data['url'];
    size = data['size'];
    extention = data['extention'];
    createdAt = data['created_at'];
    updatedAt = data['updated_at'];
  }
}
