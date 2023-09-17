// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class GetStartedButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const GetStartedButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxDevice(
      web: Positioned(
        bottom: Vx.dp24,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: Vx.m16,
            backgroundColor: Vx.purple500,
            foregroundColor: Vx.white,
          ),
          child: text.text.xl2.make(),
        ).wOneThird(context),
      ),
      mobile: Positioned(
        bottom: Vx.dp24,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: Vx.m16,
            backgroundColor: Vx.purple500,
            foregroundColor: Vx.white,
          ),
          child: text.text.xl.make(),
        ).wHalf(context),
      ),
    );
  }
}
