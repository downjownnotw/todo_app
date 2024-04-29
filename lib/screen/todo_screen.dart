import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/common/enums.dart';
import 'package:todo_app/database/model/todo_model.dart';
import 'package:todo_app/database/todo_dao.dart';
import 'package:todo_app/database/todo_database.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TodoDatabase db = TodoDatabase();
  TodoDao dao = TodoDao();
  List<TodoModel> todos = [];

  @override
  void initState() {
    super.initState();
    updateTodos();
  }

  Future<void> updateTodos() async{
    todos = await dao.getTodos(db.database);
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {

    void upsertTodo({TodoModel? oldTodo}){
      showDialog(context: context, builder: (context){
        var todoController = TextEditingController(text: oldTodo?.name ?? '');
        return AlertDialog(
          title: Text('${oldTodo == null ? 'Add' : 'Update'} Todo'),
          content: TextField(
            controller: todoController,
            decoration: const InputDecoration(
                hintText: 'Todo Name'
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')
            ),
            TextButton(
                onPressed: () async {
                  String value = todoController.text;
                  if(value.isNotEmpty) {
                    if (oldTodo == null){
                      await dao.addTodo(db.database, TodoModel(value));
                    }
                    else{
                      oldTodo.name = value;
                      await dao.updateTask(db.database, oldTodo);
                    }
                    await updateTodos();
                  }
                  if(context.mounted){
                    Navigator.pop(context);
                  }
                },
                child: Text(oldTodo == null ? 'Add' : 'Update')
            )
          ],
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Row(
                  children: [
                    Expanded(child: Text(todos[index].name)),
                    PopupMenuButton<TodoOptions>(onSelected: (value) async {
                      if (value == TodoOptions.edit){
                        upsertTodo(oldTodo: todos[index]);
                      }
                      else if (value == TodoOptions.delete){
                        await dao.deleteTask(db.database, todos[index]);
                        updateTodos();
                      }
                    }, itemBuilder: (context){
                      return [
                        const PopupMenuItem(value: TodoOptions.edit, child: Text('Edit')),
                        const PopupMenuItem(value: TodoOptions.delete,child: Text('Delete'),)
                      ];
                    },
                    child: const Icon(Icons.more_vert),
                    )
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: upsertTodo,
        child: const Icon(Icons.add),
      ),
    );
  }

}
