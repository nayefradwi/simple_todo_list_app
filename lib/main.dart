import 'package:flutter/material.dart';
import 'package:todo_list/data_layer/data.source.dart';
import 'package:todo_list/presentation_layer/main.navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseSource.getInstance().init();
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
      title: 'Todo app',
      onGenerateRoute: AppRouter().onGenerate,
    );
  }
}
