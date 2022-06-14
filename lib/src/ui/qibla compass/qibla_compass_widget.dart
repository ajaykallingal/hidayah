
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:hidayah/src/ui/qibla%20compass/qibla_compass.dart';

import '../prayer_times/text_style.dart';
import 'location_direction.dart';

class QiblaCompassWidget extends StatefulWidget {
  const QiblaCompassWidget({Key? key}) : super(key: key);
  static const String id = 'qibla_compass_screen';

  @override
  State<QiblaCompassWidget> createState() => _QiblaCompassWidgetState();
}

class _QiblaCompassWidgetState extends State<QiblaCompassWidget> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
        body: Stack(
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
                        const SizedBox(
                          height: 70,
                        ),
                        Align(

                            alignment: Alignment.center,
                            child: Image.asset("assets/images/nearest mosques.png",width: 250,height: 150,fit: BoxFit.cover,))


                      ],
                    ),
                  ),
                  Material(
                    type: MaterialType.transparency,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          leading: IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: Icon(Icons.arrow_back,color: mainThemeWhiteColor),),
                          title: Text("Qibla Compass",style: kPrayerTimeScreenHeaderStyle,),
                        ),

                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 1.5,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(

                                color: Colors.white.withOpacity(1),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: FutureBuilder(
                              future: _deviceSupport,
                              builder: (_, AsyncSnapshot<bool?> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return LoadingIndicator();
                                }
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Error: ${snapshot.error.toString()}"),
                                  );
                                }

                                if (snapshot.data!) {
                                  return QiblahCompass();
                                } else {
                                  return Container();
                                }
                              },
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
        ),

      );

  }
}
