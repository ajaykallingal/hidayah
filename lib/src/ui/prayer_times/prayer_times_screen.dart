import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/data/bloc/prayer_times_bloc.dart';
import 'package:hidayah/src/data/models/prayer_time_response.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';
import 'package:hidayah/src/ui/home/textStyle/text_style.dart';
import 'package:hidayah/src/ui/prayer_times/text_style.dart';

class PrayerTimesScreen extends StatefulWidget {
  static const String id = 'prayer_time_screen';

  const PrayerTimesScreen({Key? key}) : super(key: key);

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  final prayerTimeBloc = PrayerTimeBloc();
  List<Datum> prayerTimedata = [];
  bool loading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    prayerTimeBloc.viewAllPrayerTimesResponse.listen((event) {
      if (event != null) {
        setState(() {
          loading = false;
          // prayerTimedata = event;

          ;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                child:

                      Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          leading:
                          Icon(Icons.arrow_back, color: mainThemeWhiteColor),
                          title: Text(
                            "",
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
                              Text("Dubai,United Arab Emirates"),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text("Asr", style: KDividedLeftSideTextStyle1),
                                SizedBox(height: 20),
                                ImageIcon(
                                  AssetImage("assets/images/SUNSET.png"),
                                  color: mainThemeWhiteColor,
                                ),
                                Text("sunset", style: KDividedLeftSideTextStyle2),
                                Text("07:11 PM", style: KDividedLeftSideTextStyle2)
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
                                    Text("Maghrib",
                                        style: KDividedRightSideTextStyle2),
                                    Text("6:45 PM",
                                        style: KDividedRightSideTextStyle1),
                                  ],
                                ),
                                Text("2 hours and 21 minutes\n to go"),
                                ImageIcon(
                                  AssetImage("assets/images/SUNSET.png"),
                                  color: mainThemeWhiteColor,
                                ),
                                Text("sunset", style: KDividedLeftSideTextStyle2),
                                Text("07:11 PM", style: KDividedLeftSideTextStyle2),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
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
                                "Today/Sunday",
                                style: kPrayerTimeCardHeaderStyle,
                              ),
                              Text(
                                "21 Jamadi-ui-Thani 1442 AH",
                                style: kPrayerTimeCardHeaderStyle,
                              ),
                              Text(
                                "03 Jan 2021",
                                style: kPrayerTimeCardHeaderStyle,
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "data",
                                    style: kPrayerTimeCardTextStyle1,
                                  ),
                                  Text(
                                    "data",
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "data",
                                    style: kPrayerTimeCardTextStyle1,
                                  ),
                                  Text(
                                    "data",
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "data",
                                    style: kPrayerTimeCardTextStyle1,
                                  ),
                                  Text(
                                    "data",
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "data",
                                    style: kPrayerTimeCardTextStyle1,
                                  ),
                                  Text(
                                    "data",
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "data",
                                    style: kPrayerTimeCardTextStyle1,
                                  ),
                                  Text(
                                    "data",
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
                    ) ,
                  // Center(child: CircularProgressIndicator(color: mainThemeWhiteColor),);




              ),
            ],
          ),
        ),
      ],
    );
  }
}
