// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:echo_connect/pages/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:echo_connect/pages/meeting_page.dart';

import '../widgets/home_widgets/image.dart';
import '../widgets/textfield_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var box;
  String? name;
  String? email;
  String? image;

  @override
  void initState() {
    openBox().then((value) {
      name = box.get("name");
      email = box.get("email");
      image = box.get("image");
    }).then((value) => setState(
          () {},
        ));
    super.initState();
  }

  joinCommand() {
    if (controller.text.isEmptyOrNull) {
      VxToast.show(context,
          msg: "Meeting code can't be empty.", textColor: Vx.red600);
    } else {
      if (name != null) {
        context.nextPage(MeetingPage(
          meetingCode: controller.text,
          name: name.toString(),
          email: email.toString(),
          image: image.toString(),
        ));
      }
    }
  }

  Future<void> openBox() async {
    box = await Hive.openBox("user");
  }

  String getGreeting(String name) {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return "Good morning, $name!";
    } else if (hour >= 12 && hour < 17) {
      return "Good afternoon, $name!";
    } else {
      return "Good evening, $name!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (name != null)
          ? AppBar(
              title: [
              ["EchoConnect".text.xl3.make(), getGreeting(name!).text.make()]
                  .vStack(
                      alignment: MainAxisAlignment.start,
                      crossAlignment: CrossAxisAlignment.start),
              GestureDetector(
                onLongPress: () {
                  box.delete("name");
                  box.delete("email");
                  box.delete("image");
                  context.nextAndRemoveUntilPage(const SplashPage());
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(image ?? ""),
                ),
              )
            ].hStack(alignment: MainAxisAlignment.spaceBetween))
          : null,
      body: (name != null)
          ? VxDevice(
              mobile: [
                const VideoCallImage(),
                50.heightBox,
                MyTextField(
                    formKey: formKey,
                    controller: controller,
                    hintText: "Meeting Code",
                    onPressed: joinCommand,
                    icon: const Icon(CupertinoIcons.add),
                    label: "Join".text.make()),
                TextButton(
                    onPressed: () {},
                    child: "Create an instant Meeting".text.make())
              ].vStack(alignment: MainAxisAlignment.center),
              web: [
                const VideoCallImage(),
                50.heightBox,
                [
                  MyTextField(
                    formKey: formKey,
                    controller: controller,
                    hintText: "Meeting Code",
                    onPressed: joinCommand,
                    icon: const Icon(CupertinoIcons.add),
                    label: "Join".text.make(),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: "Create an instant Meeting".text.make())
                ].vStack(alignment: MainAxisAlignment.center)
              ]
                  .hStack(
                    alignment: MainAxisAlignment.center,
                  )
                  .whFull(context),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
