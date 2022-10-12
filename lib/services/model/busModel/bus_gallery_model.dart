import 'package:babydoo/services/remotes/api_routes.dart';

class BusGalleryModel {
  // {
  //                       "id": 199,
  //                       "bus_id": 22,
  //                       "type": "gallery",
  //                       "name": "3C997D9E-091F-4F53-B925-B57080FF9E76.jpeg",
  //                       "url": "resources/assets/medias/1633427715.3C997D9E-091F-4F53-B925-B57080FF9E76.jpeg",
  //                       "size": "23",
  //                       "extention": "jpeg",
  //                       "created_at": "2021-10-05T10:25:15.000000Z",
  //                       "updated_at": "2021-10-05T10:25:22.000000Z"
  //}
  int? id, busId;
  String? type, name, url, size, extention, createdAt, updatedAt;
  BusGalleryModel({data}) {
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
