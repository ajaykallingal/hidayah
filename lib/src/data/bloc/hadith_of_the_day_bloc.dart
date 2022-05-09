

import 'dart:async';

import 'package:hidayah/src/data/models/Hadith/hadith_of_the_day_response.dart';

import '../../constants/strings.dart';
import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class HadithOfTheDayBloc{
  bool _isDisposed = false;
  StreamController<bool> _loading = new StreamController<bool>.broadcast();


  ///stream for loader
  final _loadingSC = StreamController<bool>.broadcast();
  StreamSink<bool> get loadingSink => _loadingSC.sink;
  Stream<bool> get loadingStream => _loadingSC.stream;

  /// stream for quran fetch
  final _hadithOfTheDaySC = StreamController<HadithOfTheDayResponse>.broadcast();
  StreamSink<HadithOfTheDayResponse> get hadithOfTheDaySCSink => _hadithOfTheDaySC.sink;
  Stream<HadithOfTheDayResponse> get hadithOfTheDaySCStreamListener => _hadithOfTheDaySC.stream;


  HadithOfTheDayBloc();


  fetchHadithOfTheDay()async{
    if(_isDisposed){
      return;
    }
    loadingSink.add(true);
    StateModel? state = await ObjectFactory().repository.fetchHadithOfTheDay();

    if(state is SuccessState){
      if(!_hadithOfTheDaySC.isClosed){
        hadithOfTheDaySCSink.add(state.value );
      }
    } else if(state is ErrorState){
      hadithOfTheDaySCSink.addError(Strings.SOME_ERROR_OCCURRED);

    }

    loadingSink.add(false);

  }
  ///disposing the stream if it is not using
  @override
  void dispose() {
    _loading.close();
  }

}