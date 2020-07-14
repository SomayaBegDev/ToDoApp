import 'package:flutter/cupertino.dart';
import 'package:todolist/repositories/DBHelper.dart';
import 'package:todolist/repositories/Repositoriy.dart';
import '../model/Task.dart';

class ToDoProvider extends ChangeNotifier {
  List<Task> allTask = [];
  List<Task> completedTask = [];
  List<Task> uncompletedTask = [];

  Future<List<Task>> setTaskLists() async {
    List<Task> allTaskRep = await Repositoriy.repositoriy.getAllTasks();
    this.allTask = allTaskRep;
    this.completedTask = await Repositoriy.repositoriy.getCompletedTask();
    this.uncompletedTask = await Repositoriy.repositoriy.getUncompletedTask();
    notifyListeners();
    return allTaskRep;
  }

  insertATask(Task t) async {
    await Repositoriy.repositoriy.insertNewTask(t);
    setTaskLists();
  }

  updateTask(Task t) async {
    await Repositoriy.repositoriy.updateTask(t);
    setTaskLists();
  }

  deleteTask(Task t) async {
    await Repositoriy.repositoriy.deleteTask(t);
    setTaskLists();
  }

  deleteAllTask() async {
    await Repositoriy.repositoriy.deleteAllTask();
    setTaskLists();
  }
}
