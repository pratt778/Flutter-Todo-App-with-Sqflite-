import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";

class DbHandler {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'mydatabase2.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
  CREATE TABLE Tasks(
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  TaskName TEXT NOT NULL,
  Completed INTEGER NOT NULL
  )
''');
      },
    );
    return _database;
  }

  insertData(String name, bool com) async {
    Database? db = await database;
    Map<String, Object> map = {"TaskName": name, "Completed": com ? 1 : 0};
    db!.insert('Tasks', map);
    print("insert data is clicked");
  }

  readData() async {
    Database? db = await database;
    final list = await db!.query('Tasks');
    print(list);
    return list;
  }

  deleteData(int id) async {
    Database? db = await database;
    await db!.delete("Tasks", where: 'id=?', whereArgs: [id]);
  }

  updateData(int id, Map<String, Object> data) async {
    Database? db = await database;
    await db!.update("Tasks", data, where: 'id=?', whereArgs: [id]);
  }
}
