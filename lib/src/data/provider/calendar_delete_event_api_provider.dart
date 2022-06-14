


import 'package:hidayah/src/data/models/calendar_delete_events/calendar_delete_event_request.dart';
import 'package:hidayah/src/data/models/calendar_delete_events/calendar_delete_event_response.dart';
import 'package:hidayah/src/data/models/calendar_events/calendar_events.dart';

import '../../shared_pref/object_factory.dart';
import '../models/calendar_add_events/calendar_add_events_request.dart';
import '../models/calendar_delete_events/calendar_delete_event_response.dart';
import '../models/common/state_model.dart';

class CalendarDeleteEventApiProvider{
  Future<StateModel?> calendarDeleteEvent(CalendarDeleteEventRequest request) async {
    final response = await ObjectFactory().apiClient.calendarDeleteEvent(request);
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<CalendarResponse>.success(
          CalendarResponse.fromJson(response.data));
    } else {
      return null;
    }
  }
}