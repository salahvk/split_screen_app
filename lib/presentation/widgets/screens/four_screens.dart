import 'package:flutter/material.dart';
import 'package:split_screen_app/application/bloc/splash_bloc.dart';
import 'package:split_screen_app/presentation/presentaion_screen.dart';

Widget buildFourScreens(
  BuildContext context,
  SplashLoaded state,
  vlcontroller,
  vlcontroller2,
  vlcontroller3,
  vlcontroller4,
  ytController,
  ytController2,
  ytController3,
  ytController4,
) {
  final size = MediaQuery.of(context).size;
  return Scaffold(
    backgroundColor: Colors.black,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                state.deviceDetails?.media?[0].type == 'image'
                    ? buildOneImage(size, state, 0, size.height * .42)
                    : state.deviceDetails?.media?[0].type == 'youtube'
                        ? buildYtbvideo(
                            context, size, ytController, size.height * .42)
                        : state.deviceDetails?.media?[0].type == 'video'
                            ? buildvideo(
                                context, size, vlcontroller, size.height * .42)
                            : Container(),

                // state.deviceDetails?.media?[0].type != 'image'
                //     ? buildvideo(context, size, controller, size.height * .42)
                //     : state.deviceDetails?.media?[0].type == 'image'
                //         ? buildOneImage(size, state, 0, size.height * .42)
                //         : Container(),
                const SizedBox(
                  width: 5,
                ),
                state.deviceDetails?.media?[1].type == 'image'
                    ? buildOneImage(size, state, 1, size.height * .42)
                    : state.deviceDetails?.media?[1].type == 'youtube'
                        ? buildYtbvideo(
                            context, size, ytController2, size.height * .42)
                        : state.deviceDetails?.media?[1].type == 'video'
                            ? buildvideo(
                                context, size, vlcontroller2, size.height * .42)
                            : Container(),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                state.deviceDetails?.media?[2].type == 'image'
                    ? buildOneImage(size, state, 2, size.height * .42)
                    : state.deviceDetails?.media?[2].type == 'youtube'
                        ? buildYtbvideo(
                            context, size, ytController3, size.height * .42)
                        : state.deviceDetails?.media?[2].type == 'video'
                            ? buildvideo(
                                context, size, vlcontroller3, size.height * .42)
                            : Container(),
                const SizedBox(
                  width: 5,
                ),
                state.deviceDetails?.media?[3].type == 'image'
                    ? buildOneImage(size, state, 3, size.height * .42)
                    : state.deviceDetails?.media?[3].type == 'youtube'
                        ? buildYtbvideo(
                            context, size, ytController4, size.height * .42)
                        : state.deviceDetails?.media?[3].type == 'video'
                            ? buildvideo(
                                context, size, vlcontroller4, size.height * .42)
                            : Container(),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
