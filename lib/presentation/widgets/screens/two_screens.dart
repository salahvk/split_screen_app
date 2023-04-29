import 'package:flutter/material.dart';
import 'package:split_screen_app/application/bloc/splash_bloc.dart';
import 'package:split_screen_app/presentation/presentaion_screen.dart';

Widget buildTwoScreens(
  BuildContext context,
  SplashLoaded state,
  controller,
  controller2,
  ytController1,
  ytController2,
) {
  final size = MediaQuery.of(context).size;
  return Scaffold(
    backgroundColor: Colors.black,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            state.deviceDetails?.media?[0].type == 'image'
                ? buildOneImage(size, state, 0, size.height * .9)
                : state.deviceDetails?.media?[0].type == 'youtube'
                    ? buildYtbvideo(
                        context, size, ytController1, size.height * .9)
                    : state.deviceDetails?.media?[0].type == 'video'
                        ? buildvideo(
                            context, size, controller, size.height * .9)
                        : Container(),
            const SizedBox(
              width: 5,
            ),
            state.deviceDetails?.media?[1].type == 'image'
                ? buildOneImage(size, state, 1, size.height * .9)
                : state.deviceDetails?.media?[1].type == 'youtube'
                    ? buildYtbvideo(
                        context, size, controller2, size.height * .9)
                    : state.deviceDetails?.media?[1].type == 'video'
                        ? buildvideo(
                            context, size, controller2, size.height * .9)
                        : Container(),
          ],
        ),
      ),
    ),
  );
}
