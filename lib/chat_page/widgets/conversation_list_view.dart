import 'package:flutter/material.dart';
import 'package:chatgpt_repository/chatgpt_repository.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chatgpt/chat_page/bloc/chat_page_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_chatgpt/constants.dart';

const userId = 'user';
const senderId = 'system';
const userAvt = 'assets/avatars/user.png';
const systemAvt = 'assets/avatars/chatgpt.png';

class ConversationListView extends StatelessWidget {
  const ConversationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatPageBloc, ConversationState>(
      buildWhen: (previous, current) {
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
                crossAxisAlignment: message.sender != userId
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  if (message.sender != userId)
                    const CircleAvatar(
                      backgroundImage: AssetImage(systemAvt),
                      radius: 14.0,
                    )
                  else
                    const SizedBox(width: 30.0),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Align(
                      alignment: message.sender == userId
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 0.75,
                            vertical: kDefaultPadding / 2),
                        decoration: BoxDecoration(
                          color: message.sender == userId
                              ? kPrimaryColor
                              : kPrimaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: message.content != 'typing'
                            ? InkWell(
                                onTap: () {
                                  // Clipboard.setData(
                                  //     ClipboardData(text: message.content));
                                  // ScaffoldMessenger.of(context)
                                  //     .showSnackBar(const SnackBar(
                                  //   content: Text('Copied to clipboard'),
                                  //   duration: Duration(seconds: 1),
                                  // ));
                                  context.read<ChatPageBloc>().add(
                                      MessageClicked(message: message.content));
                                },
                                child: Text(
                                  message.content,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: message.sender == userId
                                          ? Colors.white
                                          : Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.color),
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
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: kPrimaryColor),
                      child: Icon(
                        Icons.done,
                        size: 8,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    )
                  else
                    const SizedBox(width: 30.0),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
