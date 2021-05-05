import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/business_logic_layer/events.dart';
import 'package:todo_list/business_logic_layer/states.dart';
import 'package:todo_list/data_layer/data.source.dart';
import 'package:todo_list/data_layer/todo.model.dart';

class TodoCubit extends Bloc<TodoEvents, TodoStates> {
  TodoCubit() : super(TodoInitState());

  @override
  Stream<TodoStates> mapEventToState(TodoEvents event) async* {
    if (event is AddTodoEvent) {
      DatabaseSource.getInstance().saveTodo(event.todo);
    } else if (event is DeleteTodo) {
      DatabaseSource.getInstance().deletTodo(event.todo!);
    }
    yield TodoInitState();
  }

  void addTodo(String title, String description) {
    this.add(AddTodoEvent(Todo()
      ..isDone = false
      ..description = description
      ..title = title));
  }

  void deleteTodo(Todo? todo) {
    this.add(DeleteTodo(todo));
  }

  void deleteAll() async {
    await DatabaseSource.getInstance().deleteAll();
    this.add(MarkTodoDone());
  }

  void markDoneOrUnDone(Todo todo) async {
    todo.isDone = !todo.isDone!;
    await DatabaseSource.getInstance().editTodo(todo);
    this.add(MarkTodoDone());
  }
}
