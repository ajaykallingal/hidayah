// ignore: file_names

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hidayah/src/constants/font_family.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/data/bloc/personal_details_bloc.dart';
import 'package:hidayah/src/data/models/personal_details/personal_details_request.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';
import 'package:hidayah/src/ui/Authentication/components/personal_detail_text_field_widget.dart';
import 'package:hidayah/src/ui/Authentication/components/text_field_widget.dart';
import 'package:hidayah/src/ui/Authentication/personal_details/components/latLong.dart';
import 'package:hidayah/src/ui/Authentication/personal_details/components/personal_details_screen_arguments.dart';
import 'package:hidayah/src/ui/Authentication/personal_details/components/pick_fav_container_widget.dart';
import 'package:hidayah/src/ui/Authentication/personal_details/components/pick_fav_grid_model.dart';
import 'package:hidayah/src/ui/home/home_screen.dart';
import 'package:hidayah/src/ui/home/home_screen_arguments.dart';
import 'package:intl/intl.dart';

import '../../../../main.dart';
import '../../../data/bloc/auth_bloc.dart';
import '../../../data/models/personal_details/personal_details_response.dart';
import '../../home/components/latLang.dart';
import '../components/RoundedBoxWithTick.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'components/rounded_textField_with_radioButton.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class PersonalDetailsScreen extends StatefulWidget {
  static const String id = 'personal_detail_screen';

  // final LatLang latLang;

  const PersonalDetailsScreen({Key? key}) : super(key: key);

  @override
  _PersonalDetailsScreenState createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final personalDetailsBloc = PersonalDetailsBloc();
  int? personalDetailResponse;


  PageController _pageController = PageController(initialPage: 0);
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController locationController = TextEditingController();


  String maritalStatus = "0";
  String languageId = "1";
  String dobDropdown = "DOB";
  bool genderSelectedMale = false;
  bool genderSelectedFemale = false;
  bool maritalStatusSingle = false;
  bool maritalStatusMarried = false;
  bool isPrayerChecked = false;
  bool isReadAyahChecked = false;
  bool isSayDuaChecked = false;
  bool isPrayWitrChecked = false;
  bool isGiveCharityChecked = false;
  bool isFavPrayerTimeChecked = false;
  bool isFavQiblaChecked = false;
  bool isFavNearMosqueChecked = false;
  bool isFavQuranChecked = false;
  bool isFavDuaChecked = false;
  bool isFavZakahChecked = false;

  // int index = 0;
  bool isFavChecked = false;


  static const String kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String kPermissionDeniedMessage = 'Permission denied.';
  static const String kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String kPermissionGrantedMessage = 'Permission granted.';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  StreamSubscription<Position>? _positionStreamSubscription;
  StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;
  String Address = "Search";

  Position? position;
   LatLang? lat;
  LatLang? long;
  final loginWithEmailBloc = AuthBloc();
  bool loading = false;
  String? birthDateString;


  // late Position position;

  void showNotification() {
    setState(() {});
    flutterLocalNotificationsPlugin.show(
      0,
      "Testing ",
      "How you doing?",
      NotificationDetails(
          android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        // channel.description!,
        importance: Importance.high,
        color: Colors.blue,
        playSound: true,
      )),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentPosition();
    print(Address);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      if (notification != null && androidNotification != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: "this is notification",
              color: mainRedShadeForText,
              playSound: true,
            ),
          ),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("A new onMessageOpenedApp event was published!");
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      if (notification != null && androidNotification != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body!),
                    ],
                  ),
                ),
              );
            });
      }
      // showNotification();
      // birthDateString =  "${birthDate.month}/${birthDate.day}/${birthDate.year}";

    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    personalDetailsBloc.personalDetailsSCStreamListener.listen((event) {
      if (event != null) {
        setState(() {


          ObjectFactory().prefs.setUserId(userId: event.response!.userId);
          ObjectFactory().prefs.getUserId().toString();
          ObjectFactory().prefs.setIsLoggedIn(true);
          ObjectFactory().prefs.saveUserData(event);
          Navigator.pushNamed(context, HomeScreen.id,
              // arguments: LatLong(latitude: position!.latitude, longitude: position!.longitude)
          );


          loading = false;
        });
      }


    });




  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
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
        '${place.name}, ${place.subLocality},';
    setState(() {
      print(Address);
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

  // showSnackBar() {
  // final snackBar =  SnackBar(
  //     content: Text("Please enter your Personal details to continue!."),
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //
  // }
  //
  //  void navigationPage() {
  //    if (nameController.text.isEmpty) {
  //      showSnackBar();
  //    }if
  //  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as PersonalDetailsScreenArguments;


    return Material(
      type: MaterialType.transparency,
      child: Stack(
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
                radius: 1.5,
                focal: Alignment.center,
                // focalRadius: 1.0,
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bg_pattern.png'),
              ),
            ),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(

                          child: Container(
                            height: 141,
                            width: 172,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/logo_white.png'),
                              ),
                            ),
                          ),
                          alignment: Alignment.topCenter,
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 510,
                              width: 324,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(10),
                                // color: Colors.white.withOpacity(1.0),
                              ),
                            ),
                            Container(
                              height: 470,
                              width: 324,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(10),
                                color: Colors.white.withOpacity(1.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: PageView(
                                        controller: _pageController,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          page1Widget(context,args.fullName),
                                          page2Widget(),
                                          page3Widget(),
                                          page4Widget(),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Center(
                                          child: SmoothPageIndicator(
                                            controller: _pageController,
                                            count: 4,
                                            effect: JumpingDotEffect(
                                              jumpScale: 2,
                                              activeDotColor: mainRedShadeForTitle,
                                              dotHeight: 6,
                                              dotWidth: 6,
                                            ),
                                            onDotClicked: (index) =>
                                                _pageController.animateToPage(index,
                                                    duration: Duration(milliseconds: 300),
                                                    curve: Curves.bounceOut),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      top: 560,
                      left: 250,
                      child: Container(
                        child: Stack(
                          children: [
                            Container(
                              height: 81,
                              width: 81,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(1.0),
                                // color: Colors.red.withOpacity(1.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xffE9EAFE),
                                    offset: Offset(
                                      0.0,
                                      2.0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      center: Alignment.center,
                                      colors: [
                                        Color(0xffE80000),
                                        Color(0xff382424),
                                      ],
                                      radius: 1.0,
                                      focal: Alignment.bottomRight,
                                      // focalRadius: 1.0,
                                    ),
                                  ),
                                  child: RawMaterialButton(
                                    elevation: 2,

                                    // fillColor: Colors.redAccent,
                                    child: const ImageIcon(
                                      AssetImage('assets/images/RIGHT_ARROW.png'),
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    shape: CircleBorder(),
                                    onPressed: () {
                                      print("languageID: ${languageId}");
                                      personalDetailsBloc.fetchPersonalDetails(
                                        request: PersonalDetailsRequest(
                                          userId: "0",
                                          userEmail: args.email,
                                          userFullName: args.fullName,
                                          userPassword: args.password,
                                          userDob: dobController.text,
                                          userSelectedLanguageId: languageId,
                                          userGender: genderSelectedMale ? "1" : "0",
                                          userMaritialStatus: maritalStatusMarried ? "1" : "0",
                                          userGoalPrayFive: isPrayerChecked ? "1" : "0",
                                          userGoalReadTwentyAyaDaily: isReadAyahChecked ? "1" : "0",
                                          userGoalSayThreeDua: isSayDuaChecked ? "1" : "0",
                                          userGoalPrayWitrNight: isPrayWitrChecked ? "1" : "0",
                                          userGoalGiveCharity: isGiveCharityChecked ? "1" : "0",
                                          userFavPrayerTime: isFavPrayerTimeChecked ? "1" : "0",
                                          userFavQbila: isFavQiblaChecked ? "1" : "0",
                                          userFavNarMosque: isFavNearMosqueChecked ? "1" : "0",
                                          userFavQuran: isFavQuranChecked ? "1" : "0",
                                          userFavDua: isFavDuaChecked ? "1" : "0",
                                          userZakah: isFavZakahChecked ? "1" : "0",),);
                                      print("language selected:${languageId}");

                                      setState(() {
                                        loading = true;

                                        // Navigator.pushNamed(
                                        //     context, HomeScreen.id,arguments: HomeScreenArguments(userId: args.userId));
                                      });

                                        // arguments: LatLang(longitude: position.longitude, latitude: position!.latitude

                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget page1Widget(context , name) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Personal details',
                style: kFormFieldsTitleTextStyle,
              )),
          SizedBox(height: 18),
          PersonalDetailTextFieldWidget(
            isObscured: false,
            labelText: name,
            textEditingController: nameController,
            keyboardType: TextInputType.name,
          ),
          SizedBox(height: 18),
          buildDobSelector(labelText: 'Date of Birth(optional)', textEditingController: dobController, dropDownName: dobDropdown),
          // PersonalDetailTextFieldWidget(
          //   labelText: 'Date of Birth(optional)',
          //   isObscured: false,
          //   textEditingController: dobController,
          //   keyboardType: TextInputType.numberWithOptions(),
          // ),
          SizedBox(height: 18),
          buildLanguageSelectionField(dropDownName: languageId, textEditingController: languageController, labelText: 'Select Language'),
          SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Gender',
              style: TextStyle(
                fontFamily: FontFamily.sfProDisplay,
                color: mainRedShadeForText,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 5),
          GenderMethod(),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Marital Status',
              style: TextStyle(
                fontFamily: FontFamily.sfProDisplay,
                color: mainRedShadeForText,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 5),
          MaritalStatusMethod(),
        ],
      ),
    );
  }

  Row MaritalStatusMethod() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(

            onTap: () {
              setState(() {

                maritalStatusSingle = !maritalStatusSingle;
              });
            },
            child: RoundedBoxWithTick(
                genderSelected: maritalStatusSingle, gender: 'Single')),
        InkWell(
            onTap: () {
              setState(() {
                maritalStatusMarried = !maritalStatusMarried;
              });
            },
            child: RoundedBoxWithTick(
                genderSelected: maritalStatusMarried, gender: 'Married')),
      ],
    );
  }

  Row GenderMethod() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(

            onTap: () {
              setState(() {
                genderSelectedMale = !genderSelectedMale;
              });
            },
            child: RoundedBoxWithTick(
                genderSelected: genderSelectedMale, gender: 'Male')),
        InkWell(
            onTap: () {
              setState(() {
                genderSelectedFemale = !genderSelectedFemale;
              });
            },
            child: RoundedBoxWithTick(
                genderSelected: genderSelectedFemale, gender: 'Female')),
      ],
    );
  }

  Widget page2Widget() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: ListTile(
              title: Text(
                'Set Daily Goals',
                style: kFormFieldsTitleTextStyle,
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_sharp)),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Choose at least three.',
              style: kSetDailyGoalTitle2,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15),
          RadioButtonWithOnTapFunction(),
        ],
      ),
    );
  }

  Column RadioButtonWithOnTapFunction() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isPrayerChecked = !isPrayerChecked;
            });
          },
          child: RoundedTextFieldWithRadioButton(
            context: context,
            text: 'Pray 5 Prayers',
            isChecked: isPrayerChecked,
          ),
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: () {
            setState(() {
              isReadAyahChecked = !isReadAyahChecked;
            });
          },
          child: RoundedTextFieldWithRadioButton(
            context: context,
            text: 'Read 20 Ayahs of Quran Daily',
            isChecked: isReadAyahChecked,
          ),
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: () {
            setState(() {
              isSayDuaChecked = !isSayDuaChecked;
            });
          },
          child: RoundedTextFieldWithRadioButton(
            context: context,
            text: 'Say 3 Duas Each day',
            isChecked: isSayDuaChecked,
          ),
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: () {
            setState(() {
              isPrayWitrChecked = !isPrayWitrChecked;
            });
          },
          child: RoundedTextFieldWithRadioButton(
            context: context,
            text: 'Pray Witr a Night',
            isChecked: isPrayWitrChecked,
          ),
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: () {
            setState(() {
              isGiveCharityChecked = !isGiveCharityChecked;
            });
          },
          child: RoundedTextFieldWithRadioButton(
            context: context,
            text: 'Give Charity Once a Week',
            isChecked: isGiveCharityChecked,
          ),
        ),
      ],
    );
  }

  Widget page3Widget() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.zero,
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  'Choose your Favourites',
                  style: kFormFieldsTitleTextStyle,
                ),
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_sharp)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Choose Some tools to add \nYour Favourites.',
              style: kSetDailyGoalTitle2,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30),
          PickFavFirstRowMethod1(),
          SizedBox(height: 35),
          PickFavFirstRowMethod2(),
        ],
      ),
    );
  }

  Widget page4Widget() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.zero,
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  'Location',
                  style: kFormFieldsTitleTextStyle,
                ),
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_sharp)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Select your city for accurate\nPrayer times.',
              style: kSetDailyGoalTitle2,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30),
          TextFieldWidget(
            textEditingController: locationController,
            labelText: Address,
            isObscured: false,
            textFieldIcon: ImageIcon(AssetImage('assets/images/SEARCH.png')),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              onSurface: mainRedShadeForText,
              primary: mainRedShadeForTitle,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              fixedSize: Size(MediaQuery.of(context).size.width, 40),
              onPrimary: Colors.white,
            ),
            onPressed: () {
              _getCurrentPosition();
              // showNotification();
              // GetAddressFromLatLong(position);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Use My Current Location'),
                ImageIcon(
                  AssetImage('assets/images/USE_LOCATION.png'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row PickFavFirstRowMethod1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        PickFavContainerWidget(
          favTitle: 'Prayer\nTimes',
          isFavChecked: isFavPrayerTimeChecked,
          favImageWidget: DecorationImage(
              image: AssetImage('assets/images/PRAYERTIMES.png'), scale: 3.5),
        ),
        PickFavContainerWidget(
          favTitle: 'Qibla\nCompass',
          isFavChecked: isFavQiblaChecked,
          favImageWidget: DecorationImage(
              image: AssetImage('assets/images/QIBLA_COMPASS.png'), scale: 3.5),
        ),
        PickFavContainerWidget(
          favTitle: 'Nearest\nMosques',
          isFavChecked: isFavNearMosqueChecked,
          favImageWidget: DecorationImage(
              image: AssetImage('assets/images/NEAREST_MOSQUES.png'),
              scale: 3.5),
        ),
      ],
    );
  }

  Row PickFavFirstRowMethod2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        PickFavContainerWidget(
          favTitle: 'Read\nQuran',
          isFavChecked: isFavQuranChecked,
          favImageWidget: DecorationImage(
              image: AssetImage('assets/images/READ_QURAN.png'), scale: 3.5),
        ),
        PickFavContainerWidget(
          favTitle: 'Duas',
          isFavChecked: isFavDuaChecked,
          favImageWidget: DecorationImage(
              image: AssetImage('assets/images/DUAS.png'), scale: 3.5),
        ),
        PickFavContainerWidget(
          favTitle: 'Zakah',
          isFavChecked: isFavZakahChecked,
          favImageWidget: DecorationImage(
              image: AssetImage('assets/images/ZAKAH.png'), scale: 3.5),
        ),
      ],
    );
  }

  Widget buildDobSelector({
  required TextEditingController textEditingController,
    required String labelText,
    required String dropDownName,
}){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTapDown: (TapDownDetails details){
          FocusManager.instance.primaryFocus?.unfocus();
          if (dropDownName == dobDropdown) {
            DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime(1900, 1, 1),
                maxTime: DateTime.now(),
                theme: DatePickerTheme(
                    // headerColor: AppColors.buttonColor,
                    backgroundColor: Colors.white,
                    itemStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    doneStyle: TextStyle(color: Colors.black87, fontSize: 16)),
                onChanged: (date) {}, onConfirm: (date) {
                  setState(() {
                    dobController.text = DateFormat('yyyy-MM-dd').format(date);
                    // _dobController.text = date.toString();
                  });
                }, currentTime: DateTime.now(), );
          }
        },
        child: Container(
          height: 55,
          decoration: BoxDecoration(
              border: Border.all(
                color: mainRedShadeForText,
                width: 0.4,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    // readOnly:  isReadOnly,
                    controller: textEditingController,
                    enabled: false,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        border: InputBorder.none, label: Text(labelText)),
                  ),
                ),
              ),
              Flexible(child: Icon(Icons.arrow_drop_down))
            ],
          ),

        ),
      ),
    );
  }

  Widget buildLanguageSelectionField(
      {required TextEditingController textEditingController,
        required String labelText,
        // required bool isReadOnly,
        required String dropDownName}){
   return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTapDown: (TapDownDetails details) {
          FocusManager.instance.primaryFocus?.unfocus();
            // _showPopupMenuNameTitle(details.globalPosition);
            if (dropDownName == languageId) {
            _showPopupMenuLocalBodyType(details.globalPosition);
          }
        },
        child: Container(
          height: 55,
          decoration: BoxDecoration(
              border: Border.all(
                color: mainRedShadeForText,
                width: 0.4,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    // readOnly:  isReadOnly,
                    controller: textEditingController,
                    enabled: false,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        border: InputBorder.none, label: Text(labelText)),
                  ),
                ),
              ),
              Flexible(child: Icon(Icons.arrow_drop_down))
            ],
          ),

        ),
      ),
    );
  }
  void _showPopupMenuLocalBodyType(Offset offset) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem(

          value: "12",
          child: Text("English",style: TextStyle(color: Colors.black),),
        ),
        PopupMenuItem(
          value: "35",
          child: Text("Malayalam",style: TextStyle(color: Colors.black),),
        ),

      ],
      elevation: 8.0,
    ).then((value) {
// NOTE: even you didnt select item this method will be called with null of value so you should call your call back with checking if value is not null

      if (value != null) {
        setState(() {
          languageId = value;

          print(languageId);
          // testRequestBloc.localBodyFetch(
          //   request: LocalBodyFetchRequest(
          //     localBodyType: value,
          //     localBodyDistrictId: ObjectFactory()
          //         .prefs
          //         .getPhleboData()!
          //         .response!
          //         .phlebotomistDistrictId,
          //   ),
          // );
          if (value == "12") {
            languageController.text = "English";

            // print(value);
          } else if (value == "35") {
            languageController.text = "Malayalam";
            // print(value);
          }

          // listenLocalBodyList = true;
          loading = true;
        });
      }
    });
  }



  // Widget buildLanguageSelectionField() {
  //   return Container(
  //     height: 40,
  //     width: MediaQuery.of(context).size.width,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: TextFormField(
  //       enabled: true,
  //       onTap: (){
  //         showDialog(
  //             context: context,
  //             builder: (BuildContext context){
  //               return Container(
  //                 constraints: BoxConstraints(maxWidth: 100,maxHeight: 150),
  //                 child: Column(
  //                   children: [
  //                     Text("English"),
  //                     Text("Malayalam"),
  //                   ],
  //                 ),
  //               );
  //             }
  //         );
  //       },
  //       textAlign: TextAlign.center,
  //       decoration: InputDecoration(
  //         contentPadding: EdgeInsets.all(30),
  //         // suffixIconConstraints: BoxConstraints(maxHeight: 50,maxWidth: 50),
  //         suffixIcon: Icon(Icons.arrow_drop_down),
  //
  //         label: Padding(
  //           padding: const EdgeInsets.only(left: 30),
  //           child: Center(child: Text('Language')),
  //         ),
  //
  //         labelStyle: TextStyle(color: Colors.black54),
  //         alignLabelWithHint: true,
  //
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(
  //               width: 0.8, color: Color(0xffD10005).withOpacity(0.2)),
  //           borderRadius: BorderRadius.circular(20.0),
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderSide: BorderSide(
  //               width: 0.8, color: Color(0xffD10005).withOpacity(0.2)),
  //           borderRadius: BorderRadius.circular(20.0),
  //         ),
  //       ),
  //     ),
  //   );
  // }
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
