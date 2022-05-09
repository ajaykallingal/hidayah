import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/data/bloc/daily_verses_bloc.dart';
import 'package:hidayah/src/ui/Quran/quran_screen.dart';

import '../../../data/models/dailyVerses/daily_verses_response.dart';
import '../textStyle/text_style.dart';

class DailyVerseWidget extends StatefulWidget {
  const DailyVerseWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DailyVerseWidget> createState() => _DailyVerseWidgetState();
}

class _DailyVerseWidgetState extends State<DailyVerseWidget> {
  List<DisplayWholeQuranFiltered>? displayWholeQuranFiltered;
  final dailyVersesBloc = DailyVersesBloc();
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dailyVersesBloc.fetchDailyVerses();
  }


@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    dailyVersesBloc.quranFetchDailyVersesSCStreamListener.listen((event) {
      loading = false;
      // setState(() {
      //   loading = false;
      //   displayWholeQuranFiltered = event.displayWholeQuranFiltered;
      // });
    });
  }
  @override
  Widget build(BuildContext context) {
    // dailyVersesBloc.fetchDailyVerses();

    return StreamBuilder<DailyVersesResponse?>(
      stream: dailyVersesBloc.quranFetchDailyVersesSCStreamListener,
      builder: (BuildContext context,  snapshot) {
        // dailyVersesBloc.fetchDailyVerses();


        print("snapshotVerses : ${snapshot.data}");
        if(snapshot.data == null ){
          return Center(
            child: CircularProgressIndicator(
              color: mainRedShadeForTitle,
            ),
          );
        }else if(snapshot.hasError){
          print(snapshot.error.toString());
        }
        return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Verse',
              style: kHomePageCardTitleTextStyle,
            ),
            Divider(
              color: Color(0xFF707070).withOpacity(0.1),
              indent: 0,
              thickness: 0.8,
              endIndent: 0,
            ),
            SizedBox(height: 8),
            Center(
              child:
              Text(
                snapshot.data!.displayWholeQuranFiltered![0].ayatText,
                // 'And were it not for Allah\'s grace upon you and His mercy\nand that Allah is Oft-returning(to mercy),Wise!',
                style: kHomePageCard7TextStyle1,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton.icon(

                onPressed: () {
                  Navigator.pushNamed(context, QuranScreen.id);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                icon: ImageIcon(AssetImage('assets/images/SURAH FILL.png',),color: cardRichTextColor,),
                label: Text('Surah An-Nur',style: kHomePageCard3ButtonTextStyle,),

              ),
            ),
          ],
        );
      },

    );
  }
}