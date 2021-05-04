import 'package:flutter/material.dart';
import 'package:todo_list/presentation_layer/main_navigation.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  static const Color BACKGROUND_COLOR = Color(0xFF112039);
  static const Color PRIMARY = Color(0xFFBDCFFF);
  static const Color PRIMARY_TEXT = Color(0xFFFFFFFF);
  static const Color SECONDARY_TEXT = Color(0xFFD2D2D9);
  static const Color TERTIARY_TEXT = Color(0xFFABAEB5);
  static const Color ACCENT = Color(0xFF676A7B);
  static const Color CARD = Color(0xFF222A41);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      onGenerateRoute: AppRouter().onGenerate,
    );
  }
}
