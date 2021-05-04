import 'package:flutter/material.dart';
import 'package:todo_list/main.dart';

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
          onPressed: () {},
          backgroundColor: TodoApp.PRIMARY,
          child: Icon(
            Icons.add,
            color: TodoApp.BACKGROUND_COLOR,
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(15, 20, 0, 10),
                sliver: SliverToBoxAdapter(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Todos",
                      style: TextStyle(
                        color: TodoApp.PRIMARY_TEXT,
                        fontSize: 28,
                        fontFamily: "PlayFair",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 250, 5),
                      child: Divider(
                        color: TodoApp.ACCENT,
                      ),
                    ),
                  ],
                )),
              ),
              SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                _getMainTodoItem(),
              ]))
            ],
          ),
        ));
  }

  // Widget _getMainTodoItem() {
  //   String title = "finish this app";
  //   String description = "you want to add this to your resume";
  //   String tag = "Work";
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Card(
  //         elevation: 0,
  //         color: TodoApp.CARD,
  //         child: Row(
  //           children: [
  //             Checkbox(
  //               value: isDone,
  //               onChanged: (value) {
  //                 setState(() {
  //                   isDone = value;
  //                 });
  //               },
  //             )
  //           ],
  //         )),
  //   );
  // }

  Widget _getMainTodoItem() {
    String title = "finish this app";
    String description = "you want to add this to your resume";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
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
                value: isDone,
                onChanged: (value) => setState(() => isDone = value),
                checkColor: TodoApp.PRIMARY_TEXT,
                activeColor: TodoApp.ACCENT,
              ),
            ),
            isThreeLine: description.isEmpty,
            subtitle: Text(description,
                style: TextStyle(
                  decoration:
                      isDone ? TextDecoration.lineThrough : TextDecoration.none,
                  color: TodoApp.TERTIARY_TEXT,
                  fontSize: 16,
                )),
            title: Text(
              title,
              style: TextStyle(
                decoration:
                    isDone ? TextDecoration.lineThrough : TextDecoration.none,
                color: isDone ? TodoApp.TERTIARY_TEXT : TodoApp.SECONDARY_TEXT,
                fontSize: 20,
              ),
            ),
          )),
    );
  }
}
