import 'package:sqflite/sqflite.dart';
import 'package:weight_tracker/db/model/weight.dart';
import 'package:weight_tracker/db/provider/database_provider.dart';

class WeightRepository {
  final tableName = 'weight';

  Future<void> createTable(Database database) async {
    database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
    "id" INTEGER NOT NULL,
    "createdAt" INTEGER NOT NULL,
    "amount" REAL NOT NULL,
    PRIMARY KEY("id" AUTOINCREMENT)
    )""");
  }

  Future<Weight> create(double weight) async {
    final db = await DatabaseProvider().database;
    final createdAt = DateTime.now();
    final id = await db.rawInsert("""
      INSERT INTO $tableName (amount, createdAt) VALUES (?,?)
    """, [weight, createdAt.millisecondsSinceEpoch]);

    return Weight(id: id, amount: weight, createdAt: createdAt);
  }

  Future<List<Weight>> getAll() async {
    final db = await DatabaseProvider().database;
    final weights = await db.query(tableName);

    return [for (final row in weights) Weight.fromMap(row)];
  }
}
