import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/business_logic_layer/todo.cubit.dart';
import 'package:todo_list/data_layer/todo.model.dart';

import '../main.dart';

class TodoWidget extends StatefulWidget {
  final Todo todoObject;

  const TodoWidget({Key key, this.todoObject}) : super(key: key);
  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
      child: Dismissible(
        key: ValueKey(widget.todoObject.key),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) return true;
          BlocProvider.of<TodoCubit>(context)
              .markDoneOrUnDone(widget.todoObject);
          return false;
        },
        onDismissed: (DismissDirection direction) {
          BlocProvider.of<TodoCubit>(context).deleteTodo(widget.todoObject);
        },
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(color: Colors.red.shade300)),
            elevation: 0,
            color: TodoApp.CARD,
            child: ListTile(
              leading: Theme(
                data: ThemeData(unselectedWidgetColor: TodoApp.ACCENT),
                child: Checkbox(
                  value: widget.todoObject.isDone,
                  onChanged: (value) => BlocProvider.of<TodoCubit>(context)
                      .markDoneOrUnDone(widget.todoObject),
                  checkColor: TodoApp.PRIMARY_TEXT,
                  activeColor: TodoApp.ACCENT,
                ),
              ),
              subtitle: widget.todoObject.description.isNotEmpty
                  ? Text(widget.todoObject.description,
                      style: TextStyle(
                          decoration: widget.todoObject.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: TodoApp.TERTIARY_TEXT,
                          fontSize: 16,
                          fontFamily: "Raleway"))
                  : null,
              title: Text(
                widget.todoObject.title,
                style: TextStyle(
                    decoration: widget.todoObject.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: widget.todoObject.isDone
                        ? TodoApp.TERTIARY_TEXT
                        : TodoApp.PRIMARY_TEXT,
                    fontSize: 20,
                    fontFamily: "Raleway"),
              ),
            )),
      ),
    );
  }
}
