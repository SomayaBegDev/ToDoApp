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

  static final dbName = "thestateof.db";
  static final tableName = "Task";
  static final firstColName = "taskID";
  static final sectColName = "taskTitle";
  static final thiColName = "taskState";

  Database stateofdb;
  Future<Database> initStateOfDB() async {
    if (stateofdb == null) {
      stateofdb = await conectToStateOfdb();
      return stateofdb;
    } else {
      return stateofdb;
    }
  }

  Future<Database> conectToStateOfdb() async {
    Directory dbDirec = await getApplicationDocumentsDirectory();
    String path = join(dbDirec.path, '$dbName');
    Database stOfdb = await openDatabase(
      path,
      version: 1,
      onCreate: (mydb, version) {
        mydb.execute('''CREATE TABLE $tableName(
          $firstColName INTEGER PRIMARY KEY AUTOINCREMENT,
          $sectColName TEXT NOT NULL,
          $thiColName INTEGER NOT NULL
        )''');
      },
    );
    return stOfdb;
  }

  Future<int> insertNewTask(Map<String, dynamic> record) async {
    try {
      stateofdb = await initStateOfDB();
      int rowIndex = await stateofdb.insert(tableName, record);
      return rowIndex;
    } catch (dbEror) {
      throw "Database error $dbEror";
    }
  }

  Future<List<Map<String, dynamic>>> myRecords() async {
    try {
      stateofdb = await initStateOfDB();
      var rec = await stateofdb.query(tableName);
      return rec;
    } catch (dbEror) {
      throw "Database error $dbEror";
    }
  }

  Future<List<Map<String, dynamic>>> myRecCompletedTask() async {
    try {
      stateofdb = await initStateOfDB();
      var rec = await stateofdb
          .query(tableName, where: '$thiColName =?', whereArgs: [1]);
      return rec;
    } catch (dbEror) {
      throw "Database error $dbEror";
    }
  }

  Future<List<Map<String, dynamic>>> myRecUncompletedTask() async {
    try {
      stateofdb = await initStateOfDB();
      var rec = await stateofdb
          .query(tableName, where: '$thiColName =?', whereArgs: [0]);
      return rec;
    } catch (dbEror) {
      throw "Database error $dbEror";
    }
  }

  Future<int> myRecUpdateTask(Map<String, dynamic> record, int id) async {
    try {
      stateofdb = await initStateOfDB();
      int updareRec = await stateofdb.update(tableName, record,
          where: '$firstColName =?', whereArgs: [id]);
      return updareRec;
    } catch (dbEror) {
      throw "Database error $dbEror";
    }
  }

  deleteTask(int id) async {
    try {
      stateofdb = await initStateOfDB();
      int row = await stateofdb
          .delete(tableName, where: '$firstColName =?', whereArgs: [id]);
      return row;
    } catch (dbError) {
      throw 'Database error $dbError';
    }
  }

  deleteAllTask() async {
    try {
      stateofdb = await initStateOfDB();
      await stateofdb.delete(tableName);
    } catch (dbError) {
      throw 'Database error $dbError';
    }
  }
}
