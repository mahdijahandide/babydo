import 'dart:io';

import 'package:babydoo/services/bindings/bindings.dart';
import 'package:babydoo/services/controller/auth_controller.dart';
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
import 'package:babydoo/view/screens/webview/payment_webview.dart';
import 'package:background_mode_new/background_mode_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'view/screens/auth/reset_password.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

// Please place this code in main.dart,
// After the import statements, and outside any Widget class (top-level)

@pragma('vm:entry-point')
void backgroundNotificationListener(Map<String, dynamic> data) {
  // Print notification payload data
  print('Received notification: $data');

  // Notification title
  String notificationTitle = 'Babydo Bus';

  // Attempt to extract the "message" property from the payload: {"message":"Hello World!"}
  String notificationText = data['message'] ?? 'Hello World!';
  Pushy.setNotificationIcon('ic_notification');

  // Android: Displays a system notification
  // iOS: Displays an alert dialog
  Pushy.notify(notificationTitle, notificationText, data);

  // Clear iOS app badge number
  Pushy.clearBadge();

}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  // Pushy.listen();
  AppStatusbar().statusbarColor(color: Colors.transparent);
  await GetStorage.init();

  runApp(
    Phoenix(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Pushy.listen();
    BackgroundMode.start();
    // Enable in-app notification banners (iOS 10+)
    Pushy.toggleInAppBanner(true);

    // Listen for push notifications received
    Pushy.setNotificationListener(backgroundNotificationListener);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(LanguageController());
    Get.put(AuthController());
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
        GetPage(name: '/auth', page: () =>  AuthScreen(isOrange: false,)),
        GetPage(name: '/otp', page: () => const OtpScreen()),
        GetPage(name: '/home', page: () => const DashboardScreen()),
        GetPage(name: '/booking', page: () =>  Booking()),
        GetPage(name: '/payment', page: () => const PaymentWebview()),
        GetPage(name: '/addressBook', page: () => const AddressBook()),
        GetPage(name: '/addAddress', page: () => const AddAddressScreen()),
        GetPage(name: '/updateAddress', page: () => const UpdateAddressScreen()),
        GetPage(name: '/myBooking', page: () => const MyBooking()),
        GetPage(name: '/editProfile', page: () => const EditProfileScreen()),
        GetPage(name: '/liveStreaming', page: () => const LiveStreaming()),
        GetPage(name: '/contactUs', page: () => const ContactUsScreen()),
        GetPage(name: '/aboutUs', page: () => const AboutUsScreen()),
        GetPage(name: '/forgotPassword', page: () => const ForgotPasswordScreen()),
        GetPage(name: '/reset_password', page: () => const ResetPasswordScreen()),
        GetPage(name: '/changePassword', page: () => const ChangePasswordScreen()),
      ],
      initialRoute: '/splash',
      initialBinding: AppBindings(),
      // unknownRoute:
      //     GetPage(name: '/nothingFound', page: () => const Languages()),
    );
  }
}
