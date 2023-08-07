import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'time_entry.freezed.dart';

part 'time_entry.g.dart';

@freezed
class TimeEntry with _$TimeEntry {
  const factory TimeEntry({
    required String id,
    required DateTime startTime,
    required DateTime endTime,
  }) = _TimeEntry;

  factory TimeEntry.fromJson(Map<String, Object?> json) =>
      _$TimeEntryFromJson(json);
}
