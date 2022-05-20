import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/data/bloc/prayer_times_bloc.dart';
import 'package:hidayah/src/ui/prayer_times/prayer_times_screen.dart';
import 'package:intl/intl.dart';

import '../../../data/models/prayerTimes/prayer_time_request.dart';
import '../../../data/models/prayerTimes/prayer_time_response.dart';
import '../textStyle/text_style.dart';

class PrayerTimesCardWidget extends StatefulWidget {
  const PrayerTimesCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PrayerTimesCardWidget> createState() => _PrayerTimesCardWidgetState();
}

class _PrayerTimesCardWidgetState extends State<PrayerTimesCardWidget> {
  Times? prayerTime;
  String upcomingPrayerTime = "please wait..";
  String upcomingPrayerName = "please wait..";
  String timeToNextPrayer = "please wait..";
  DateFormat formatDate = DateFormat("HH:mm");
  final prayerTimeBloc = PrayerTimeBloc();
  bool loading  = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("pos:${position!.latitude.toString()}");
    // prayerTimeBloc.getAllPrayerTimes(
    //     request: GetPrayerTimesRequest(
    //       year: "2022",
    //       month: DateTime.now().month.toString(),
    //       method: "3",
    //       lat: "10.0165393",
    //       // position!.latitude.toString(),
    //       long: "76.3524932",
    //       // position!.longitude.toString(),
    //       day: DateTime.now().day.toString(),
    //     ));
    // fajr = prayerTime!.fajr as DateTime?;
    // isha = prayerTime!.isha as DateTime?;
    // dhuhr = prayerTime!.dhuhr as DateTime?;
    // maghrib = prayerTime!.maghrib as DateTime?;
    // asr = prayerTime!.asr as DateTime?;
    // TimeOfDay.fromDateTime(fajr!);
    // print("fajrtime: ${fajr}");
  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    prayerTimeBloc.getAllPrayerTimes(
        request: GetPrayerTimesRequest(
          year: "2022",
          month: DateTime.now().month.toString(),
          method: "3",
          lat: "10.0165393",
          // position!.latitude.toString(),
          long: "76.3524932",
          // position!.longitude.toString(),
          day: DateTime.now().day.toString(),
        ));
    prayerTimeBloc.prayerTimesFetchSCStreamListener.listen((event) {
      print(DateTime.now());
      print("dataloaded");
      setState(() {
        prayerTime = event.times!;
        // int fajr = int.tryParse(event.times!.fajr.replaceAll(RegExp('[^0-9]'), ''))!;
        // int dhuhr = int.tryParse(event.times!.dhuhr.replaceAll(RegExp('[^0-9]'), ''))!;
        // int asr = int.tryParse(event.times!.asr.replaceAll(RegExp('[^0-9]'), ''))!;
        // int maghrib = int.tryParse(event.times!.maghrib.replaceAll(RegExp('[^0-9]'), ''))!;
        // int isha = int.tryParse(event.times!.isha.replaceAll(RegExp('[^0-9]'), ''))!;
        // int currentTime = int.tryParse(DateFormat.Hm().format(DateTime.now()).replaceAll(RegExp('[^0-9]'), ''))!;

        findPrayerTime(event.times!);

        // if(int.tryParse(event.times!.fajr.replaceAll(RegExp('[^0-9]'), ''))!>int.tryParse(DateFormat.Hm().format(DateTime.now()).replaceAll(RegExp('[^0-9]'), ''))!){
        //   upcomingPrayerTime = event.times!.fajr;
        //   upcomingPrayerName = " Fajr";
        //   timeToNextPrayer = "${DateTime.now().difference(formatDate.parse(event.times!.fajr.replaceAll(' (IST)', ''))).inHours} hours and ${DateTime.now().difference(formatDate.parse(event.times!.fajr.replaceAll(' (IST)', ''))).inMinutes} minutes\n to go";
        //   timeToNextPrayer = formatDate.parse(event.times!.fajr.replaceAll(' (IST)', '')).toString();
        //
        // }
        // else if(int.tryParse(DateFormat.Hm().format(DateTime.now()).replaceAll(RegExp('[^0-9]'), ''))!<int.tryParse(event.times!.fajr.replaceAll(RegExp('[^0-9]'), ''))! && int.tryParse(DateFormat.Hm().format(DateTime.now()).replaceAll(RegExp('[^0-9]'), ''))!>int.tryParse(event.times!.dhuhr.replaceAll(RegExp('[^0-9]'), ''))!){
        //   upcomingPrayerTime = event .times!.dhuhr;
        //   upcomingPrayerName = " Dhuhr";
        // }
        // else if(int.tryParse(DateFormat.Hm().format(DateTime.now()).replaceAll(RegExp('[^0-9]'), ''))!>int.tryParse(event.times!.dhuhr.replaceAll(RegExp('[^0-9]'), ''))! && int.tryParse(DateFormat.Hm().format(DateTime.now()).replaceAll(RegExp('[^0-9]'), ''))!<int.tryParse(event.times!.asr.replaceAll(RegExp('[^0-9]'), ''))!){
        //   upcomingPrayerTime = event .times!.asr;
        //   upcomingPrayerName = " Asr";
        // }
        // else if(int.tryParse(DateFormat.Hm().format(DateTime.now()).replaceAll(RegExp('[^0-9]'), ''))!>int.tryParse(event.times!.asr.replaceAll(RegExp('[^0-9]'), ''))! && int.tryParse(DateFormat.Hm().format(DateTime.now()).replaceAll(RegExp('[^0-9]'), ''))!<int.tryParse(event.times!.maghrib.replaceAll(RegExp('[^0-9]'), ''))!){
        //   upcomingPrayerTime = event .times!.maghrib;
        //   upcomingPrayerName = " Maghrib";
        //   timeToNextPrayer = "${DateTime.now().difference(formatDate.parse(event.times!.maghrib.replaceAll(' (IST)', ''))).inHours} hours and ${DateTime.now().difference(formatDate.parse(event.times!.maghrib.replaceAll(' (IST)', ''))).inMinutes} minutes\n to go";
        //   print(formatDate.parse(event.times!.maghrib.replaceAll(' (IST)', '')).toString()+"cdmckdmkcmd");
        //
        // }
        // else if(int.tryParse(DateFormat.Hm().format(DateTime.now()).replaceAll(RegExp('[^0-9]'), ''))!>int.tryParse(event.times!.maghrib.replaceAll(RegExp('[^0-9]'), ''))! && int.tryParse(DateFormat.Hm().format(DateTime.now()).replaceAll(RegExp('[^0-9]'), ''))!<int.tryParse(event.times!.isha.replaceAll(RegExp('[^0-9]'), ''))!){
        //   upcomingPrayerTime = event .times!.isha;
        //   upcomingPrayerName = " Isha";
        // }
        // else if(int.tryParse(DateFormat.Hm().format(DateTime.now()).replaceAll(RegExp('[^0-9]'), ''))!>int.tryParse(event.times!.isha.replaceAll(RegExp('[^0-9]'), ''))! ){
        //   upcomingPrayerTime = "Update Tomorrow";
        //   upcomingPrayerName = "";
        // }

        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      loading ? Center(
        child: CircularProgressIndicator(color: mainRedShadeForTitle,),
      ) : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prayer Times',
          style: kHomePageCardTitleTextStyle,
        ),
        Divider(
          color: Color(0xFF707070).withOpacity(0.1),
          indent: 0,
          thickness: 0.8,
          endIndent: 0,
        ),
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'Next Prayer is',
                style: kHomePageCard3RichTextStyle1,
                children: <TextSpan>[
                  TextSpan(
                    text: upcomingPrayerName,
                    style: kHomePageCard3RichTextStyle2,
                  ),
                  TextSpan(
                    text: ' at ',
                    style: kHomePageCard3RichTextStyle1,
                  ),
                  TextSpan(
                    text:  upcomingPrayerTime ,
                    style: kHomePageCardTitleTextStyle,
                  ),
                  TextSpan(
                    text: timeToNextPrayer ,
                    style: kHomePageCard3RichTextStyle3,
                  ),
                ]),
          ),
        ),
        SizedBox(height: 15),
        Align(
          alignment: Alignment.bottomRight,
          child: TextButton.icon(

            onPressed: () {
              Navigator.pushNamed(context, PrayerTimesScreen.id);
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            icon: ImageIcon(AssetImage('assets/images/PRAYERTIMES_FILL.png',),color: cardRichTextColor,),
            label: Text('Prayer Times',style: kHomePageCard3ButtonTextStyle,),

          ),
        ),

      ],
    );
  }
  void findPrayerTime(Times pTimes) {
    setState(() {
      int fajr = int.tryParse(pTimes.fajr.replaceAll(RegExp('[^0-9]'), ''))!;
      int dhuhr = int.tryParse(pTimes.dhuhr.replaceAll(RegExp('[^0-9]'), ''))!;
      int asr = int.tryParse(pTimes.asr.replaceAll(RegExp('[^0-9]'), ''))!;
      int maghrib =
      int.tryParse(pTimes.maghrib.replaceAll(RegExp('[^0-9]'), ''))!;
      int isha = int.tryParse(pTimes.isha.replaceAll(RegExp('[^0-9]'), ''))!;
      int currentTime = int.tryParse(DateFormat.Hm()
          .format(DateTime.now())
          .replaceAll(RegExp('[^0-9]'), ''))!;
      var _date = DateFormat("yyyy-MM-dd").format(DateTime.now());

      DateTime fajrDateTime =
      DateTime.parse('$_date ${pTimes.fajr.replaceAll(' (IST)', '')}:00');
      DateTime dhuhrDateTime =
      DateTime.parse('$_date ${pTimes.dhuhr.replaceAll(' (IST)', '')}:00');
      DateTime asrDateTime =
      DateTime.parse('$_date ${pTimes.asr.replaceAll(' (IST)', '')}:00');
      DateTime maghribDateTime = DateTime.parse(
          '$_date ${pTimes.maghrib.replaceAll(' (IST)', '')}:00');
      DateTime ishaDateTime = DateTime.parse(
          '$_date ${pTimes.isha.replaceAll(' (IST)', '')}:00');
      // print(fajrDateTime.difference(DateTime.now()).inHours.toString() + " ttttttttttt");
      calculateTime(DateTime.now());
      if (fajr > currentTime) {
        upcomingPrayerTime = pTimes.fajr;
        upcomingPrayerName = " Fajr";
        calculateTime(fajrDateTime);
      } else if (currentTime > fajr && currentTime < dhuhr) {
        upcomingPrayerTime = pTimes.dhuhr;
        upcomingPrayerName = " Dhuhr";
        calculateTime(dhuhrDateTime);
      } else if (currentTime > dhuhr && currentTime < asr) {
        upcomingPrayerTime = pTimes.asr;
        upcomingPrayerName = " Asr";
        calculateTime(asrDateTime);
      } else if (currentTime > asr && currentTime < maghrib) {
        upcomingPrayerTime = pTimes.maghrib;
        upcomingPrayerName = " Maghrib";
        calculateTime(maghribDateTime);
      } else if (currentTime > maghrib && currentTime < isha) {
        upcomingPrayerTime = pTimes.isha;
        upcomingPrayerName = " Isha";
        calculateTime(ishaDateTime);
      } else if (currentTime > isha) {
        upcomingPrayerTime = "Update Tomorrow";
        upcomingPrayerName = "";
        timeToNextPrayer = " ";

      }
    });
  }
  void calculateTime(DateTime dateTime) {
    setState(() {
      if (dateTime.difference(DateTime.now()).inMinutes > 59) {
        timeToNextPrayer =
        "${dateTime.difference(DateTime.now()).inHours} hours and ${(dateTime.difference(DateTime.now()).inMinutes) % 60} minutes\n to go";
      } else {
        timeToNextPrayer =
        "${dateTime.difference(DateTime.now()).inMinutes} minutes to go";
      }
    });
  }

}