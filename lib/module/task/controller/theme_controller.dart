import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  Rx<ThemeData> themeData = ThemeData.light().obs;
  void toggleTheme() {
    if (themeData.value == ThemeData.dark()) {
      themeData.value = ThemeData.light();
    } else {
      themeData.value = ThemeData.dark();
    }
  }
}
