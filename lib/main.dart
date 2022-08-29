import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'todo_list_view.dart';
import 'todo_view_model.dart';

final todoProvider = ChangeNotifierProvider(
      (ref) => TodoViewModel(),
);

void main() {
  runApp(
    ProviderScope(
      child: TodoListView(),
    ),
  );
}