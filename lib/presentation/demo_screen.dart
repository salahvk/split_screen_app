// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   late YoutubePlayerController ytcontroller;
//   late YoutubePlayerController ytcontroller2;
//   final bool _isPlayerReady = false;
//   final bool _isPlayerReady2 = false;
//   late PlayerState _playerState;
//   late YoutubeMetaData _videoMetaData;
//   late PlayerState _playerState2;
//   late YoutubeMetaData _videoMetaData2;
//   @override
//   void initState() {
//     super.initState();
//     ytcontroller = YoutubePlayerController(
//       initialVideoId: 'eRGw6hh2Qyg',
//       flags: const YoutubePlayerFlags(
//         mute: false,
//         autoPlay: true,
//         disableDragSeek: false,
//         loop: true,
//         isLive: false,
//         forceHD: false,
//         enableCaption: true,
//       ),
//     )..addListener(listener);
//     _videoMetaData = const YoutubeMetaData();
//     _playerState = PlayerState.unknown;

//     ytcontroller2 = YoutubePlayerController(
//       initialVideoId: 'FrqGGw9DYfs',
//       flags: const YoutubePlayerFlags(
//         mute: false,
//         autoPlay: true,
//         disableDragSeek: false,
//         loop: true,
//         isLive: false,
//         forceHD: false,
//         enableCaption: true,
//       ),
//     )..addListener(listener);
//     _videoMetaData2 = const YoutubeMetaData();
//     _playerState2 = PlayerState.unknown;
//   }

//   @override
//   void dispose() {
//     ytcontroller.dispose();
//     ytcontroller2.dispose();

//     super.dispose();
//   }

//   void listener() {
//     if (_isPlayerReady && mounted && !ytcontroller.value.isFullScreen) {
//       setState(() {
//         _playerState = ytcontroller.value.playerState;
//         _videoMetaData = ytcontroller.metadata;
//       });
//     }

//     if (_isPlayerReady2 && mounted && !ytcontroller2.value.isFullScreen) {
//       setState(() {
//         _playerState2 = ytcontroller2.value.playerState;
//         _videoMetaData2 = ytcontroller2.metadata;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Row(
//         children: [
//           buildYtbvideo(
//               context, size, ytcontroller, size.height, _isPlayerReady),
//           buildYtbvideo2(
//               context, size, ytcontroller2, size.height, _isPlayerReady2)
//         ],
//       ),
//     );
//   }
// }

// Widget buildYtbvideo(
//     BuildContext context, size, ytcontroller, height, isPlayerReady) {
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
//           onReady: () {
//             isPlayerReady = true;
//           },
//         ),
//       ),
//     ),
//   );
// }

// Widget buildYtbvideo2(
//     BuildContext context, size, ytcontroller, height, isPlayerReady) {
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
//           onReady: () {
//             isPlayerReady = true;
//           },
//         ),
//       ),
//     ),
//   );
// }

// import 'package:flutter/material.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// class TwoVideosScreen extends StatelessWidget {
//   const TwoVideosScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Two Videos'),
//       ),
//       body: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: YoutubePlayer(
//               controller: YoutubePlayerController.fromVideoId(
//                 videoId: 'FrqGGw9DYfs',
//                 autoPlay: true,
//                 params: const YoutubePlayerParams(showFullscreenButton: true),
//               ),
//               aspectRatio: 16 / 9,
//             ),
//           ),
//           Expanded(
//             child: YoutubePlayer(
//               controller: YoutubePlayerController.fromVideoId(
//                 videoId: 'eRGw6hh2Qyg',
//                 autoPlay: true,
//                 params: const YoutubePlayerParams(showFullscreenButton: true,),
//               ),
//               aspectRatio: 16 / 9,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeVlcPlayer extends StatefulWidget {
  final String videoId;

  const YoutubeVlcPlayer({super.key, required this.videoId});

  @override
  _YoutubeVlcPlayerState createState() => _YoutubeVlcPlayerState();
}

class _YoutubeVlcPlayerState extends State<YoutubeVlcPlayer> {
  late VlcPlayerController _controller;
  late Future<String> _videoUrlFuture;

  @override
  void initState() {
    super.initState();
    // _controller = VlcPlayerController.network();
    _videoUrlFuture = _getVideoUrl();
  }

  // Future<String> _getVideoUrl() async {
  //   var yt = YoutubeExplode();
  //   var manifest = await yt.videos.streamsClient.getManifest(widget.videoId);
  //   var video = manifest.videoOnly.first;
  //   print("object");
  //   print(video.url.toString());
  //   return video.url.toString();
  // }

  Future<String> _getVideoUrl() async {
    var yt = YoutubeExplode();
    var manifest = await yt.videos.streamsClient.getManifest(widget.videoId);
    String videoUrl;
    // var s = manifest.videoOnly.getAllVideoQualitiesLabel();
    // var s1 = manifest.videoOnly.getAllVideoQualities();
    // if(manifest.videoOnly.getAllVideoQualities().contains(VideoQuality.high1080)){

    // }

    if (manifest.videoOnly
        .getAllVideoQualities()
        .contains(VideoQuality.high720)) {
      var video = manifest.videoOnly.firstWhere(
        (stream) => stream.videoQuality == VideoQuality.high720,
      );
      videoUrl = video.url.toString();
    } else {
      videoUrl = manifest.videoOnly.last.url.toString();
    }
    // var s2 = manifest.videoOnly.bestQuality;
    // print("________________");
    // print(s1.contains(VideoQuality.high1080));
    // print(s2.videoQuality);
    // print(s);
    // var videog = manifest.videoOnly.sortByVideoQuality();
    // var video = manifest.videoOnly.sortByVideoQuality().firstWhere((stream) {
    //   final s = stream.videoQuality;
    //   print(s);
    //   return true;
    // });
    // print("object");
    // print(video.url.toString());
    print(videoUrl);
    return videoUrl;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _videoUrlFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return VlcPlayer(
            controller: _controller,
            aspectRatio: 16 / 9,
            // url: snapshot.data!,
            placeholder: Container(),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
