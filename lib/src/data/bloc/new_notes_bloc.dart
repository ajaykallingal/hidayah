


import 'dart:async';

import 'package:hidayah/src/data/models/new_notes/new_notes_request.dart';
import 'package:hidayah/src/data/models/new_notes/new_notes_response.dart';

import '../../constants/strings.dart';
import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class NewNotesBloc{
  bool _isDispose = false;


  ///stream for loader
  final _loadingSC = StreamController<bool>.broadcast();
  StreamSink<bool> get loadingSink => _loadingSC.sink;
  Stream<bool> get loadingStream => _loadingSC.stream;

  /// Stream for notes
  final _newUserNotesSC = StreamController<NewNotesResponse>.broadcast();
  StreamSink<NewNotesResponse> get insertNewNotesSCSink => _newUserNotesSC.sink;
  Stream<NewNotesResponse> get insertNewNotesSCStreamListener => _newUserNotesSC.stream;


NewNotesBloc();

  fetchUserNotes({required NewNotesRequest request}) async {
    if(_isDispose){
      return;
    }
    loadingSink.add(true);
    StateModel? state = await ObjectFactory().repository.insertNewNotes(request);

    if(state is SuccessState){
      if(!_newUserNotesSC.isClosed){
        insertNewNotesSCSink.add(state.value );
      }
    } else if(state is ErrorState){
      insertNewNotesSCSink.addError(Strings.SOME_ERROR_OCCURRED);

    }

    loadingSink.add(false);

  }

}