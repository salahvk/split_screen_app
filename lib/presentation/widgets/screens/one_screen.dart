import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:split_screen_app/application/bloc/splash_bloc.dart';
import 'package:split_screen_app/core/controllers/controllers.dart';
import 'package:split_screen_app/domain/core/api_endPoint.dart';
import 'package:split_screen_app/presentation/widgets/carousel_build.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

Widget buildOneScreen(
    BuildContext context, SplashLoaded state, controller, ytController) {
  final size = MediaQuery.of(context).size;
  return Scaffold(
    backgroundColor: Colors.black,
    body: state.deviceDetails?.media?[0].type == 'image'
        ? buildImage(size, state, 0, size.height)
        : state.deviceDetails?.media?[0].type == 'youtube'
            ? YtbVideoWidget(height: size.height)
            : state.deviceDetails?.media?[0].type == 'video'
                ? CustomVideoPlayer(
                    controller: controller,
                    height: size.height,
                  )
                : state.deviceDetails?.media?[0].type == 'carousel'
                    ? CarouselSlider2(
                        size: size.width,
                        height: size.height,
                        imageList:
                            state.deviceDetails!.media![0].carouselImages!,
                        dur: state.deviceDetails!.media![0].timeInterval ?? 800,
                        ani: state.deviceDetails!.media![0].animation)
                    : Container(),
  );
}

Widget buildImage(size, state, index, height) {
  return Image.network(
    "$endPoint${state.deviceDetails?.media?[index].file}",
    fit: BoxFit.cover,
    width: size.width,
    height: height,
  );
}

// Widget buildvid(
//     BuildContext context, size, VideoPlayerController controller, height) {
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(14),
//     child: SizedBox(
//         height: height,
//         width: size.width,
//         // decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
//         child: VideoPlayer(controller)),
//   );
// }
class CustomVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  final double height;

  const CustomVideoPlayer(
      {super.key, required this.controller, required this.height});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    log("disposing");
    // widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        height: widget.height,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
        child: VideoPlayer(widget.controller),
      ),
    );
  }
}

// Widget buildOneYtbvideo(BuildContext context, size, ytcontroller, height) {
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(14),
//     child: SizedBox(
//       height: height,
//       width: size.width,
//       // decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
//       child: YoutubePlayer(
//         controller: ytcontroller,
//         showVideoProgressIndicator: true,
//         // videoProgressIndicatorColor: Colors.amber,
//         progressColors: const ProgressBarColors(
//           playedColor: Colors.amber,
//           handleColor: Colors.amberAccent,
//         ),
//         onReady: () {
//           log("Ready");
//         },
//       ),
//     ),
//   );
// }

class YtbVideoWidget extends StatefulWidget {
  final double height;
  // final YoutubePlayerController ytController;

  const YtbVideoWidget({
    Key? key,
    required this.height,
    // required this.ytController,
  }) : super(key: key);

  @override
  State<YtbVideoWidget> createState() => _YtbVideoWidgetState();
}

class _YtbVideoWidgetState extends State<YtbVideoWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final url = Hive.box("device_id").get('url');
    // ytController = YoutubePlayerController(
    //   params: const YoutubePlayerParams(
    //       mute: false,
    //       showControls: true,
    //       showFullscreenButton: true,
    //       loop: true),
    // );

    // ytController?.loadVideoById(videoId: url); // Auto Play
    // var logger = Logger();
    // logger.d("___________________________________");
    // print("video playing");
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
          height: widget.height,
          width: MediaQuery.of(context).size.width,
          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: YoutubePlayer(
            controller: ytController ?? YoutubePlayerController(),
            aspectRatio: 16 / 9,
          )),
    );
  }
}

// Widget buildCarousel2(size, height, List<String> imageList, dur) {
// // Use map method to add the string to every value in the list
//   List<String> modifiedList =
//       imageList.map((item) => "$endPoint$item").toList();

// // Output the modified list
//   print(modifiedList); // Output: [apple fruit, banana fruit, orange fruit]

//   return ClipRRect(
//       borderRadius: BorderRadius.circular(14),
//       child: CarouselSlider.builder(
//           options: CarouselOptions(
//             height: height,
//             // aspectRatio: 16 / 9,
//             viewportFraction: 1,
//             initialPage: 0,
//             enableInfiniteScroll: true,
//             reverse: false,
//             autoPlay: true,
//             autoPlayInterval: Duration(milliseconds: dur),
//             autoPlayAnimationDuration: const Duration(milliseconds: 800),
//             autoPlayCurve: Curves.fastOutSlowIn,
//             enlargeCenterPage: true,
//             enlargeFactor: 0.3,
//             scrollDirection: Axis.vertical,
//           ),
//           itemCount: modifiedList.length,
//           itemBuilder:
//               (BuildContext context, int itemIndex, int pageViewIndex) {
//             print(itemIndex);
//             return CachedNetworkImage(
//                 imageUrl: modifiedList[itemIndex], fit: BoxFit.cover);
//           }));
// }
