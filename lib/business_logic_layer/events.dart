import 'package:todo_list/data_layer/todo.model.dart';

abstract class TodoEvents {
  const TodoEvents();
}

class GetTodosEvent extends TodoEvents {}

class AddTodoEvent extends TodoEvents {
  final Todo todo;
  const AddTodoEvent(this.todo);
}

class DeleteTodo extends TodoEvents {
  final Todo todo;
  const DeleteTodo(this.todo);
}

class MarkTodoDone extends TodoEvents {}
