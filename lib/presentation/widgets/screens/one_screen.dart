import 'package:flutter/material.dart';
import 'package:split_screen_app/application/bloc/splash_bloc.dart';
import 'package:split_screen_app/domain/core/api_endPoint.dart';
import 'package:split_screen_app/presentation/widgets/carousel_build.dart';
import 'package:video_player/video_player.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

Widget buildOneScreen(
    BuildContext context, SplashLoaded state, controller, ytController) {
  final size = MediaQuery.of(context).size;
  return Scaffold(
    backgroundColor: Colors.black,
    body: state.deviceDetails?.media?[0].type == 'image'
        ? buildImage(size, state, 0, size.height)
        : state.deviceDetails?.media?[0].type == 'youtube'
            ? buildOneYtbvideo(context, size, ytController, size.height)
            : state.deviceDetails?.media?[0].type == 'video'
                ? buildvid(context, size, controller, size.height)
                : state.deviceDetails?.media?[0].type == 'carousel'
                    ? CarouselSlider2(
                        size: size.width,
                        height: size.height,
                        imageList:
                            state.deviceDetails!.media![0].carouselImages!,
                        dur: state.deviceDetails!.media![0].timeInterval ?? 800)
                    : Container(),
  );
}

Widget buildImage(size, state, index, height) {
  return Image.network(
    "$endPoint${state.deviceDetails?.media?[index].file}",
    fit: BoxFit.fill,
    width: size.width,
    height: height,
  );
}

Widget buildvid(
    BuildContext context, size, VideoPlayerController controller, height) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(14),
    child: SizedBox(
        height: height,
        width: size.width,
        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
        child: VideoPlayer(controller)),
  );
}

Widget buildOneYtbvideo(BuildContext context, size, ytcontroller, height) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(14),
    child: SizedBox(
      height: height,
      width: size.width,
      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      child: YoutubePlayer(
        controller: ytcontroller,
        showVideoProgressIndicator: true,
        // videoProgressIndicatorColor: Colors.amber,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        // onReady: () {
        //   _isPlayerReady = true;
        // },
      ),
    ),
  );
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
