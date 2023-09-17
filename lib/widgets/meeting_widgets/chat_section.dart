// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:echo_connect/widgets/textfield_widget.dart';

class ChatSection extends StatefulWidget {
  const ChatSection({super.key});

  @override
  State<ChatSection> createState() => _ChatSectionState();
}

class _ChatSectionState extends State<ChatSection> {
  List<ChatBubble> messages = [
    const ChatBubble(
      message: "Hello World",
      sender: "EchoConnect",
    )
  ];
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return [
      "Chat Section".text.xl2.semiBold.makeCentered().py12(),
      messages
          .vStack(crossAlignment: CrossAxisAlignment.start)
          .wFull(context)
          .px16()
          .scrollVertical()
          .expand(),
      [
        IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        MyTextField(
          controller: controller,
          formKey: formKey,
          hintText: "Message",
          icon: const Icon(Icons.send),
          onPressed: () {
            if (controller.text.isEmptyOrNull) return;
            messages.add(ChatBubble(message: controller.text, sender: "user"));
            controller.clear();
            setState(() {});
          },
        ).expand(),
      ].hStack().p12(),
    ]
        .vStack(
            alignment: MainAxisAlignment.spaceBetween,
            crossAlignment: CrossAxisAlignment.start)
        .wFull(context);
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final String sender;
  const ChatBubble({
    Key? key,
    required this.message,
    required this.sender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        margin: const EdgeInsets.symmetric(vertical: 15),
        constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: 270,
          minHeight: 40,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Vx.randomPrimaryColor,
              blurRadius: 10,
            ),
          ],
          color: Vx.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: message.text.xl.center.make(),
      ),
      Positioned(
        top: Vx.dp20,
        child: sender.text.xs.ellipsis.make().px16(),
      )
    ].zStack();
  }
}
