

import 'dart:async';

import 'package:hidayah/src/data/models/dua/dua_category_response.dart';

import '../../constants/strings.dart';
import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class DuaCategoryBloc{

  bool _isDisposed = false;

  ///stream for loader
  final _loadingSC = StreamController<bool>.broadcast();
  StreamSink<bool> get loadingSink => _loadingSC.sink;
  Stream<bool> get loadingStream => _loadingSC.stream;

  /// stream for dua category fetch
  final _duaCategoryFetchSC = StreamController<DuaCategoryResponse>.broadcast();
  StreamSink<DuaCategoryResponse> get duaCategoryFetchSCSink => _duaCategoryFetchSC.sink;
  Stream<DuaCategoryResponse> get duaCategoryFetchStreamListener => _duaCategoryFetchSC.stream;


  DuaCategoryBloc();


  fetchDuaCategory()async{
    if(_isDisposed){
      return;
    }
    loadingSink.add(true);
    StateModel? state = await ObjectFactory().repository.fetchDuaCategory();

    if(state is SuccessState){
      if(!_duaCategoryFetchSC.isClosed){
        duaCategoryFetchSCSink.add(state.value );
      }
    } else if(state is ErrorState){
      duaCategoryFetchSCSink.addError(Strings.SOME_ERROR_OCCURRED);

    }

    loadingSink.add(false);

  }

}