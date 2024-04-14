import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../repository/weight_repository.dart';

class DatabaseProvider {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initialize();
    return _database!;
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(path,
        version: 1, onCreate: create, singleInstance: true);
    return database;
  }

  Future<String> get fullPath async {
    const name = 'weight.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<void> create(Database database, int version) async =>
      await WeightRepository().createTable(database);
}
