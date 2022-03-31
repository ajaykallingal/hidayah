import 'package:flutter/material.dart';

import '../Quran/components/search_bar_widget.dart';
import '../Quran/components/textStyle.dart';

class ViewDuaScreen extends StatefulWidget {
  static const String id = 'view_dua_screen';

  const ViewDuaScreen({Key? key}) : super(key: key);

  @override
  State<ViewDuaScreen> createState() => _ViewDuaScreenState();
}

class _ViewDuaScreenState extends State<ViewDuaScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              colors: [
                Color(0xffE80000),
                Color(0xff382424),
              ],
              radius: 1.9,
              focal: Alignment.topCenter,
              // focalRadius: 1.0,
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/bg_pattern.png'),
            ),
          ),
        ),
        SafeArea(
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBarWidget(),
                Padding(
                  padding: const EdgeInsets.only(left: 28, top: 10),
                  child: Text(
                    'Duas',
                    style: kQuranPageHeadlineTextStyle,
                  ),
                ),
                SizedBox(height: 8),


                DefaultTabController(
                  length: 2,

                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: mainThemeWhiteColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [

                            

                              Container(
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(10),
                                height: 450,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: ListView.builder(itemBuilder: (BuildContext context, index) {
                                  return ListTile(
                                    title: Text("Duas"),
                                    trailing: Icon(Icons.arrow_right),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //       child:
                //       Column(
                //         children: [

                //
                //   },
                //   ),
                //
                // ),
                //
                //       ],
                //     ),
                //   ),
                //
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
