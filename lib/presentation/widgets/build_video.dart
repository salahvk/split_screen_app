import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

Widget buildvideo(
    BuildContext context, size, VlcPlayerController vlcController, height) {
  return Expanded(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: height,
        width: size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
        child: VlcPlayer(
          controller: vlcController,
          aspectRatio: 3,
          // showControls: true,
        ),
      ),
    ),
  );
}
