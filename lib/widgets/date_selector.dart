import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/date.dart';

class DateSelector extends ConsumerWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Select a date",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 20.0),
        TextField(
          readOnly: true,
          controller: TextEditingController(
            text: "${date.day}/${date.month}/${date.year}",
          ),
          // open date picker on tap
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
            ).then((value) {
              if (value != null) {
                ref.read(dateProvider.notifier).setDate(value);
              }
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Select a date",
            labelText: "Date",
            suffixIcon: Icon(Icons.calendar_today),
          ),
        ),
      ],
    );
  }
}
