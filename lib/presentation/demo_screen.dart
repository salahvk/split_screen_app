import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Transform.rotate(
        angle: 270 * 3.1415927 / 180,
        alignment: Alignment.lerp(Alignment.bottomCenter, Alignment.center, 5),
        child: Container(
          // width: size.width * .7,
          // height: size.height * .7,
          color: Colors.amber,
          child: Image.asset(
            'assets/aiony-haust-3TLl_97HNJo-unsplash.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
