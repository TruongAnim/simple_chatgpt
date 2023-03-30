import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chatgpt/chat_page/bloc/chat_page_bloc.dart';
import 'package:simple_chatgpt/constants.dart';

import 'widgets.dart';

class ChatPageAppBar extends StatelessWidget with PreferredSizeWidget {
  const ChatPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatPageBloc, ConversationState>(
      builder: (context, state) {
        return AppBar(
          title: Text(state.conversations[state.currentConversation].title),
          flexibleSpace: Container(
            decoration: BoxDecoration(color: kPrimaryColor),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu)),
          actions: [CustomPopupMenu()],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
