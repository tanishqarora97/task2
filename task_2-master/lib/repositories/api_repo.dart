import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:task_1/model/api_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ApiRepo {
  int statusCode;
  String errorMessage = '';
  static final ApiRepo instance = ApiRepo._init();
  ApiRepo._init();
  ApiRepo();
  static Database _database;
  Future<List<Tag>> getTags() async {
    var url = Uri.parse('https://sigmatenant.com/mobile/tags/');
    List<Tag> data = [];

    try {
      var response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var jsonData = json['tags'] as List;
        jsonData.forEach(
          (element) {
            data.add(Tag.fromJson(element));
          },
        );
      } else {
        errorMessage = 'Something went wrong';
      }
    } catch (e) {
      errorMessage = 'Something went wrong';
      throw e;
    }
    return data;
  }

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('tanishq.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final textType = 'TEXT NOT NULL';

    await db.execute('CREATE TABLE TT (data TEXT)');
  }

  Future<void> create(Tag tag) async {
    final db = await instance.database;
    await openDatabase('tanishq.db');
    await db.insert('TT', tag.toJson());
  }

  Future<List<Tag>> readAllNotes() async {
    final db = await instance.database;

    // final orderBy = '${Tag.time} ASC';
    final result = await db.rawQuery('SELECT * FROM TT');
    return result.map((json) => Tag.fromJson(json)).toList();
  }
}
