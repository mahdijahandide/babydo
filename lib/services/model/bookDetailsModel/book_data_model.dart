class BookDataModel {
  String? busId,
      dateReserved,
      startTime,
      endTime,
      selectedTime,
      name,
      phoneNumber,
      block,
      street,
      avenue,
      areaId,
      areaName,
      lat,
      lng,
      houseNumber,
      specialNote,
      packageType,
      bookPrice,
      deliveryCharge;
  BookDataModel(
      mBusId,
      mDateReserved,
      mStartTime,
      mEndTime,
      mSelectedTime,
      mName,
      mPhoneNumber,
      mBlock,
      mStreet,
      mAvenue,
      mAreaId,
      mAreaName,
      mLat,
      mLng,
      mHouseNumber,
      mSpecialNote,
      mPackageType,
      mBookPrice,
      mDeliveryCharge) {
    busId = mBusId.toString();
    dateReserved = mDateReserved.toString();
    startTime = mStartTime.toString();
    endTime = mEndTime.toString();
    selectedTime = mSelectedTime.toString();
    name = mName.toString();
    phoneNumber = mPhoneNumber.toString();
    block = mBlock.toString();
    street = mStreet.toString();
    avenue = mAvenue.toString();
    areaId = mAreaId.toString();
    areaName = mAreaName.toString();
    lat = mLat.toString();
    lng = mLng.toString();
    houseNumber = mHouseNumber.toString();
    specialNote = mSpecialNote.toString();
    packageType = mPackageType.toString();
    bookPrice = mBookPrice.toString();
    deliveryCharge = mDeliveryCharge.toString();
  }
}
