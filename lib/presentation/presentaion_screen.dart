import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_screen_app/application/bloc/splash_bloc.dart';
import 'package:split_screen_app/core/controllers/controllers.dart';
import 'package:split_screen_app/domain/core/api_endPoint.dart';
import 'package:split_screen_app/presentation/controls.dart';
import 'package:split_screen_app/presentation/widgets/screens/four_screens.dart';
import 'package:split_screen_app/presentation/widgets/screens/one_screen.dart';
import 'package:split_screen_app/presentation/widgets/screens/three_screens.dart';
import 'package:split_screen_app/presentation/widgets/screens/two_screens.dart';
import 'package:split_screen_app/presentation/widgets/screens/two_screens_port.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  // VideoPlayerController? controller;
  // VideoPlayerController? controller2;
  // VideoPlayerController? controller3;
  // VideoPlayerController? controller4;
  Timer? timer;

  // String? url1;
  // String? url2;
  // String? url3;
  // String? url4;
  final bool _isPlayerReady = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final myBlocState = context.read<SplashBloc>().state;
    if (myBlocState is SplashLoaded) {
      log("++++++++++++++++");
      // if (myBlocState.deviceDetails?.media?[0].type != "image") {
      //   url1 = myBlocState.deviceDetails?.media?[0].type == "video"
      //       ? "$endPoint${myBlocState.deviceDetails?.media?[0].file}"
      //       : myBlocState.deviceDetails?.media?[0].file;
      //   if (myBlocState.deviceDetails?.media?[0].type == "video") {
      //     controller = VideoPlayerController.network(
      //       url1 ?? '',
      //       videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      //     );
      //     controller?.addListener(() {
      //       setState(() {});
      //     });
      //     controller?.setLooping(true);
      //     controller?.initialize();
      //   }
      // }
      // if (myBlocState.deviceDetails!.deviceDetails!.elements! > 1) {
      //   if (myBlocState.deviceDetails?.media?[1].type != "image") {
      //     url2 = myBlocState.deviceDetails?.media?[1].type == "video"
      //         ? "$endPoint${myBlocState.deviceDetails?.media?[1].file}"
      //         : myBlocState.deviceDetails?.media?[1].file;
      //     if (myBlocState.deviceDetails?.media?[1].type == "youtube") {
      //       // url2 = await getVideoUrl(url2);
      //     }
      //     controller2 = VideoPlayerController.network(
      //       url2 ?? '',
      //       videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      //     );
      //   }
      // }

      // if (myBlocState.deviceDetails!.deviceDetails!.elements! > 2) {
      //   if (myBlocState.deviceDetails?.media?[2].type != "image") {
      //     url3 = myBlocState.deviceDetails?.media?[2].type == "video"
      //         ? "$endPoint${myBlocState.deviceDetails?.media?[2].file}"
      //         : myBlocState.deviceDetails?.media?[2].file;
      //     if (myBlocState.deviceDetails?.media?[2].type == "youtube") {
      //       // url3 = await getVideoUrl(url3);
      //     }
      //     controller3 = VideoPlayerController.network(
      //       url3 ?? '',
      //       videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      //     );
      //   }
      // }

      // if (myBlocState.deviceDetails!.deviceDetails!.elements! > 3) {
      //   log("message");
      //   if (myBlocState.deviceDetails?.media?[3].type != "image") {
      //     url4 = myBlocState.deviceDetails?.media?[3].type == "video"
      //         ? "$endPoint${myBlocState.deviceDetails?.media?[3].file}"
      //         : myBlocState.deviceDetails?.media?[3].file;
      //     if (myBlocState.deviceDetails?.media?[3].type == "youtube") {
      //       // url4 = await getVideoUrl(url4);
      //     }
      //     controller4 = VideoPlayerController.network(
      //       url4 ?? '',
      //       videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      //     );
      //   }
      // }

      // Do something with these values

      // _videoMetaData = const YoutubeMetaData();
      // _playerState = PlayerState.unknown;

      // _videoMetaData = const YoutubeMetaData();
      // _playerState = PlayerState.unknown;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        BlocProvider.of<SplashBloc>(context).add(
          FetchLayoutModify(),
        );

        print("Timer");
      });
    });
  }

  @override
  void dispose() {
    // ytcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoaded && state.isScreenRef == true) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
            return const ImageScreen();
          }));
        }
      },
      builder: (context, state) {
        if (state is SplashLoaded) {
          final eleCou = state.deviceDetails?.deviceDetails?.elements;

          if (eleCou == 4) {
            if (state.deviceDetails?.deviceDetails?.orientation == 'portrait') {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
              ]);
            } else {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
              ]);
            }
            return buildFourScreens(
              context,
              state,
              controller,
              controller2,
              controller3,
              controller4,
              ytController,
            );
          } else if (eleCou == 3) {
            if (state.deviceDetails?.deviceDetails?.orientation == 'portrait') {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
              ]);
            } else {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
              ]);
            }
            return buildThreeScreens(
              context,
              state,
              controller,
              controller2,
              controller3,
              ytController,
            );
          } else if (eleCou == 2 &&
              state.deviceDetails?.deviceDetails?.orientation == 'portrait') {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
            return buildTwoScreensPor(
              context,
              state,
              controller,
              controller2,
              ytController,
            );
          } else if (eleCou == 2 &&
              state.deviceDetails?.deviceDetails?.orientation == 'landscape') {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
            ]);
            return buildTwoScreens(
              context,
              state,
              controller,
              controller2,
              ytController,
            );
          } else if (eleCou == 1 &&
              state.deviceDetails?.deviceDetails?.orientation == 'portrait') {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
            return buildOneScreen(
              context,
              state,
              controller,
              ytController,
            );
          } else if (eleCou == 1 &&
              state.deviceDetails?.deviceDetails?.orientation == 'landscape') {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
            ]);
            return buildOneScreen(
              context,
              state,
              controller,
              ytController,
            );
          }
          return buildImage(context);
        }
        return Container();
      },
    );
  }
}

Widget buildImage(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return Scaffold(
    body: Image.asset(
      'assets/image.png',
      fit: BoxFit.fitWidth,
      width: size.width,
      height: size.height,
    ),
  );
}

// Widget buildFourScreens(BuildContext context, LayoutLoaded state, controller) {
//   final size = MediaQuery.of(context).size;
//   return Scaffold(
//     backgroundColor: Colors.black,
//     body: SafeArea(
//       child: GridView.builder(
//           padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
//           // shrinkWrap: true,
//           // physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//               maxCrossAxisExtent: 530,
//               // childAspectRatio: 2 / 3,
//               crossAxisSpacing: 5,
//               mainAxisExtent: size.height * .4,
//               mainAxisSpacing: 5),
//           itemCount: 4,
//           itemBuilder: (BuildContext ctx, index) {
//             return InkWell(
//               child: Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(

//                       // color: ColorManager.whiteColor,
//                       borderRadius: BorderRadius.circular(5)),
//                   child:
//                       //  state.deviceDetails?.media?[index].type == 'youtube'?
//                       buildvideo(context, size, controller)
//                   //     : state.deviceDetails?.media?[index].type == 'image'
//                   //         ? buildOneImage(size, state)
//                   //         : Container(),
//                   ),
//             );
//           }),
//     ),
//   );
// }

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
          children: [
            VideoPlayer(controller),
            ControlsOverlay(controller: controller),
            VideoProgressIndicator(controller, allowScrubbing: true),
          ],
        ),
      ),
    ),
  );
}

Widget buildOneImage(size, state, index, height) {
  return Expanded(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.network(
        "$endPoint${state.deviceDetails?.media?[index].file}",
        fit: BoxFit.contain,
        width: size.width,
        height: height,
      ),
    ),
  );
}

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
          // onReady: () {
          //   _isPlayerReady = true;
          // },
        ),
      ),
    ),
  );
}

// Widget buildYtbvideo2(BuildContext context, size, ytcontroller, height) {
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
//             playedColor: Color.fromARGB(255, 0, 0, 0),
//             handleColor: Color.fromARGB(255, 66, 55, 13),
//           ),
//           // onReady: () {
//           //   _isPlayerReady = true;
//           // },
//         ),
//       ),
//     ),
//   );
// }
