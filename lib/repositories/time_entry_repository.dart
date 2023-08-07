import 'package:sqflite/sqflite.dart';

import '../models/time_entry.dart';

class TimeEntryRepository {
  const TimeEntryRepository({required this.database});

  final Database database;

  Future<void> insertTimeEntry(TimeEntry timeEntry) async {
    await database.insert(
      "time_entries",
      timeEntry.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TimeEntry>> getTimeEntries(DateTime date) async {
    final List<Map<String, dynamic>> maps = await database.query(
      "time_entries",
      where: "startTime LIKE ?",
      whereArgs: [
        "${date.year}-${date.month.toString().padLeft(2, "0")}-${date.day.toString().padLeft(2, "0")}%"
      ],
    );
    return List.generate(maps.length, (i) {
      return TimeEntry.fromJson(maps[i]);
    });
  }

  Future<void> updateTimeEntry(TimeEntry timeEntry) async {
    await database.update(
      "time_entries",
      timeEntry.toJson(),
      where: "id = ?",
      whereArgs: [timeEntry.id],
    );
  }

  Future<void> deleteTimeEntry(String id) async {
    await database.delete(
      "time_entries",
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
