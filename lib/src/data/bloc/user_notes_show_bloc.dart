

import 'dart:async';

import 'package:hidayah/src/data/models/notes/notes_request.dart';
import 'package:hidayah/src/data/models/notes/notes_response.dart';

import '../../constants/strings.dart';
import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class UserNotesShowBloc{
  bool _isDispose = false;


  ///stream for loader
  final _loadingSC = StreamController<bool>.broadcast();
  StreamSink<bool> get loadingSink => _loadingSC.sink;
  Stream<bool> get loadingStream => _loadingSC.stream;

/// Stream for notes
  final _userNotesSC = StreamController<NotesResponse>.broadcast();
  StreamSink<NotesResponse> get notesFetchSCSink => _userNotesSC.sink;
  Stream<NotesResponse> get notesFetchSCStreamListener => _userNotesSC.stream;


UserNotesShowBloc();


  fetchUserNotes({required NotesRequest request}) async {
    if(_isDispose){
      return;
    }
    loadingSink.add(true);
    StateModel? state = await ObjectFactory().repository.fetchUserNotes(request);

    if(state is SuccessState){
      if(!_userNotesSC.isClosed){
        notesFetchSCSink.add(state.value );
      }
    } else if(state is ErrorState){
      notesFetchSCSink.addError(Strings.SOME_ERROR_OCCURRED);

    }

    loadingSink.add(false);

  }


}