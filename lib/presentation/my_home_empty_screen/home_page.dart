import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mineclaim/globals.dart';
import 'package:mineclaim/presentation/my_home_empty_screen/empty_mines.dart';
import 'package:mineclaim/presentation/notification_screen/notification_screen.dart';

import 'package:mineclaim/presentation/settings_screen/settings_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';


import '../../my_personal_mines/MyPersonalMines.dart';
import '../confirm_request_screen/confirm_request_screen.dart';

import '../mine_gallery_screen/mine_gallery_screen.dart';
import '../new_request_page/mine_transfer_request.dart';
import '../new_request_page/request_home.dart';
import '../owned_mines_screen/owned_mines_screen.dart';


class MineclaimHome extends StatefulWidget {
   MineclaimHome({Key? key}) : super(key: key);

  @override
  State<MineclaimHome> createState() => _MineclaimHomeState();
}

class _MineclaimHomeState extends State<MineclaimHome> {


  PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: globalEmail == "ministry@gmail.com" ?  _buildScreens():_buildMinersScreens() ,
        items: globalEmail == "ministry@gmail.com" ? _navBarsItems() : _minersNavBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      // MineGallery(),
      OwnedMines(),

      NotificationScreen(),
      SettingsScreen(),


    ];
  }

  List<Widget> _buildMinersScreens() {
    return [
      // ViZ4jOHjZPQYMXq2y2BK7kzvbhf2
      OwnedMines(),
      MyPersonalMines(),

      NotificationScreen(),
      SettingsScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _minersNavBarsItems() {
    return [

      PersistentBottomNavBarItem(
        icon: Image.asset("assets/app_icons/home_final.png"),
        // title: ("Mine Collection"),
        activeColorPrimary: Color(0xFF152A47),
        inactiveColorPrimary: Color(0xFF152A47),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.collections),
        title: ("Mine Gallery"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        // icon: Icon(Icons.notifications),
        icon: Image.asset("assets/app_icons/notificationf.png"),
        // title: ("Notifications"),
        activeColorPrimary: Color(0xFF152A47),
        inactiveColorPrimary: Color(0xFF152A47),
      ),
      PersistentBottomNavBarItem(
        // icon: Icon(Icons.settings),
        icon: Image.asset("assets/app_icons/setting.png"),
        // title: ("Settings"),
        activeColorPrimary: Color(0xFF152A47),
        inactiveColorPrimary: Color(0xFF152A47),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      // PersistentBottomNavBarItem(
      //   icon: Icon(Icons.collections),
      //   title: ("Mine Gallery"),
      //   activeColorPrimary: CupertinoColors.activeBlue,
      //   inactiveColorPrimary: CupertinoColors.systemGrey,
      // ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/app_icons/home_final.png"),
        // title: ("Mine Collection"),
        activeColorPrimary: Color(0xFF152A47),
        inactiveColorPrimary: Color(0xFF152A47),
      ),

      PersistentBottomNavBarItem(
        // icon: Icon(Icons.notifications),
        icon: Image.asset("assets/app_icons/notificationf.png"),
        // title: ("Notifications"),
        activeColorPrimary: Color(0xFF152A47),
        inactiveColorPrimary: Color(0xFF152A47),
      ),
      PersistentBottomNavBarItem(
        // icon: Icon(Icons.settings),
        icon: Image.asset("assets/app_icons/setting.png"),
        // title: ("Settings"),
        activeColorPrimary: Color(0xFF152A47),
        inactiveColorPrimary: Color(0xFF152A47),
      ),
    ];
  }
}