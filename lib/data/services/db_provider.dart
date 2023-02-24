import 'package:sqflite/sqflite.dart';

const String tableTodo = 'Todos';
const String columnId = 'id';
const String columnTitle = 'title';
const String columnDescription = 'description';

class Todo {
  // attributs
  late int id;
  late String title;
  late String description;
  // constructeur
  Todo();
  // transformer en map
  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnTitle: title,
      columnDescription: description,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Todo.fromMap(Map<dynamic, dynamic> map) {
    title = map[columnTitle]!;
    description = map[columnDescription]!;
    id = map[columnId]!;
  }
}

class TodoProvider {
  Database? db;
  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table $tableTodo ( 
        $columnId integer primary key autoincrement, 
        $columnTitle varchar(255) not null,
        $columnDescription text not null)
      ''');
    });
  }

  Future<Todo> insert(Todo todo) async {
    todo.id = await db!.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<List<Map>?> getTodos() async {
    List<Map> todosReturn = [];
    List<Map> maps = await db!
        .query(tableTodo, columns: [columnId, columnTitle, columnDescription]);
    if (maps.isNotEmpty) {
      maps.map((e) => Todo.fromMap(e));
      return todosReturn;
    }
    return null;
  }

  Future close() async => db!.close();
}
