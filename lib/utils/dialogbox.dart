import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/todobuttons.dart';

class DialogBox extends StatelessWidget {
  final mycontroller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({super.key,required this.mycontroller,required this.onSave,required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green[500],
      title: const Text("Add a task"),
      content: SizedBox(
        width: 350,
        height: 180,
        child: Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3, top: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller:mycontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MyButtons(
                    onPressed: onSave,
                    btnName: "Save",
                    col: Colors.blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  MyButtons(
                    onPressed: onCancel,
                    btnName: "Cancel",
                    col: Colors.red,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
