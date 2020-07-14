import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/model/Task.dart';
import 'package:todolist/provider/ToDOProv.dart';
import 'UITask.dart';

class MainScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  String taskTitle;
  setTaskTitle(String tt) {
    this.taskTitle = tt;
  }

  submitTask(BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        Provider.of<ToDoProvider>(context, listen: false)
            .insertATask(Task(this.taskTitle));
        Navigator.pop(context);
      } catch (error) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(error.toString()),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Got it"),
                  )
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("ToDo App"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "TODo"),
              Tab(text: "Done"),
              Tab(text: "Not Done"),
            ],
          ),
        ),
        body: FutureBuilder<List<Task>>(
          future: Provider.of<ToDoProvider>(context).setTaskLists(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return TabBarView(
                children: <Widget>[
                  AllTask(),
                  CompletedTask(),
                  UncompletedTask()
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Form(
                      key: formKey,
                      child: CupertinoActionSheet(
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            onPressed: () {
                              //submitTask(context);
                            },
                            child: Card(
                              elevation: 0.0,
                              child: TextFormField(
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "This field is required";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: "Task Title",
                                ),
                                onSaved: (val) {
                                  setTaskTitle(val);
                                },
                              ),
                            ),
                          )
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () {
                            submitTask(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text("Add Task"),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
