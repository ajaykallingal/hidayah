import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/data/bloc/dua_detailed_bloc.dart';
import 'package:hidayah/src/data/models/dua_detailed/dua_detailed_request.dart';
import 'package:hidayah/src/data/models/dua_detailed/dua_detailed_response.dart';
import 'package:hidayah/src/ui/duas/components/view_all_dua_screen_arguments.dart';
import 'package:hidayah/src/ui/duas/components/view_dua_detailed_screen_arguments.dart';

import '../Quran/components/textStyle.dart';
import '../prayer_times/text_style.dart';


class ViewDuaDetailedScreen extends StatefulWidget {
  const ViewDuaDetailedScreen({Key? key}) : super(key: key);
  static const String id = 'view_dua_detailed_screen';


  @override
  State<ViewDuaDetailedScreen> createState() => _ViewDuaDetailedScreenState();
}

class _ViewDuaDetailedScreenState extends State<ViewDuaDetailedScreen> {

  final duaDetailedBloc = DuaDetailedBloc();



  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as ViewDuaDetailedScreenArguments;

    duaDetailedBloc.fetchDuaDetailed(
        request: DuaDetailedRequest(subCatId: args.subCatId),
    );



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
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 28, top: 10),
                  //   child:  ListTile(
                  //     horizontalTitleGap: 50,
                  //     leading: IconButton(onPressed: (){
                  //       Navigator.pop(context);
                  //     }, icon: Icon(Icons.arrow_back,color: Colors.white),),
                  //     title: Text("All Dua",style: kPrayerTimeScreenHeaderStyle,),
                  //   ),
                  // ),
    Padding(
      padding: const EdgeInsets.only(left: 15,top: 10),
      child: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back,color: Colors.white),),
    ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left:10,right: 10),
                    child:
                    Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(1),
                          borderRadius: BorderRadius.circular(20)),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: buildDuaDetailedView(),
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

  Widget buildDuaDetailedView(){
    return
      StreamBuilder<DuaDetailedResponse>(
        stream: duaDetailedBloc.duaDetailedSCStreamListener,
        builder: (context, snapshot) {
          if(snapshot.data == null || !snapshot.hasData){
            return Center(child: CircularProgressIndicator(color: mainRedShadeForText,),);
          }else {
            return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: snapshot.data!.response!.length,

          itemBuilder: (BuildContext context, index) {
            // print(
            //   int.parse(displayWholeQuranFiltered![index].suartNumberOfAyats),
            // );
            return

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child:


                Container(
                  child:

                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F0F0).withOpacity(1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: CircleAvatar(
                                backgroundColor: mainRedShadeForTitle,
                                // radius: 10,
                                child: Text(
                                    snapshot.data!.response![index].duaId,
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right:8),
                              child: Text(
                                snapshot.data!.response![index].duaEnTranslation,
                                softWrap: true,
                                // textDirection: TextDirection.rtl,
                                // textAlign: TextAlign.right,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right:8),
                              child: Text(
                                snapshot.data!.response![index].duaArabic,
                                softWrap: true,
                                textDirection: TextDirection.rtl,
                                // textAlign: TextAlign.right,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right:8),
                              child: Text(
                                snapshot.data!.response![index].duaTransliteration,
                                softWrap: true,
                                // textDirection: TextDirection.rtl,
                                // textAlign: TextAlign.right,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              );
          },
    );
          }
        }
      );
  }

}
