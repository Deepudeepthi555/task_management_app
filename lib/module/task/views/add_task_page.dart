import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/module/task/controller/task_controller.dart';
import 'package:task_management/module/task/controller/theme_controller.dart';
import 'package:task_management/module/task/models/task_model.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  AddTaskPageState createState() => AddTaskPageState();
}

class AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final themeController = Get.put(ThemeController());

  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "Task Title",
                  hintStyle: const TextStyle(fontFamily: 'Roboto'),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                ),
                style: const TextStyle(fontFamily: 'Roboto'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: "Task Description",
                  hintStyle:
                      const TextStyle(fontFamily: 'Roboto', fontSize: 16),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                ),
                style: const TextStyle(fontFamily: 'Roboto', fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Obx(() {
                final categories = taskController.tasksByCategory.keys.toList();
                return DropdownButton<String>(
                  value: _selectedCategory,
                  hint: const Text(
                    'Select Category',
                    style: TextStyle(fontFamily: 'Roboto'),
                  ),
                  isExpanded: true,
                  items: categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: const TextStyle(fontFamily: 'Roboto'),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                );
              }),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.black, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  backgroundColor:
                      themeController.themeData.value == ThemeData.dark()
                          ? Colors.white
                          : null,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final title = _titleController.text.trim();
                  final description = _descriptionController.text.trim();
                  if (title.isEmpty || _selectedCategory == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please fill in all fields')),
                    );
                    return;
                  }
                  taskController.addTask(
                    Task(
                      title: title,
                      description: description,
                      category: _selectedCategory!,
                      isCompleted: false,
                      id: DateTime.now().millisecondsSinceEpoch,
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(6)), // Rectangular shape
                  ),
                  backgroundColor: Colors.deepPurple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text(
                  'Add Task',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
