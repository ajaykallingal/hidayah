

import 'package:hidayah/src/data/models/notes/notes_request.dart';
import 'package:hidayah/src/data/models/notes/notes_response.dart';

import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class UserNotesShowApiProvider{
  Future<StateModel> fetchUserNotes(NotesRequest request) async {
    final response = await ObjectFactory().apiClient.fetchUserNotes(request);
    print("response" + response.toString());
    if (response.statusCode == 200) {
      // ObjectFactory().prefs.saveCompanyBaseUrl(baseUrl: GetBaseUrlResponse.fromJson(response.data).data[0].restaurantCrmUrl);
      return StateModel<NotesResponse>.success(NotesResponse.fromJson(response.data));
    } else {
      return StateModel<String>.error("Error Occurred");
    }
  }
}