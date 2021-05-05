import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/business_logic_layer/todo.cubit.dart';
import 'package:todo_list/presentation_layer/main.screen.dart';

class AppRouter {
  static const String MAIN_SCREEN = '/';

  Route onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case MAIN_SCREEN:
        return MaterialPageRoute(
            builder: (_context) => BlocProvider(
                create: (context) => TodoCubit(), child: MainScreen()));
      default:
        return null;
    }
  }
}
