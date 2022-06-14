

import 'dart:async';

import 'package:hidayah/src/data/models/dua_detailed/dua_detailed_request.dart';
import 'package:hidayah/src/data/models/dua_detailed/dua_detailed_response.dart';

import '../../constants/strings.dart';
import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class DuaDetailedBloc{

  final bool _isDispose = false;


  ///stream for loader
  final _loadingSC = StreamController<bool>.broadcast();
  StreamSink<bool> get loadingSink => _loadingSC.sink;
  Stream<bool> get loadingStream => _loadingSC.stream;

  /// stream for dua sub category
  final _duaDetailedSC = StreamController<DuaDetailedResponse>.broadcast();
  StreamSink<DuaDetailedResponse> get duaDetailedSCSink => _duaDetailedSC.sink;
  Stream<DuaDetailedResponse> get duaDetailedSCStreamListener => _duaDetailedSC.stream;

  // /// stream for daily surat
  // final _displayDailySuratSC = StreamController<bool>.broadcast();
  // StreamSink<bool> get fetchDailySuratSCSink => _displayDailySuratSC.sink;
  // Stream<bool> get fetchDailySCStream => _displayDailySuratSC.stream;


  DuaDetailedBloc();

  /// quran screen

  fetchDuaDetailed({required DuaDetailedRequest request}) async {
    if(_isDispose){
      return;
    }
    loadingSink.add(true);
    StateModel? state = await ObjectFactory().repository.fetchDuaDetailed(request);

    if(state is SuccessState){
      if(!_duaDetailedSC.isClosed){
        duaDetailedSCSink.add(state.value );
      }
    } else if(state is ErrorState){
      duaDetailedSCSink.addError(Strings.SOME_ERROR_OCCURRED);

    }

    loadingSink.add(false);

  }


}