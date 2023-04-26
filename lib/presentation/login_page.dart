import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_screen_app/application/bloc/splash_bloc.dart';
import 'package:split_screen_app/core/styles_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? deviceId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/tech1.png',
            fit: BoxFit.cover,
            width: size.width,
            height: size.height,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xff000A47).withOpacity(.7),
                  const Color(0xff039CA6).withOpacity(.7),
                ],
              ),
            ),
          ),
          Center(
              child: SizedBox(
            width: size.width * .5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ready to Watch ?",
                  style: getMediumtStyle(color: Colors.white, fontSize: 25),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet",
                  textAlign: TextAlign.center,
                  style: getLightStyle(color: Colors.white, fontSize: 10)
                      .copyWith(height: 2, wordSpacing: 1),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<SplashBloc, SplashState>(
                  builder: (context, state) {
                    if (state is SplashLoaded) {
                      return Container(
                        // width: size.width * .17,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Device Id : ${state.deviceId}",
                            style: getSemiBoldStyle(
                                color: Colors.white, fontSize: 13),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
