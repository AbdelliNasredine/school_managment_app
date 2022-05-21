import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment_app/src/ui/auth/login_screen.dart';
import 'package:school_managment_app/src/ui/home_screen.dart';
import 'package:school_managment_app/src/ui/landing.dart';
import 'package:school_managment_app/src/ui/messages_screen.dart';

import 'ui/children_screen.dart';

class AppPages {
  static get pages => [
        GetPage(
          name: '/',
          page: () => LandingScreen(),
        ),
        GetPage(
          name: "/login",
          page: () => LoginScreen(),
          fullscreenDialog: true,
        ),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
        ),
        GetPage(
          name: '/messages',
          page: () => MessageScreen(),
        ),
        GetPage(
          name: '/children',
          page: () => ChildrenScreen(),
        ),
      ];
}
