import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/UI/Widget/TaskItem.dart';
import 'package:todolist/model/Task.dart';
import '../../provider/ToDOProv.dart';

class AllTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoProvider>(
      builder: (context, value, child) {
        List<Task> myTasks = value.allTask;
        return ListView.builder(
            itemCount: myTasks.length,
            itemBuilder: (context, index) {
              return TaskItem(myTasks[index]);
            });
      },
    );
  }
}

class CompletedTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoProvider>(
      builder: (context, value, child) {
        List<Task> compTasks = value.completedTask;
        return ListView.builder(
            itemCount: compTasks.length,
            itemBuilder: (context, index) {
              return TaskItem(compTasks[index]);
            });
      },
    );
  }
}

class UncompletedTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoProvider>(
      builder: (context, value, child) {
        List<Task> unCompTasks = value.uncompletedTask;
        return ListView.builder(
            itemCount: unCompTasks.length,
            itemBuilder: (context, index) {
              return TaskItem(unCompTasks[index]);
            });
      },
    );
  }
}
