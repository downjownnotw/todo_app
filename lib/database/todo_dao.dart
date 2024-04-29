import 'package:sqflite/sqlite_api.dart';
import 'package:todo_app/database/model/todo_model.dart';

class TodoDao{
  // do the CRUD on task

  // create
  Future<void> addTodo(Database db, TodoModel todoModel) async{
    db.insert(TodoModel.tableName, todoModel.toJson());
  }

  // read
  Future<List<TodoModel>> getTodos(Database db) async{
    List<TodoModel> result = [];
    List queryResults = await db.query(TodoModel.tableName);
    for (var queryResult in queryResults){
      result.add(TodoModel.fromJson(queryResult));
    }
    return result;
  }

  // update
  Future<void> updateTask(Database db, TodoModel todoModel) async{
    await db.update(
        TodoModel.tableName,
        todoModel.toJson(),
        where: '${TodoModel.colId} = ?',
        whereArgs: [todoModel.id]
    );
  }

  // delete
  Future<void> deleteTask(Database db, TodoModel todoModel) async{
    await db.delete(
        TodoModel.tableName,
        where: '${TodoModel.colId} = ?',
        whereArgs: [todoModel.id]
    );
  }

}