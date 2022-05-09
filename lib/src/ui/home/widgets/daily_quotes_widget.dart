import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/data/bloc/daily_quotes_bloc.dart';
import 'package:hidayah/src/data/models/dailyQuotes/daily_quotes_response.dart';

import '../textStyle/text_style.dart';

class DailyQuotesWidget extends StatefulWidget {
  const DailyQuotesWidget({
    Key? key,
    required String dailyQuotesImageUrl,
  }) : _dailyQuotesImageUrl = dailyQuotesImageUrl, super(key: key);

  final String _dailyQuotesImageUrl;

  @override
  State<DailyQuotesWidget> createState() => _DailyQuotesWidgetState();
}

class _DailyQuotesWidgetState extends State<DailyQuotesWidget> {
  final getDailyQuotesBloc = DailyQuotesBloc();
  Response? response;
  bool loading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getDailyQuotesBloc.quranFetchDailyQuotesSCStreamListener.listen((event) {
      loading = false;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDailyQuotesBloc.getDailyQuotes();
  }



  @override
  Widget build(BuildContext context) {
    // getDailyQuotesBloc.getDailyQuotes();

    return StreamBuilder<GetDailyQuotesReponse?>(
      stream: getDailyQuotesBloc.quranFetchDailyQuotesSCStreamListener,
      builder: (BuildContext context, snapshot) {

        print("daily quotes snapshots = ${snapshot.data}");

      if(snapshot.data == null) {
        return Center(
          child: CircularProgressIndicator(color: mainRedShadeForTitle,),
        );
      }else if(snapshot.hasError){
        print(snapshot.error.toString());
      }
      return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Quotes',
            style: kHomePageCardTitleTextStyle,
          ),
          Divider(
            color: Color(0xFF707070).withOpacity(0.1),
            indent: 0,
            thickness: 0.8,
            endIndent: 0,
          ),
          SizedBox(height: 10),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: Container(
                  height: 132,
                  width: 290,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(
                      snapshot.data!.todaysQuote,
                    ),
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),


        ],
      );
    },);

  }
}