// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String title;
  final DateTime date;
  final String type;

  const Event(this.title, this.date, this.type);

  @override
  String toString() => title;
}

// example dates
final fechas = [
  DateTime.parse('2021-07-02T07:12'),
  DateTime.parse('2021-07-11T07:12'),
  DateTime.parse('2021-08-10T07:12'),
  DateTime.parse('2021-08-08T07:12'),
  DateTime.parse('2021-08-12T07:12'),
  DateTime.parse('2021-08-01T07:12')
];

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource= {
    kToday: [
      Event('Public Holiday', kToday, "holiday"),
      Event('Today\'s Event 2', kToday, "test"),
    ],
    fechas[0]: [
      Event('Testing', fechas[0], "test"),
      Event('evento 2', fechas[0], "test"),
    ],
    fechas[1]: [
      Event('Public Holiday', fechas[1], "holiday"),
      Event('evento 2', fechas[1], "test"),
    ],
    fechas[2]: [
      Event('Public Holiday', fechas[2], "holiday"),
      Event('evento 2', fechas[2], "test"),
    ],
    fechas[3]: [
      Event('evento', fechas[3], "event"),
      Event('evento 2', fechas[3], "test"),
    ],
    fechas[4]: [
      Event('evento', fechas[4], "event"),
      Event('evento 2', fechas[4], "test"),
    ],
    fechas[5]: [
      Event('evento', fechas[5], "test"),
      Event('evento 2', fechas[5], "test"),
    ],
};
// final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
//     key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
//     value: (item) => List.generate(
//         item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
//   ..addAll({
//     kToday: [
//       Event('Today\'s Event 1'),
//       Event('Today\'s Event 2'),
//     ],
//   });

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
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

Color colorByType(Event event){
  var eventColor;
  if(event.type == "test") eventColor = Colors.green[400];
  if(event.type == "event") eventColor = Color.fromRGBO(243, 150, 7, 1);
  if(event.type == "holiday") eventColor = Color.fromRGBO(249, 53, 52, 1);

  return eventColor;
  
}