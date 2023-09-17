import 'package:echo_connect/pages/home_page.dart';
import 'package:echo_connect/services/get_email_avatar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets/appbar_widget.dart';
import '../widgets/getstarted_widgets/button.dart';
import '../widgets/getstarted_widgets/text_and_image.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
 Future<void> addToBox() async {
    var box = await Hive.openBox("user");
    box.put("name", nameController.text);
    box.put("email", emailController);
    box.put("image", getGravatarURL(emailController.text));
    box.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appAppBar(),
      body: [
        const TextAndImage(),
        GetStartedButton(
          onPressed: () => showModalBottomSheet(
            showDragHandle: true,
            context: context,
            builder: (context) => [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Name",
                ),
              ),
              TextFormField(

                controller: emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  if (nameController.text.isEmptyOrNull) {
                    VxToast.show(context,
                        msg: "Name can't be empty.", textColor: Vx.red600);
                  } else if (nameController.text.length < 3) {
                    VxToast.show(context,
                        msg: "Name should be at least 3 characters long.",
                        textColor: Vx.red600);
                  } else if (nameController.text.length > 50) {
                    VxToast.show(context,
                        msg: "Name cannot exceed 50 characters.",
                        textColor: Vx.red600);
                  } else if (!RegExp(r'^[a-zA-Z\s]+$')
                      .hasMatch(nameController.text)) {
                    VxToast.show(context,
                        msg: "Name can only contain letters and spaces.",
                        textColor: Vx.red600);
                  } else if (emailController.text.isEmptyOrNull) {
                    VxToast.show(context,
                        msg: "Email can't be empty.", textColor: Vx.red600);
                  } else if (!RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(emailController.text)) {
                    VxToast.show(context,
                        msg: "Please enter a valid email address.",
                        textColor: Vx.red600);
                  } else {
                    addToBox().then((value) => context.nextAndRemoveUntilPage(const HomePage()))
                    ;
                  }
                },
                icon: const Icon(Icons.forward),
                label: "Proceed".text.make(),
              )
            ].vStack().p32().centered(),
          ),
          text: "Get Started",
        ),
      ].zStack(alignment: Alignment.center),
    );
  }
}
