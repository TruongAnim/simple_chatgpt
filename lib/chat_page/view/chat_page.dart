import 'package:flutter/material.dart';
import 'package:simple_chatgpt/chat_page/chat_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChatView();
  }
}

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ChatPageAppBar(),
    );
  }
}
