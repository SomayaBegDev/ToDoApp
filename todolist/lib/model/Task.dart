import '../repositories/DBHelper.dart';

class Task {
  int id;
  String aTask;
  bool isComplete;

  Task(this.aTask, {this.isComplete = false});
  set setTaskName(String newTask) {
    this.aTask = newTask;
  }

  Task.fromJson(Map<String, dynamic> map) {
    bool taskState = false;
    if (DBHelper.dbHelper.thiColName == 1) {
      taskState = true;
    }
    this.id = map["${DBHelper.dbHelper.firstColName}"];
    this.aTask = map["${DBHelper.dbHelper.sectColName}"];
    this.isComplete = taskState;
  }

  Map<String, dynamic> toJson() {
    return {
      DBHelper.dbHelper.sectColName: this.aTask,
      DBHelper.dbHelper.thiColName: this.isComplete ? 1 : 0
    };
  }

  taskState() {
    this.isComplete = !this.isComplete;
  }
}
