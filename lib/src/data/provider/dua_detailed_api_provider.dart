


import 'package:hidayah/src/data/models/dua_detailed/dua_detailed_request.dart';
import 'package:hidayah/src/data/models/dua_detailed/dua_detailed_response.dart';

import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class DuaDetailedScreenApiProvider{

  Future<StateModel> fetchDuaDetailed(DuaDetailedRequest request) async {
    final response = await ObjectFactory().apiClient.fetchDuaDetailed(request);
    print("response" + response.toString());
    if (response.statusCode == 200) {
      // ObjectFactory().prefs.saveCompanyBaseUrl(baseUrl: GetBaseUrlResponse.fromJson(response.data).data[0].restaurantCrmUrl);
      return StateModel<DuaDetailedResponse>.success(DuaDetailedResponse.fromJson(response.data));
    } else {
      return StateModel<String>.error("Error Occurred");
    }
  }
}