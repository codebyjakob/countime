import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracker/models/time_entry.dart';
import 'package:time_tracker/widgets/date_selector.dart';
import 'package:time_tracker/widgets/time_entry_list.dart';
import 'package:time_tracker/widgets/total_time.dart';

import '../providers/date.dart';
import '../providers/time_entries.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key, required this.title});

  final String title;

  Future<void> _showAboutDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("About"),
          content: const Text(
              "CounTime is a basic and experimental time tracking app. Thank you for trying it out!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _showAboutDialog(context);
            },
            icon: const Icon(Icons.info)),
        title: Text(title),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 24.0, bottom: 128.0),
        children: const <Widget>[
          DateSelector(),
          SizedBox(height: 32.0),
          TotalTime(),
          SizedBox(height: 32.0),
          TimeEntryList(),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          DateTime currentTime = DateTime.now();
          DateTime startTime = date.copyWith(
            hour: currentTime.hour,
            minute: currentTime.minute,
          );
          DateTime endTime = startTime.hour < 23
              ? startTime.add(const Duration(hours: 1))
              : startTime.copyWith(hour: 23, minute: 59);
          ref.read(timeEntriesProvider.notifier).addTimeEntry(
                TimeEntry(
                  id: UniqueKey().toString(),
                  startTime: startTime,
                  endTime: endTime,
                ),
              );
        },
        tooltip: "Add a new entry",
        child: const Icon(Icons.add),
      ),
    );
  }
}
