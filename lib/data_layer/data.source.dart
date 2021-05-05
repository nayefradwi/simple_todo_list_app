import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/data_layer/todo.model.dart';

class DatabaseSource {
  DatabaseSource._();
  bool _isInitialized = false;
  static DatabaseSource _$ = DatabaseSource._();
  factory DatabaseSource.getInstance() => _$;
  Box<Todo> _todosBox;

  Future<void> init() async {
    if (_isInitialized) return;
    await Hive.initFlutter();
    Hive.registerAdapter<Todo>(TodoAdapter());
    this._todosBox = await Hive.openBox<Todo>('testBox');
  }

  List<Todo> getTodos() {
    return this._todosBox.values.toList().cast<Todo>();
  }

  Future<int> saveTodo(Todo todo) {
    return this._todosBox.add(todo);
  }

  Future<void> deletTodo(Todo todo) async {
    return await this._todosBox.delete(todo.key);
  }

  Future<void> deleteAll() async {
    return await this._todosBox.clear();
  }

  Future<void> editTodo(Todo todo) async {
    return await todo.save();
  }

  void close() async {
    this._todosBox.close();
  }
}
