import 'package:echo_connect/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:velocity_x/velocity_x.dart';

import 'getstarted_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool newUser = false;

  isNewUser() async {
    var box = await Hive.openBox('user');
    if (box.get("name") == null) {
      newUser = true;
    }

    await Hive.close();
  }

  @override
  void initState() {
    super.initState();
    isNewUser();

    Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      context.nextAndRemoveUntilPage(
        (newUser) ? const GetStartedPage() : const HomePage(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        SvgPicture.asset("assets/video_call.svg")
            .wPCT(
              context: context,
              widthPCT: 40,
            )
            .centered(),
        Positioned(
          bottom: Vx.dp20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              "MADE WITH ".text.xl.make(),
              "❤️".text.color(Vx.red500).xl4.make()
            ],
          ).wFull(context),
        )
      ].zStack(),
    );
  }
}
