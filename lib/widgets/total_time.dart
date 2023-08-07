import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/total_time.dart';

class TotalTime extends ConsumerWidget {
  const TotalTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalTime = ref.watch(totalTimeProvider);
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Total time", style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16.0),
          Text(
              "${totalTime.inHours}:${(totalTime.inMinutes % 60).toString().padLeft(2, "0")} h",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface)),
        ],
      ),
    );
  }
}
