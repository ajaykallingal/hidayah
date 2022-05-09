import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/strings.dart';
import 'package:hidayah/src/data/models/dailyQuotes/daily_quotes_response.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';

import '../models/common/state_model.dart';

class DailyQuotesBloc {


  StreamController<bool> _loading = new StreamController<bool>.broadcast();
  bool _isDisposed = false;



  ///Stream for fetching all daily quotes
  final _quranFetchFilteredForDailyQuotesSC = StreamController<GetDailyQuotesReponse>.broadcast();


  StreamSink<GetDailyQuotesReponse> get quranFetchDailyQuotesSCSink => _quranFetchFilteredForDailyQuotesSC.sink;
  Stream<GetDailyQuotesReponse> get quranFetchDailyQuotesSCStreamListener => _quranFetchFilteredForDailyQuotesSC.stream;

  Stream<bool> get loadingListener => _loading.stream;

  StreamSink<bool> get loadingSink => _loading.sink;


  getDailyQuotes() async {
    if (_isDisposed) {
      return;
    }
    loadingSink.add(true);
    StateModel? state = await ObjectFactory().repository.getDailyQuotes(
        );
    if (state is SuccessState) {
      if(!_quranFetchFilteredForDailyQuotesSC.isClosed){
        quranFetchDailyQuotesSCSink.add(state.value as GetDailyQuotesReponse);
      }
    } else if(state is ErrorState){
      quranFetchDailyQuotesSCSink.addError(Strings.SOME_ERROR_OCCURRED);

    }
    loadingSink.add(false);
  }

  ///disposing the stream if it is not using
  @override
  void dispose() {
    _loading.close();
  }
}
