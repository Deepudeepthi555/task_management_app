import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/module/task/models/task_model.dart';

class TaskController extends GetxController {
  var tasksByCategory = <String, List<Task>>{
    'Work': [],
    'Personal': [],
    'Home & Family': [],
    'Projects': [],
  }.obs;

  // Method to get the description for each category
  String getCategoryDescription(String category) {
    switch (category) {
      case 'Work':
        return 'Tasks related to professional work.';
      case 'Personal':
        return 'Tasks related to personal life.';
      case 'Home & Family':
        return 'Tasks for home and family care.';
      case 'Projects':
        return 'Work-related projects and management.';
      default:
        return '';
    }
  }

  static const _tasksKey = 'tasks_key'; // SharedPreferences key for tasks

  @override
  void onInit() {
    super.onInit();
    loadTasksFromPreferences(); // Load tasks when the controller is initialized
  }

  void markTaskAsComplete(Task task) {
    List<Task>? tasks = tasksByCategory[task.category];

    if (tasks != null && tasks.isNotEmpty) {
      if (tasks.length == 1) {
        task.isCompleted = true;
      } else {
        tasks.remove(task);
        task.isCompleted = true;
        tasks.add(task);
      }

      // Rebuild the task list with completed tasks at the end
      tasksByCategory[task.category] = [
        ...tasks.where((task) => !task.isCompleted),
        ...tasks.where((task) => task.isCompleted),
      ];

      // Save updated tasks list
      saveTasksToPreferences();
      tasksByCategory.refresh();
    }
  }

  void deleteTask(Task task) {
    tasksByCategory[task.category]?.remove(task);
    saveTasksToPreferences();
    tasksByCategory.refresh();
  }

  void deleteTaskWithUndo(BuildContext context, Task task) {
    tasksByCategory[task.category]?.remove(task);
    tasksByCategory.refresh();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${task.title} deleted',
          style: TextStyle(fontSize: 18), // Make the text size bigger
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            tasksByCategory[task.category]?.add(task);
            tasksByCategory.refresh();
            saveTasksToPreferences();
          },
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        duration: Duration(seconds: 10),
      ),
    );

    saveTasksToPreferences();
  }

  void addTask(Task task) {
    List<Task>? tasks = tasksByCategory[task.category];
    if (tasks != null) {
      tasks.insert(0, task);
      tasksByCategory.refresh();
    }
    saveTasksToPreferences();
  }

  // Save tasks to SharedPreferences
  Future<void> saveTasksToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonData = {};
    tasksByCategory.forEach((category, tasks) {
      jsonData[category] = tasks.map((task) => task.toJson()).toList();
    });

    await prefs.setString(_tasksKey, json.encode(jsonData));
  }

  // Load tasks from SharedPreferences
  Future<void> loadTasksFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    // Load JSON data
    String? jsonString = prefs.getString(_tasksKey);
    if (jsonString != null) {
      Map<String, dynamic> jsonData = json.decode(jsonString);

      jsonData.forEach((category, tasks) {
        List<Task> taskList =
            (tasks as List).map((taskJson) => Task.fromJson(taskJson)).toList();

        taskList.sort((a, b) {
          if (a.isCompleted == b.isCompleted) return 0;
          return a.isCompleted ? 1 : -1;
        });

        tasksByCategory[category] = taskList;
      });

      tasksByCategory.refresh();
    }
  }
}
