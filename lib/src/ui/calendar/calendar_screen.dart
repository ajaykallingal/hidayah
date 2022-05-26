import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/data/bloc/calendar_events_bloc.dart';
import 'package:hidayah/src/data/models/calendar_events/calendar_events.dart';
import 'package:hidayah/src/ui/calendar/event_add.dart';
import 'package:hidayah/src/ui/calendar/utils.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants/font_family.dart';
import '../prayer_times/text_style.dart';

class CalendarScreen extends StatefulWidget {
  static const String id = 'calendar_screen';

  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with TickerProviderStateMixin {

  ValueNotifier<List<Event>>? _selectedEvents = ValueNotifier([]);
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  bool loading = true;

  final calendarEventBloc = CalendarEventBloc();

  // LinkedHashMap<DateTime, List<Event>> kEvents = LinkedHashMap<DateTime, List<Event>>(
  //   equals: isSameDay,
  //   hashCode: getHashCode,
  // )..addAll(_kEventSource);
  Map<DateTime, List<Event>>? kEvents;
  TextEditingController? _eventController;

  @override
  void initState() {
    super.initState();
    _eventController = TextEditingController();
    calendarEventBloc.fetchCalendarEvents();
    _selectedDay = _focusedDay;
  }

  List<ResponseOfCalendarEvents> events = List.empty(growable: true);
  List<List<ResponseOfCalendarEvents>> eventList = List.empty(growable: true);

  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    calendarEventBloc.calendarEventsSCStreamListener.listen((event) {
      setState(() {
        for (var element in event.response!) {
          for (var item in event.response!) {
            if (element.eventDate == item.eventDate) {
              events.add(item);
            }
          }
          eventList.add(events);
          events = List.empty(growable: true);
        }

        final _kEventSource = {
          for (var item in List.generate(eventList.length, (index) => index))
            DateTime.utc(
                DateTime
                    .parse(eventList[item][0].eventDate)
                    .year,
                DateTime
                    .parse(eventList[item][0].eventDate)
                    .month,
                DateTime
                    .parse(eventList[item][0].eventDate)
                    .day):
            List.generate(eventList[item].length,
                    (index) => Event(eventList[item][index].eventDescription))
        };
        kEvents = LinkedHashMap<DateTime, List<Event>>(
          equals: isSameDay,
          hashCode: getHashCode,
        )
          ..addAll(_kEventSource);
        _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
        loading = false;
      });
    });
  }

  @override
  void dispose() {
    _selectedEvents!.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents![day] ?? [];
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

      _selectedEvents!.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = DateTime.now();
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents!.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents!.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents!.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              colors: [
                Color(0xffE80000),
                Color(0xff382424),
              ],
              radius: 1.6,
              focal: Alignment.topCenter,
              // focalRadius: 1.5,
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/bg_pattern.png'),
            ),
          ),
        ),
        SafeArea(
          child: Material(
            type: MaterialType.transparency,
            child: CustomScrollView(
              shrinkWrap: true,
              anchor: 0.0,
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  leadingWidth: 0,
                  leading: Container(),
                  backgroundColor: Colors.transparent,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Calendar",
                        style: kPrayerTimeScreenHeaderStyle,
                      ),
                    ],
                  ),
                  pinned: true,
                  floating: true,
                  expandedHeight: 110,
                  flexibleSpace: FlexibleSpaceBar(
                    expandedTitleScale: 1.0,
                    titlePadding: EdgeInsets.only(right: 4),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            // fixedSize: Size(60, 10),
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          onPressed: () {
                            addEventDialogBox();
                          },
                          label: Text(
                            "Add Event",
                            style: TextStyle(color: mainRedShadeForTitle),
                          ),
                          icon: Icon(
                            Icons.add,
                            color: mainRedShadeForTitle,
                          ),
                        ),
                      ],
                    ),

                  ),


                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Visibility(
                              visible: !loading,
                              child:

                      SingleChildScrollView(

                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.white.withOpacity(1),
                                child: TableCalendar<Event>(

                                  firstDay: kFirstDay,
                                  lastDay: kLastDay,
                                  focusedDay: _focusedDay,
                                  selectedDayPredicate: (day) =>
                                      isSameDay(_selectedDay, day),
                                  rangeStartDay: _rangeStart,
                                  rangeEndDay: _rangeEnd,
                                  calendarFormat: _calendarFormat,
                                  rangeSelectionMode: _rangeSelectionMode,
                                  eventLoader: _getEventsForDay,
                                  startingDayOfWeek: StartingDayOfWeek.monday,
                                  calendarStyle: CalendarStyle(
                                    // Use `CalendarStyle` to customize the UI
                                    outsideDaysVisible: false,
                                    markersAutoAligned: true,
                                    isTodayHighlighted: true,
                                    disabledTextStyle: TextStyle(
                                        color: Colors.black),
                                    weekendTextStyle: TextStyle(
                                        color: Colors.red),
                                    canMarkersOverflow: true,
                                    defaultTextStyle: TextStyle(
                                        color: Colors.black),
                                    todayDecoration: BoxDecoration(
                                        color: mainRedShadeForTitle,
                                        shape: BoxShape.circle),
                                    selectedDecoration: BoxDecoration(
                                        color: mainRedShadeForTitle,
                                        shape: BoxShape.circle),
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
                                  pageJumpingEnabled: true,
                                  pageAnimationEnabled: true,
                                  headerStyle: HeaderStyle(
                                    titleCentered: true,
                                    titleTextStyle:
                                    TextStyle(color: mainRedShadeForTitle),
                                    formatButtonDecoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(
                                            10)),
                                  ),
                                  onPageChanged: (focusedDay) {
                                    _focusedDay = focusedDay;
                                  },
                                ),
                              ),
                              ValueListenableBuilder<List<Event>>(
                                valueListenable:
                                !loading ? _selectedEvents! : ValueNotifier([]),
                                builder: (context, value, _) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    // physics: NeverScrollableScrollPhysics(),
                                    itemCount: value.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onLongPress: (){
                                          editEventDialogBox();
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 12.0,
                                            vertical: 4.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(1),
                                            // border: Border.all(),
                                            borderRadius: BorderRadius.circular(
                                                12.0),
                                          ),
                                          child: ListTile(
                                            onTap: () => print('${value[index]}'),
                                            title: Text(
                                              '${value[index]}',
                                              style:
                                              TextStyle(
                                                  color: mainRedShadeForText),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),

                            ],
                          ),
                        ),
                        physics: NeverScrollableScrollPhysics(),

                      ),
                      ),
                    ],
                  ),
                ),

              ],
            ),


            // child: Stack(
            //   children: [
            //
            //   ],
            // ),
          ),
        ),
      ],
    );
  }


  TextFormField eventContent() {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      controller: _eventController,
      maxLines: 8,
      decoration: InputDecoration(

          border: OutlineInputBorder(
            borderSide: BorderSide(color: mainRedShadeForTitle),
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );
  }
  Future editEventDialogBox() {
    return showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              alignment: Alignment.center,

              title: Text("Edit Event",style: kCalendarAddEventStyle,),
              content: eventContent(),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: mainRedShadeForTitle),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 10,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel",style: kCalendarAddEventButtonStyle,),
                ),
                TextButton(
                  onPressed: () {
                    if(_eventController!.text.isEmpty)return;
                    setState(() {
                      if(kEvents![_selectedDay] != null) {
                        kEvents![_selectedDay]!.add(Event(_eventController!.text),);
                      }else{
                        kEvents![_selectedDay] = [
                          Event(_eventController!.text),
                        ];
                      }
                      _eventController!.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.pop(context);
                    });
                  },
                  child: Text("Edit",style: kCalendarAddEventButtonStyle,),),
              ],
            ));
  }

  Future addEventDialogBox() {
    return showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              alignment: Alignment.center,

              title: Text("Add Event",style: kCalendarAddEventStyle,),
              content: eventContent(),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: mainRedShadeForTitle),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 10,
              actions: [
                TextButton(
                  onPressed: () {
                  Navigator.of(context).pop();
                  },
                  child: Text("Cancel",style: kCalendarAddEventButtonStyle,),
                ),
                TextButton(
                    onPressed: () {
                     if(_eventController!.text.isEmpty)return;
                     setState(() {
                       if(kEvents![_selectedDay] != null) {
                         kEvents![_selectedDay]!.add(Event(_eventController!.text),);
                       }else{
                         kEvents![_selectedDay] = [
                           Event(_eventController!.text),
                         ];
                       }
                       _eventController!.clear();
                       FocusManager.instance.primaryFocus?.unfocus();
                       Navigator.pop(context);
                      });
                    },
                    child: Text("Add",style: kCalendarAddEventButtonStyle,),),
              ],
            ));
  }
}

// getEventsFromDay(DateTime? selectedDay) {
//   return
// }

