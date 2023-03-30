import 'package:flutter/material.dart';
import 'package:chatgpt_repository/chatgpt_repository.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chatgpt/chat_page/bloc/chat_page_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const userId = 'user';
const senderId = 'system';
const userAvt = 'assets/avatars/user1.png';
const systemAvt = 'assets/avatars/chatbot.png';

class ConversationListView extends StatelessWidget {
  ConversationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatPageBloc, ConversationState>(
      buildWhen: (previous, current) {
        print('build when');
        return true;
      },
      builder: (context, state) {
        Conversation conversation =
            state.conversations[state.currentConversation];
        if (conversation.message.isEmpty) {
          return const Center(
            child: Text('Conversation is empty!'),
          );
        }
        final ScrollController _controller = ScrollController();
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _controller.jumpTo(_controller.position.maxScrollExtent);
        });

        return ListView.builder(
          controller: _controller,
          itemCount: conversation.message.length,
          itemBuilder: (BuildContext context, int index) {
            Message message = conversation.message[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.sender != userId)
                    const CircleAvatar(
                      backgroundImage: AssetImage(systemAvt),
                      radius: 16.0,
                    )
                  else
                    const SizedBox(width: 24.0),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Align(
                      alignment: message.sender == userId
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: message.sender == userId
                              ? Colors.blue
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
                        child: message.content != 'typing'
                            ? Text(
                                message.content,
                                style: TextStyle(
                                  color: message.sender == userId
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              )
                            : const SpinKitThreeBounce(
                                color: Color.fromARGB(255, 107, 221, 172),
                                size: 30.0,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  if (message.sender == userId)
                    Image.asset(
                      userAvt,
                      height: 32,
                    )
                  else
                    const SizedBox(width: 24.0),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
