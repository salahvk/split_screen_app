import 'package:flutter/material.dart';
import 'package:split_screen_app/application/bloc/splash_bloc.dart';
import 'package:split_screen_app/presentation/widgets/build_one_image.dart';
import 'package:split_screen_app/presentation/widgets/build_video.dart';
import 'package:split_screen_app/presentation/widgets/build_youtube.dart';
import 'package:split_screen_app/presentation/widgets/carousel_build.dart';

Widget buildFourScreens(
  BuildContext context,
  SplashLoaded state,
  vlcontroller,
  vlcontroller2,
  vlcontroller3,
  vlcontroller4,
  ytController,
) {
  final size = MediaQuery.of(context).size;
  return Scaffold(
    backgroundColor: Colors.black,
    body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                state.deviceDetails?.media?[0].type == 'image'
                    ? buildOneImage(size, state, 0, size.height)
                    : state.deviceDetails?.media?[0].type == 'youtube'
                        ? buildYtbvideo(
                            context, size, ytController, size.height)
                        : state.deviceDetails?.media?[0].type == 'video'
                            ? buildvideo(
                                context, size, vlcontroller, size.height)
                            : state.deviceDetails?.media?[0].type == 'carousel'
                                ? CarouselSlider1(
                                    size: size.width,
                                    height: size.height,
                                    imageList: state.deviceDetails!.media![0]
                                        .carouselImages!,
                                    dur: state.deviceDetails!.media![0]
                                            .timeInterval ??
                                        500,
                                    ani: state
                                        .deviceDetails!.media![0].animation,
                                  )
                                : Container(),
                const SizedBox(
                  width: 5,
                ),
                state.deviceDetails?.media?[1].type == 'image'
                    ? buildOneImage(size, state, 1, size.height)
                    : state.deviceDetails?.media?[1].type == 'carousel'
                        ? CarouselSlider1(
                            size: size.width,
                            height: size.height,
                            imageList:
                                state.deviceDetails!.media![1].carouselImages!,
                            dur: state.deviceDetails!.media![1].timeInterval ??
                                800,
                            ani: state.deviceDetails!.media![1].animation)
                        : buildvideo(context, size, vlcontroller2, size.height)
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Row(
              children: [
                state.deviceDetails?.media?[2].type == 'image'
                    ? buildOneImage(size, state, 2, size.height)
                    : state.deviceDetails?.media?[2].type == 'carousel'
                        ? CarouselSlider1(
                            size: size.width,
                            height: size.height,
                            imageList:
                                state.deviceDetails!.media![2].carouselImages!,
                            dur: state.deviceDetails!.media![2].timeInterval ??
                                800,
                            ani: state.deviceDetails!.media![2].animation)
                        : buildvideo(context, size, vlcontroller3, size.height),
                const SizedBox(
                  width: 5,
                ),
                state.deviceDetails?.media?[3].type == 'image'
                    ? buildOneImage(size, state, 3, size.height)
                    : state.deviceDetails?.media?[3].type == 'carousel'
                        ? CarouselSlider1(
                            size: size.width,
                            height: size.height,
                            imageList:
                                state.deviceDetails!.media![3].carouselImages!,
                            dur: state.deviceDetails!.media![3].timeInterval ??
                                800,
                            ani: state.deviceDetails!.media![3].animation)
                        : buildvideo(context, size, vlcontroller4, size.height)
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
