import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';


class UpsertTodoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)?.settings.arguments as Todo;
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo${todo == null ? '作成' : '更新'}'),
      ),
      body: TodoForm(),
    );
  }
}

class TodoForm extends StatefulWidget {
  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)?.settings.arguments as Todo;
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              initialValue: todo != null ? todo.title : '',
              maxLength: 20,
              maxLengthEnforcement: MaxLengthEnforcement.none,
              decoration: const InputDecoration(
                hintText: 'Todoタイトルを入力してください',
                labelText: 'Todoタイトル',
              ),
              validator: (title) {
                if(title==null||title.isEmpty){
                  return 'Todoタイトルを入力してください';
                }
              },
              onSaved: (title) {
                _title = title!;
              },
            ),
            RaisedButton(
              onPressed: () => _submission(context, todo),
              child: Text('Todoを${todo == null ? '作成' : '更新'}する'),
            ),
          ],
        ),
      ),
    );
  }

  void _submission(BuildContext context, Todo todo) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (todo != null) {
        // viewModelのtodoListを更新
        context.read().updateTodo(todo.id, _title);
      } else {
        // viewModelのtodoListを作成
        context.read().createTodo(_title);
      }
      // 前の画面に戻る
      Navigator.pop(context, '$_titleを${todo == null ? '作成' : '更新'}しました');
    }
  }
}