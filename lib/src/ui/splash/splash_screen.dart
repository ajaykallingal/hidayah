import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/app_theme.dart';
import 'package:hidayah/src/constants/font_family.dart';
import 'package:hidayah/src/ui/Authentication/authentication_screen.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> animation;
  bool isAnimating = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: (Duration(seconds: 3)),
    );
    animation = CurvedAnimation(parent: animationController, curve: Curves.decelerate );
    animation.addListener(() => this.setState(() {}));
    animationController.forward();


    setState(() {
      isAnimating = !isAnimating;
    });
    splashScreenDelay();
  }

  @override
  void dispose() {
    animationController.dispose();

    // TODO: implement dispose
    super.dispose();

  }

  splashScreenDelay() {
    var duration = Duration( seconds: 5);
    return Timer(duration,route);
  }

  route() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeScreen()));
    // Navigator.pushNamedAndRemoveUntil(
    //     context, '/auth', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return
       Material(
         type: MaterialType.transparency,
         child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient:
              RadialGradient(
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: animation.value * 173,
                  width: 211,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo_white.png'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 40,
                width: 216,
                decoration: BoxDecoration(
                  color: Color(0xff363636).withOpacity(1.0),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                ),
                child: Center(
                  child: Text(' HiDAYAH',
                    textAlign: TextAlign.left,

                    style: TextStyle(
                      letterSpacing: 1.5,
                      fontFamily: FontFamily.sfProDisplay,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

              ),
              SizedBox(height: 5),
              Center(
                child: Text('Be a Perfect Muslim',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: FontFamily.sfProDisplay,
                    fontWeight: FontWeight.w500,fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
      ),
       );

  }
}
