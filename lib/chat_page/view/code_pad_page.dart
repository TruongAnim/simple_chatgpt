import 'package:flutter/material.dart';
import 'package:simple_chatgpt/chat_page/view/highlight_box.dart';

class CodePadPage extends StatelessWidget {
  const CodePadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: SafeArea(
          child: HighlightBox(
        content: message,
        isExpand: true,
      )),
    );
  }
}
