import 'package:babydoo/services/controller/language_controller.dart';
import 'package:get/get.dart';

//BASE URL
const String baseUrl = 'https://babydo.gulfweb.ir/';
String apiRoute = 'api/V3/${Get.find<LanguageController>().lang.value}';
//routes
String userRegisterRoute = '$baseUrl$apiRoute/user/register';
String userLoginRoute = '$baseUrl$apiRoute/user/login';
String getSliderRoute = '$baseUrl$apiRoute/getSlider';
String getBusRoute = '$baseUrl$apiRoute/bus/list';
String getAddressesRoute = '$baseUrl$apiRoute/getAddresses';
String getBookingRoute = '$baseUrl$apiRoute/bookingList';
String getBookingNowRoute = '$baseUrl$apiRoute/bus/get_bookingNow';
String changePasswordRoute = '$baseUrl$apiRoute/user/changePassword';
String editProfileRoute = '$baseUrl$apiRoute/user/editPrifile';
String getAreasRoute = '$baseUrl$apiRoute/getAreas';

