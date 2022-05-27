
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hidayah/main.dart';
import 'package:hidayah/src/common/route_generator.dart';
import 'package:hidayah/src/constants/app_state.dart';
import 'package:hidayah/src/constants/app_theme.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/ui/Authentication/authentication_screen.dart';
import 'package:hidayah/src/ui/Authentication/personal_details/Personal_details_screen.dart';
import 'package:hidayah/src/ui/Authentication/personal_details/components/latLong.dart';
import 'package:hidayah/src/ui/Authentication/personal_details/daily_goal_screen.dart';
import 'package:hidayah/src/ui/Authentication/sign_up_screen.dart';
import 'package:hidayah/src/ui/Quran/components/my_audio_player.dart';
import 'package:hidayah/src/ui/Quran/components/quran_arabic_translated_page.dart';
import 'package:hidayah/src/ui/Quran/components/quran_translated_page_arguments.dart';
import 'package:hidayah/src/ui/Quran/quran_screen.dart';
import 'package:hidayah/src/ui/calendar/calendar_screen.dart';
import 'package:hidayah/src/ui/daily_goals/daily_goals_screen.dart';
import 'package:hidayah/src/ui/duas/duas_screen.dart';
import 'package:hidayah/src/ui/duas/view_all_duas_screen.dart';
import 'package:hidayah/src/ui/duas/view_dua_detailed_screen.dart';
import 'package:hidayah/src/ui/home/home_screen.dart';
import 'package:hidayah/src/ui/more/more_screen.dart';
import 'package:hidayah/src/ui/near_mosques/near_by_mosques.dart';
import 'package:hidayah/src/ui/notes/add_new_notes.dart';
import 'package:hidayah/src/ui/notes/edit_note.dart';
import 'package:hidayah/src/ui/notes/note_view_screen.dart';
import 'package:hidayah/src/ui/notes/notes_screen.dart';
import 'package:hidayah/src/ui/prayer_times/prayer_times_screen.dart';
import 'package:hidayah/src/ui/qibla%20compass/qibla_compass.dart';
import 'package:hidayah/src/ui/qibla%20compass/qibla_compass_widget.dart';
import 'package:hidayah/src/ui/sample/sample_calender.dart';
import 'package:hidayah/src/ui/splash/splash_screen.dart';
import 'package:provider/provider.dart';


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {





  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }



  @override
  Widget build(BuildContext context) {

    return buildMaterialApp(context);
  }
}

Widget buildMaterialApp(BuildContext context) {
  // final args = ModalRoute.of(context)!.settings.arguments as QuranTranslatedPageArguments;
  // final quranTrasnlatedPageArguments = args as QuranTranslatedPageArguments;

  return Consumer<AppState>(
    builder: (context, appState, child) {
  return
    // ChangeNotifierProvider(
    // create: (_)=>MyAudioPlayer(),
    // child:
    MaterialApp(


      debugShowCheckedModeBanner: false,
      title: 'HiDAYAH',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,


      builder: (context , child) {
      final mediaQueryData = MediaQuery.of(context);

        return MediaQuery(

            data: mediaQueryData.copyWith(textScaleFactor:  0.85,alwaysUse24HourFormat: false),
            child: child!,
        );

      },
      initialRoute: SplashScreen.id,
        routes: {
              SplashScreen.id : (context) => SplashScreen(),
              // SplashScreen.id : (context) => TableEventsExample(),
              AuthenticationScreen.id : (context) => AuthenticationScreen(),
          SignUpScreen.id : (context) => SignUpScreen(),
          PersonalDetailsScreen.id : (context) => PersonalDetailsScreen(),
          HomeScreen.id : (context) => HomeScreen(),
          QuranScreen.id : (context) => QuranScreen(),
          QuranArabicTranslatedPage.id : (context) => QuranArabicTranslatedPage(),
          DuasScreen.id : (context) => DuasScreen(),
          ViewAllDuasScreen.id : (context) => ViewAllDuasScreen(),
          MoreScreen.id : (context) => MoreScreen(),
          PrayerTimesScreen.id : (context) => PrayerTimesScreen(),
          NearByMosques.id : (context) => NearByMosques(),
          CalendarScreen.id : (context) => CalendarScreen(),
          ViewDuaDetailedScreen.id : (context) => ViewDuaDetailedScreen(),
          NotesScreen.id : (context) => NotesScreen(),
          AddNewNotes.id : (context) => AddNewNotes(),
          QiblaCompassWidget.id : (context) => QiblaCompassWidget(),
          DailyGoalsScreen.id : (context) => DailyGoalsScreen(),
          EditNote.id : (context) => EditNote(),
          NoteViewScreen.id : (context) => NoteViewScreen(),



        },
      // onGenerateRoute: RouteGenerator.generateRoute,


    );
  // );
    },
  );
}

