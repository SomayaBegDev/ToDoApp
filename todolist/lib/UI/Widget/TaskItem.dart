import 'package:flutter/material.dart';
import 'package:todolist/model/Task.dart';
import 'package:todolist/provider/ToDOProv.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatelessWidget {
  Task myTask;
  TaskItem(this.myTask);
  @override
  Widget build(BuildContext context) {
    ToDoProvider toDoProv = Provider.of<ToDoProvider>(context, listen: false);
    return Dismissible(
      key: ObjectKey(myTask),
      onDismissed: (right) {
        toDoProv.deleteTask(myTask);
      },
      child: ListTile(
        title: Text(myTask.aTask),
        trailing: Checkbox(
          value: myTask.isComplete,
          onChanged: (value) {
            toDoProv.updateTask(myTask);
          },
        ),
      ),
    );
  }
}
