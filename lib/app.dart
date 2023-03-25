import 'package:flutter/material.dart';
import 'package:simple_chatgpt/chat_page/chat_page.dart';

class ChatGptApp extends StatelessWidget {
  const ChatGptApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT',
      theme: ThemeData(primaryColor: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: ChatPage(),
    );
  }
}
