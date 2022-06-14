

import 'dart:async';

import 'package:hidayah/src/data/models/calendar_events/calendar_events.dart';

import '../../constants/strings.dart';
import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class CalendarEventBloc{
  final bool _isDisposed = false;
  final StreamController<bool> _loading = StreamController<bool>.broadcast();

  ///stream for loader
  final _loadingSC = StreamController<bool>.broadcast();
  StreamSink<bool> get loadingSink => _loadingSC.sink;
  Stream<bool> get loadingStream => _loadingSC.stream;

  /// stream for quran fetch
  final _calendarEventsSC = StreamController<CalendarResponse>.broadcast();
  StreamSink<CalendarResponse> get calendarEventsSCSink => _calendarEventsSC.sink;
  Stream<CalendarResponse> get calendarEventsSCStreamListener => _calendarEventsSC.stream;


  CalendarEventBloc();


  fetchCalendarEvents()async{
    if(_isDisposed){
      return;
    }
    loadingSink.add(true);
    StateModel? state = await ObjectFactory().repository.fetchCalendarEvents();

    if(state is SuccessState){
      if(!_calendarEventsSC.isClosed){
        calendarEventsSCSink.add(state.value as CalendarResponse);
      }
    } else if(state is ErrorState){
      calendarEventsSCSink.addError(Strings.SOME_ERROR_OCCURRED);

    }

    loadingSink.add(false);

  }
  ///disposing the stream if it is not using
  @override
  void dispose() {
    _loading.close();
  }

}