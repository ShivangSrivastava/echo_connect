import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ParticipantsList extends StatelessWidget {
  const ParticipantsList({super.key});

  @override
  Widget build(BuildContext context) {
    return [
      "Participants".text.make(),
      List.generate(
        30,
        (index) => Card(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: [const Icon(Icons.person), "user $index".text.make()]
              .hStack()
              .p12(),
        ),
      ).vStack().scrollVertical().expand()
    ].vStack();
  }
}