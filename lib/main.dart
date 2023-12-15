import 'package:apps/controller/auth_controller.dart';
import 'package:apps/controller/login_controller.dart';
import 'package:apps/controller/newtask_controller.dart';
import 'package:apps/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/cancelledController.dart';
import 'controller/compeletController.dart';
import 'controller/editprofilr_controller.dart';
import 'controller/forgetcontroller.dart';
import 'controller/pinvarificationController.dart';
import 'controller/progress_controller.dart';
import 'controller/reset_passcontroller.dart';
import 'controller/signup_controller.dart';

void main() {
  runApp(const Myapps());
}

class Myapps extends StatelessWidget {
  const Myapps({super.key});

  static GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorkey,
      debugShowCheckedModeBanner: false,
      home: const Splashscreen(),
      theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              )),
          textTheme: const TextTheme(
              titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
          primaryColor: Colors.green,
          primarySwatch: Colors.green,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10),
          ))),
      initialBinding: Getexbainding(),
    );
  }
}

class Getexbainding extends Bindings {
  @override
  void dependencies() {
    Get.put(Authcontroller());
    Get.put(Logincontroller());
    Get.put(Newtaskcontroller());
    Get.put(Progresscoltroller());
    Get.put(Cencelledcontroller());
    Get.put(Compeletcontroller());
    Get.put(Forgercontroller());
    Get.put(Pinvarificationcoltroller());
     Get.put(Resetpasscontrollerp());
     Get.put(Signupcontroller());
     Get.put(Editprofilecontroller());
  }
}
