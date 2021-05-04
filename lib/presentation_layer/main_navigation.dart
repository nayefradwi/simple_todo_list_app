import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/presentation_layer/main_screen.dart';

class AppRouter {
  static const String MAIN_SCREEN = '/';

  Route onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case MAIN_SCREEN:
        return MaterialPageRoute(builder: (_context) => MainScreen());
      default:
        return null;
    }
  }
}
