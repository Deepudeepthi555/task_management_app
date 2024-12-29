import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/module/task/controller/theme_controller.dart'; // Import ThemeController
import 'package:task_management/module/task/views/task_list_screen.dart'; // Import your screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the ThemeController instance
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() {
      // Observe the themeData and apply it to the MaterialApp
      return MaterialApp(
        title: 'Flutter Demo',
        theme: themeController.themeData.value, // Use the observed theme
        home: TaskListScreen(),
      );
    });
  }
}
