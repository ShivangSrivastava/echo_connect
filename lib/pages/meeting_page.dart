// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:echo_connect/widgets/meeting_widgets/chat_section.dart';
import 'package:echo_connect/widgets/meeting_widgets/profile_cards.dart';

import '../widgets/meeting_widgets/participants_list.dart';

class MeetingPage extends StatefulWidget {
  final String meetingCode;
  final String name;
  final String email;
  final String image;

  const MeetingPage({
    Key? key,
    required this.meetingCode,
    required this.name,
    required this.email,
    required this.image,
  }) : super(key: key);

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  bool fullscreen = false;
  bool micState = false;
  bool cameraState = true;
  bool isFrontCamera = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  toogleFullScreen() {
    setState(() {
      fullscreen = !fullscreen;
    });
  }

  toggleCamera() {
    setState(() {
      cameraState = !cameraState;
      _getUserMedia();
    });
  }

  toggleMic() {
    setState(() {
      micState = !micState;
    });
  }

  final _localVideoRenderer = RTCVideoRenderer();

  void initRenderers() async {
    await _localVideoRenderer.initialize();
  }

  _getUserMedia() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': micState,
      'video': cameraState
          ? {
              'facingMode': 'user',
            }
          : false
    };

    MediaStream stream =
        await navigator.mediaDevices.getUserMedia(mediaConstraints);
    _localVideoRenderer.srcObject = stream;
  }

  @override
  void initState() {
    initRenderers();
    _getUserMedia();
    super.initState();
  }

  @override
  void dispose() async {
    await _localVideoRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        endDrawer: const Drawer(
          child: ChatSection(),
        ),
        appBar: fullscreen
            ? null
            : AppBar(
                automaticallyImplyLeading: false,
                actions: [Container()],
                title: widget.meetingCode.text.make(),
              ),
        body: VxDevice(
            mobile: [
              GestureDetector(
                onTap: toogleFullScreen,
                child: ProfileCard(
                  fullscreen: fullscreen,
                  child: RTCVideoView(
                    _localVideoRenderer,
                    mirror: true,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  ),
                ),
              ).expand(),
              fullscreen
                  ? Container()
                  : ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton.filled(
                          style: IconButton.styleFrom(
                            backgroundColor: Vx.red500,
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.call_end),
                        ),
                        IconButton.filled(
                          isSelected: cameraState,
                          onPressed: toggleCamera,
                          selectedIcon: const Icon(Icons.videocam),
                          icon: const Icon(Icons.videocam_off),
                        ),
                        IconButton.filled(
                          isSelected: micState,
                          onPressed: toggleMic,
                          selectedIcon: const Icon(Icons.mic),
                          icon: const Icon(Icons.mic_off),
                        ),
                        IconButton.filled(
                          isSelected: false,
                          onPressed: () {
                            showModalBottomSheet(
                              showDragHandle: true,
                              context: context,
                              builder: (context) {
                                return const ParticipantsList();
                              },
                            );
                          },
                          icon: const Icon(Icons.people),
                        ),
                        IconButton.filled(
                          isSelected: false,
                          onPressed: () {
                            scaffoldKey.currentState!.openEndDrawer();
                          },
                          icon: const Icon(Icons.message),
                        ),
                      ],
                    )
            ].vStack(),
            web: [
              [
                GestureDetector(
                  onTap: toogleFullScreen,
                  child: ProfileCard(
                    fullscreen: fullscreen,
                    child: const Icon(Icons.person),
                  ),
                ).hFull(context).expand(flex: 2),
                fullscreen ? Container() : const ParticipantsList().expand(),
                fullscreen ? Container() : const ChatSection().expand(),
              ].hStack().expand(),
              fullscreen
                  ? Container()
                  : ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton.filled(
                          style: IconButton.styleFrom(
                            backgroundColor: Vx.red500,
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.call_end),
                        ),
                        IconButton.filled(
                          isSelected: cameraState,
                          onPressed: toggleCamera,
                          selectedIcon: const Icon(Icons.videocam),
                          icon: const Icon(Icons.videocam_off),
                        ),
                        IconButton.filled(
                          isSelected: micState,
                          onPressed: toggleMic,
                          selectedIcon: const Icon(Icons.mic),
                          icon: const Icon(Icons.mic_off),
                        ),
                      ],
                    )
            ].vStack().whFull(context)));
  }
}
