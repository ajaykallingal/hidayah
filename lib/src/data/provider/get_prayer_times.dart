

import 'package:hidayah/src/data/models/prayerTimes/prayer_time_request.dart';

import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';
import '../models/prayerTimes/prayer_time_response.dart';

class GetPrayerTimes{

  Future<StateModel?> fetchPrayerTimes(GetPrayerTimesRequest request) async {
    final response = await ObjectFactory().apiClient.fetchPrayerTimes(request);
    print(response.toString());
    if(response.statusCode == 200) {
      return StateModel<GetPrayerTimesReponse>.success(
          GetPrayerTimesReponse.fromJson(response.data)
      );
    } else{
      return null;
    }
  }
}