import 'DBHelper.dart';
import 'package:todolist/model/Task.dart';

class Repositoriy {
  Repositoriy._();
  static final Repositoriy repositoriy = Repositoriy._();

  insertNewTask(Task t) async {
    await DBHelper.dbHelper.insertNewTask(t.toJson());
  }

  Future<List<Task>> getAllTasks() async {
    List<Map<String, dynamic>> records = await DBHelper.dbHelper.myRecords();
    List<Task> myTasks = records.map((f) => Task.fromJson(f)).toList();
    return myTasks;
  }

  Future<List<Task>> getCompletedTask() async {
    List<Map<String, dynamic>> completedRecords =
        await DBHelper.dbHelper.myRecCompletedTask();
    List<Task> completedTask =
        completedRecords.map((f) => Task.fromJson(f)).toList();
    return completedTask;
  }

  Future<List<Task>> getUncompletedTask() async {
    List<Map<String, dynamic>> uncompletedrecords =
        await DBHelper.dbHelper.myRecUncompletedTask();
    List<Task> uncompletedTask =
        uncompletedrecords.map((f) => Task.fromJson(f)).toList();
    return uncompletedTask;
  }

  Future<int> updateTask(Task t) async {
    t.taskState();
    int rowNum = await DBHelper.dbHelper.myRecUpdateTask(t.toJson(), t.id);
    return rowNum;
  }

  Future<int> deleteTask(Task t) async {
    int colNum = await DBHelper.dbHelper.deleteTask(t.id);
    return colNum;
  }

  deleteAllTask() async {
    await DBHelper.dbHelper.deleteAllTask();
  }
}
