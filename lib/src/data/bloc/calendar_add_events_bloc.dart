



import 'dart:async';

import 'package:hidayah/src/data/models/calendar_add_events/calendar_add_events_response.dart';
import 'package:hidayah/src/data/models/calendar_events/calendar_events.dart';

import '../../constants/strings.dart';
import '../../shared_pref/object_factory.dart';
import '../models/calendar_add_events/calendar_add_events_request.dart';
import '../models/common/state_model.dart';

class CalendarAddEventsBloc{
  final bool _isDispose = false;
  ///stream for loader
  final _loadingSC = StreamController<bool>.broadcast();
  StreamSink<bool> get loadingSink => _loadingSC.sink;
  Stream<bool> get loadingStream => _loadingSC.stream;



  /// Stream for calendar add event
  final _calendarAddEventsSC = StreamController<CalendarResponse>.broadcast();
  StreamSink<CalendarResponse> get calendarAddEventSCSink => _calendarAddEventsSC.sink;
  Stream<CalendarResponse> get calendarAddEventSCStreamListener => _calendarAddEventsSC.stream;


CalendarAddEventsBloc();

  fetchCalendarAddEvent({required CalendarAddEventRequest request}) async {
  if(_isDispose){
    return;
  }
  loadingSink.add(true);
  StateModel? state = await ObjectFactory().repository.fetchCalendarAddEvent(request);
  if(state is SuccessState){
    if(!_calendarAddEventsSC.isClosed){
      calendarAddEventSCSink.add(state.value as CalendarResponse);
    }
  } else if(state is ErrorState){
    calendarAddEventSCSink.addError(Strings.SOME_ERROR_OCCURRED);

  }
  loadingSink.add(false);

  }


}