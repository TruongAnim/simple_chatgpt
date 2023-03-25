import 'package:flutter/material.dart';

class MessageEditor extends StatelessWidget {
  const MessageEditor({super.key});

  @override
  Widget build(BuildContext context) {
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
              // controller: _textController,
              decoration: const InputDecoration.collapsed(
                  hintText: 'Type your message...'),
            ),
          ),
          IconButton(icon: const Icon(Icons.send), onPressed: () {}
              // listen to apikey to see if changed
              ),
        ],
      ),
    );
  }
}
