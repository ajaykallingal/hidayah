

import 'package:hidayah/src/data/models/common/state_model.dart';
import 'package:hidayah/src/data/models/prayer_time_response.dart';
import 'package:hidayah/src/data/models/quran_request.dart';
import 'package:hidayah/src/data/provider/get_prayer_times.dart';
import 'package:hidayah/src/data/provider/test_request_provider.dart';

class Repository{
  final testRequestProvider  = TestRequestProvider();
  final prayerTimesApiProvider = GetPrayerTimes();





  /// test request provider

  Future<StateModel> quranFetchFiltered(QuranRequest request) =>
      testRequestProvider.quranFetchFiltered(request);

  ///Prayer times
  Future<StateModel?> getPrayerTimes() =>
      prayerTimesApiProvider.getPrayerTimesProvider();




}