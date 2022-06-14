import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String? title;
  final String? description;
  final String? eventID;

   Event({this.title, this.description,this.eventID});

  String toString1() => title!;
  String toString2() => description!;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);
final _kEventSource = { for (var item in List.generate(50, (index) => index)) DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5) : List.generate(
        item % 4 + 1, (index) => Event(
          title: 'Event $item | ${index + 1}',
            description: 'Description $item | ${index + 1}',
            // 'Event $item | ${index + 1}','Description $item | ${index + 1}'
        )) }
  ..addAll({
    kToday: [
      Event(
        title: 'Today\'s Event 1',
          description: 'Today\'s description 1',
          // 'Today\'s Event 1','Today\'s description 1'
      ),
      Event(
          title: 'Today\'s Event 1',
          description: 'Today\'s description 1',
          // 'Today\'s Event 2','Today\'s description 2'
      ),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 6, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 6 , kToday.day);
