


import 'package:hidayah/src/data/models/login/login_with_email_response.dart';
import 'package:hidayah/src/data/models/personal_details/personal_details_request.dart';
import 'package:hidayah/src/data/models/personal_details/personal_details_response.dart';

import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class PersonalDetailsApiProvider{
  Future<StateModel?> fetchPersonalDetails(PersonalDetailsRequest request) async {
    final response = await ObjectFactory().apiClient.fetchPersonalDetails(request);
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<LoginWithEmailResponse>.success(
          LoginWithEmailResponse.fromJson(response.data));
    } else {
      return null;
    }
  }
}