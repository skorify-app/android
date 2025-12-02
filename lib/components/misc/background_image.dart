import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext ctx) {
    return Image.asset(
      'assets/images/home-background.png',
      fit: BoxFit.cover,
      alignment: Alignment.center,
    );
  }
}
