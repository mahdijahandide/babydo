class BusFeatureModel {
  //                   {
  //                       "id": 17,
  //                       "bus_id": 22,
  //                       "feature_en": "Slides",
  //                       "feature_ar": "زحلاقيات",
  //                       "created_at": "2021-10-16T14:48:53.000000Z",
  //                       "updated_at": "2021-10-16T14:48:53.000000Z"
  //                   },
  int? id, busId;
  String? featureEn, featureAr, createdAt, updatedAt;
  BusFeatureModel({data}) {
    id = data['id'];
    busId = data['bus_id'];
    featureEn = data['feature_en'];
    featureAr = data['feature_ar'];
    createdAt = data['created_at'];
    updatedAt = data['updated_at'];
  }
}
