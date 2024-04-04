class TodoModel{
  TodoModel(this.name, {this.id, this.createdAt});

  int? id;
  String? createdAt;
  String name;

  static const String tableName = 'todo';
  static const String colId = 'id';
  static const String colCreatedAt = 'createdAt';
  static const String colName = 'name';

  static String getCreateQuery(){
    return '''
    CREATE TABLE $tableName
    (
      $colId integer PRIMARY KEY AUTOINCREMENT,
      $colCreatedAt datetime DEFAULT CURRENT_TIMESTAMP,
      $colName varchar
    )
    ''';
  }
}