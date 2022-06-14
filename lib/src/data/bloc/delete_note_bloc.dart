//
//
//
// import 'dart:async';
//
// import 'package:hidayah/src/data/models/delete_notes/delete_notes_request.dart';
//
// import '../../constants/strings.dart';
// import '../../shared_pref/object_factory.dart';
// import '../models/common/state_model.dart';
// import '../models/notes/notes_response.dart';
//
// class DeleteNoteBloc{
//   final bool _isDispose = false;
//
//
//   ///stream for loader
//   final _loadingSC = StreamController<bool>.broadcast();
//   StreamSink<bool> get loadingSink => _loadingSC.sink;
//   Stream<bool> get loadingStream => _loadingSC.stream;
//
//   /// Stream for notes
//   final _deleteNotesSC = StreamController<NotesResponse>.broadcast();
//   StreamSink<NotesResponse> get deleteNotesSCSink => _deleteNotesSC.sink;
//   Stream<NotesResponse> get deleteNotesSCStreamListener => _deleteNotesSC.stream;
//
//
//   DeleteNoteBloc();
//
//   deleteNote({required DeleteNotesRequest request}) async {
//     if(_isDispose){
//       return;
//     }
//     loadingSink.add(true);
//     StateModel? state = await ObjectFactory().repository.deleteNotes(request);
//
//     if(state is SuccessState){
//       if(!_deleteNotesSC.isClosed){
//         deleteNotesSCSink.add(state.value );
//       }
//     } else if(state is ErrorState){
//       deleteNotesSCSink.addError(Strings.SOME_ERROR_OCCURRED);
//
//     }
//
//     loadingSink.add(false);
//
//   }
//
// }