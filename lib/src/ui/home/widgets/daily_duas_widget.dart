import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hidayah/src/ui/duas/duas_screen.dart';

import '../../../constants/text_style.dart';
import '../../../data/bloc/dua_detailed_bloc.dart';
import '../../../data/models/dua_detailed/dua_detailed_request.dart';
import '../../../data/models/dua_detailed/dua_detailed_response.dart';
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
  bool loading = true;
  int i = 1;
  var rng = Random();
  DuaDetailedResponse? duaDetailedResponse;


  @override
  void initState() {
    // TODO: implement initState
    duaDetailedBloc.fetchDuaDetailed(
      request: DuaDetailedRequest(subCatId: rng.nextInt(8).toString()),
    );
    super.initState();


  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    duaDetailedBloc.duaDetailedSCStreamListener.listen((event) {
      setState((){
        duaDetailedResponse = event;
        loading = false;
      });

    });
  }

  @override
  Widget build(BuildContext context) {

    // final args = ModalRoute.of(context)!.settings.arguments as ViewDuaDetailedScreenArguments;


    return Visibility(
      visible: !loading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Duas',
            style: kHomePageCardTitleTextStyle,
          ),
          Divider(
            color: const Color(0xFF707070).withOpacity(0.1),
            indent: 0,
            thickness: 0.8,
            endIndent: 0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: duaDetailedResponse==null?Container()  : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  duaDetailedResponse!.response![0].duaEnTranslation,
                  style: kHomePageCard4TextStyle1,
                ),
                // SizedBox(height: 7),

                const SizedBox(height: 16),
                Center(
                  child: Text(
                    duaDetailedResponse!.response![0].duaArabic,
                    style: kHomePageCard4TextStyle1,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  duaDetailedResponse!.response![0].duaTransliteration,
                  style: kHomePageCard4TextStyle1,
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    duaDetailedResponse!.response![0].duaCatName,
                    style: kHomePageCard4TextStyle2,
                  ),
                ),
                const SizedBox(height: 7),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton.icon(

                    onPressed: () {
                      Navigator.pushNamed(context, DuasScreen.id);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    icon: ImageIcon(const AssetImage('assets/images/VIEW DUAS FILL.png',),color: cardRichTextColor,),
                    label: Text('View Duas',style: kHomePageCard3ButtonTextStyle,),

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