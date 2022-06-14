
import 'package:hidayah/src/data/models/quran_request.dart';
import 'package:hidayah/src/data/models/quran_request_response.dart';

import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class QuranRequestProvider{

  ///fetch quran request
  Future<StateModel> quranFetchFiltered(QuranRequest request) async {
    final response = await ObjectFactory().apiClient.quranFetchFiltered(request);
    print("response" + response.toString());
    if (response.statusCode == 200) {
      // ObjectFactory().prefs.saveCompanyBaseUrl(baseUrl: GetBaseUrlResponse.fromJson(response.data).data[0].restaurantCrmUrl);
      return StateModel<QuranRequestResponse>.success(QuranRequestResponse.fromJson(response.data));
    } else {
      return StateModel<String>.error("Error Occurred");
    }
  }

}