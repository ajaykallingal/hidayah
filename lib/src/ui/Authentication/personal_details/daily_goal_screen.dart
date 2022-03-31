import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';

class DailyGoalScreen extends StatefulWidget {
  static const String id = 'daily_goal_screen';

  const DailyGoalScreen({Key? key}) : super(key: key);

  @override
  _DailyGoalScreenState createState() => _DailyGoalScreenState();
}

class _DailyGoalScreenState extends State<DailyGoalScreen> {
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
                  height: 450,
                  width: 324,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    color: Colors.white.withOpacity(1.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ListTile(

                          title:   Text('Set Daily Goals',style: kFormFieldsTitleTextStyle,),
                          leading: IconButton(onPressed: () {
                            Navigator.of(context).pop();
                          },
                              icon: Icon(Icons.arrow_back_sharp)
                          ),

                        ),





    //
    // Container(
    // height: 40,
    // width: 130,
    // decoration: BoxDecoration(
    // borderRadius: BorderRadius.circular(20),
    // border: Border.all(color: Color(0xffD10005).withOpacity(0.2),width: 0.8),
    // ),
    // child: Row(
    // mainAxisSize: MainAxisSize.max,
    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    // children: [
    // Text( 'gender',style: TextStyle(color: Colors.black54),),
    // SizedBox(width: 20),
    // genderSelected == true ? Container(
    // margin: EdgeInsets.zero,
    // padding: EdgeInsets.zero,
    // height: 20,
    // width: 20,
    // // child: Image.asset('assets/images/TICK.png',height: 30,width: 30,fit: BoxFit.cover,),
    // decoration: BoxDecoration(
    // shape: BoxShape.circle,
    //
    // image: DecorationImage(
    //
    // image: new AssetImage(
    // 'assets/images/TICK.png'),
    // fit: BoxFit.fill,
    //
    //
    // ),
    // // color: mainRedShadeForText,
    // boxShadow: [
    // BoxShadow(
    // blurRadius: 1.5,
    // color: Colors.black26,
    // offset: Offset(0, 1))
    // ],
    // ),
    // )
    //     : Container(
    // height: 20,
    // width: 20,
    // decoration: BoxDecoration(
    // shape: BoxShape.circle,
    // color: Colors.white,
    // boxShadow: [
    // BoxShadow(
    // blurRadius: 1.5,
    // color: Colors.black38,
    // offset: Offset(0, 1))
    // ],
    // ),
    // ),
    //
    //
    // ],
    // ),
    // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 1.19,
            left: MediaQuery.of(context).size.width / 1.5,
            // right: MediaQuery.of(context).size.width / 1.9,
            // bottom: 65,
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
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DailyGoalScreen(),
                            ));
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







}
