


import 'dart:async';

import 'package:hidayah/src/data/models/calendar_delete_events/calendar_delete_event_request.dart';
import 'package:hidayah/src/data/models/calendar_delete_events/calendar_delete_event_response.dart';

import '../../constants/strings.dart';
import '../../shared_pref/object_factory.dart';
import '../models/calendar_add_events/calendar_add_events_request.dart';
import '../models/calendar_events/calendar_events.dart';
import '../models/common/state_model.dart';

class CalendarDeleteEventBloc{
  final bool _isDispose = false;
  ///stream for loader
  final _loadingSC = StreamController<bool>.broadcast();
  StreamSink<bool> get loadingSink => _loadingSC.sink;
  Stream<bool> get loadingStream => _loadingSC.stream;



  /// Stream for calendar add event
  final _calendarDeleteEventsSC = StreamController<CalendarResponse>.broadcast();
  StreamSink<CalendarResponse> get calendarDeleteEventSCSink => _calendarDeleteEventsSC.sink;
  Stream<CalendarResponse> get calendarDeleteEventSCStreamListener => _calendarDeleteEventsSC.stream;

CalendarDeleteEventBloc();

  calendarDeleteEvent({required CalendarDeleteEventRequest request}) async {
    if(_isDispose){
      return;
    }
    loadingSink.add(true);
    StateModel? state = await ObjectFactory().repository.calendarDeleteEvent(request);
    if(state is SuccessState){
      if(!_calendarDeleteEventsSC.isClosed){
        calendarDeleteEventSCSink.add(state.value as CalendarResponse);
      }
    } else if(state is ErrorState){
      calendarDeleteEventSCSink.addError(Strings.SOME_ERROR_OCCURRED);

    }
    loadingSink.add(false);

  }


}