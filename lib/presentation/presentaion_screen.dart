import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_screen_app/application/bloc/splash_bloc.dart';
import 'package:split_screen_app/core/controllers/controllers.dart';
import 'package:split_screen_app/presentation/widgets/screens/four_screens.dart';
import 'package:split_screen_app/presentation/widgets/screens/one_screen.dart';
import 'package:split_screen_app/presentation/widgets/screens/three_screens.dart';
import 'package:split_screen_app/presentation/widgets/screens/two_screens.dart';
import 'package:split_screen_app/presentation/widgets/screens/two_screens_port.dart';

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        BlocProvider.of<SplashBloc>(context).add(
          FetchLayoutModify(),
        );
      });
    });
  }

  @override
  void dispose() {
    ytController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoaded && state.isScreenRef == true) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
            return const PresentationScreen();
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
