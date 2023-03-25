import 'package:flutter/material.dart';

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
            title: Text('Refresh'),
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
              String newName = '';
              return AlertDialog(
                title: const Text('Rename Conversation'),
                content: TextField(
                  // display the current name of the conversation
                  decoration: InputDecoration(
                    hintText: 'hello',
                  ),
                  onChanged: (value) {
                    newName = value;
                  },
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

                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );

          // Provider.of<ConversationProvider>(context, listen: false)
          //     .renameCurrentConversation();
        } else if (value == "delete") {
          // delete
        } else if (value == "refresh") {
          // refresh
        }
      },
    );
  }
}
