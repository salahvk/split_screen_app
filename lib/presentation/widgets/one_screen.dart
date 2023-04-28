import 'package:flutter/material.dart';
import 'package:split_screen_app/application/bloc/splash_bloc.dart';
import 'package:split_screen_app/domain/core/api_endPoint.dart';
import 'package:split_screen_app/presentation/presentaion_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget buildOneScreen(
    BuildContext context, SplashLoaded state, controller, ytController) {
  final size = MediaQuery.of(context).size;
  return Scaffold(
    backgroundColor: Colors.black,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: state.deviceDetails?.media?[0].type == 'image'
            ? buildOneImage(size, state, 0, size.height * .9)
            : state.deviceDetails?.media?[0].type == 'youtube'
                ? buildYtbvideo(context, size, ytController, size.height * .9)
                : state.deviceDetails?.media?[0].type == 'video'
                    ? buildvid(context, size, controller, size.height * .9)
                    : Container(),

        //  state.deviceDetails?.media?[0].type != 'image'
        //     ? buildvid(context, size, controller, size.height * .9)
        //     : state.deviceDetails?.media?[0].type == 'image'
        //         ? buildImage(size, state, 0, size.height * .9)
        //         : Container(),
      ),
    ),
  );
}

Widget buildImage(size, state, index, height) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(14),
    child: Image.network(
      "$endPoint${state.deviceDetails?.media?[index].file}",
      fit: BoxFit.cover,
      width: size.width,
      height: height,
    ),
  );
}

Widget buildvid(
    BuildContext context, size, WebViewController controller, height) {
  return ClipRRect(
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
  );
}
