import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:school_managment_app/src/controllers/auth_controller.dart';
import 'package:school_managment_app/src/ui/app.dart';
import 'package:school_managment_app/src/ui/auth/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put<AuthController>(AuthController());

  runApp(const SchoolManagementApp());
}
