import 'dart:io';

import 'package:babydoo/services/bindings/bindings.dart';
import 'package:babydoo/services/controller/language_controller.dart';
import 'package:babydoo/services/internationalization/messages.dart';
import 'package:babydoo/services/remotes/http_config.dart';
import 'package:babydoo/services/utils/app_statusbar.dart';
import 'package:babydoo/view/screens/about/about_us.dart';
import 'package:babydoo/view/screens/about/contact_us_screen.dart';
import 'package:babydoo/view/screens/address/address_book.dart';
import 'package:babydoo/view/screens/address/create_address.dart';
import 'package:babydoo/view/screens/address/update_address_screen.dart';
import 'package:babydoo/view/screens/auth/auth_screen.dart';
import 'package:babydoo/view/screens/auth/change_password.dart';
import 'package:babydoo/view/screens/auth/forgot_password.dart';
import 'package:babydoo/view/screens/auth/otp_screen.dart';
import 'package:babydoo/view/screens/booking/booking.dart';
import 'package:babydoo/view/screens/booking/my_booking.dart';
import 'package:babydoo/view/screens/bus/live_streaming.dart';
import 'package:babydoo/view/screens/home/dashboard.dart';
import 'package:babydoo/view/screens/language/languages.dart';
import 'package:babydoo/view/screens/profile/edit_profile_screen.dart';
import 'package:babydoo/view/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';

import 'view/screens/auth/reset_password.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  AppStatusbar().statusbarColor(color: Colors.transparent);
  runApp(
    Phoenix(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(LanguageController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Babydo',
      translations: Messages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(primarySwatch: Colors.yellow, fontFamily: 'Poppins'),
      defaultTransition: Transition.cupertino,
      getPages: [
        GetPage(name: '/splash', page: () => const Splash()),
        GetPage(name: '/languages', page: () => const Languages()),
        GetPage(name: '/auth', page: () => const AuthScreen()),
        GetPage(name: '/otp', page: () => const OtpScreen()),
        GetPage(name: '/home', page: () => const DashboardScreen()),
        GetPage(name: '/booking', page: () => const Booking()),
        GetPage(name: '/addressBook', page: () => const AddressBook()),
        GetPage(name: '/addAddress', page: () => const AddAddressScreen()),
        GetPage(
            name: '/updateAddress', page: () => const UpdateAddressScreen()),
        GetPage(name: '/myBooking', page: () => const MyBooking()),
        GetPage(name: '/editProfile', page: () => const EditProfileScreen()),
        GetPage(name: '/liveStreaming', page: () => const LiveStreaming()),
        GetPage(name: '/contactUs', page: () => const ContactUsScreen()),
        GetPage(name: '/aboutUs', page: () => const AboutUsScreen()),
        GetPage(
            name: '/forgotPassword', page: () => const ForgotPasswordScreen()),
        GetPage(
            name: '/reset_password', page: () => const ResetPasswordScreen()),
        GetPage(
            name: '/changePassword', page: () => const ChangePasswordScreen()),
      ],
      initialRoute: '/splash',
      initialBinding: AppBindings(),
      unknownRoute:
          GetPage(name: '/nothingFound', page: () => const Languages()),
    );
  }
}
