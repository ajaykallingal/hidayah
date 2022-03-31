import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/ui/Quran/quran_screen.dart';
import 'package:hidayah/src/ui/dhikr/dhikr_screen.dart';
import 'package:hidayah/src/ui/duas/duas_screen.dart';
import 'package:hidayah/src/ui/home/textStyle/text_style.dart';
import 'package:hidayah/src/ui/home/widgets/PrayerTimesCardWidget.dart';
import 'package:hidayah/src/ui/home/widgets/daily_duas_widget.dart';
import 'package:hidayah/src/ui/home/widgets/daily_quotes_widget.dart';
import 'package:hidayah/src/ui/home/widgets/daily_verse_widget.dart';
import 'package:hidayah/src/ui/home/widgets/hadith_of_the_day_widget.dart';
import 'package:hidayah/src/ui/home/widgets/inspiratonal_videos_widget.dart';
import 'package:hidayah/src/ui/home/widgets/upcoming_events_widget.dart';
import 'package:hidayah/src/ui/more/more_screen.dart';
import 'package:hidayah/src/ui/more/text_style.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'components/glass_morphic_container.dart';
import 'widgets/home_page_card_widget.dart';
import 'components/round_container_with_tick.dart';
import 'components/round_container_without_tick_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late YoutubePlayerController _controller;

  late TextEditingController _videoIdController;
  late TextEditingController _seekToController;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  final _upcomingEventsImageUrl =
      "https://image.shutterstock.com/image-illustration/eid-mubarak-islamic-design-crescent-260nw-1962740215.jpg";
  final _dailyQuotesImageUrl =
      "https://www.betterlyf.com/articles/wp-content/uploads/2021/02/Top-islamic-quotes.jpg";
  final _videoIds = [
    // "zBNUdeWw-wE"
    "k8dKImAwVs0"
  ];

  bool isPrayer1Checked = false;
  bool isPrayer2Checked = false;
  bool isPrayer3Checked = false;
  bool isPrayer4Checked = false;
  bool isPrayer5Checked = false;
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _videoIds.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
        controlsVisibleAtStart: true,
        useHybridComposition: true,
      ),
    )..addListener(listener);
    // _videoIdController = TextEditingController();
    // _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _seekToController.dispose();
    _controller.dispose();
    _videoIdController.dispose();
    super.dispose();
  }

  void _onTapped(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> _screenWidgets = <dynamic>[
      buildHomeScreenBody(context),
      DhikrScreen(),
      QuranScreen(),
      DuasScreen(),
      MoreScreen(),


    ];


    return Stack(
      children: [
        Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          persistentFooterButtons: [

            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
                child: buildBottomNavBar()),
          ],
          body:        _screenWidgets.elementAt(selectedIndex),

        ),
      ],
    );
    // Container(
    //   height: 30,
    //   width: MediaQuery.of(context).size.width,
    //   color: Colors.green,
    // ),
  }

  Container buildHomeScreenBody(BuildContext context) {
    return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              colors: [
                Color(0xffE80000),
                Color(0xff382424),
              ],
              radius: 1.7,
              focal: Alignment.center,
              // focalRadius: 1.0,
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/bg_pattern.png'),
            ),
          ),
          child: Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GlassMorphicContainer(
                              icon: AssetImage('assets/images/SETTINGS.png'),
                            ),
                            GlassMorphicContainer(
                              icon: AssetImage(
                                  'assets/images/NOTIFICATION.png'),
                            ),
                          ],
                        ),
                        SizedBox(height: 13),
                        Container(
// color: Colors.green,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ImageIcon(
                                        AssetImage(
                                            'assets/images/LOCATION.png'),
                                        color: Colors.white.withOpacity(1.0),
                                        size: 17,
                                      ),
// SizedBox(width: 5),
                                      Text(
                                        'Dubai,United Arab Emirates',
                                        style: kTopLeftCornerTextStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 7),
                                  Text(
                                    '21 Jamadi-ul-Thani 1442 AH',
                                    style: kTopLeftCornerTextStyle,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Wednesday, 03 February 2021',
                                    style: kTopLeftCornerTextStyle,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Maghrib',
                                    style: kTopRightCornerTextStyle1,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '6:45',
                                    style: kTopRightCornerTextStyle2,
                                  ),
                                  SizedBox(height: 1),
                                  Text(
                                    '00:10:44',
                                    style: kTopRightCornerTextStyle3,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.26,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(10),
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            buildHomePagecard1(),
                            SizedBox(height: 10),
                            buildHomePageCard2(),
                            SizedBox(height: 10),
                            buildHomePageCard3(),
                            SizedBox(height: 10),
                            buildHomePageCard4(),
                            SizedBox(height: 10),
                            buildHomePageCard5(),
                            SizedBox(height: 10),
                            buildHomePageCard6(),
                            SizedBox(height: 10),
                            buildHomePageCard7(),
                            SizedBox(height: 10),
                            buildHomePageCard8(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
  }

  ClipRRect buildBottomNavBar() {
    return ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: BottomNavigationBar(
              elevation: 10,
              currentIndex: selectedIndex,
              backgroundColor: mainThemeWhiteColor,
              showSelectedLabels: true,
              unselectedItemColor: kCardGreyShadeForText,
              selectedItemColor: mainRedShadeForTitle,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: ImageIcon(
                        AssetImage('assets/images/CALENDER NAV.png')),
                    label: "Today"),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('assets/images/DIKR NAV.png')),
                    label: "Dhikr"),
                BottomNavigationBarItem(
                    icon:
                        ImageIcon(AssetImage('assets/images/QURAN NAV.png')),
                    label: "Quran"),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('assets/images/DUAS NAV.png')),
                    label: "Duas"),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('assets/images/MORE NAV.png')),
                    label: "More"),
              ],
              onTap: _onTapped,
            ),

          );
  }

  Widget buildHomePagecard1() {
    return HomePageCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s Goals',
            style: kHomePageCardTitleTextStyle,
          ),
          Divider(
            color: Color(0xFF707070).withOpacity(0.1),
            indent: 0,
            thickness: 0.8,
            endIndent: 0,
          ),
          SizedBox(height: 9),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Prayers',
                style: kHomePageCard1TextStyle1,
              ),
              SizedBox(width: 10),
              buildInkWellWithToggleTick1(),
              SizedBox(width: 10),
              buildInkWellWithToggleTick2(),
              SizedBox(width: 10),
              buildInkWellWithToggleTick3(),
              SizedBox(width: 10),
              buildInkWellWithToggleTick4(),
              SizedBox(width: 10),
              buildInkWellWithToggleTick5(),
              SizedBox(width: 10),
              Text(
                '2 out of 5',
                style: kHomePageCard1PrayernamesTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  InkWell buildInkWellWithToggleTick1() {
    return InkWell(
      onTap: () {
        setState(() {
          isPrayer1Checked = !isPrayer1Checked;
        });
      },
      child: Container(
        height: 25,
        width: 25,
        child: isPrayer1Checked == true
            ? RoundContainerWithTick()
            : RoundContainerWithoutTick(prayerName: 'Fajir'),
      ),
    );
  }

  InkWell buildInkWellWithToggleTick2() {
    return InkWell(
      onTap: () {
        setState(() {
          isPrayer2Checked = !isPrayer2Checked;
        });
      },
      child: Container(
        height: 25,
        width: 25,
        child: isPrayer2Checked == true
            ? RoundContainerWithTick()
            : RoundContainerWithoutTick(prayerName: 'Dhuhr'),
      ),
    );
  }

  InkWell buildInkWellWithToggleTick3() {
    return InkWell(
      onTap: () {
        setState(() {
          isPrayer3Checked = !isPrayer3Checked;
        });
      },
      child: Container(
        height: 25,
        width: 25,
        child: isPrayer3Checked == true
            ? RoundContainerWithTick()
            : RoundContainerWithoutTick(prayerName: 'Asr'),
      ),
    );
  }

  InkWell buildInkWellWithToggleTick4() {
    return InkWell(
      onTap: () {
        setState(() {
          isPrayer4Checked = !isPrayer4Checked;
        });
      },
      child: Container(
        height: 25,
        width: 25,
        child: isPrayer4Checked == true
            ? RoundContainerWithTick()
            : RoundContainerWithoutTick(prayerName: 'Maghrib'),
      ),
    );
  }

  InkWell buildInkWellWithToggleTick5() {
    return InkWell(
      onTap: () {
        setState(() {
          isPrayer5Checked = !isPrayer5Checked;
        });
      },
      child: Container(
        height: 25,
        width: 25,
        child: isPrayer5Checked == true
            ? RoundContainerWithTick()
            : RoundContainerWithoutTick(prayerName: 'Isha'),
      ),
    );
  }

  Widget buildHomePageCard2() {
    return HomePageCardWidget(
      child: InspirationalVideosWidget(
          controller: _controller, videoIds: _videoIds),
    );
  }

  Widget buildHomePageCard3() {
    return HomePageCardWidget(
      child: const PrayerTimesCardWidget(),
    );
  }

  Widget buildHomePageCard4() {
    return HomePageCardWidget(
      child: Daily_Duas_widget(),
    );
  }

  Widget buildHomePageCard5() {
    return HomePageCardWidget(
      child: DailyQuotesWidget(dailyQuotesImageUrl: _dailyQuotesImageUrl),
    );
  }

  Widget buildHomePageCard6() {
    return HomePageCardWidget(
      child:
          UpcomingEventsWidget(upcomingEventsImageUrl: _upcomingEventsImageUrl),
    );
  }

  Widget buildHomePageCard7() {
    return HomePageCardWidget(
      child: DailyVerseWidget(),
    );
  }

  Widget buildHomePageCard8() {
    return HomePageCardWidget(
      child: HadithOfThedayWidget(),
    );
  }
}


