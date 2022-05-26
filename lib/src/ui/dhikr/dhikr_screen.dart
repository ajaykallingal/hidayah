import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/textStyle/text_style.dart';

class DhikrScreen extends StatefulWidget {
  const DhikrScreen({Key? key}) : super(key: key);

  @override
  State<DhikrScreen> createState() => _DhikrScreenState();
}

class _DhikrScreenState extends State<DhikrScreen> {
  final String tapAudio = "iPhone typing on keyboard (78E463D-MSH).mp3";
  
  int _counter = 0;
  bool toggleSwitch = false;
  // int count = 0;
  String prefedCount = "0";

  void _incrementCounter() {

    setState(() {
      SystemSound.play(SystemSoundType.click);
ObjectFactory().prefs.setUserDhikrCount(userDhikrCount: _counter.toString());
      _counter++;

    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      ObjectFactory().prefs.setUserDhikrCount(userDhikrCount: _counter.toString());

      // ObjectFactory().prefs.setUserDhikrCount();

    });
  }







  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // count = _counter.toInt();
    if(ObjectFactory().prefs.getUserDhikrCount() == null){
      _counter = 0;
    }else{
      _counter = int.parse(ObjectFactory().prefs.getUserDhikrCount().toString());
    }



  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/BACK_IMAGE_DIKR.jpg"),
            ),
          ),
        ),
        SafeArea(
          child: Material(
            type: MaterialType.transparency,
            child: Stack(
              children: [
                // SizedBox(height: 10),
                // Padding(
                //   padding: const EdgeInsets.only(left: 15, right: 15),
                //   child: ClipRRect(
                //     child: BackdropFilter(
                //       filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                //       child: Container(
                //         height: 160,
                //         width: MediaQuery.of(context).size.width,
                //         decoration: BoxDecoration(
                //           color: Colors.black.withOpacity(0.6),
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         child: Column(
                //           children: [
                //             SizedBox(height: 10),
                //             // Row(
                //             //   mainAxisAlignment: MainAxisAlignment.end,
                //             //   children: [
                //             //     Padding(
                //             //       padding: const EdgeInsets.only(
                //             //         right: 20,
                //             //       ),
                //             //       child: Text("arabic"),
                //             //     )
                //             //   ],
                //             // ),
                //             SizedBox(height: 50),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 10),
                //                   child: AnimatedTextKit(
                //                     animatedTexts: [
                //                       TypewriterAnimatedText(
                //
                //                         'Allahu Akbar..',
                //                         cursor: "",
                //                         curve: Curves.linear,
                //
                //                         textStyle: kDhikrScreenStyle,
                //                         speed: const Duration(milliseconds: 200),
                //                       ),
                //                     ],
                //
                //                     // totalRepeatCount: 10,
                //                     pause: const Duration(milliseconds: 1000),
                //                     displayFullTextOnTap: true,
                //                     stopPauseOnTap: true,
                //                     // isRepeatingAnimation: true,
                //
                //                     repeatForever: true,
                //                   )
                //                 ),
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: Container(
                          height: 190,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(

                            children: [
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 SizedBox(height: 20),
                                 Text(
                                   "Count",
                                   style: TextStyle(
                                       fontSize: 16, color: Colors.white),
                                 ),
                                 SizedBox(height: 30,),
                                 Text(
                                   _counter.toString(),
                                   style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                       fontSize: 30, color: Colors.white),
                                 ),
                                 // Text(
                                 //   "Your last count: ${_counter.toString()}",
                                 //   style: TextStyle(
                                 //       fontWeight: FontWeight.bold,
                                 //       fontSize: 30, color: Colors.white),
                                 // ),
                               ],
                             ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 3.9,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      splashColor: mainRedShadeForTitle,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        height: 90,
                        width: 90,
                        // constraints: BoxConstraints(
                        //   maxHeight: 150,
                        //   maxWidth: 150,
                        // ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          enableFeedback: true,
                            splashColor: mainRedShadeForText,
                            iconSize: 70,
                            onPressed: () {
                              // FlutterBeep.playSysSound(iOSSoundIDs.AudioToneBusy);
                              Feedback.forTap(context);
                              _incrementCounter();
                              Clipboard.setData(const ClipboardData());
                              HapticFeedback.heavyImpact();
                              // ObjectFactory().prefs.setUserDhikrCount();
                              // ObjectFactory().prefs.setUserDhikrCount(userDhikrCount: count.toString());

                            },
                            icon: ImageIcon(
                              AssetImage("assets/images/TAPICON.png"),
                            )),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(

                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: Container(
                              height: 60,
                              width: 130,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text("Reset",style: TextStyle(color: mainRedShadeForText),)),

                            ),
                          ),
                        ),
                        onTap: (){
                          _resetCounter();
                        },
                        splashColor: mainRedShadeForText,
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     setState(() {
                      //       toggleSwitch = !toggleSwitch;
                      //     });
                      //   },
                      //   child: ClipRRect(
                      //     child: BackdropFilter(
                      //       filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      //       child: Container(
                      //         height: 60,
                      //         width: 130,
                      //         decoration: BoxDecoration(
                      //           color: Colors.grey.withOpacity(0.3),
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //         child: Center(
                      //           child: RichText(
                      //
                      //               text: TextSpan(text: "Sound: ",style: TextStyle(color: mainRedShadeForText),
                      //                   children: [
                      //             TextSpan(text: toggleSwitch ? "ON" : "OFF",style: TextStyle(color: mainRedShadeForTitle))
                      //           ])),
                      //         )
                      //
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
