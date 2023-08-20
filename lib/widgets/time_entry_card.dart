import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/time_entry.dart';
import '../providers/time_entries.dart';

class TimeEntryCard extends ConsumerWidget {
  const TimeEntryCard({super.key, required this.timeEntry});

  final TimeEntry timeEntry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(timeEntry.id),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Delete time entry"),
              content: const Text(
                  "This will permanently delete the time entry. Are you sure?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Delete"),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (_) {
        ref.read(timeEntriesProvider.notifier).deleteTimeEntry(timeEntry);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("From"),
              const SizedBox(height: 16.0),
              TextField(
                readOnly: true,
                controller: TextEditingController(
                    text:
                        "${timeEntry.startTime.hour}:${timeEntry.startTime.minute.toString().padLeft(2, "0")}"),
                // open date picker on tap
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(
                        hour: timeEntry.startTime.hour,
                        minute: timeEntry.startTime.minute),
                  ).then((value) {
                    if (value == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select a start time"),
                        ),
                      );
                    } else if (value.hour > timeEntry.endTime.hour ||
                        (value.hour == timeEntry.endTime.hour &&
                            value.minute > timeEntry.endTime.minute)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("End time must be after start time"),
                        ),
                      );
                    } else {
                      ref.read(timeEntriesProvider.notifier).updateTimeEntry(
                          timeEntry.copyWith(
                              startTime: DateTime(
                                  timeEntry.startTime.year,
                                  timeEntry.startTime.month,
                                  timeEntry.startTime.day,
                                  value.hour,
                                  value.minute)));
                    }
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Select a start time",
                  labelText: "Start time",
                  suffixIcon: Icon(Icons.schedule),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text("Until"),
              const SizedBox(height: 16.0),
              TextField(
                readOnly: true,
                controller: TextEditingController(
                  text:
                      "${timeEntry.endTime.hour}:${timeEntry.endTime.minute.toString().padLeft(2, "0")}",
                ),
                // open date picker on tap
                onTap: () {
                  showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                              hour: timeEntry.endTime.hour,
                              minute: timeEntry.endTime.minute))
                      .then((value) {
                    if (value == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select an end time"),
                        ),
                      );
                    } else if (value.hour < timeEntry.startTime.hour ||
                        (value.hour == timeEntry.startTime.hour &&
                            value.minute < timeEntry.startTime.minute)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("End time must be after start time"),
                        ),
                      );
                    } else {
                      ref.read(timeEntriesProvider.notifier).updateTimeEntry(
                          timeEntry.copyWith(
                              endTime: DateTime(
                                  timeEntry.endTime.year,
                                  timeEntry.endTime.month,
                                  timeEntry.endTime.day,
                                  value.hour,
                                  value.minute)));
                    }
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Select an end time",
                  labelText: "End time",
                  suffixIcon: Icon(Icons.schedule),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
