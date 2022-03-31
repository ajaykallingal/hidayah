import 'package:flutter/material.dart';

import '../../constants/text_style.dart';
import '../Quran/components/search_bar_widget.dart';
import '../Quran/components/textStyle.dart';

class ViewAllDuasScreen extends StatefulWidget {
  static const String id = 'view_all_duas_screen';

  const ViewAllDuasScreen({Key? key}) : super(key: key);

  @override
  State<ViewAllDuasScreen> createState() => _ViewAllDuasScreenState();
}

class _ViewAllDuasScreenState extends State<ViewAllDuasScreen> {
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
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchBarWidget(),
                  Padding(
                    padding: const EdgeInsets.only(left: 28, top: 10),
                    child: Text(
                      'All Duas',
                      style: kQuranPageHeadlineTextStyle,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left:10,right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(1),

                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, index) {
                          return ListTile(
                            title: Text(
                              "data",
                              style: TextStyle(color: Colors.black),
                            ),

                            trailing: IconButton(onPressed: (){},
                              icon: Icon(Icons.arrow_forward_ios,color: mainRedShadeForTitle,size: 15,),
                              padding: EdgeInsets.zero,
                            )

                          );
                        },
                        itemCount: 10,
                        scrollDirection: Axis.vertical,
                        // controller: _scrollController,
                        physics: BouncingScrollPhysics(),
                      ),
                    ),
                  ),
                ],
              ),
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
        )
      ],
    );
  }
}
