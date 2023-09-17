// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTextField extends StatelessWidget {
  final Key formKey;
  final TextEditingController controller;
  final String hintText;
  final void Function() onPressed;
  final Widget icon;
  final Widget? label;
  const MyTextField({
    Key? key,
    required this.formKey,
    required this.controller,
    required this.hintText,
    required this.onPressed,
    required this.icon,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxDevice(
      mobile: Form(
        key: formKey,
        child: [
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: Vx.mH8,
              hintText: hintText,
              border: InputBorder.none,
            ),
          ).expand(),
          IconButton(onPressed: onPressed, icon: icon)
        ]
            .hStack()
            .px12()
            .box
            .roundedLg
            .border(width: 0.5)
            .make()
            .wThreeForth(context),
      ),
      web: Form(
        key: formKey,
        child: [
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              errorStyle: const TextStyle(color: Vx.red400),
              contentPadding: Vx.mH8,
              hintText: hintText,
              border: InputBorder.none,
            ),
          ).expand(),
          (label == null)
              ? IconButton(onPressed: onPressed, icon: icon)
              : TextButton.icon(
                  onPressed: onPressed,
                  icon: icon,
                  label: label ?? Container(),
                )
        ]
            .hStack()
            .px12()
            .box
            .roundedLg
            .border(width: 0.5)
            .make()
            .wHalf(context),
      ),
    );
  }
}
