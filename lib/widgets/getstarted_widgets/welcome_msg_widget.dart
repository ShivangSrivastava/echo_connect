import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return [
      "Connect with\nAnyone,\nAnywhere,\nAnytime"
          .text
          .xl3
          .wider
          .semiBold
          .make(),
    ].vStack();
  }
}
