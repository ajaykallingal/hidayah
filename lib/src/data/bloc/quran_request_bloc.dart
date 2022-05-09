import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/strings.dart';
import 'package:hidayah/src/data/models/common/state_model.dart';
import 'package:hidayah/src/data/models/quran_request.dart';
import 'package:hidayah/src/data/models/quran_request_response.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';

class QuranRequestBloc {
  bool _isDispose = false;


  ///stream for loader
  final _loadingSC = StreamController<bool>.broadcast();
  StreamSink<bool> get loadingSink => _loadingSC.sink;
  Stream<bool> get loadingStream => _loadingSC.stream;

  /// stream for quran fetch
  final _quranFetchFilteredSC = StreamController<QuranRequestResponse>.broadcast();
  StreamSink<QuranRequestResponse> get quranFetchSCSink => _quranFetchFilteredSC.sink;
  Stream<QuranRequestResponse> get quranFetchSCStreamListener => _quranFetchFilteredSC.stream;

  // /// stream for daily surat
  // final _displayDailySuratSC = StreamController<bool>.broadcast();
  // StreamSink<bool> get fetchDailySuratSCSink => _displayDailySuratSC.sink;
  // Stream<bool> get fetchDailySCStream => _displayDailySuratSC.stream;


  QuranRequestBloc();

  /// quran screen

  quranFetchFiltered({required QuranRequest request}) async {
    if(_isDispose){
      return;
    }
    loadingSink.add(true);
    StateModel? state = await ObjectFactory().repository.quranFetchFiltered(request);

    if(state is SuccessState){
        if(!_quranFetchFilteredSC.isClosed){
          quranFetchSCSink.add(state.value );
        }
    } else if(state is ErrorState){
      quranFetchSCSink.addError(Strings.SOME_ERROR_OCCURRED);

    }

    loadingSink.add(false);

  }


}