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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: TodoApp.BACKGROUND_COLOR,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddTodoDialog(context);
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

  void _showAddTodoDialog(BuildContext _context) {
    showDialog(
        context: _context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: TodoApp.CARD,
              elevation: 0,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onSubmitted: (value) {
                          BlocProvider.of<TodoCubit>(_context)
                              .addTodo(value, _descriptionController.text);
                          _descriptionController.clear();
                          _titleController.clear();
                          Navigator.pop(context);
                        },
                        autofocus: true,
                        controller: _titleController,
                        cursorColor: TodoApp.PRIMARY_TEXT,
                        style: TextStyle(
                            color: TodoApp.PRIMARY_TEXT, fontFamily: "Raleway"),
                        decoration: InputDecoration(
                            counterStyle: TextStyle(
                                color: TodoApp.TERTIARY_TEXT,
                                fontFamily: "Raleway"),
                            hintText: "title",
                            hintStyle: TextStyle(
                                color: TodoApp.TERTIARY_TEXT,
                                fontFamily: "Raleway"),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: TodoApp.ERROR, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: TodoApp.ACCENT, width: 2))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _descriptionController,
                        cursorColor: TodoApp.PRIMARY_TEXT,
                        style: TextStyle(
                            color: TodoApp.PRIMARY_TEXT, fontFamily: "Raleway"),
                        decoration: InputDecoration(
                            counterStyle: TextStyle(
                                color: TodoApp.TERTIARY_TEXT,
                                fontFamily: "Raleway"),
                            hintText: "description",
                            hintStyle: TextStyle(
                                color: TodoApp.TERTIARY_TEXT,
                                fontFamily: "Raleway"),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: TodoApp.ERROR, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: TodoApp.ACCENT, width: 2))),
                        maxLines: 4,
                        maxLength: 100,
                      ),
                    ),
                    Theme(
                      data: ThemeData(splashColor: TodoApp.PRIMARY),
                      child: TextButton(
                          onPressed: () {
                            if (_titleController.text.isNotEmpty) {
                              BlocProvider.of<TodoCubit>(_context).addTodo(
                                  _titleController.text,
                                  _descriptionController.text);
                              _descriptionController.clear();
                              _titleController.clear();
                            }
                            Navigator.pop(context);
                          },
                          child: Text(
                            "ADD TODO",
                            style: TextStyle(
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.bold,
                                color: TodoApp.PRIMARY_TEXT),
                          )),
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }
}
