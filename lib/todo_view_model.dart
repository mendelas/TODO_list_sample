import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'todo.dart';

class TodoViewModel extends ChangeNotifier {

  List<Todo> _todoList = [];
  UnmodifiableListView<Todo> get todoList => UnmodifiableListView(_todoList);

  void createTodo(String title) {
    final id = _todoList.length + 1;
    _todoList = [...todoList, Todo(id, title)];
    notifyListeners();
  }

  void updateTodo(int id, String title) {
    todoList.asMap().forEach((int index, Todo todo) {
      if (todo.id == id) {
        _todoList[index].title = title;
      }
    });
    notifyListeners();
  }

  void deleteTodo(int id) {
    _todoList = todoList.where((todo) => todo.id != id).toList();
    notifyListeners();
  }
}