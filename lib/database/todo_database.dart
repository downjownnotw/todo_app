import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/database/model/todo_model.dart';

class TodoDatabase{
  TodoDatabase._internal();

  static final TodoDatabase _instance = TodoDatabase._internal();

  factory TodoDatabase(){
    return _instance;
  }

  late Database _database;

  Database get database => _database;

  String dbName = "TodoList";
  int dbVersion = 1;

  Future<void> initialized() async{

    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, '$dbName.db');

    // Delete the database
    // await deleteDatabase(path);

    // open the database
    _database = await openDatabase(
        path,
        version: dbVersion,
        onCreate: (Database db, int version) async {
          await db.execute(TodoModel.getCreateQuery());
        });

  }
}