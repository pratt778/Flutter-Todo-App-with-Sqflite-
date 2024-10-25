import 'package:flutter/material.dart';

class Todo_List_Item extends StatelessWidget {
  final String todoName;
  final bool todoComplete;
  Function(bool?)? onChanged;
  VoidCallback onPressed;
  Todo_List_Item({
    super.key,
    required this.todoName,
    required this.todoComplete,
    required this.onChanged,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      child: Container(
        // ignore: sort_child_properties_last
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                value: todoComplete,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              Text(
                todoName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: todoComplete
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.delete),
                color: Colors.red[700],
              ),
            ],
          ),
        ),

        decoration: BoxDecoration(
          color: Colors.green[400],
        ),
      ),
    );
  }
}
