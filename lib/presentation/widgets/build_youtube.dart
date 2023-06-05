import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:split_screen_app/core/controllers/controllers.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// Widget buildYtbvideo(BuildContext context, size, ytcontroller, height) {
//   return Expanded(
//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(14),
//       child: Container(
//         height: height,
//         width: size.width,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
//         child: YoutubePlayer(
//           controller: ytcontroller,
//           showVideoProgressIndicator: true,
//           // videoProgressIndicatorColor: Colors.amber,
//           progressColors: const ProgressBarColors(
//             playedColor: Colors.amber,
//             handleColor: Colors.amberAccent,
//           ),
//         ),
//       ),
//     ),
//   );
// }

class YtbVideoWidget1 extends StatefulWidget {
  final double height;
  // final YoutubePlayerController ytController;

  const YtbVideoWidget1({
    Key? key,
    required this.height,
    // required this.ytController,
  }) : super(key: key);

  @override
  State<YtbVideoWidget1> createState() => _YtbVideoWidgetState();
}

class _YtbVideoWidgetState extends State<YtbVideoWidget1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final url = Hive.box("device_id").get('url');
    ytController = YoutubePlayerController(
      initialVideoId: url ?? '',
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: true,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
    ytController?.play();
    ytController?.addListener(
      () {
        log("Listening");
      },
    );
    print(ytController?.initialVideoId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          height: widget.height,
          width: MediaQuery.of(context).size.width,
          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: YoutubePlayer(
            controller:
                ytController ?? YoutubePlayerController(initialVideoId: ''),
            showVideoProgressIndicator: true,
            // videoProgressIndicatorColor: Colors.amber,
            progressColors: const ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
            onReady: () {
              debugPrint("Ready");
            },
          ),
        ),
      ),
    );
  }
}
