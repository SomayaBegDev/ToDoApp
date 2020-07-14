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
    if (DBHelper.thiColName == 1) {
      taskState = true;
    }
    this.id = map["${DBHelper.firstColName}"];
    this.aTask = map["${DBHelper.sectColName}"];
    this.isComplete = taskState;
  }

  Map<String, dynamic> toJson() {
    return {
      DBHelper.sectColName: this.aTask,
      DBHelper.thiColName: this.isComplete ? 1 : 0
    };
  }

  taskState() {
    this.isComplete = !this.isComplete;
  }
}
