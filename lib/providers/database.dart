import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'database.g.dart';

@riverpod
Future<Database> database(DatabaseRef ref) async {
  return openDatabase(join(await getDatabasesPath(), "time_tracker.db"),
      onCreate: (db, version) {
    return db.execute(
      "CREATE TABLE time_entries(id TEXT PRIMARY KEY, startTime TEXT, endTime TEXT)",
    );
  }, version: 1);
}
