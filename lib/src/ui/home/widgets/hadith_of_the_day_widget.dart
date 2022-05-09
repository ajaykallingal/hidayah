import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/data/bloc/hadith_of_the_day_bloc.dart';
import 'package:hidayah/src/data/models/Hadith/hadith_of_the_day_response.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../textStyle/text_style.dart';
class HadithOfThedayWidget extends StatefulWidget {
  const HadithOfThedayWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<HadithOfThedayWidget> createState() => _HadithOfThedayWidgetState();
}

class _HadithOfThedayWidgetState extends State<HadithOfThedayWidget> {
  final hadithOfTheDayBloc = HadithOfTheDayBloc();
  bool loading = true;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hadithOfTheDayBloc.fetchHadithOfTheDay();

  }
  @override
  Widget build(BuildContext context) {
    // hadithOfTheDayBloc.fetchHadithOfTheDay();

    return StreamBuilder<HadithOfTheDayResponse?>(

      stream: hadithOfTheDayBloc.hadithOfTheDaySCStreamListener,
      builder: (context, snapshot) {
        print("hadith: ${snapshot.data}");
        if(snapshot.data == null || !snapshot.hasData){
          return Center(child: CircularProgressIndicator(color: mainRedShadeForText,),);
        }else {

          return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hadith of the day',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    snapshot.data!.response!.engText,
                    // "Abu Huraira reported: I said, “O Messenger of Allah, I hear many traditions from you and I forget them.” The Prophet said, “Spread open your garment.” I spread it and then he placed something from his hand into it, saying, “Wrap it.” I wrapped it around me and I never forgot a tradition ever again.",
                    style: kHomePageCard8TextStyle1,
                    softWrap: true,
                  ),
                  SizedBox(height: 20),
                  Text(
                    snapshot.data!.response!.arText,
                    // "Abu Huraira reported: I said, “O Messenger of Allah, I hear many traditions from you and I forget them.” The Prophet said, “Spread open your garment.” I spread it and then he placed something from his hand into it, saying, “Wrap it.” I wrapped it around me and I never forgot a tradition ever again.",
                    style: kHomePageCard8TextStyle1,
                    softWrap: true,
                    // textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 50),
                  Text(
                    "Source: ${snapshot.data!.response!.engBookName}",
                    // "Source: Ṣaḥīḥ al-Bukhārī 3448\n\nGrade: Sahih (authentic) according to Al-Bukhari",
                    style: kHomePageCard8TextStyle1,
                    softWrap: true,
                  ),
                  Text(
                    "Author: ${snapshot.data!.response!.engAuth}",
                    // "Source: Ṣaḥīḥ al-Bukhārī 3448\n\nGrade: Sahih (authentic) according to Al-Bukhari",
                    style: kHomePageCard8TextStyle1,
                    softWrap: true,
                  ),
                  SizedBox(height: 50),
                  // Align(
                  //   alignment: Alignment.bottomRight,
                  //   child: TextButton.icon(
                  //
                  //     onPressed: () {},
                  //     style: TextButton.styleFrom(
                  //       padding: EdgeInsets.zero,
                  //     ),
                  //     icon: ImageIcon(AssetImage('assets/images/SURAH FILL.png',),color: cardRichTextColor,),
                  //     label: Text('View Hadith',style: kHomePageCard3ButtonTextStyle,),
                  //
                  //   ),
                  // ),
                ],
              ),
            ),

          ],
        );
        }
      }
    );
  }
}