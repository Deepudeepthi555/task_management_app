import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:task_management/module/task/controller/task_controller.dart';
import 'package:task_management/module/task/controller/theme_controller.dart';
import 'package:task_management/module/task/models/task_model.dart';
import 'package:task_management/module/task/views/add_task_page.dart';
import 'package:task_management/module/task/views/task_list_tile.dart';

class TaskListScreen extends StatelessWidget {
  final taskController = Get.put(TaskController());
  final themeController = Get.put(ThemeController());

  TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskIt'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTaskPage(),
                ),
              );
            },
            icon: const Icon(Icons.add_task),
          ),
          IconButton(
            onPressed: () {
              themeController.toggleTheme();
            },
            icon: const Icon(Icons.brightness_6),
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: taskController.tasksByCategory.keys.length,
          itemBuilder: (context, categoryIndex) {
            String category =
                taskController.tasksByCategory.keys.toList()[categoryIndex];
            List<Task> tasks = taskController.tasksByCategory[category] ?? [];
            String description =
                taskController.getCategoryDescription(category);
            double completedTasks =
                tasks.where((task) => task.isCompleted).length.toDouble();
            double totalTasks = tasks.length.toDouble();
            double completionPercentage =
                totalTasks == 0 ? 0 : completedTasks / totalTasks;

            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                clipBehavior: Clip.antiAlias,
                child: ExpansionTile(
                  subtitle: Text(
                    description,
                    style: themeController.themeData.value.textTheme.bodySmall,
                  ),
                  key: PageStorageKey<String>(category),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: themeController
                            .themeData.value.textTheme.titleMedium,
                      ),
                    ],
                  ),
                  showTrailingIcon: tasks.isNotEmpty,
                  trailing: CircularPercentIndicator(
                    radius: 18,
                    lineWidth: 4.0,
                    percent: completionPercentage,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.purple,
                    center: Text(
                        '${(completionPercentage * 100).toStringAsFixed(0)}%', // Percentage
                        style: TextStyle(fontSize: 9)),
                    animation: true,
                    animationDuration: 1000,
                  ),
                  children: List.generate(tasks.length, (index) {
                    final task = tasks[index];
                    return Column(
                      children: [
                        TaskTile(
                          task: task,
                          onMarkComplete: () =>
                              taskController.markTaskAsComplete(task),
                          onDelete: () =>
                              taskController.deleteTaskWithUndo(context, task),
                        ),
                        if (index < tasks.length - 1)
                          Divider(
                            endIndent: 8,
                            indent: 8,
                          ),
                      ],
                    );
                  }),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
