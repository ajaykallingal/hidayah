

import 'dart:async';

import 'package:hidayah/src/data/models/common/state_model.dart';
import 'package:hidayah/src/data/models/prayer_time_response.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';

import '../../constants/strings.dart';

class PrayerTimeBloc{

  StreamController<bool> _loading = new StreamController<bool>.broadcast();
  bool _isDisposed = false;

  StreamController<Datum> _getPrayerTimes =
      new StreamController<Datum>.broadcast();

  ///Stream to fetch all prayer times
  Stream<Datum?> get viewAllPrayerTimesResponse =>
      _getPrayerTimes.stream;
  Stream<bool> get loadingListener => _loading.stream;
  StreamSink<bool> get loadingSink => _loading.sink;

  getAllPrayerTimes()async{
    if(_isDisposed){
      return;

    }
    loadingSink.add(true);
    StateModel? state = await ObjectFactory().repository.getPrayerTimes();
    if(state is SuccessState) {
      _getPrayerTimes.sink.add(state.value as Datum);

    }else if(state is ErrorState) {
      _getPrayerTimes.sink.addError(Strings.SOME_ERROR_OCCURRED);
    }
    loadingSink.add(false);
  }
}