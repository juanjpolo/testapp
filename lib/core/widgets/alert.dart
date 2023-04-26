import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget>? actions;

  const Alert(
      {super.key, required this.title, required this.content, this.actions});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title), content: Text(content), actions: actions);
  }
}
