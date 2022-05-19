import 'package:flutter/material.dart';
import 'package:hidayah/src/ui/more/more_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../constants/text_style.dart';
import '../../data/bloc/personal_details_bloc.dart';
import '../../data/models/personal_details/personal_details_request.dart';
import '../../shared_pref/object_factory.dart';
import '../Authentication/personal_details/components/rounded_textField_with_radioButton.dart';
import '../home/textStyle/text_style.dart';
import '../prayer_times/text_style.dart';

class DailyGoalsScreen extends StatefulWidget {
  static const String id = 'daily_goals_screen';

  const DailyGoalsScreen({Key? key}) : super(key: key);

  @override
  State<DailyGoalsScreen> createState() => _DailyGoalsScreenState();
}

class _DailyGoalsScreenState extends State<DailyGoalsScreen> {
  final personalDetailsBloc = PersonalDetailsBloc();
  bool loading = false;
  bool isPrayerChecked = false;
  bool isReadAyahChecked = false;
  bool isSayDuaChecked = false;
  bool isPrayWitrChecked = false;
  bool isGiveCharityChecked = false;
  String? userDataGoals1 = "0";
  String userDataGoals2 =  "0";
  String userDataGoals3 = "0";
  String userDataGoals4 = "0";
  String userDataGoals5 = "0";


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDataGoals1 = ObjectFactory().prefs.getUserData()!.response!.userGoalPrayFive.toString();
    userDataGoals2 =  ObjectFactory().prefs.getUserData()!.response!.userGoalReadTwentyAyaDaily.toString();
    userDataGoals3 = ObjectFactory().prefs.getUserData()!.response!.userGoalSayThreeDua.toString();
    userDataGoals4 = ObjectFactory().prefs.getUserData()!.response!.userGoalPrayWitrNight.toString();
    userDataGoals5 = ObjectFactory().prefs.getUserData()!.response!.userGoalGiveCharity.toString();

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
                child:  Column(
                  children: [
                    SizedBox(
                      height: 90,
                    ),
                    Align(

                        alignment: Alignment.topRight,
                        child: Image.asset("assets/images/mosques background 2.png",width: 250,height: 150,))

                  ],
                ),
              ),
              Material(
                type: MaterialType.transparency,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back,color: mainThemeWhiteColor),),
                      title: Text("Daily Goals",style: kPrayerTimeScreenHeaderStyle,),
                    ),
                    SizedBox(height: 70,),
                    Container(
                      // height: 490,
                      width: 324,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(10),
                        color: Colors.white.withOpacity(1.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                        Padding(
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
                            SizedBox(height: 15),
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: mainRedShadeForTitle,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                  )
                                ),
                                  onPressed: (){
                                    buildDailyGoalContinuePopUp(context);

                                  },
                                  child: Text("Save",style: TextStyle(color: Colors.white),),
                              )
                            ),
                          ],
                        ),
                      ),

                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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
            isChecked: isPrayerChecked  ? true : false,
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
            isChecked: isReadAyahChecked ? true : false,
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
            isChecked: isSayDuaChecked ? true : false,
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
            isChecked: isPrayWitrChecked ? true : false,
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
            isChecked: isGiveCharityChecked ? true : false,
          ),
        ),
      ],
    );
  }


  Future buildDailyGoalContinuePopUp(BuildContext context) async {
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
      desc: "Your daily goals will be updated.\nDo you wish to continue?",
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
              "Continue",
              style: kHomePageLogOutStyle,
            ),
            onPressed: () {
              personalDetailsBloc.fetchPersonalDetails(
                request: PersonalDetailsRequest(
                  userId: ObjectFactory().prefs.getUserData()!.response!.userId,
                  userEmail: ObjectFactory().prefs.getUserData()!.response!.userEmail,
                  userFullName: ObjectFactory().prefs.getUserData()!.response!.userFullName,
                  userPassword: ObjectFactory().prefs.getUserData()!.response!.userPassword,
                  userDob: ObjectFactory().prefs.getUserData()!.response!.userDob,
                  userSelectedLanguageId: ObjectFactory().prefs.getUserData()!.response!.userSelectedLanguageId,
                  userGender:  ObjectFactory().prefs.getUserData()!.response!.userGender,
                  userMaritialStatus: ObjectFactory().prefs.getUserData()!.response!.userMaritialStatus,
                  userGoalPrayFive: isPrayerChecked == true ? "1" : "0",
                  userGoalReadTwentyAyaDaily: isReadAyahChecked == true ? "1" : "0",
                  userGoalSayThreeDua: isSayDuaChecked == true ? "1" : "0",
                  userGoalPrayWitrNight: isPrayWitrChecked == true ? "1" : "0",
                  userGoalGiveCharity: isGiveCharityChecked == true ? "1" : "0",
                  userFavPrayerTime:  "0",
                  userFavQbila: "0",
                  userFavNarMosque:  "0",
                  userFavQuran:  "0",
                  userFavDua:  "0",
                  userZakah:  "0",),);


              setState(() {
                loading = true;

                // Navigator.pushNamed(
                //     context, HomeScreen.id,arguments: HomeScreenArguments(userId: args.userId));
              });

              // Navigator.pushNamed(context, MoreScreen.id);
            },
            width: 95,
            color: mainRedShadeForTitle
        ),
      ],
    ).show();
  }



}
