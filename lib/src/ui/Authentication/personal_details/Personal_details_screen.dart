// ignore: file_names

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hidayah/src/constants/font_family.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/ui/Authentication/components/personal_detail_text_field_widget.dart';
import 'package:hidayah/src/ui/Authentication/components/text_field_widget.dart';
import 'package:hidayah/src/ui/Authentication/personal_details/components/pick_fav_container_widget.dart';
import 'package:hidayah/src/ui/Authentication/personal_details/components/pick_fav_grid_model.dart';
import 'package:hidayah/src/ui/home/home_screen.dart';

import '../../../../main.dart';
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
  PageController _pageController = PageController(initialPage: 0);
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController languageController = TextEditingController();

  bool genderSelectedMale = false;
  bool genderSelectedFemale = false;
  bool maritalStatusSingle = false;
  bool maritalStatusMarried = false;
  bool isPrayerChecked = false;
  bool isReadAyahChecked = false;
  bool isSayDuaChecked = false;
  bool isPrayWitrChecked = false;
  bool isGiveCharityChecked = false;

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
  late LatLang lat;
  late LatLang long;

  // late Position position;


  void showNotification(){
    setState(() {

    });
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
          )
      ),
    );
  }


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentPosition();
    print(Address);
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      if(notification != null && androidNotification != null ) {
        flutterLocalNotificationsPlugin .show(
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
    } );
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("A new onMessageOpenedApp event was published!");
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      if(notification != null && androidNotification != null){
        showDialog(context: context, builder: (_) {
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
      showNotification();

    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }



  Future<void> _getCurrentPosition()async {
  final hasPermission = await _handlePermission();

  if(!hasPermission){
    return;
  }

  final position = await _geolocatorPlatform.getCurrentPosition();
  List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  Placemark place = placemarks[0];
  Address = '${place.name}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
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
          radius: 1.5,
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
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 141,
                  width: 172,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo_white.png'),
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
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
                              page1Widget(),
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
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 1.16,
            left: MediaQuery.of(context).size.width / 1.5,
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
                            Navigator.pushNamed(context, HomeScreen.id,
                                // arguments: LatLang(longitude: position.longitude, latitude: position!.latitude
                                );


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
    );
  }

  Widget page1Widget() {
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
          SizedBox(height: 25),
          PersonalDetailTextFieldWidget(
            isObscured: false,
            labelText: 'Name',
          ),
          SizedBox(height: 20),
          PersonalDetailTextFieldWidget(
            labelText: 'Date of Birth(optional)',
            isObscured: false,
          ),
          SizedBox(height: 20),
          buildLanguageSelectionField(),
          SizedBox(height: 20),
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
              'Choose at least 3\nYou always can change these later.',
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


            labelText: Address,


            isObscured: false,


            textFieldIcon: ImageIcon(AssetImage('assets/images/SEARCH.png')),
          ),
          SizedBox(height: 30,),
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
              showNotification();
              // GetAddressFromLatLong(position);
            }, child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Use My Current Location'),
              ImageIcon(AssetImage('assets/images/USE_LOCATION.png'),)
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
          isFavChecked: isFavChecked,
          favImageWidget: DecorationImage(
              image: AssetImage('assets/images/PRAYERTIMES.png'), scale: 3.5),
        ),
        PickFavContainerWidget(
          favTitle: 'Qibla\nCompass',
          isFavChecked: isFavChecked,
          favImageWidget: DecorationImage(
              image: AssetImage('assets/images/QIBLA_COMPASS.png'), scale: 3.5),
        ),
        PickFavContainerWidget(
          favTitle: 'Nearest\nMosques',
          isFavChecked: isFavChecked,
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
          isFavChecked: isFavChecked,
          favImageWidget: DecorationImage(
              image: AssetImage('assets/images/READ_QURAN.png'), scale: 3.5),
        ),
        PickFavContainerWidget(
          favTitle: 'Duas',
          isFavChecked: isFavChecked,
          favImageWidget: DecorationImage(
              image: AssetImage('assets/images/DUAS.png'), scale: 3.5),
        ),
        PickFavContainerWidget(
          favTitle: 'Zakah',
          isFavChecked: isFavChecked,
          favImageWidget: DecorationImage(
              image: AssetImage('assets/images/ZAKAH.png'), scale: 3.5),
        ),
      ],
    );
  }

  Widget buildLanguageSelectionField() {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        enabled: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(30),
          // suffixIconConstraints: BoxConstraints(maxHeight: 50,maxWidth: 50),
          suffixIcon: Icon(Icons.arrow_drop_down),

          label: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Center(child: Text('Language')),
          ),

          labelStyle: TextStyle(color: Colors.black54),
          alignLabelWithHint: true,

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 0.8, color: Color(0xffD10005).withOpacity(0.2)),
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 0.8, color: Color(0xffD10005).withOpacity(0.2)),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
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
