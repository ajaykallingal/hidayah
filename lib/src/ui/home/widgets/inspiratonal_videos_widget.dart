import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../constants/text_style.dart';
import '../textStyle/text_style.dart';

class InspirationalVideosWidget extends StatelessWidget {
  const InspirationalVideosWidget({
    Key? key,
    required YoutubePlayerController controller,
    required List<String> videoIds,
  }) : _controller = controller, _videoIds = videoIds, super(key: key);

  final YoutubePlayerController _controller;
  final List<String> _videoIds;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text('Inspiration',style: kHomePageCardTitleTextStyle,),
        Divider(color: Color(0xFF707070).withOpacity(0.1),indent: 0,thickness: 0.8,endIndent: 0,),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 160,
              width: 290,
              
              child: YoutubePlayerBuilder(

                player: YoutubePlayer(

                  controller: _controller,
                  showVideoProgressIndicator:  true,
                  progressIndicatorColor: mainRedShadeForTitle,
                  // aspectRatio: 16 / 9,
                  progressColors: ProgressBarColors(handleColor: mainRedShadeForTitle,playedColor: mainRedShadeForText),
                  topActions: <Widget>[
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        _controller.metadata.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      onPressed: () {
                        log('Settings Tapped!');
                      },
                    ),
                  ],
                  onReady: () {
                    // _controller.addListener((listner) )
                  },
                  onEnded: (data) {
                    _controller
                        .load(_videoIds[(_videoIds.indexOf(data.videoId) + 1) % _videoIds.length]);
                    // _showSnackBar('Next Video Started!');
                  },
                ),


                builder: (BuildContext context, player) {
                  return player;
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}