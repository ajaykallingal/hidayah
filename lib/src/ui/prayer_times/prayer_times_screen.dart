import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/data/bloc/prayer_times_bloc.dart';
import 'package:hidayah/src/data/models/prayerTimes/prayer_time_request.dart';
import 'package:hidayah/src/data/models/prayerTimes/prayer_time_response.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';
import 'package:hidayah/src/ui/home/textStyle/text_style.dart';
import 'package:hidayah/src/ui/prayer_times/text_style.dart';
import 'package:intl/intl.dart';

import '../../data/provider/get_prayer_times.dart';

class PrayerTimesScreen extends StatefulWidget {
  static const String id = 'prayer_time_screen';

  const PrayerTimesScreen({Key? key}) : super(key: key);

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> animation1;



  final prayerTimeBloc = PrayerTimeBloc();
  Response? responseDetails;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  String Address = "Fetching your location...";
  Position? position;
  static const String kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String kPermissionDeniedMessage = 'Permission denied.';
  static const String kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String kPermissionGrantedMessage = 'Permission granted.';

  static String formatTime(int val) {
    if (val > 12) {
      return ("PM");
    } else
      return ("AM");
  }

  Times? prayerTime;
  DateTime? newTime;

  bool loading = false;
  bool isAnimating = false;

  String upcomingPrayerTime = "please wait..";
  String upcomingPrayerName = "please wait..";
  String timeToNextPrayer = "please wait..";

  DateFormat formatDate = DateFormat("HH:mm");

  // GetPrayerTimesRequest get request => GetPrayerTimesRequest(year: "", month: "", method: "", lat: "", long: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentPosition();
    // print("pos:${position!.latitude.toString()}");
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
    // fajr = prayerTime!.fajr as DateTime?;
    // isha = prayerTime!.isha as DateTime?;
    // dhuhr = prayerTime!.dhuhr as DateTime?;
    // maghrib = prayerTime!.maghrib as DateTime?;
    // asr = prayerTime!.asr as DateTime?;
    // TimeOfDay.fromDateTime(fajr!);
    // print("fajrtime: ${fajr}");

    animationController = AnimationController(
      vsync: this,
      duration: (Duration(seconds: 5)),
    );
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeInExpo );
    animation.addListener(() => this.setState(() {}));
    animationController.forward();
    animation1 = CurvedAnimation(parent: animationController, curve: Curves.linearToEaseOut);
    animation1.addListener(() => this.setState(() {}));

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
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



  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks[0];
    Address =
        '${place.name}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      print(Address);
      print(position.latitude);
      print(position.longitude);
      // lat = widget.latLang;
      // long = widget.latLang;
    });
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _updatePositionList(
          _PositionItemType.log, kLocationServicesDisabledMessage);
      return false;
    }
    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        _updatePositionList(_PositionItemType.log, kPermissionDeniedMessage);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _updatePositionList(
          _PositionItemType.log, kPermissionDeniedForeverMessage);
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    _updatePositionList(_PositionItemType.log, kPermissionGrantedMessage);
    return true;
  }

  void _updatePositionList(_PositionItemType type, String displayValue) {
    _positionItems.add(_PositionItem(type, displayValue));
    setState(() {});
  }

  // void showWitchPrayerTime(){
  //   if(DateTime.now )
  // }

  @override
  Widget build(BuildContext context) {
// print(DateFormat('dd-MM-yyyy').format(DateTime.now()));

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
          child: Stack(
            children: [
              Material(
                type: MaterialType.transparency,
                child: Column(
                  children: [
                    SizedBox(
                      height: 90,
                    ),
                    Image.asset(
                      "assets/images/MOSQUE BACKGROUND.png",
                      fit: BoxFit.cover,
                    )
                  ],
                ),
              ),
              Material(
                type: MaterialType.transparency,
                child: StreamBuilder<GetPrayerTimesReponse>(
                  stream: prayerTimeBloc.prayerTimesFetchSCStreamListener,
                  builder: (BuildContext context, snapshot) {
                    print("snapshot: ${snapshot.data}");
                    if (snapshot.data == null) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: mainRedShadeForTitle,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      // snapshot.data!.times!.any((element) =>
                      //     element.containsKey(
                      //         DateFormat('dd-MM-yyyy').format(
                      //             DateTime.now())));
                      // snapshot.data!.times!.forEach((element) {if(element.containsKey(
                      //     DateFormat('dd-MM-yyyy').format(
                      //         DateTime.now()))){
                      //   // print(element.)
                      //
                      //    print("index is : "+snapshot.data!.times!.indexOf(element).toString());
                      // }});
                      // // int index = snapshot.data!.times!.contains(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                      // print(snapshot.data!.times!.map((e) => e.keys == DateFormat('dd-MM-yyyy').format(DateTime.now())));
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            ListTile(
                              leading: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white.withOpacity(1),
                                ),
                              ),
                              title: Text(
                                "Prayer Times",
                                style: kPrayerTimeScreenHeaderStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 28),
                              child: Row(
                                children: [
                                  ImageIcon(
                                    AssetImage("assets/images/LOCATION.png"),
                                    color: mainThemeWhiteColor,
                                    size: 15,
                                  ),
                                  SizedBox(width: 4),
                                  Text(Address),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    // if()...[
                                    //   Text("fajr"),
                                    // ],
                                    Text("",
                                        style: KDividedLeftSideTextStyle1),

                                    SizedBox(height: 20),
                                    ImageIcon(
                                      AssetImage("assets/images/SUNSET.png"),
                                      size: isAnimating ? 26 : animation1.value * 26 ,
                                      color: mainThemeWhiteColor,
                                    ),
                                    Text("sunset",
                                        style: KDividedLeftSideTextStyle2),
                                    Text(prayerTime!.sunset,
                                        style: KDividedLeftSideTextStyle2),
                                  ],
                                ),
                                VerticalDivider(
                                  color: Colors.black.withOpacity(1),
                                  // endIndent: 10,
                                  // indent: 10,
                                  thickness: 4,
                                ),
                                Column(
                                  children: [
                                    Text("UPCOMING PRAYER",
                                        style: KDividedRightSideTextStyle1),
                                    Row(
                                      children: [
                                        Text(upcomingPrayerName,
                                            style: KDividedRightSideTextStyle2),
                                        SizedBox(width: 5),
                                        Text(upcomingPrayerTime,
                                            style: KDividedRightSideTextStyle1),
                                      ],
                                    ),
                                    Text(timeToNextPrayer),
                                    ImageIcon(

                                      AssetImage("assets/images/SUNSET.png"),
                                      size: animation.value * 26,
                                      color: mainThemeWhiteColor,
                                    ),
                                    Text("sunrise",
                                        style: KDividedLeftSideTextStyle2),
                                    Text(prayerTime!.sunrise,
                                        style: KDividedLeftSideTextStyle2),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Stack(
                              children: [
                                Container(

                                  margin: EdgeInsets.all(20),
                                  padding: EdgeInsets.all(20),
                                 
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: mainThemeWhiteColor,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Today/${DateFormat.EEEE().format(DateTime.now())}",
                                        style: kPrayerTimeCardHeaderStyle,
                                      ),
                                      // Text(
                                      //   "21 Jamadi-ui-Thani 1442 AH",
                                      //   style: kPrayerTimeCardHeaderStyle,
                                      // ),
                                      Text(
                                        DateFormat("yyyy-MM-dd").format(DateTime.now()),
                                        style: kPrayerTimeCardHeaderStyle,
                                      ),
                                      SizedBox(height: 10),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Text(
                                      //       "Fajr",
                                      //       style: kPrayerTimeCardTextStyle1,
                                      //     ),
                                      //     Text(
                                      //       // snapshot.data!.times!.map((e) => e.keys).toString(),
                                      //       prayerTime != null
                                      //           ? prayerTime!.asr.toString()
                                      //           : "Afaf",
                                      //       style: kPrayerTimeCardTextStyle1,
                                      //     ),
                                      //   ],
                                      // ),
                                      Divider(
                                        color: kCardGreyShadeForText,
                                        indent: 5,
                                        endIndent: 5,
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Fajr",
                                            style: kPrayerTimeCardTextStyle1,
                                          ),
                                          MediaQuery(
                                            data: MediaQuery.of(context).copyWith(
                                                alwaysUse24HourFormat: false),
                                            child: Text(
                                              prayerTime != null
                                                  ? prayerTime!.fajr.toString()
                                                  : "Afaf",
                                              style: kPrayerTimeCardTextStyle1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: kCardGreyShadeForText,
                                        indent: 5,
                                        endIndent: 5,
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Dhuhr",
                                            style: kPrayerTimeCardTextStyle1,
                                          ),
                                          Text(
                                            prayerTime != null
                                                ? prayerTime!.dhuhr
                                                : "Something Went Wrong!",
                                            style: kPrayerTimeCardTextStyle1,
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: kCardGreyShadeForText,
                                        indent: 5,
                                        endIndent: 5,
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Asr",
                                            style: kPrayerTimeCardTextStyle1,
                                          ),
                                          Text(
                                            prayerTime != null
                                                ? prayerTime!.asr
                                                : "Something Went Wrong!",
                                            style: kPrayerTimeCardTextStyle1,
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: kCardGreyShadeForText,
                                        indent: 5,
                                        endIndent: 5,
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Maghrib",
                                            style: kPrayerTimeCardTextStyle1,
                                          ),
                                          Text(
                                            prayerTime != null
                                                ? prayerTime!.maghrib
                                                : "Something Went Wrong!",
                                            style: kPrayerTimeCardTextStyle1,
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: kCardGreyShadeForText,
                                        indent: 5,
                                        endIndent: 5,
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Isha",
                                            style: kPrayerTimeCardTextStyle1,
                                          ),
                                          Text(
                                            prayerTime != null
                                                ? prayerTime!.isha
                                                : "Something Went Wrong!",
                                            style: kPrayerTimeCardTextStyle1,
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: kCardGreyShadeForText,
                                        indent: 5,
                                        endIndent: 5,
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
                // Center(child: CircularProgressIndicator(color: mainThemeWhiteColor),);
              ),
            ],
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

enum _PositionItemType {
  log,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}
