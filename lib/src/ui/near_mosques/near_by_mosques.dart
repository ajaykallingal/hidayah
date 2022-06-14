import 'package:flutter/material.dart';

import '../prayer_times/text_style.dart';
class NearByMosques extends StatefulWidget {
  static const String id = 'near_mosque_screen';

  const NearByMosques({Key? key}) : super(key: key);

  @override
  State<NearByMosques> createState() => _NearByMosquesState();
}

class _NearByMosquesState extends State<NearByMosques> {

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
                    const SizedBox(
                      height: 90,
                    ),
                    Align(

                      alignment: Alignment.topRight,
                        child: Image.asset("assets/images/nearest mosques.png",width: 250,height: 150,))

                  ],
                ),
              ),
              Material(
                type: MaterialType.transparency,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back,color: mainThemeWhiteColor),),
                      title: Text("Nearest Mosque",style: kPrayerTimeScreenHeaderStyle,),
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
}
