import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chatgpt/chat_page/bloc/chat_page_bloc.dart';

class CustomPopupMenu extends StatelessWidget {
  const CustomPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        const PopupMenuItem(
          value: "rename",
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Rename'),
          ),
        ),
        const PopupMenuItem(
          value: "refresh",
          child: ListTile(
            leading: Icon(Icons.refresh),
            title: Text('Clear chat'),
          ),
        ),
        const PopupMenuItem(
          value: "delete",
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
          ),
        ),
      ],
      elevation: 2,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onSelected: (value) {
        if (value == "rename") {
          // rename
          showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController controller = TextEditingController();
              ChatPageBloc bloc = context.read<ChatPageBloc>();

              controller.text = bloc
                  .state.conversations[bloc.state.currentConversation].title;
              return AlertDialog(
                title: const Text('Rename Conversation'),
                content: TextField(
                  // display the current name of the conversation
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Conversation name',
                  ),
                  onChanged: (value) {},
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'Rename',
                      style: TextStyle(
                        color: Color(0xff55bb8e),
                      ),
                    ),
                    onPressed: () {
                      // Call renameConversation method here with the new name
                      bloc.add(ChangeName(newName: controller.text));
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        } else if (value == "delete") {
          // delete
          context.read<ChatPageBloc>().add(DeleteConversation());
        } else if (value == "refresh") {
          // refresh
          context.read<ChatPageBloc>().add(ClearChat());
        }
      },
    );
  }
}
