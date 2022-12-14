import 'package:babydoo/services/controller/auth_controller.dart';
import 'package:babydoo/services/controller/home_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/drawer/drawer.dart';
import 'package:babydoo/view/screens/bus/live_streaming.dart';
import 'package:babydoo/view/screens/home/home_screen.dart';
import 'package:babydoo/view/screens/menu/menu_screen.dart';
import 'package:babydoo/view/screens/profile/profile_screen.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../services/enums/enums.dart';
import '../auth/auth_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var _selectedTab = SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = SelectedTab.values[i];
      print(_selectedTab.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(()=>HomeController());
    Get.put(AuthController());
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: Get.find<HomeController>().drawerKey,
        extendBody: true,
        endDrawer: Drawer(
            child: Get.find<AuthController>().user['user_type'] == 'guest'
                ? DrawerWidgets().createGuestDrawer(context)
                : DrawerWidgets().createUserDrawer(context)),
        body: Stack(
          children: [
            SvgPicture.asset(
              'assets/svg/bg.svg',
              fit: BoxFit.fill,
              width: Get.width,
            ),
            _selectedTab.name == 'home'
                ? const HomeScreen()
                : _selectedTab.name == 'bus'
                    ? Get.find<AuthController>().user['user_type'] == 'guest'? Padding(
                      padding:const EdgeInsets.only(bottom: 50),
                      child: AuthScreen(isOrange: false),
                    ): const LiveStreaming()
                    : _selectedTab.name == 'profile'
                        ?Get.find<AuthController>().user['user_type'] == 'guest'? Padding(
                          padding:const  EdgeInsets.only(bottom: 50),
                          child: AuthScreen(isOrange: true),
                        ): const ProfileScreen()
                        : const MenuScreen(),
          ],
        ),
        bottomNavigationBar: Directionality(
          textDirection: TextDirection.ltr,
          child: DotNavigationBar(
            currentIndex: SelectedTab.values.indexOf(_selectedTab),
            marginR: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            borderRadius: 15,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  offset: const Offset(1, 1),
                  spreadRadius: 1,
                  blurRadius: 5)
            ],
            onTap: _handleIndexChanged,
            items: [
              DotNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/home.svg',
                  color: _selectedTab.name == 'home'
                      ? AppColors().yellow
                      : Colors.black,alignment: Alignment.center,
                ),
                selectedColor: AppColors().yellow,
              ),
              DotNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/bus.svg',
                  color: _selectedTab.name == 'bus'
                      ? AppColors().yellow
                      : Colors.black,alignment: Alignment.center,
                ),
                selectedColor: AppColors().yellow,
              ),
              DotNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/profile.svg',
                  color: _selectedTab.name == 'profile'
                      ? AppColors().yellow
                      : Colors.black,alignment: Alignment.center,
                ),
                selectedColor: AppColors().yellow,
              ),
              DotNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/more.svg',
                  color: _selectedTab.name == 'menu'
                      ? AppColors().yellow
                      : Colors.black,alignment: Alignment.center,
                ),
                selectedColor: AppColors().yellow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
