import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';

class DhikrScreen extends StatefulWidget {
  const DhikrScreen({Key? key}) : super(key: key);

  @override
  State<DhikrScreen> createState() => _DhikrScreenState();
}

class _DhikrScreenState extends State<DhikrScreen> {
  int _counter = 0;

  void _incrementCounter(){
    setState(() {
      _counter++;
    });
  }
  void _resetCounter(){
    setState(() {
      _counter =0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [


          Align(
            alignment: Alignment.center,
            child: Container(

              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  // alignment: Alignment.bottomLeft,
                  image: AssetImage("assets/images/religious-books-standing-with-bird-cage.png"),
                )
              ),

            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/COUNTERNEW.png"),
                )
              ),
            ),
          ),
          Positioned(
            bottom: 160,
            left: 100,
            top: 0,

            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 70,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(15))

                ),
                child: Align(
                  alignment: Alignment.center,
                    child: Text('$_counter')),

              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 73,
            top: 0,

            child: Align(
                alignment: Alignment.center,
                child: ClipOval(
                  child: Material(
                    color: Colors.white, // Button color
                    child: InkWell(
                      splashColor: mainRedShadeForTitle, // Splash color
                      onTap: () {
                        _resetCounter();
                      },
                      child: SizedBox(width: 50, height: 50,child: Icon(Icons.refresh,color: Colors.black,),),
                    ),
                  ),
                )

            ),
          ),
          Positioned(
            bottom: 0,
            left: 129,
            top: 150,

            child: Align(
              alignment: Alignment.center,
              child: ClipOval(
                child: Material(
                  color: Colors.white, // Button color
                  child: InkWell(
                    splashColor: mainRedShadeForTitle, // Splash color
                    onTap: () {
                      _incrementCounter();
                    },
                    child: SizedBox(width: 102, height: 102,),
                  ),
                ),
              )

            ),
          ),
        ],
      ),
    );
  }
}
