// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileCard extends StatelessWidget {
  final Widget child;
  final bool fullscreen;
  const ProfileCard({
    Key? key,
    required this.child,
    required this.fullscreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child.box.rounded.make().wPCT(
          context: context,
          widthPCT: fullscreen ? 100 : 90,
        );
  }
}
