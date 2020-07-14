import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
//import 'package:flutter/material.dart';
//import 'package:todolist/model/Task.dart';
//import '../model/ToDOProv.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper dbHelper = DBHelper._();
  final String tableName = "task";
  final String firstColName = "taskID";
  final String sectColName = "taskTitle";
  final String thiColName = "taskState";

  Database stateOfDB;
  iniDB() async {
    if (stateOfDB == null) {
      stateOfDB = await connectToStateOfDB();
      return stateOfDB;
    } else {
      return stateOfDB;
    }
  }

  Future<Database> connectToStateOfDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = join(appDocDir.path, 'tasksDb.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''CREATE TABLE $tableName(
          $firstColName INTEGER PRIMARY KEY AUTOINCREMENT,
          $sectColName TEXT NOT NULL,
          $thiColName INTEGER NOT NULL
        )''');
      },
    );
    return database;
  }

  Future<int> insertNewTask(Map<String, dynamic> map) async {
    try {
      stateOfDB = await iniDB();
      int rowIndex = await stateOfDB.insert(tableName, map);
      return rowIndex;
    } catch (error) {
      throw 'database error $error';
    }
  }

  Future<List<Map<String, dynamic>>> myRecords() async {
    try {
      stateOfDB = await iniDB();
      List<Map<String, dynamic>> results = await stateOfDB.query(tableName);
      return results;
    } catch (error) {
      throw 'database error $error';
    }
  }

  Future<List<Map<String, dynamic>>> myRecCompletedTask() async {
    try {
      stateOfDB = await iniDB();
      List<Map<String, dynamic>> results = await stateOfDB
          .query(tableName, where: '$thiColName = ?', whereArgs: [1]);
      return results;
    } catch (error) {
      throw 'database error $error';
    }
  }

  Future<List<Map<String, dynamic>>> myRecUncompletedTask() async {
    try {
      stateOfDB = await iniDB();
      List<Map<String, dynamic>> results = await stateOfDB
          .query(tableName, where: '$thiColName = ?', whereArgs: [0]);
      return results;
    } catch (error) {
      throw 'database error $error';
    }
  }

  Future<int> myRecUpdateTask(Map<String, dynamic> map, int id) async {
    try {
      stateOfDB = await iniDB();
      int rows = await stateOfDB
          .update(tableName, map, where: '$firstColName = ?', whereArgs: [id]);
      return rows;
    } catch (error) {
      throw 'database error $error';
    }
  }

  deleteTask(int id) async {
    try {
      stateOfDB = await iniDB();
      int rows = await stateOfDB
          .delete(tableName, where: '$firstColName = ?', whereArgs: [id]);
      return rows;
    } catch (error) {
      throw 'database error $error';
    }
  }

  deleteAllTask() async {
    try {
      stateOfDB = await iniDB();
      int rows = await stateOfDB.delete(tableName);
      return rows;
    } catch (error) {
      throw 'database error $error';
    }
  }
}
