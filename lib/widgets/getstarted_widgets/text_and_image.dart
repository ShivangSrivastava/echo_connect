import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

import 'welcome_msg_widget.dart';

class TextAndImage extends StatelessWidget {
  const TextAndImage({super.key});

  @override
  Widget build(BuildContext context) {
    return VxDevice(
      web: [
        const WelcomeMessage(),
        SvgPicture.asset("assets/connect.svg")
            .p32()
            .pOnly(bottom: Vx.dp48)
            .expand(),
      ].hStack(alignment: MainAxisAlignment.spaceBetween).px64(),
      mobile: [
        SvgPicture.asset("assets/connect.svg").hOneThird(context),
        const WelcomeMessage(),
      ].vStack(),
    );
  }
}
