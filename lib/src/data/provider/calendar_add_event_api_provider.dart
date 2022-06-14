


import 'package:hidayah/src/data/models/calendar_add_events/calendar_add_events_request.dart';
import 'package:hidayah/src/data/models/calendar_events/calendar_events.dart';

import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class CalendarAddEventApiProvider{
  Future<StateModel?> fetchCalendarAddEvent(CalendarAddEventRequest request) async {
    final response = await ObjectFactory().apiClient.fetchCalendarAddEvent(request);
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<CalendarResponse>.success(
          CalendarResponse.fromJson(response.data));
    } else {
      return null;
    }
  }
}