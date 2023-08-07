import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/time_entries.dart';
import 'time_entry_card.dart';

class TimeEntryList extends ConsumerWidget {
  const TimeEntryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(timeEntriesProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Time entries",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16.0),
        entries.when(
            data: (timeEntries) => timeEntries.isEmpty
                ? const Text(
                    "There aren't any time entries for this day yet. Add one by clicking the + button.")
                : Column(
                    children: timeEntries
                        .map((timeEntry) => TimeEntryCard(timeEntry: timeEntry))
                        .toList(),
                  ),
            error: (error, stackTrace) => Text("Error: $error"),
            loading: () => const CircularProgressIndicator()),
      ],
    );
  }
}
