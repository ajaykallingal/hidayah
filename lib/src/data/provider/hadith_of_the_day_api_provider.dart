

import 'package:hidayah/src/data/models/Hadith/hadith_of_the_day_response.dart';

import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class HadithOfTheDayApiProvider{

  Future<StateModel> fetchHadithOfTheDay() async {
    final response = await ObjectFactory().apiClient.fetchHadithOfTheDay();
    print("response" + response.toString());
    if (response.statusCode == 200) {
      // ObjectFactory().prefs.saveCompanyBaseUrl(baseUrl: GetBaseUrlResponse.fromJson(response.data).data[0].restaurantCrmUrl);
      return StateModel<HadithOfTheDayResponse>.success(HadithOfTheDayResponse.fromJson(response.data));
    } else {
      return StateModel<String>.error("Error Occurred");
    }
  }
}