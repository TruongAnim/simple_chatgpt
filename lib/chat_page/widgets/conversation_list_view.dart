import 'package:flutter/material.dart';
import 'package:chatgpt_repository/chatgpt_repository.dart';

const userId = 'user';
const senderId = 'system';
const userAvt = 'assets/avatars/person.png';
const systemAvt = 'assets/avatars/ChatGPT_logo.png';

class ConversationListView extends StatelessWidget {
  const ConversationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // controller: _scrollController,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        Message message = Message(content: 'hello', senderId: 'system');
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message.senderId != userId)
                CircleAvatar(
                  backgroundImage: AssetImage(systemAvt),
                  radius: 16.0,
                )
              else
                const SizedBox(width: 24.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Align(
                  alignment: message.senderId == userId
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: message.senderId == userId
                          ? Color(0xff55bb8e)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      message.content,
                      style: TextStyle(
                        color: message.senderId == userAvt
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              if (message.senderId == userId)
                CircleAvatar(
                  backgroundImage: AssetImage(userAvt),
                  radius: 16.0,
                )
              else
                const SizedBox(width: 24.0),
            ],
          ),
        );
      },
    );
  }
}
