import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final String btnName;
  VoidCallback onPressed;
  final col;
  MyButtons({super.key, required this.btnName, required this.col,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: col,
      child: Text(
        btnName,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
