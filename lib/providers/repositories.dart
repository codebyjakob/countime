import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/time_entry_repository.dart';
import 'database.dart';

part 'repositories.g.dart';

@riverpod
TimeEntryRepository? timeEntryRepository(TimeEntryRepositoryRef ref) {
  final database = ref.watch(databaseProvider).value;
  return database != null ? TimeEntryRepository(database: database) : null;
}
