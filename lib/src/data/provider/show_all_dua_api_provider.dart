

import 'package:hidayah/src/data/models/show_all_dua/show_all_dua_request.dart';
import 'package:hidayah/src/data/models/show_all_dua/show_all_dua_response.dart';

import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class ShowAllDuaApiProvider{
  Future<StateModel> fetchDuaDetailed(ShowAllDuaRequest request) async {
    final response = await ObjectFactory().apiClient.showAllDua(request);
    print("response" + response.toString());
    if (response.statusCode == 200) {
      // ObjectFactory().prefs.saveCompanyBaseUrl(baseUrl: GetBaseUrlResponse.fromJson(response.data).data[0].restaurantCrmUrl);
      return StateModel<ShowAllDuaResponse>.success(ShowAllDuaResponse.fromJson(response.data));
    } else {
      return StateModel<String>.error("Error Occurred");
    }
  }
}