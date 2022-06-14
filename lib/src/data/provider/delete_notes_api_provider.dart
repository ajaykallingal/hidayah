

import 'package:hidayah/src/data/models/delete_notes/delete_notes_request.dart';

import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';
import '../models/notes/notes_response.dart';

class DeleteNotesApiProvider{
  Future<StateModel> deleteNotes(DeleteNotesRequest request) async {
    final response = await ObjectFactory().apiClient.deleteNotes(request);
    print("response" + response.toString());
    if (response.statusCode == 200) {
      // ObjectFactory().prefs.saveCompanyBaseUrl(baseUrl: GetBaseUrlResponse.fromJson(response.data).data[0].restaurantCrmUrl);
      return StateModel<NotesResponse>.success(NotesResponse.fromJson(response.data));
    } else {
      return StateModel<String>.error("Error Occurred");
    }
  }
}