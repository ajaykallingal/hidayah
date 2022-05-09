//
//
// import 'dart:async';
//
// import 'package:hidayah/src/data/models/show_all_dua/show_all_dua_request.dart';
// import 'package:hidayah/src/data/models/show_all_dua/show_all_dua_response.dart';
//
// import '../../constants/strings.dart';
// import '../../shared_pref/object_factory.dart';
// import '../models/common/state_model.dart';
//
// class ShowAllDuaBloc{
//   bool _isDispose = false;
//
//
//   ///stream for loader
//   final _loadingSC = StreamController<bool>.broadcast();
//   StreamSink<bool> get loadingSink => _loadingSC.sink;
//   Stream<bool> get loadingStream => _loadingSC.stream;
//
//   /// stream for quran fetch
//   final _showAllDuaSC = StreamController<ShowAllDuaResponse>.broadcast();
//   StreamSink<ShowAllDuaResponse> get showAllDuaSCSink => _showAllDuaSC.sink;
//   Stream<ShowAllDuaResponse> get showAllDuaStreamListener => _showAllDuaSC.stream;
//
//   // /// stream for daily surat
//   // final _displayDailySuratSC = StreamController<bool>.broadcast();
//   // StreamSink<bool> get fetchDailySuratSCSink => _displayDailySuratSC.sink;
//   // Stream<bool> get fetchDailySCStream => _displayDailySuratSC.stream;
//
//
// ShowAllDuaBloc();
//   /// quran screen
//
//   showAllDua({required ShowAllDuaRequest request}) async {
//     if(_isDispose){
//       return;
//     }
//     loadingSink.add(true);
//     StateModel? state = await ObjectFactory().repository.s
//
//     if(state is SuccessState){
//       if(!_showAllDuaSC.isClosed){
//         showAllDuaSCSink.add(state.value );
//       }
//     } else if(state is ErrorState){
//       showAllDuaSCSink.addError(Strings.SOME_ERROR_OCCURRED);
//
//     }
//
//     loadingSink.add(false);
//
//   }
// }