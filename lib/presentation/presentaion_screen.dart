import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_screen_app/application/bloc/splash_bloc.dart';
import 'package:split_screen_app/core/controllers/controllers.dart';
import 'package:split_screen_app/domain/core/api_endPoint.dart';
import 'package:split_screen_app/presentation/widgets/screens/four_screens.dart';
import 'package:split_screen_app/presentation/widgets/screens/one_screen.dart';
import 'package:split_screen_app/presentation/widgets/screens/three_screens.dart';
import 'package:split_screen_app/presentation/widgets/screens/two_screens.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  Timer? timer;
  bool? isLaunched;
  double width = 0;
  double height = 0;
  dynamic isportraitSupport = "false";
  WebViewController webController = WebViewController();

  @override
  void initState() {
    super.initState();
    isLaunched = false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        BlocProvider.of<SplashBloc>(context).add(
          FetchLayoutModify(),
        );
      });
    });
  }

  Future laun() async {
    final url = '$endPoint/show-layout/$deviceId?width=$height&height=$width';
    log(url);
    try {
      if (isLaunched == false) {
        isLaunched = true;
        webController = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..loadRequest(Uri.parse(url));
      }
    } catch (_) {}
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
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
            return const PresentationScreen();
          }));
        }
      },
      builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
        if (state is SplashLoaded) {
          final eleCou = state.deviceDetails?.deviceDetails?.elements;

          if (eleCou == 4 &&
              state.deviceDetails?.deviceDetails?.orientation == 'portrait') {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
            ]);
            laun();
            return WebViewWidget(controller: webController);
          } else if (eleCou == 4 &&
              state.deviceDetails?.deviceDetails?.orientation == 'landscape') {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
            ]);
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
              DeviceOrientation.landscapeLeft,
            ]);
            laun();
            return WebViewWidget(controller: webController);
          } else if (eleCou == 3 &&
              state.deviceDetails?.deviceDetails?.orientation == 'landscape') {
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
              DeviceOrientation.landscapeLeft,
            ]);
            laun();
            return WebViewWidget(controller: webController);
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
              DeviceOrientation.landscapeLeft,
            ]);
            laun();
            return WebViewWidget(controller: webController);
            // return buildImage(context, state);
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
          return buildImage(context, state);
          // return const Center(
          //   child: CircularProgressIndicator(),
          // );
        }
        return Container();
      },
    );
  }
}

Widget buildImage(BuildContext context, SplashLoaded state) {
  print("$endPoint${state.deviceDetails?.deviceDetails?.defaultImage}");
  final size = MediaQuery.of(context).size;
  return Scaffold(
    body: Image.network(
      "$endPoint${state.deviceDetails?.deviceDetails?.defaultImage}",
      fit: BoxFit.cover,
      width: size.width,
      height: size.height,
    ),
  );
}
