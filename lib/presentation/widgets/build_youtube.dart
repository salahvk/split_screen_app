import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

Widget buildYtbvideo(BuildContext context, size, ytcontroller, height) {
  return Expanded(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: height,
        width: size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
        child: YoutubePlayer(
          controller: ytcontroller,
          showVideoProgressIndicator: true,
          // videoProgressIndicatorColor: Colors.amber,
          progressColors: const ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
        ),
      ),
    ),
  );
}
