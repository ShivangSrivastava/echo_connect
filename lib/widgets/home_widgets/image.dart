import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

class VideoCallImage extends StatelessWidget {
  const VideoCallImage({super.key});

  @override
  Widget build(BuildContext context) {
    return VxDevice(
      mobile: SvgPicture.asset("assets/video_call.svg").hOneForth(context),
      web: SvgPicture.asset("assets/video_call.svg").whPCT(
        context: context,
        widthPCT: 40,
        heightPCT: 40,
      ),
    );
  }
}
