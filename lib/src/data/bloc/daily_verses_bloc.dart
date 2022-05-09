



import 'dart:async';

import 'package:hidayah/src/data/models/dailyVerses/daily_verses_response.dart';

import '../../constants/strings.dart';
import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';
import '../models/dailyQuotes/daily_quotes_response.dart';

class DailyVersesBloc{

  bool _isDisposed = false;
  StreamController<bool> _loading = new StreamController<bool>.broadcast();

  ///stream for loader
  final _loadingSC = StreamController<bool>.broadcast();
  StreamSink<bool> get loadingSink => _loadingSC.sink;
  Stream<bool> get loadingStream => _loadingSC.stream;

  /// stream for quran fetch
  final _quranFetchFilteredForDailyVersesSC = StreamController<DailyVersesResponse>.broadcast();
  StreamSink<DailyVersesResponse> get quranFetchDailyVersesSCSink => _quranFetchFilteredForDailyVersesSC.sink;
  Stream<DailyVersesResponse> get quranFetchDailyVersesSCStreamListener => _quranFetchFilteredForDailyVersesSC.stream;


  DailyVersesBloc();


  fetchDailyVerses()async{
    if(_isDisposed){
      return;
    }
    loadingSink.add(true);
    StateModel? state = await ObjectFactory().repository.fetchDailyVerses();

    if(state is SuccessState){
      if(!_quranFetchFilteredForDailyVersesSC.isClosed){
        quranFetchDailyVersesSCSink.add(state.value as DailyVersesResponse);
      }
    } else if(state is ErrorState){
      quranFetchDailyVersesSCSink.addError(Strings.SOME_ERROR_OCCURRED);

    }

    loadingSink.add(false);

  }
  ///disposing the stream if it is not using
  @override
  void dispose() {
    _loading.close();
  }

}

