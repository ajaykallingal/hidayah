import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/data/bloc/personal_details_bloc.dart';
import 'package:hidayah/src/data/models/dailyQuotes/daily_quotes_response.dart';
import 'package:hidayah/src/data/models/login/login_with_email_response.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';
import 'package:hidayah/src/ui/Authentication/personal_details/components/latLong.dart';
import 'package:hidayah/src/ui/Quran/quran_screen.dart';
import 'package:hidayah/src/ui/calendar/calendar_screen.dart';
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
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../data/bloc/auth_bloc.dart';
import '../../data/bloc/prayer_times_bloc.dart';
import '../../data/bloc/youtube_videos_bloc.dart';
import '../../data/models/personal_details/personal_details_response.dart';
import '../../data/models/prayerTimes/prayer_time_request.dart';
import '../../data/models/prayerTimes/prayer_time_response.dart';
import '../../data/models/youtube_videos/youtube_videos_response.dart';
import '../Authentication/authentication_screen.dart';
import 'components/glass_morphic_container.dart';
import 'components/latLang.dart';
import 'widgets/home_page_card_widget.dart';
import 'components/round_container_with_tick.dart';
import 'components/round_container_without_tick_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  // final LatLong latLong;



  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // late YoutubePlayerController _controller;

  // late TextEditingController _videoIdController;
  // late TextEditingController _seekToController;
  // late PlayerState _playerState;
  // late YoutubeMetaData _videoMetaData;
  double volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  final _upcomingEventsImageUrl =
      "https://image.shutterstock.com/image-illustration/eid-mubarak-islamic-design-crescent-260nw-1962740215.jpg";
  // late final String<GetDailyQuotesReponse>  todaysQuote;
  // final _videoIds = [
  //   // "zBNUdeWw-wE"
  //   "k8dKImAwVs0"
  // ];
  bool isPray5PrayerGoal = false;
  bool isPrayer1Checked = false;
  bool isPrayer2Checked = false;
  bool isPrayer3Checked = false;
  bool isPrayer4Checked = false;
  bool isPrayer5Checked = false;
  int selectedIndex = 0;

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  String Address = "Fetching your location...";
  // String AddressName = "name";
  Position? position;

  static const String kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String kPermissionDeniedMessage = 'Permission denied.';
  static const String kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String kPermissionGrantedMessage = 'Permission granted.';

 final prayerTimeBloc = PrayerTimeBloc();
 final loginWithEmailBloc = AuthBloc();
  Times? prayerTime;
  bool loading = true;
 String? userDataGoals1 = "0";
  String userDataGoals2 =  "0";
  String userDataGoals3 = "0";
  String userDataGoals4 = "0";
  String userDataGoals5 = "0";
  final youtubeVideosBloc = YoutubeVideosBloc();
  bool loader = false;
  YoutubeVideosResponse? youtubeVideosResponse;
  String upcomingPrayerTime = "please wait..";
  String upcomingPrayerName = "please wait..";
  String timeToNextPrayer = "please wait..";

  DateFormat formatDate = DateFormat("HH:mm");

  late LatLong latLong;
  final personalDetailsBloc = PersonalDetailsBloc();



  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();


    personalDetailsBloc.personalDetailsSCStreamListener.listen((event) {
      if (event != null) {
        setState(() {

          // ObjectFactory().prefs.setIsLoggedIn(true);
          ObjectFactory().prefs.saveUserData(event);

          Navigator.pop(context);

          loading = false;
        });
      }

    });
    // _getCurrentPosition();
    prayerTimeBloc.prayerTimesFetchSCStreamListener.listen((event) {
      print(DateTime.now());
      print("dataloaded");
      setState(() {
        prayerTime = event.times!;
        findPrayerTime(event.times!);
        loading = false;
        latLong = LatLong(latitude: position!.latitude, longitude: position!.longitude);
        print(latLong.longitude);


      });
    });

    youtubeVideosBloc.youtubeVideosSCStreamListener.listen((event) {
      loader = false;
      youtubeVideosResponse = event.response as YoutubeVideosResponse ;
    });




  }




  @override
  void initState() {
    // TODO: implement initState
    // latLong = widget.latLong;


    youtubeVideosBloc.fetchYouTubeVideos();

    super.initState();
    //
    userDataGoals1 = ObjectFactory().prefs.getUserData()!.response!.userGoalPrayFive.toString();
    userDataGoals2 =  ObjectFactory().prefs.getUserData()!.response!.userGoalReadTwentyAyaDaily.toString();
    userDataGoals3 = ObjectFactory().prefs.getUserData()!.response!.userGoalSayThreeDua.toString();
    userDataGoals4 = ObjectFactory().prefs.getUserData()!.response!.userGoalPrayWitrNight.toString();
    userDataGoals5 = ObjectFactory().prefs.getUserData()!.response!.userGoalGiveCharity.toString();

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



    _getCurrentPosition();


  }


  void _onTapped(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future<void> _getCurrentPosition()async {
    final hasPermission = await _handlePermission();

    if(!hasPermission){
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    Address = '${place.name},${place.locality} \n ${place.subLocality} ${place.country}';
    setState(()  {
      print(Address);
      // lat = widget.latLang;
      // long = widget.latLang;

    });

  }

  Future<bool> _handlePermission() async{
    bool serviceEnabled;
    LocationPermission permission;


    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if(!serviceEnabled) {
      _updatePositionList(_PositionItemType.log, kLocationServicesDisabledMessage);
      return false;
    }
    permission =  await _geolocatorPlatform.checkPermission();
    if(permission ==  LocationPermission.denied){
      permission = await _geolocatorPlatform.requestPermission();
      if(permission == LocationPermission.denied){
        _updatePositionList(_PositionItemType.log, kPermissionDeniedMessage);
        return false;
      }
    }
    if(permission ==  LocationPermission.deniedForever){
      _updatePositionList(_PositionItemType.log, kPermissionDeniedForeverMessage);
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

  @override
  Widget build(BuildContext context) {

    // final arguments = ModalRoute.of(context)!.settings.arguments as LatLang ;



    List<dynamic> _screenWidgets = <dynamic>[
      buildHomeScreenBody(context),
      loading?const Center(child: CircularProgressIndicator(color: Colors.white,),) :
      const DhikrScreen(),
      loading?const Center(child: CircularProgressIndicator(color: Colors.white,),):
      const QuranScreen(),
      loading?const Center(child: CircularProgressIndicator(color: Colors.white,),) :
      const DuasScreen(),
      loading?const Center(child: CircularProgressIndicator(color: Colors.white,),) :
      const MoreScreen(),
      loading?const Center(child: CircularProgressIndicator(color: Colors.white,),) :
      const CalendarScreen(),


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
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8,top: 0),
                              child:
                              GlassMorphicContainer(
                                child: IconButton(

                                    onPressed: () {
                                  buildLogoutPopUp(context);
                                }, icon: Image.asset("assets/images/logout.png",color: Colors.white,)),
                              ),
                            ),
                            // GlassMorphicContainer(
                            //   icon: AssetImage(
                            //       'assets/images/NOTIFICATION.png'),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 8),
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
                                        const AssetImage(
                                            'assets/images/LOCATION.png'),
                                        color: Colors.white.withOpacity(1.0),
                                        size: 17,
                                      ),
                                        SizedBox(width: 3,),
// SizedBox(width: 5),
                                      Text(
                                        Address,
                                        style: kTopLeftCornerTextStyle,
                                        softWrap: true,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 7),
                                  // Text(
                                  //   '21 Jamadi-ul-Thani 1442 AH',
                                  //   style: kTopLeftCornerTextStyle,
                                  // ),
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      DateFormat.MMMMEEEEd().format(DateTime.now()),
                                      style: kTopLeftCornerTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    upcomingPrayerName,
                                    style: kTopRightCornerTextStyle1,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    upcomingPrayerTime,
                                    style: kTopRightCornerTextStyle2,
                                  ),
                                  const SizedBox(height: 1),
                                  Text(
                                    timeToNextPrayer,
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
                      height: MediaQuery.of(context).size.height / 1.25,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(left: 14,right: 14),
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            buildHomePagecard1(),
                            const SizedBox(height: 10),
                            buildHomePageCard2(),
                            const SizedBox(height: 10),
                            buildHomePageCard3(),
                            const SizedBox(height: 10),
                            buildHomePageCard4(),
                            const SizedBox(height: 10),
                            buildHomePageCard5(),
                            const SizedBox(height: 10),
                            buildHomePageCard6(),
                            const SizedBox(height: 10),
                            buildHomePageCard7(),
                            const SizedBox(height: 10),
                            buildHomePageCard8(),
                            const SizedBox(height: 70),

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
            borderRadius: const BorderRadius.all(const Radius.circular(20)),
            child: BottomNavigationBar(
              elevation: 10,
              currentIndex: selectedIndex,
              backgroundColor: mainThemeWhiteColor,
              showSelectedLabels: true,
              unselectedItemColor: kCardGreyShadeForText,
              selectedItemColor: mainRedShadeForTitle,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: ImageIcon(
                        AssetImage('assets/images/SURAH FILL.png')),
                    label: "Home"),
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
                BottomNavigationBarItem(
                    icon:
                    ImageIcon(AssetImage('assets/images/CALENDER NAV.png')),
                    label: "Today"),
              ],
              onTap: _onTapped,
            ),

          );
  }

  Widget buildHomePagecard1() {
    return HomePageCardWidget(
      child:
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today\'s Goals',
                style: kHomePageCardTitleTextStyle,
              ),
              Divider(
                color: const Color(0xFF707070).withOpacity(0.1),
                indent: 0,
                thickness: 0.8,
                endIndent: 0,
              ),
              const SizedBox(height: 9),

              // const SizedBox(height: 15),
              Text("Make sure you meet your daily goals!",style: kHomePageCard1TextStyle1,),
              // const SizedBox(height: 5),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Visibility(
                  visible:  userDataGoals1 == "1" ? true : false,
                  child:


                    Text("Pray 5 Prayers.",style: kHomePageCard1GoalsStyle,),
                  ),
              ),
              const SizedBox(height: 10),


              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Visibility(
                  visible:  userDataGoals2 == "1" ? true : false,
                  child:


                    Text("Read 20 Ayahs of  Quran Daily.",style: kHomePageCard1GoalsStyle,),

                ),
              ),
              const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Visibility(
                    visible: userDataGoals3 == "1" ? true : false,
                      child: Text("Say 3 Duas Each Day.",style: kHomePageCard1GoalsStyle,)),
                ) ,
              const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left : 10),
                  child: Visibility(
                      visible: userDataGoals4 == "1" ? true : false,
                      child: Text("Pray Witr at Night.",style: kHomePageCard1GoalsStyle,)),
                ),
              const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Visibility(
                    visible: userDataGoals5 == "1" ? true : false,
                      child: Text("Give Charity Once a Week.",style: kHomePageCard1GoalsStyle,)),
                ),
              const SizedBox(height: 10),


            ],
          ),

    );
  }

  // InkWell toggleTickForPray5Prayres() {
  //   return InkWell(
  //     onTap: () {
  //       setState(() {
  //         userDataGoals1 == "1" ? isPray5PrayerGoal = true : false;
  //         // print(ObjectFactory().prefs.getUserData()!.response!.userGoalPrayWitrNight.toString());
  //
  //         // ObjectFactory().prefs.getUserData()!.response!.userGoalPrayFive == "1" ? isPray5PrayerGoal = true : false;
  //       });
  //     },
  //     child: Container(
  //       height: 25,
  //       width: 25,
  //       child: isPray5PrayerGoal == true
  //           ? const RoundContainerWithTick()
  //           : const RoundContainerWithoutTick(prayerName: 'Goals'),
  //     ),
  //   );
  // }

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
            ? const RoundContainerWithTick()
            : const RoundContainerWithoutTick(prayerName: 'Fajir'),
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
            ? const RoundContainerWithTick()
            : const RoundContainerWithoutTick(prayerName: 'Dhuhr'),
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
            ? const RoundContainerWithTick()
            : const RoundContainerWithoutTick(prayerName: 'Asr'),
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
            ? const RoundContainerWithTick()
            : const RoundContainerWithoutTick(prayerName: 'Maghrib'),
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
            ? const RoundContainerWithTick()
            : const RoundContainerWithoutTick(prayerName: 'Isha'),
      ),
    );
  }

  Widget buildHomePageCard2() {
    return HomePageCardWidget(
      child:
           const
           InspirationalVideosWidget(
              ),

  );
  }

  Widget buildHomePageCard3() {
    return HomePageCardWidget(
      child: const PrayerTimesCardWidget(),
    );
  }

  Widget buildHomePageCard4() {
    return HomePageCardWidget(
      child: const Daily_Duas_widget(),
    );
  }

  Widget buildHomePageCard5() {
    return HomePageCardWidget(
      child: const DailyQuotesWidget(dailyQuotesImageUrl: '',  ),
    );
  }

  Widget buildHomePageCard6() {
    return HomePageCardWidget(
      child:
          const UpcomingEventsWidget(),
    );
  }

  Widget buildHomePageCard7() {
    return HomePageCardWidget(
      child: const DailyVerseWidget(),
    );
  }

  Widget buildHomePageCard8() {
    return HomePageCardWidget(
      child: const HadithOfThedayWidget(),
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

  Future buildLogoutPopUp(BuildContext context) async {
    await Alert(
      padding: EdgeInsets.only(top: 15),
      // image: ImageIcon(
      //   AssetImage(Assets.success),
      //   size: 95,
      //   color: Color(0xff68CE78).withOpacity(1.0),
      // ),
      closeIcon: Container(),

      context: context,
      // type: AlertType.success,
      // title: "RFLUTTER ALERT",
      desc: "Do you want to Logout?",
      style: AlertStyle(
          isOverlayTapDismiss: false,
          alertElevation: 1.0,
          alertPadding: EdgeInsets.symmetric(vertical: 200, horizontal: 50),
          overlayColor: Colors.transparent.withOpacity(0.4),
          constraints: BoxConstraints(maxHeight: 80, maxWidth: 324),
          // alertPadding: EdgeInsets.only(top: 30),
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
            side: BorderSide(
              color: Colors.white10,
            ),
          ),
          // alertBorder: Border(top: BorderSide(color: Colors.white)),
          descStyle: kHomePageCardTitleTextStyle),
      buttons: [
        DialogButton(
          height: 36.0,
          radius: BorderRadius.circular(12),
          child: Text(
            "Cancel",
            style: kHomePageLogOutStyle,
          ),
          onPressed: () => Navigator.of(context).pop(),
          width: 95,
          color: mainRedShadeForTitle
        ),
        DialogButton(
          height: 36.0,
          radius: BorderRadius.circular(12),
          child: Text(
            "Logout",
            style: kHomePageLogOutStyle,
          ),
          onPressed: () {
            ObjectFactory().prefs.clearPrefs();
            Navigator.pushNamed(context, AuthenticationScreen.id);
          },
          width: 95,
          color: mainRedShadeForTitle
        ),
      ],
    ).show();
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

