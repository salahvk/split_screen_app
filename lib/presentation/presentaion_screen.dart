import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_screen_app/application/bloc/splash_bloc.dart';
import 'package:split_screen_app/domain/core/api_endPoint.dart';
import 'package:split_screen_app/presentation/widgets/four_screens.dart';
import 'package:split_screen_app/presentation/widgets/one_screen.dart';
import 'package:split_screen_app/presentation/widgets/three_screens.dart';
import 'package:split_screen_app/presentation/widgets/two_screens.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  WebViewController? controller;
  WebViewController? controller2;
  WebViewController? controller3;
  WebViewController? controller4;
  Timer? timer;
  late YoutubePlayerController ytcontroller;
  late YoutubePlayerController ytcontroller2;
  late YoutubePlayerController ytcontroller3;
  late YoutubePlayerController ytcontroller4;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  String? url1;
  String? url2;
  String? url3;
  String? url4;
  final bool _isPlayerReady = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final myBlocState = context.read<SplashBloc>().state;
    if (myBlocState is SplashLoaded) {
      if (myBlocState.deviceDetails?.media?[0].type != "image") {
        url1 = myBlocState.deviceDetails?.media?[0].type == "video"
            ? "$endPoint${myBlocState.deviceDetails?.media?[0].file}"
            : myBlocState.deviceDetails?.media?[0].file;
        if (myBlocState.deviceDetails?.media?[0].type == "video") {
          controller = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(Colors.white)
            ..loadRequest(Uri.parse(url1 ?? ''));
        }
      }
      if (myBlocState.deviceDetails!.deviceDetails!.elements! > 1) {
        if (myBlocState.deviceDetails?.media?[1].type != "image") {
          url2 = myBlocState.deviceDetails?.media?[1].type == "video"
              ? "$endPoint${myBlocState.deviceDetails?.media?[1].file}"
              : myBlocState.deviceDetails?.media?[1].file;
          if (myBlocState.deviceDetails?.media?[1].type == "video") {
            controller2 = WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(Colors.white)
              ..loadRequest(Uri.parse(url2 ?? ''));
          }
        }
      }

      if (myBlocState.deviceDetails!.deviceDetails!.elements! > 2) {
        if (myBlocState.deviceDetails?.media?[2].type != "image") {
          url3 = myBlocState.deviceDetails?.media?[2].type == "video"
              ? "$endPoint${myBlocState.deviceDetails?.media?[2].file}"
              : myBlocState.deviceDetails?.media?[2].file;
          if (myBlocState.deviceDetails?.media?[2].type == "video") {
            controller3 = WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(Colors.white)
              ..loadRequest(Uri.parse(url3 ?? ''));
          }
        }
      }

      if (myBlocState.deviceDetails!.deviceDetails!.elements! > 3) {
        log("message");
        if (myBlocState.deviceDetails?.media?[3].type != "image") {
          url4 = myBlocState.deviceDetails?.media?[3].type == "video"
              ? "$endPoint${myBlocState.deviceDetails?.media?[3].file}"
              : myBlocState.deviceDetails?.media?[3].file;
          if (myBlocState.deviceDetails?.media?[3].type == "video") {
            controller4 = WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(Colors.white)
              ..loadRequest(Uri.parse(url4 ?? ''));
          }
        }
      }

      // Do something with these values

      ytcontroller = YoutubePlayerController(
        initialVideoId: url1 ?? '',
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: true,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(listener);

      _videoMetaData = const YoutubeMetaData();
      _playerState = PlayerState.unknown;

      ytcontroller2 = YoutubePlayerController(
        initialVideoId: url2 ?? '',
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: true,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(listener);

      _videoMetaData = const YoutubeMetaData();
      _playerState = PlayerState.unknown;

      ytcontroller3 = YoutubePlayerController(
        initialVideoId: url3 ?? '',
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: true,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(listener);

      _videoMetaData = const YoutubeMetaData();
      _playerState = PlayerState.unknown;

      ytcontroller4 = YoutubePlayerController(
        initialVideoId: url4 ?? '',
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: true,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(listener);

      _videoMetaData = const YoutubeMetaData();
      _playerState = PlayerState.unknown;
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

  void listener() {
    if (_isPlayerReady && mounted && !ytcontroller.value.isFullScreen) {
      setState(() {
        _playerState = ytcontroller.value.playerState;
        _videoMetaData = ytcontroller.metadata;
      });
    }
  }

  @override
  void dispose() {
    ytcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (context, state) {
        if (state is SplashLoaded) {
          final eleCou = state.deviceDetails?.deviceDetails?.elements;

          if (eleCou == 4) {
            return buildFourScreens(
                context,
                state,
                controller ?? WebViewController(),
                controller2 ?? WebViewController(),
                controller3 ?? WebViewController(),
                controller4 ?? WebViewController(),
                ytcontroller,
                ytcontroller2,
                ytcontroller3,
                ytcontroller4);
          } else if (eleCou == 3) {
            return buildThreeScreens(
              context,
              state,
              controller,
              controller2,
              controller3,
              ytcontroller,
              ytcontroller2,
              ytcontroller3,
            );
          } else if (eleCou == 2) {
            return buildTwoScreens(
              context,
              state,
              controller,
              controller2,
              ytcontroller,
              ytcontroller2,
            );
          } else if (eleCou == 1) {
            return buildOneScreen(
              context,
              state,
              controller,
              ytcontroller,
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
      fit: BoxFit.cover,
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
    BuildContext context, size, WebViewController controller, height) {
  return Expanded(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
          height: height,
          width: size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: WebViewWidget(controller: controller)
          //     YoutubePlayer(
          //   controller: controller,
          //   showVideoProgressIndicator: true,
          //   // videoProgressIndicatorColor: Colors.amber,
          //   progressColors: const ProgressBarColors(
          //     playedColor: Colors.amber,
          //     handleColor: Colors.amberAccent,
          //   ),
          //   // onReady: () {
          //   //   _isPlayerReady = true;
          //   // },
          // ),
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
        fit: BoxFit.fill,
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

Widget buildYtbvideo2(BuildContext context, size, ytcontroller, height) {
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
            playedColor: Color.fromARGB(255, 0, 0, 0),
            handleColor: Color.fromARGB(255, 66, 55, 13),
          ),
          // onReady: () {
          //   _isPlayerReady = true;
          // },
        ),
      ),
    ),
  );
}
