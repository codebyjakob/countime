import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/time_entry.dart';
import 'time_entries.dart';

part 'total_time.g.dart';

@riverpod
Duration totalTime(TotalTimeRef ref) {
  List<TimeEntry> timeEntries = ref.watch(timeEntriesProvider).value ?? [];
  Duration totalTime = Duration.zero;
  for (TimeEntry timeEntry in timeEntries) {
    totalTime += timeEntry.endTime.difference(timeEntry.startTime);
  }
  return totalTime;
}
