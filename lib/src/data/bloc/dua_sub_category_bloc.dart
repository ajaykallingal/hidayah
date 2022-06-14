


import 'dart:async';

import 'package:hidayah/src/data/models/dua_sub_category/dua_sub_category_request.dart';
import 'package:hidayah/src/data/models/dua_sub_category/dua_sub_category_response.dart';

import '../../constants/strings.dart';
import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class DuaSubCategoryBloc{

  final bool _isDispose = false;


  ///stream for loader
  final _loadingSC = StreamController<bool>.broadcast();
  StreamSink<bool> get loadingSink => _loadingSC.sink;
  Stream<bool> get loadingStream => _loadingSC.stream;

  /// stream for dua sub category
  final _duaSubCategorySC = StreamController<DuaSubCategoryResponse>.broadcast();
  StreamSink<DuaSubCategoryResponse> get duaSubCategorySCSink => _duaSubCategorySC.sink;
  Stream<DuaSubCategoryResponse> get duaSubCategorySCStreamListener => _duaSubCategorySC.stream;

  // /// stream for daily surat
  // final _displayDailySuratSC = StreamController<bool>.broadcast();
  // StreamSink<bool> get fetchDailySuratSCSink => _displayDailySuratSC.sink;
  // Stream<bool> get fetchDailySCStream => _displayDailySuratSC.stream;


  DuaSubCategoryBloc();

  /// quran screen

  fetchDuaSubCategory({required DuaSubCategoryRequest request}) async {
    if(_isDispose){
      return;
    }
    loadingSink.add(true);
    StateModel? state = await ObjectFactory().repository.fetchDuaSubCategory(request);

    if(state is SuccessState){
      if(!_duaSubCategorySC.isClosed){
        duaSubCategorySCSink.add(state.value );
      }
    } else if(state is ErrorState){
      duaSubCategorySCSink.addError(Strings.SOME_ERROR_OCCURRED);

    }

    loadingSink.add(false);

  }


}