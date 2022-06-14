
import 'package:hidayah/src/data/models/dailyVerses/daily_verses_response.dart';

import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';
import '../models/dailyVerses/daily_verses_response.dart';


class GetDailyVerses{


  Future<StateModel> fetchDailyVerses() async {
    final response = await ObjectFactory().apiClient.fetchDailyVerses();
    print("response" + response.toString());
    if (response.statusCode == 200) {
      // ObjectFactory().prefs.saveCompanyBaseUrl(baseUrl: GetBaseUrlResponse.fromJson(response.data).data[0].restaurantCrmUrl);
      return StateModel<DailyVersesResponse>.success(DailyVersesResponse.fromJson(response.data));
    } else {
      return StateModel<String>.error("Error Occurred");
    }
  }







}