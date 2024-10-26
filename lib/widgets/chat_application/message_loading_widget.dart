import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';

class MessageLoadingWidget extends StatelessWidget {
  const MessageLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const BubbleSpecialThree(
      text: 'Message Loading',
      tail: true,
    );
  }
}
