import 'package:flutter/material.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Application',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: const Scaffold(),
    );
  }
}
