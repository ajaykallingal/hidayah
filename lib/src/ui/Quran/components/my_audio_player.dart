//
//
//
//  import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/cupertino.dart';
//
// class MyAudioPlayer extends ChangeNotifier{
//   Duration? totalDuration;
//   Duration? position;
//   String playerState = "";
//
//
//   MyAudioPlayer(){
//     initAudio();
//   }
//
//   AudioPlayer audioPlayer = AudioPlayer();
//   AudioCache audioPLayerCache = AudioCache();
//
//   initAudio(){
//     audioPlayer.onDurationChanged.listen((updatedDuration) {
//       totalDuration = updatedDuration;
//       notifyListeners();
//
//
//     });
//
//     // audioPlayer.onPlayerCompletion.listen((event) {
//     //   if(currentIndex < fileName.length - 1){
//     //     currentIndex = currentIndex + 1;
//     //     nextTrack(fileName, currentIndex);
//     //   }
//     // });
//
//
//     audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
//       position = updatedPosition;
//       notifyListeners();
//
//     });
//     audioPlayer.onPlayerStateChanged.listen((playerState) {
//       if(playerState == PlayerState.STOPPED){
//         playerState = "Stopped" as PlayerState;
//       }
//       if(playerState == PlayerState.PLAYING){
//         playerState = "Playing" as PlayerState;
//       }
//       if(playerState == PlayerState.PAUSED){
//         playerState = "Paused" as PlayerState;
//       }
//
//
//     });
//
//   }
//
//   playAudio(String fileName){
//     audioPlayer.play(fileName);
//   }
//
//   pauseAudio(){
//     audioPlayer.pause();
//   }
//
//   stopAudio(){
//     audioPlayer.stop();
//   }
//
//   seekAudio(Duration durationToSeek){
//     audioPlayer.seek(durationToSeek);
//   }
//
//   // releaseModeAudio(){
//   //   audioPlayer.setReleaseMode(ReleaseMode.STOP);
//   // }
//
//   setUrl(String fileName){
//     audioPlayer.setUrl(fileName);
//   }
//
//   // onComplete(String fileName,int currentIndex){
//   //   audioPlayer.onPlayerCompletion.listen((event) {
//   //     if(currentIndex < fileName.length - 1){
//   //       currentIndex = currentIndex + 1;
//   //       nextTrack(fileName, currentIndex);
//   //     }
//   //   });
//   // }
//
// }