import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chatgpt/chat_page/bloc/chat_page_bloc.dart';

class MessageEditor extends StatelessWidget {
  const MessageEditor({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(32.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration.collapsed(
                  hintText: 'Type your message...'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              String question = _textController.text;
              context.read<ChatPageBloc>().add(AddQuestion(question: question));
              _textController.clear();
            },
          ),
        ],
      ),
    );
  }
}
