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

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _fadeInAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
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
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
            return const LoginPage();
          }));
        } else if (state is SplashLoaded && state.isDeviceReg == true) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
            return const PresentationScreen();
          }));
        }
        //  else if (state is SplashLoading) {
        //   print(state.error);
        //   if (state.error == const MainFailure.clientFailure()) {
        //     showAnimatedSnackBar(context, "No Network");
        //   } else if (state.error == const MainFailure.serverFailure()) {
        //     showAnimatedSnackBar(context, "Server Error");
        //   }
        // }
        // else if (state is SplashLoading) {}
      },
      child: Stack(
        children: [
          FadeTransition(
            opacity: _animationController,
            child: Image.asset(
              'assets/Alpha.jpg',
              fit: BoxFit.fitHeight,
              width: size.width,
              height: size.height,
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: [
          //         const Color(0xff000A47).withOpacity(.3),
          //         const Color(0xff039CA6).withOpacity(.3),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    ));
  }
}
