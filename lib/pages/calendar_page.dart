// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  // styles
  final headerStyle = TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w600, fontSize: 24, color: Colors.white);

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 245, 245, 1),
      appBar: AppBar(
        leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop()
        ),
        backgroundColor: Color.fromRGBO(116, 67, 230, 1),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(),
        title: Text('Calendar',style: headerStyle,),
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            calendarBuilders: CalendarBuilders(
              singleMarkerBuilder: (context, date, event){
                var eventColor =  colorByType(event);
                return Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: eventColor,
                    shape: BoxShape.circle,
                  ),
                );
              } 
            ),
              headerStyle: HeaderStyle(
              leftChevronMargin: EdgeInsets.only(left: 70),
              rightChevronMargin: EdgeInsets.only(right: 70),
              leftChevronIcon: Icon(Icons.arrow_back_ios, color: Colors.white),
              rightChevronIcon: Icon(Icons.arrow_forward_ios, color: Colors.white),
              titleTextStyle: headerStyle,
              titleCentered: true,
              formatButtonVisible: false,
              decoration: BoxDecoration(
                color: Color.fromRGBO(116, 67, 230, 1),
              )
            ),
            holidayPredicate: (day) {
              // Every 20th day of the month will be treated as a holiday
              return day.day == 20;
            },
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              rowDecoration: BoxDecoration(
                color: Colors.white
              ),
              // Use `CalendarStyle` to customize the UI
              canMarkersOverflow: false,
              markersAutoAligned: false,
              markersOffset: PositionedOffset(
                top: 6,
                start: 9
              ),
              markersMaxCount: 1,
              markerSizeScale: 1,
              outsideDaysVisible: false,
              holidayTextStyle: TextStyle(color: Colors.white),
              holidayDecoration: BoxDecoration(
                color: Color.fromRGBO(249, 53, 52, 1),
                shape: BoxShape.circle,
              )
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white, border: Border.all(width: 1, color: Colors.grey.shade400) ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 16),
                        height: 10, width: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green[400] ),
                      ),
                      Text("Test"),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white, border: Border.all(width: 1, color: Colors.grey.shade400) ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 16),
                        height: 10, width: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(243, 150, 7, 1) ),
                      ),
                      Text("Event"),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white, border: Border.all(width: 1, color: Colors.grey.shade400) ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 16),
                        height: 10, width: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(249, 53, 52, 1)),
                      ),
                      Text("Holiday"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, widget) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    var eventColor = colorByType(value[index]);
                    DateFormat formatter = DateFormat('d MMM, yyyy E');
                    String formatted = formatter.format(value[index].date);
                    // print(formatted);
                    return  Container(
                      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(
                        color: Colors.grey, blurRadius: 2.0,
                        offset: Offset(0.0, 1.0)
                      )]),
                      margin: EdgeInsets.only(bottom: 8),
                      height: 100,
                      child: ListTile(
                          title: Container(
                            margin: EdgeInsets.only(bottom: 16, top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${value[index].type}',style: TextStyle(color: eventColor, fontFamily: 'Raleway', fontWeight: FontWeight.w600, fontSize: 20)),
                                Text('$formatted', style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w600, fontSize: 20))
                              ],
                            ),
                          ),
                          subtitle: Text('${value[index].title}', style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black), ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}