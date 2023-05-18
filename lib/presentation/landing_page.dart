import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_screen_app/application/bloc/splash_bloc.dart';
import 'package:split_screen_app/presentation/login_page.dart';
import 'package:split_screen_app/presentation/presentaion_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashBloc>(context).add(
      FetchDeviceId(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded && state.isDeviceReg == false) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (ctx) {
              return const LoginPage();
            }));
          } else if (state is SplashLoaded && state.isDeviceReg == true) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (ctx) {
              return const PresentationScreen();
            }));
          }
        },
        child: Stack(
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/rectangle.png'),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/LO.png'),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Image.asset('assets/GO.png'),
                      ),
                    ],
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
