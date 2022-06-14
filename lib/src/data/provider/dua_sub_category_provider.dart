


import 'package:hidayah/src/data/models/dua_sub_category/dua_sub_category_request.dart';
import 'package:hidayah/src/data/models/dua_sub_category/dua_sub_category_response.dart';

import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class DuaSubCategoryProvider{
  Future<StateModel> fetchDuaSubCategory(DuaSubCategoryRequest request) async {
    final response = await ObjectFactory().apiClient.fetchDuaSubCategory(request);
    print("response" + response.toString());
    if (response.statusCode == 200) {
      // ObjectFactory().prefs.saveCompanyBaseUrl(baseUrl: GetBaseUrlResponse.fromJson(response.data).data[0].restaurantCrmUrl);
      return StateModel<DuaSubCategoryResponse>.success(DuaSubCategoryResponse.fromJson(response.data));
    } else {
      return StateModel<String>.error("Error Occurred");
    }
  }
}