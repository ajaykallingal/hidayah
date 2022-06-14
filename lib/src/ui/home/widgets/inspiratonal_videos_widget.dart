
import 'package:flutter/material.dart';
import 'package:hidayah/src/data/bloc/youtube_videos_bloc.dart';
import 'package:hidayah/src/data/models/youtube_videos/youtube_videos_response.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../textStyle/text_style.dart';

class InspirationalVideosWidget extends StatefulWidget {
  const InspirationalVideosWidget({Key? key}) : super(key: key);

  // const InspirationalVideosWidget({
  //   Key? key,
  //   required YoutubePlayerController controller,
  //   required String videoIds,
  // }) : _controller = controller, _videoIds = videoId, super(key: key);

  // final YoutubePlayerController _controller;
  // final List<String> _videoIds;

  @override
  State<InspirationalVideosWidget> createState() => _InspirationalVideosWidgetState();
}

class _InspirationalVideosWidgetState extends State<InspirationalVideosWidget> {

  final youtubeVideosBloc = YoutubeVideosBloc();
  bool loading = true;
  YoutubeVideosResponse? youtubeVideosResponse;

  double volume = 100;
  YoutubePlayerController? _controller;
 List videoIds = [];






  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    youtubeVideosBloc.youtubeVideosSCStreamListener.listen((event) {

      setState(() {
        // _controller!.load(event.response!.link);
        // _controller!.pause();

        _controller =  YoutubePlayerController(
          initialVideoId: event.response!.link,
          params:  const YoutubePlayerParams(
            startAt: Duration(seconds: 30),
            showControls: true,
            showFullscreenButton: true,
            useHybridComposition: true,
          ),

        );
        youtubeVideosResponse = event;
        // videoIds = youtubeVideosResponse!.link as List;
        // _controller =  YoutubePlayerController(
        //   initialVideoId: youtubeVideosResponse!.response!.link,
        //   params:  const YoutubePlayerParams(
        //     startAt: Duration(seconds: 30),
        //     showControls: true,
        //     showFullscreenButton: true,
        //     useHybridComposition: true,
        //   ),
        //
        // );

        loading = false;
        print(event.response!.link+"2222222222222222222");
        // _controller.load(_ids[(_ids.indexOf(_controller.metadata.videoId) - 1) % _ids.length]);



      });
    });
    super.didChangeDependencies();

  }

  @override
  void initState() {
    // TODO: implement initState
    youtubeVideosBloc.fetchYouTubeVideos();

    super.initState();
    //


  }
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();

  }


  @override
  Widget build(BuildContext context) {

    return Visibility(visible: !loading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text('Inspiration',style: kHomePageCardTitleTextStyle,),
          Divider(color: const Color(0xFF707070).withOpacity(0.1),indent: 0,thickness: 0.8,endIndent: 0,),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:  SizedBox(
                    height: 160,
                    width: 290,

                    child: YoutubePlayerIFrame(
                      controller: _controller,
                      aspectRatio: 16 / 9,

                    ),
                    // loading? YoutubePlayerBuilder(
                    //
                    //   player: YoutubePlayer(
                    //
                    //     controller: _controller,
                    //     showVideoProgressIndicator:  true,
                    //     progressIndicatorColor: mainRedShadeForTitle,
                    //     // aspectRatio: 16 / 9,
                    //     progressColors: ProgressBarColors(handleColor: mainRedShadeForTitle,playedColor: mainRedShadeForText),
                    //     topActions: <Widget>[
                    //       const SizedBox(width: 8.0),
                    //       Expanded(
                    //         child: Text(
                    //           _controller.metadata.title,
                    //           style: const TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 18.0,
                    //           ),
                    //           overflow: TextOverflow.ellipsis,
                    //           maxLines: 1,
                    //         ),
                    //       ),
                    //       // IconButton(
                    //       //   icon: const Icon(
                    //       //     Icons.settings,
                    //       //     color: Colors.white,
                    //       //     size: 25.0,
                    //       //   ),
                    //       //   onPressed: () {
                    //       //     log('Settings Tapped!');
                    //       //   },
                    //       // ),
                    //     ],
                    //     onReady: () {
                    //       // _controller.addListener((listner) )
                    //     },
                    //     // onEnded: (data) {
                    //     //   _controller
                    //     //       .load(youtubeVideosResponse!.response.link[(youtubeVideosResponse!.response.link.indexOf(data.title) + 1) % snapshot.data!.response.link.length]);
                    //     //   // _showSnackBar('Next Video Started!');
                    //     // },
                    //   ),
                    //
                    //
                    //   builder: (BuildContext context, player) {
                    //     return player;
                    //   },
                    // ):const CircularProgressIndicator(),
                  ),

            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}