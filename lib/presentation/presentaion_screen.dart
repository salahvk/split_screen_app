import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
}
