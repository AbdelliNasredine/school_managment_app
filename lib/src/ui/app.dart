import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../routes.dart';
import 'landing.dart';

class SchoolManagementApp extends StatelessWidget {
  const SchoolManagementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      // home: LandingScreen(),
    );
  }
}
