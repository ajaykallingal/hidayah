import 'package:flutter/material.dart';
import 'package:hidayah/src/ui/more/text_style.dart';
import 'package:hidayah/src/ui/more/widgets/more_screen_list_tile_widget.dart';
import 'package:hidayah/src/ui/prayer_times/prayer_times_screen.dart';
import 'package:hidayah/src/ui/qibla%20compass/qibla_compass_widget.dart';

import '../daily_goals/daily_goals_screen.dart';
import '../notes/notes_screen.dart';

class MoreScreen extends StatefulWidget {
  static const String id = 'more_screen';

  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  bool loading = false;
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
              radius: 1.9,
              focal: Alignment.topCenter,
              // focalRadius: 1.0,
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
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "More Tools",
                          style: kMoreScreenHeaderStyle,
                        )),
                    SizedBox(height: 30),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.45,
                      width: MediaQuery.of(context).size.width,
                      // margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            child: MoreScreenListTileWidget(
                              title: 'Prayer Times',
                              subTitle:
                                  'Get the accurate prayer\ntiming everywhere',
                              iconPath: 'assets/images/PRAYERTIMES.png',
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, PrayerTimesScreen.id);
                            },
                          ),
                          // SizedBox(height: 10),
                          // InkWell(
                          //   child: MoreScreenListTileWidget(
                          //     iconPath: 'assets/images/NEAREST MOSQUE.png',
                          //     title: "Nearest Mosques",
                          //     subTitle: "Search nearest mosques around you.",
                          //   ),
                          //   onTap: (){
                          //     Navigator.pushNamed(context, NearByMosques.id);
                          //   },
                          // ),
                          SizedBox(height: 10),

                          InkWell(
                            child: MoreScreenListTileWidget(
                              title: 'Notes',
                              subTitle:
                              'Notes',
                              iconPath: 'assets/images/NOTES.png',
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, NotesScreen.id);

                            },
                          ),
                          SizedBox(height: 10),

                          InkWell(
                            child: MoreScreenListTileWidget(
                              title: 'Qibla Compass',
                              subTitle:
                              'Show accurate qibla\ndirection from your location.',
                              iconPath: 'assets/images/QIBLA_COMPASS.png',
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, QiblaCompassWidget.id);

                            },
                          ),
                          SizedBox(height: 10),

                          InkWell(
                            child: MoreScreenListTileWidget(
                              title: 'Goals',
                              subTitle:
                              'You can always change these later.',
                              iconPath: 'assets/images/to-do-list.png',
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, DailyGoalsScreen.id).then((value) => null);

                            },
                          ),
                          // MoreScreenListTileWidget(iconPath: iconPath, title: title, subTitle: subTitle)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
