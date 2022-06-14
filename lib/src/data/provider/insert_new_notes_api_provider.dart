

import 'package:hidayah/src/data/models/new_notes/new_notes_request.dart';
import 'package:hidayah/src/data/models/new_notes/new_notes_response.dart';
import 'package:hidayah/src/data/models/notes/notes_response.dart';

import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class InsertNewNotesApiProvider{
  Future<StateModel> insertNewNotes(NewNotesRequest request) async {
    final response = await ObjectFactory().apiClient.insertNewNotes(request);
    print("response" + response.toString());
    if (response.statusCode == 200) {
      // ObjectFactory().prefs.saveCompanyBaseUrl(baseUrl: GetBaseUrlResponse.fromJson(response.data).data[0].restaurantCrmUrl);
      return StateModel<NotesResponse>.success(NotesResponse.fromJson(response.data));
    } else {
      return StateModel<String>.error("Error Occurred");
    }
  }
}