
import 'package:hidayah/src/data/models/dua/dua_category_response.dart';

import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';



class DuaCategoryProvider {
  Future<StateModel?> fetchDuaCategory() async {
    final response = await ObjectFactory().apiClient.fetchDuaCategory();
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<DuaCategoryResponse>.success(
          DuaCategoryResponse.fromJson(response.data));
    } else {
      return null;
    }
  }
}