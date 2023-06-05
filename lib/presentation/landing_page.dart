import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_screen_app/application/bloc/splash_bloc.dart';
import 'package:split_screen_app/presentation/layout_set_screen.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
        return const LayoutSetScreen();
      }));
    });
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
    ));
  }
}
