import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/business_logic_layer/states.dart';
import 'package:todo_list/business_logic_layer/todo.cubit.dart';
import 'package:todo_list/data_layer/data.source.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/presentation_layer/todo.widget.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: TodoApp.BACKGROUND_COLOR,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            BlocProvider.of<TodoCubit>(context).addTodo("finish app", "");
          },
          backgroundColor: TodoApp.PRIMARY,
          child: Icon(
            Icons.add,
            color: TodoApp.BACKGROUND_COLOR,
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                child: Text(
                  "Todos",
                  style: TextStyle(
                    color: TodoApp.PRIMARY_TEXT,
                    fontSize: 28,
                    fontFamily: "PlayFair",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 250, 5),
                child: Divider(
                  color: TodoApp.ACCENT,
                ),
              ),
              Expanded(
                child: BlocBuilder<TodoCubit, TodoStates>(
                  builder: (context, state) {
                    return CustomScrollView(
                      slivers: [
                        SliverList(
                            delegate: SliverChildBuilderDelegate((context, i) {
                          return TodoWidget(
                            todoObject:
                                DatabaseSource.getInstance().getTodos()[i],
                          );
                        },
                                childCount: DatabaseSource.getInstance()
                                    .getTodos()
                                    .length))
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  void _showAddTodoDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 1,
              backgroundColor: TodoApp.ACCENT,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(hintText: "title"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(hintText: "title"),
                      ),
                    ),
                    // add button
                  ],
                ),
              ),
            ));
  }
}
