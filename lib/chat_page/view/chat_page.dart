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
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        appBar: ChatPageAppBar(),
        drawer: ChatPageDrawer(),
        body: Column(children: [
          Expanded(child: ConversationListView()),
          MessageEditor()
        ]),
      ),
    );
  }
}
