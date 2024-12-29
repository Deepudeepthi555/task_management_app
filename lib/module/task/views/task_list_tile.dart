import 'package:flutter/material.dart';
import 'package:task_management/module/task/models/task_model.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onMarkComplete;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.onMarkComplete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (task.isCompleted) {
          return;
        }
      },
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
            alignment: Alignment.centerLeft,
            color: Colors.red,
            padding: const EdgeInsets.only(left: 20),
            child: const Text(
              "Delete Task",
              style: TextStyle(color: Colors.white),
            )),
        secondaryBackground: Container(
            alignment: Alignment.centerRight,
            color: Colors.green,
            padding: const EdgeInsets.only(right: 20),
            child: const Text(
              "Mark as completed",
              style: TextStyle(color: Colors.white),
            )),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            onDelete();
          } else if (direction == DismissDirection.endToStart) {
            if (task.isCompleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Task is already marked as completed'),
                  duration: Duration(seconds: 2),
                ),
              );
            } else {
              onMarkComplete();
            }
          }
        },
        child: ListTile(
          title: Text(task.title),
          subtitle: Text(
            task.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            task.isCompleted ? 'Completed' : 'Pending',
            style: TextStyle(
              color: task.isCompleted ? Colors.green : Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
