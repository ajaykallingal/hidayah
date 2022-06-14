

import 'dart:async';

import 'package:hidayah/src/data/models/youtube_videos/youtube_videos_response.dart';

import '../../constants/strings.dart';
import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class YoutubeVideosBloc{

  final bool _isDisposed = false;
  final StreamController<bool> _loading = StreamController<bool>.broadcast();

  ///stream for loader
  final _loadingSC = StreamController<bool>.broadcast();
  StreamSink<bool> get loadingSink => _loadingSC.sink;
  Stream<bool> get loadingStream => _loadingSC.stream;

  /// stream for quran fetch
  final _youtubeVideosSC = StreamController<YoutubeVideosResponse>.broadcast();
  StreamSink<YoutubeVideosResponse> get youtubeVideosSCSink => _youtubeVideosSC.sink;
  Stream<YoutubeVideosResponse> get youtubeVideosSCStreamListener => _youtubeVideosSC.stream;


  YoutubeVideosBloc();


  fetchYouTubeVideos()async{
    if(_isDisposed){
      return;
    }
    loadingSink.add(true);
    StateModel? state = await ObjectFactory().repository.fetchYouTubeVideos();

    if(state is SuccessState){
      if(!_youtubeVideosSC.isClosed){
        youtubeVideosSCSink.add(state.value as YoutubeVideosResponse);
      }
    } else if(state is ErrorState){
      youtubeVideosSCSink.addError(Strings.SOME_ERROR_OCCURRED);

    }

    loadingSink.add(false);

  }
  ///disposing the stream if it is not using
  @override
  void dispose() {
    _loading.close();
  }


}