import 'package:chatgpt_repository/chatgpt_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chatgpt/chat_page/chat_page.dart';
import 'package:simple_chatgpt/chat_page/view/code_pad_page.dart';

class ChatGptApp extends StatefulWidget {
  const ChatGptApp({super.key});

  @override
  State<ChatGptApp> createState() => _ChatGptAppState();
}

class _ChatGptAppState extends State<ChatGptApp> {
  late ChatGptRepository repository;

  @override
  void initState() {
    repository = ChatGptRepository();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(value: repository, child: AppView());
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatPageBloc>(
      create: (context) {
        return ChatPageBloc(
            repository: RepositoryProvider.of<ChatGptRepository>(context))
          ..add(InitConversations());
      },
      child: MaterialApp(
        title: 'ChatGPT',
        theme: ThemeData(primaryColor: Colors.green),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => ChatPage(),
          '/codePad': (context) => CodePadPage(),
        },
      ),
    );
  }
}
