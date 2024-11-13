import 'package:flutter/material.dart';
import 'package:to_do_list/app/app_theme.dart';
import 'package:to_do_list/pages/main_page.dart';

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light( Colors.purple),
      home: const MainPage(),
    );
  }
}