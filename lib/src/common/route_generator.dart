// import 'package:flutter/material.dart';
// import 'package:hidayah/src/ui/Authentication/authentication_screen.dart';
// import 'package:hidayah/src/ui/Authentication/personal_details/Personal_details_screen.dart';
// import 'package:hidayah/src/ui/Authentication/sign_up_screen.dart';
// import 'package:hidayah/src/ui/Quran/quran_screen.dart';
// import 'package:hidayah/src/ui/home/home_screen.dart';
// import 'package:hidayah/src/ui/splash/splash_screen.dart';
//
// class RouteGenerator{
//
//   static const initialPage = '/';
//   static const splashPage = '/splash';
//   static const authPage = '/auth';
//   static const signUpPage = '/signUp';
//   static const personalDetails = '/personalDetails';
//   static const homeNavigationPage = '/home';
//   static const dhikrNavigationPage = '/dhikr';
//   static const quranNavigationPage = '/quran';
//   static const duasNavigationPage = '/duas';
//   static const moreNavigationPage = '/more';
//
//   static Route<dynamic> generateRoute(RouteSettings settings){
//     final args = settings.arguments;
//     switch(settings.name){
//       case initialPage:
//         return MaterialPageRoute(builder: (_) => SplashScreen());
//
//       case authPage:
//         return MaterialPageRoute(builder: (_) => AuthenticationScreen());
//
//
//       case signUpPage:
//         return MaterialPageRoute(builder: (_) => SignUpScreen() );
//
//       case personalDetails:
//         return MaterialPageRoute(builder: (_) => PersonalDetailsScreen() );
//
//       case homeNavigationPage:
//         return MaterialPageRoute(builder: (_) => HomeScreen() );
//
//       case quranNavigationPage:
//
//         return MaterialPageRoute(builder: (_) => QuranScreen() );
//     }
//   }
//
//   static Route<dynamic> _errorRoute(){
//     return MaterialPageRoute(builder: (_) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Error'),
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//         ),
//         body: Center(
//           child: Text('Error'),
//         ),
//       );
//     });
//   }
//
//
//
//
// }