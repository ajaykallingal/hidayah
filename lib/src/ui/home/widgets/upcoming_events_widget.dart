import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/data/models/calendar_events/calendar_events.dart';
import 'package:hidayah/src/ui/calendar/calendar_screen.dart';

import '../../../data/bloc/calendar_events_bloc.dart';
import '../textStyle/text_style.dart';

class UpcomingEventsWidget extends StatefulWidget {
  const UpcomingEventsWidget({
    Key? key,
  }) : super(key: key);

  // final String _upcomingEventsImageUrl;

  @override
  State<UpcomingEventsWidget> createState() => _UpcomingEventsWidgetState();
}

class _UpcomingEventsWidgetState extends State<UpcomingEventsWidget> {
  final calendarEventBloc = CalendarEventBloc();
  List<ResponseOfCalendarEvents> resposneOfCalendar =
      List.empty(growable: true);
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calendarEventBloc.fetchCalendarEvents();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    calendarEventBloc.calendarEventsSCStreamListener.listen((event) {
      setState(() {
        resposneOfCalendar = event.response!;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !loading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upcoming Events',
            style: kHomePageCardTitleTextStyle,
          ),
          Divider(
            color: const Color(0xFF707070).withOpacity(0.1),
            indent: 0,
            thickness: 0.8,
            endIndent: 0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 10),
            child: SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: resposneOfCalendar.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    tileColor: mainRedShadeForTitle,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    style: ListTileStyle.list,
                    title: Text(
                      resposneOfCalendar[index].eventName,
                      style: kHomePageCard1GoalsStyle,
                    ),
                    subtitle: Text(
                      resposneOfCalendar[index].eventDate,
                      style: kHomePageCard1GoalsStyle,
                    ),
                  );
                },
                physics: BouncingScrollPhysics(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, CalendarScreen.id);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              icon: ImageIcon(
                const AssetImage(
                  'assets/images/CALENDER FILL.png',
                ),
                color: cardRichTextColor,
              ),
              label: Text(
                'Calender',
                style: kHomePageCard3ButtonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
