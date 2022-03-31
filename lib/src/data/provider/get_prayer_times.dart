

import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';
import '../models/prayer_time_response.dart';

class GetPrayerTimes{
  Future<StateModel?> getPrayerTimesProvider() async {
    final response = await ObjectFactory().apiClient.getPrayerTimes();
    print(response.toString());
    if(response.statusCode == 200) {
      return StateModel<PrayerTimeResponse>.success(
          PrayerTimeResponse.fromJson(response.data)
      );
    } else{
      return null;
    }
  }
}