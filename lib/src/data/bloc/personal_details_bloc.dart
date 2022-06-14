

import 'dart:async';

import 'package:hidayah/src/data/models/login/login_with_email_response.dart';
import 'package:hidayah/src/data/models/personal_details/personal_details_request.dart';

import '../../constants/strings.dart';
import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class PersonalDetailsBloc{
  final bool _isDispose = false;


  ///stream for loader
  final _loadingSC = StreamController<bool>.broadcast();
  StreamSink<bool> get loadingSink => _loadingSC.sink;
  Stream<bool> get loadingStream => _loadingSC.stream;

  /// stream for personal details
  final _personalDetailsSC = StreamController<LoginWithEmailResponse>.broadcast();
  StreamSink<LoginWithEmailResponse> get personalDetailsSink => _personalDetailsSC.sink;
  Stream<LoginWithEmailResponse> get personalDetailsSCStreamListener => _personalDetailsSC.stream;

  // /// stream for daily surat
  // final _displayDailySuratSC = StreamController<bool>.broadcast();
  // StreamSink<bool> get fetchDailySuratSCSink => _displayDailySuratSC.sink;
  // Stream<bool> get fetchDailySCStream => _displayDailySuratSC.stream;


 PersonalDetailsBloc();

  /// quran screen

  fetchPersonalDetails({required PersonalDetailsRequest request}) async {
    if(_isDispose){
      return;
    }
    loadingSink.add(true);
    StateModel? state = await ObjectFactory().repository.fetchPersonalDetails(request);
    if(state is SuccessState){
      if(!_personalDetailsSC.isClosed){
        personalDetailsSink.add(state.value as LoginWithEmailResponse );
      }
    } else if(state is ErrorState){
      personalDetailsSink.addError(Strings.SOME_ERROR_OCCURRED);

    }

    loadingSink.add(false);

  }


}