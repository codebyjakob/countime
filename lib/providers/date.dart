import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date.g.dart';

@riverpod
class Date extends _$Date {
  @override
  DateTime build() {
    return DateTime.now();
  }

  void setDate(DateTime date) {
    state = date;
  }
}
