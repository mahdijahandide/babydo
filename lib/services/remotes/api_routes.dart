//BASE URL
// const String baseUrl = 'https://babydo.gulfweb.ir/';
const String baseUrl = 'https://test2.babydobus.com/';
String apiRoute = 'api/V3';
//routes

String getBusRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/bus/list';

String userRegisterRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/user/register';
String guestRegisterRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/user/registerGuest';
String userLoginRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/user/login';
String getOtpRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/user/sendSms';
String contactUsRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/user/contactUs';
String aboutUsRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/about_us';
String forgetPasswordRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/user/forgetPassword';
String getSliderRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/getSlider';
String getAddressesRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/getAddresses';
String createAddressRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/address/store';
String updateAddressRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/address/update';
String deleteAddressRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/address/destroy';
String getBookingRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/bookingList';
String getBookingNowRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/bus/get_bookingNow';
String changePasswordRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/user/changePassword';
String editProfileRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/user/editPrifile';
String getAreasRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/getAreas';
String bookPaymentRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/payment';
String termsAndConditionRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/terms_and_conditions';
String getCameraRoute({required String lang}) =>
    '$baseUrl$apiRoute/$lang/bus/camera';