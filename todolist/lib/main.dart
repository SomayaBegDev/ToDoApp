import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI/Screen/MyScreen.dart';
import 'Ui/Widget/TaskItem.dart';
import 'provider/ToDOProv.dart';
import 'UI/Screen/UITask.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ToDoProvider>(
      create: (context) => ToDoProvider(),
      child: MaterialApp(
        title: "ToDoApp",
        home: MainScreen(),
      ),
    );
  }
}
