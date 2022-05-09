import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hidayah/src/ui/duas/duas_screen.dart';

import '../../../constants/text_style.dart';
import '../../../data/bloc/dua_detailed_bloc.dart';
import '../../../data/models/dua_detailed/dua_detailed_request.dart';
import '../../../data/models/dua_detailed/dua_detailed_response.dart';
import '../../duas/components/view_dua_detailed_screen_arguments.dart';
import '../textStyle/text_style.dart';
class Daily_Duas_widget extends StatefulWidget {
  const Daily_Duas_widget({
    Key? key,
  }) : super(key: key);

  @override
  State<Daily_Duas_widget> createState() => _Daily_Duas_widgetState();
}

class _Daily_Duas_widgetState extends State<Daily_Duas_widget> {
  final duaDetailedBloc = DuaDetailedBloc();
  bool loading = false;
  int i = 1;
  var rng = Random();



  @override
  void initState() {
    // TODO: implement initState

    super.initState();

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    duaDetailedBloc.fetchDuaDetailed(
      request: DuaDetailedRequest(subCatId: rng.nextInt(8).toString() ),
    );

    duaDetailedBloc.duaDetailedSCStreamListener.listen((event) {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    // final args = ModalRoute.of(context)!.settings.arguments as ViewDuaDetailedScreenArguments;
    duaDetailedBloc.fetchDuaDetailed(
      request: DuaDetailedRequest(subCatId: rng.nextInt(10).toString()),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Duas',
          style: kHomePageCardTitleTextStyle,
        ),
        Divider(
          color: Color(0xFF707070).withOpacity(0.1),
          indent: 0,
          thickness: 0.8,
          endIndent: 0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: StreamBuilder<DuaDetailedResponse>(
            stream: duaDetailedBloc.duaDetailedSCStreamListener,
            builder: (context, snapshot) {
              if(snapshot.data == null || !snapshot.hasData){
                return Center(child: CircularProgressIndicator(color: mainRedShadeForTitle,),);
              }else{
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data!.response![0].duaEnTranslation,
                      style: kHomePageCard4TextStyle1,
                    ),
                    // SizedBox(height: 7),

                    SizedBox(height: 16),
                    Center(
                      child: Text(
                        snapshot.data!.response![0].duaArabic,
                        style: kHomePageCard4TextStyle1,
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      snapshot.data!.response![0].duaTransliteration,
                      style: kHomePageCard4TextStyle1,
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: Text(
                        snapshot.data!.response![0].duaCatName,
                        style: kHomePageCard4TextStyle2,
                      ),
                    ),
                    SizedBox(height: 7),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton.icon(

                        onPressed: () {
                          Navigator.pushNamed(context, DuasScreen.id);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        icon: ImageIcon(AssetImage('assets/images/VIEW DUAS FILL.png',),color: cardRichTextColor,),
                        label: Text('View Duas',style: kHomePageCard3ButtonTextStyle,),

                      ),
                    ),
                  ],
                );
              }

            }
          ),
        ),

      ],
    );
  }
}