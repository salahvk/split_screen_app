import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:split_screen_app/application/bloc/splash_bloc.dart';
import 'package:split_screen_app/core/controllers/controllers.dart';
import 'package:split_screen_app/domain/core/api_endPoint.dart';
import 'package:split_screen_app/presentation/widgets/screens/four_screens.dart';
import 'package:split_screen_app/presentation/widgets/screens/one_screen.dart';
import 'package:split_screen_app/presentation/widgets/screens/three_screens.dart';
import 'package:split_screen_app/presentation/widgets/screens/two_screens.dart';
import 'package:split_screen_app/presentation/widgets/screens/two_screens_port.dart';
import 'package:url_launcher/url_launcher.dart';

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  Timer? timer;
  bool isLaunched = false;
  double width = 0;
  double height = 0;
  dynamic isportraitSupport;
  // bool isPortraitModeSupported = true;
  @override
  void initState() {
    super.initState();
    isportraitSupport = Hive.box("device_id").get('isPortraitModeSupported');
    print(isportraitSupport);
    print("_____________________");
    // return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        try {
          BlocProvider.of<SplashBloc>(context).add(
            FetchLayoutModify(),
          );
        } catch (_) {}
      });
    });

    // motionSensors.isOrientationAvailable().then((available) {
    //   if (available) {
    //     motionSensors.orientation.listen((OrientationEvent event) {
    //       print(degrees(_orientation.x).toInt());
    //       if (degrees(_orientation.x).toInt() < 50 &&
    //           degrees(_orientation.x).toInt() > -50) {
    //         SystemChrome.setPreferredOrientations([
    //           DeviceOrientation.portraitUp,
    //         ]);
    //       } else {
    //         SystemChrome.setPreferredOrientations([
    //           DeviceOrientation.landscapeLeft,
    //         ]);
    //       }
    //       setState(() {
    //         _orientation.setValues(event.yaw, event.pitch, event.roll);
    //       });
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) async {
        if (state is SplashLoaded && state.isScreenRef == true) {
          closeInAppWebView();
          // String isportraitSupport =
          //     Hive.box("device_id").get('isPortraitModeSupported');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
            return const PresentationScreen();
          }));
          final eleCou = state.deviceDetails?.deviceDetails?.elements;
          if (isportraitSupport != 'true') {
            // print("is portrait mode supported 5");
            if ((eleCou == 1 || eleCou == 2 || eleCou == 3 || eleCou == 4) &&
                state.deviceDetails?.deviceDetails?.orientation == 'portrait') {
              laun();
              // print("is portrait mode supported 6");
            }
          } else {
            closeInAppWebView();
          }
        } else if (state is SplashLoaded && state.isScreenRef == null) {
          // String isportraitSupport =
          //     Hive.box("device_id").get('isPortraitModeSupported');

          final eleCou = state.deviceDetails?.deviceDetails?.elements;

          if (isportraitSupport != 'true') {
            if ((eleCou == 1 || eleCou == 2 || eleCou == 3 || eleCou == 4) &&
                state.deviceDetails?.deviceDetails?.orientation == 'portrait') {
              laun();
            }
          }
        }
      },
      builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
        if (state is SplashLoaded) {
          final eleCou = state.deviceDetails?.deviceDetails?.elements;

          if (eleCou == 4 &&
              state.deviceDetails?.deviceDetails?.orientation == 'portrait') {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
            // isPortraitModeSupported =
            //     MediaQuery.of(context).orientation == Orientation.portrait;

            if (isportraitSupport == 'true') {
              // Hive.box("device_id").put('isPortraitModeSupported',
              //     isPortraitModeSupported.toString());

              closeInAppWebView();
              return buildFourScreens(
                context,
                state,
                controller,
                controller2,
                controller3,
                controller4,
                ytController,
              );
            } else {
              if (state.isScreenRef == null) {
                laun();
              }
            }
          } else if (eleCou == 4 &&
              state.deviceDetails?.deviceDetails?.orientation == 'landscape') {
            // final isportraitSupport =
            //     Hive.box("device_id").get('isPortraitModeSupported');

            // if (isportraitSupport == null) {
            //   print("checking portrait support");
            //   SystemChrome.setPreferredOrientations([
            //     DeviceOrientation.portraitUp,
            //   ]);
            //   isPortraitModeSupported =
            //       MediaQuery.of(context).orientation == Orientation.portrait;
            //   Hive.box("device_id").put('isPortraitModeSupported',
            //       isPortraitModeSupported.toString());
            // }

            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
            ]);

            print(isportraitSupport);
            return buildFourScreens(
              context,
              state,
              controller,
              controller2,
              controller3,
              controller4,
              ytController,
            );
          } else if (eleCou == 3 &&
              state.deviceDetails?.deviceDetails?.orientation == 'portrait') {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
            // isPortraitModeSupported =
            //     MediaQuery.of(context).orientation == Orientation.portrait;
            if (isportraitSupport == 'true') {
              // Hive.box("device_id").put('isPortraitModeSupported',
              //     isPortraitModeSupported.toString());
              closeInAppWebView();
              return buildThreeScreens(
                context,
                state,
                controller,
                controller2,
                controller3,
                ytController,
              );
            } else {
              if (state.isScreenRef == null) {
                laun();
              }
            }
          } else if (eleCou == 3 &&
              state.deviceDetails?.deviceDetails?.orientation == 'landscape') {
            // final isportraitSupport =
            //     Hive.box("device_id").get('isPortraitModeSupported');
            // print(isportraitSupport);
            // if (isportraitSupport == null) {
            //   print("checking portrait support");
            //   SystemChrome.setPreferredOrientations([
            //     DeviceOrientation.portraitUp,
            //   ]);
            //   isPortraitModeSupported =
            //       MediaQuery.of(context).orientation == Orientation.portrait;
            //   Hive.box("device_id").put('isPortraitModeSupported',
            //       isPortraitModeSupported.toString());
            // }
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
            ]);

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
            // isPortraitModeSupported =
            //     MediaQuery.of(context).orientation == Orientation.portrait;
            if (isportraitSupport == 'true') {
              // Hive.box("device_id").put('isPortraitModeSupported',
              //     isPortraitModeSupported.toString());
              closeInAppWebView();
              return buildTwoScreensPor(
                context,
                state,
                controller,
                controller2,
                ytController,
              );
            } else {
              if (state.isScreenRef == null) {
                laun();
              }
            }
          } else if (eleCou == 2 &&
              state.deviceDetails?.deviceDetails?.orientation == 'landscape') {
            // final isportraitSupport =
            //     Hive.box("device_id").get('isPortraitModeSupported');
            // print(isportraitSupport);
            // if (isportraitSupport == null) {
            //   print("checking portrait support");
            //   SystemChrome.setPreferredOrientations([
            //     DeviceOrientation.portraitUp,
            //   ]);
            //   isPortraitModeSupported =
            //       MediaQuery.of(context).orientation == Orientation.portrait;
            //   Hive.box("device_id").put('isPortraitModeSupported',
            //       isPortraitModeSupported.toString());
            // }
            // Navigator.pop(context);

            // print(isLaunched);
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
            // isPortraitModeSupported =
            //     MediaQuery.of(context).orientation == Orientation.portrait;
            if (isportraitSupport == 'true') {
              // Hive.box("device_id").put('isPortraitModeSupported',
              //     isPortraitModeSupported.toString());
              closeInAppWebView();
              return buildOneScreen(
                context,
                state,
                controller,
                ytController,
              );
            } else {
              if (state.isScreenRef == null) {
                laun();
              }
            }
          } else if (eleCou == 1 &&
              state.deviceDetails?.deviceDetails?.orientation == 'landscape') {
            // final isportraitSupport =
            //     Hive.box("device_id").get('isPortraitModeSupported');
            // print(isportraitSupport);
            // if (isportraitSupport == null) {
            //   print("checking portrait support");
            //   SystemChrome.setPreferredOrientations([
            //     DeviceOrientation.portraitUp,
            //   ]);
            //   isPortraitModeSupported =
            //       MediaQuery.of(context).orientation == Orientation.portrait;
            //   Hive.box("device_id").put('isPortraitModeSupported',
            //       isPortraitModeSupported.toString());
            // }
            // Navigator.pop(context);
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
          // return Container(
          //   child: const Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // );
        }
        return Container();
      },
    );
  }

  void laun() async {
    if (!isLaunched) {
      isLaunched = true;
      print("calling");

      final url = '$endPoint/show-layout/$deviceId?width=$height&height=$width';
      print(url);
      await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView);
    }
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
