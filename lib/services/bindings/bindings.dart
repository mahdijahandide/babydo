import 'package:babydoo/services/controller/address_controller.dart';
import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:babydoo/services/controller/booking_controller.dart';
import 'package:babydoo/services/controller/bus_controller.dart';
import 'package:babydoo/services/controller/home_controller.dart';
import 'package:babydoo/services/controller/language_controller.dart';
import 'package:babydoo/services/controller/profile_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookController());
    Get.lazyPut(() => LanguageController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => AddressController());
    Get.lazyPut(() => BusController());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => ProfileController());
  }
}
