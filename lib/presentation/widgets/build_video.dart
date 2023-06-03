import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

Widget buildvideo(
    BuildContext context, size, VideoPlayerController controller, height) {
  return Expanded(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: height,
        width: size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            VideoPlayer(controller),
            // ControlsOverlay(controller: controller),
            VideoProgressIndicator(controller, allowScrubbing: true),
          ],
        ),
      ),
    ),
  );
}
