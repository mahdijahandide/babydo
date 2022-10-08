import 'package:babydoo/services/remotes/api_routes.dart';

class SliderModel {

  /*{
  "id": 191,
  "bus_id": null,
  "type": "slider",
  "name": "12546B68-CDA9-4F97-81ED-EE93A49711CD.jpeg",
  "url": "resources/assets/medias/1633278345.12546B68-CDA9-4F97-81ED-EE93A49711CD.jpeg",
  "size": "23",
  "extention": "jpeg",
  "created_at": "2021-10-03T16:55:45.000000Z",
  "updated_at": "2021-10-03T16:55:45.000000Z"
  }*/

  String?id;
  String?type;
  String?name;
  String?url;
  String?size;
  String?extension;

  SliderModel({data}) {
    id=data['id'].toString();
    type=data['type'].toString();
    name=data['name'].toString();
    url=baseUrl+ data['url'].toString();
    size=data['size'].toString();
    extension=data['extention'].toString();
  }
}
