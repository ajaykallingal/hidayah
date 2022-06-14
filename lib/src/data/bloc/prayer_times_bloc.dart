

import 'dart:async';

import 'package:hidayah/src/data/models/common/state_model.dart';
import 'package:hidayah/src/data/models/prayerTimes/prayer_time_request.dart';
import 'package:hidayah/src/data/models/prayerTimes/prayer_time_response.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';

import '../../constants/strings.dart';

class PrayerTimeBloc {

  final bool _isDisposed = false;

  ///Stream for loader
  final _loadingSC = StreamController<bool>.broadcast();

  StreamSink<bool> get loadingSink => _loadingSC.sink;

  Stream<bool> get loadingStream => _loadingSC.stream;

  ///Stream to fetch all prayer times
  final _fetchPrayerTimesSC = StreamController<
      GetPrayerTimesReponse>.broadcast();

  StreamSink<GetPrayerTimesReponse> get prayerTimesFetchSCSink =>
      _fetchPrayerTimesSC.sink;

  Stream<GetPrayerTimesReponse> get prayerTimesFetchSCStreamListener =>
      _fetchPrayerTimesSC.stream;



  PrayerTimeBloc();


  getAllPrayerTimes({required GetPrayerTimesRequest request}) async {
    if (_isDisposed) {
      return;
    }
    loadingSink.add(true);
    StateModel? state = await ObjectFactory().repository.getAllPrayerTimes(
        request);

    if (state is SuccessState) {
      if (!_fetchPrayerTimesSC.isClosed) {
        prayerTimesFetchSCSink.add(state.value as GetPrayerTimesReponse);
      }
    } else if (state is ErrorState) {
      prayerTimesFetchSCSink.addError(Strings.SOME_ERROR_OCCURRED);
    }

    loadingSink.add(false);
  }
}