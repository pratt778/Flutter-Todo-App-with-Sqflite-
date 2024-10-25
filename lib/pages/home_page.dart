import 'package:flutter/material.dart';
import 'package:flutter_application_1/db_handler.dart';
import 'package:flutter_application_1/pages/todolist.dart';
import 'package:flutter_application_1/utils/dialogbox.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  final mycontroller = TextEditingController();

  List<Map<String, dynamic>> mytasks = [];

  @override
  void initState() {
    super.initState();
    loadTodoTask();
  }

  Future<void> loadTodoTask() async {
    final List<Map<String, dynamic>> alltasks = await DbHandler().readData();
    setState(() {
      mytasks = alltasks;
      print(mytasks);
    });
  }

  void HandleOnChange(bool? value, int id, String task) async {
    if (value == true) {
      await DbHandler().updateData(id, {"TaskName": task, "Completed": 0});
    } else if (value == false) {
      await DbHandler().updateData(id, {"TaskName": task, "Completed": 1});
    }
    loadTodoTask();
  }

  void whenSaved() async {
    if (mycontroller.text != "") {
      await DbHandler().insertData(mycontroller.text, false);
      loadTodoTask();
      mycontroller.clear();
      Navigator.of(context).pop();
    }
  }

  void whenCancel() {
    Navigator.of(context).pop();
  }

  void HandleAddTodo() async {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            onSave: whenSaved,
            onCancel: whenCancel,
            mycontroller: mycontroller,
          );
        });
  }

  Future<void> deleteTask(int id) async {
    await DbHandler().deleteData(id);
    loadTodoTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text("Todo-list"),
      ),
      body: ListView.builder(
        itemCount: mytasks.length,
        itemBuilder: (context, index) => Todo_List_Item(
          todoName: mytasks[index]['TaskName'] ?? "UnNamed Task",
          todoComplete: mytasks[index]['Completed'] == 1 ? true : false,
          onPressed: () => deleteTask(mytasks[index]['Id']),
          onChanged: (value) => HandleOnChange(
              mytasks[index]['Completed'] == 1 ? true : false,
              mytasks[index]['Id'],
              mytasks[index]['TaskName']),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: HandleAddTodo,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
