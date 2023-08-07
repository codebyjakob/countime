import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/time_entry.dart';
import '../repositories/time_entry_repository.dart';
import 'date.dart';
import 'repositories.dart';

part 'time_entries.g.dart';

@riverpod
class TimeEntries extends _$TimeEntries {
  @override
  FutureOr<List<TimeEntry>> build() async {
    TimeEntryRepository? repository = ref.watch(timeEntryRepositoryProvider);
    DateTime date = ref.watch(dateProvider);
    if (repository != null) {
      return repository.getTimeEntries(date);
    }
    return [];
  }

  void addTimeEntry(TimeEntry timeEntry) {
    if (timeEntry.startTime.day == ref.read(dateProvider).day) {
      state = const AsyncValue.loading();
    }
    TimeEntryRepository? repository = ref.watch(timeEntryRepositoryProvider);
    if (repository != null) {
      repository.insertTimeEntry(timeEntry);
    }
    if (timeEntry.startTime.day == ref.read(dateProvider).day) {
      state = AsyncValue.data([...?state.value, timeEntry]);
    }
  }

  void updateTimeEntry(TimeEntry timeEntry) {
    if (timeEntry.startTime.day == ref.read(dateProvider).day) {
      state = const AsyncValue.loading();
    }
    TimeEntryRepository? repository = ref.watch(timeEntryRepositoryProvider);
    if (repository != null) {
      repository.updateTimeEntry(timeEntry);
    }
    if (timeEntry.startTime.day == ref.read(dateProvider).day) {
      state = AsyncValue.data([
        if (state.value != null)
          for (TimeEntry entry in state.value!)
            if (entry.id == timeEntry.id) timeEntry else entry
      ]);
    }
  }

  void deleteTimeEntry(TimeEntry timeEntry) {
    if (timeEntry.startTime.day == ref.read(dateProvider).day) {
      state = const AsyncValue.loading();
    }
    TimeEntryRepository? repository = ref.watch(timeEntryRepositoryProvider);
    if (repository != null) {
      repository.deleteTimeEntry(timeEntry.id);
    }
    if (timeEntry.startTime.day == ref.read(dateProvider).day) {
      state = AsyncValue.data([
        if (state.value != null)
          for (TimeEntry entry in state.value!)
            if (entry.id != timeEntry.id) entry
      ]);
    }
  }
}
