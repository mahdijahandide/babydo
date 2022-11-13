class AddressDataModel {
  String? block,
      street,
      avenue,
      areaId,
      areaName,
      lat,
      lng,
      houseNumber,
      specialNote;
  AddressDataModel(
    mBlock,
    mStreet,
    mAvenue,
    mAreaId,
    mAreaName,
    mLat,
    mLng,
    mHouseNumber,
    mSpecialNote,
  ) {
    block = mBlock.toString();
    street = mStreet.toString();
    avenue = mAvenue.toString();
    areaId = mAreaId.toString();
    areaName = mAreaName.toString();
    lat = mLat.toString();
    lng = mLng.toString();
    houseNumber = mHouseNumber.toString();
    specialNote = mSpecialNote.toString();
  }
}
