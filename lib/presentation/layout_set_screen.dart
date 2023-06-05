import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:split_screen_app/application/bloc/splash_bloc.dart';
import 'package:split_screen_app/presentation/login_page.dart';
import 'package:split_screen_app/presentation/presentaion_screen.dart';

class LayoutSetScreen extends StatefulWidget {
  const LayoutSetScreen({super.key});

  @override
  State<LayoutSetScreen> createState() => _LayoutSetScreenState();
}

class _LayoutSetScreenState extends State<LayoutSetScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashBloc>(context).add(
      FetchDeviceId(),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      bool isPortraitModeSupported =
          MediaQuery.of(context).orientation == Orientation.portrait;

      Hive.box("device_id")
          .put('isPortraitModeSupported', isPortraitModeSupported.toString());
    });

    return Scaffold(
        body: BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoaded && state.isDeviceReg == false) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
          ]);

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
            return const LoginPage();
          }));
        } else if (state is SplashLoaded && state.isDeviceReg == true) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
            return const PresentationScreen();
          }));
        }
      },
      child: const Center(),
    ));
  }
}
