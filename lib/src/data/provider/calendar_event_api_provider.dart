

import 'package:hidayah/src/data/models/calendar_events/calendar_events.dart';

import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class CalendarEventApiProvider{
  Future<StateModel?> fetchCalendarEvents() async {
    final response = await ObjectFactory().apiClient.fetchCalendarEvents();
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<CalendarResponse>.success(
          CalendarResponse.fromJson(response.data));
    } else {
      return null;
    }
  }
}