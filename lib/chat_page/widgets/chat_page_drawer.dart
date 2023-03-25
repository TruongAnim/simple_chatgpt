import 'package:flutter/material.dart';

class ChatPageDrawer extends StatelessWidget {
  ChatPageDrawer({super.key});
  List<String> conversations = List.empty();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(color: Color(Colors.grey[300]?.value ?? 0)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    // left align
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.add, color: Colors.grey[800], size: 20.0),
                      const SizedBox(width: 15.0),
                      const Text(
                        'New Chat',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'din-regular',
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              child: ListView.builder(
                itemCount: conversations.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text('hello');
                  // Conversation conversation =
                  //     conversationProvider.conversations[index];
                  // return Dismissible(
                  //   key: UniqueKey(),
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       conversationProvider.currentConversationIndex = index;
                  //       Navigator.pop(context);
                  //     },
                  //     child: Container(
                  //       padding: const EdgeInsets.all(10.0),
                  //       margin: const EdgeInsets.symmetric(
                  //           horizontal: 20.0, vertical: 4.0),
                  //       decoration: BoxDecoration(
                  //         color:
                  //             conversationProvider.currentConversationIndex ==
                  //                     index
                  //                 ? const Color(0xff55bb8e)
                  //                 : Colors.white,
                  //         // border: Border.all(color: Color(Colors.grey[200]?.value ?? 0)),
                  //         borderRadius: BorderRadius.circular(8.0),
                  //       ),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           // coversation icon
                  //           Icon(
                  //             Icons.person,
                  //             color: conversationProvider
                  //                         .currentConversationIndex ==
                  //                     index
                  //                 ? Colors.white
                  //                 : Colors.grey[700],
                  //             size: 20.0,
                  //           ),
                  //           const SizedBox(width: 15.0),
                  //           Text(
                  //             conversation.title,
                  //             style: TextStyle(
                  //               // fontWeight: FontWeight.bold,
                  //               color: conversationProvider
                  //                           .currentConversationIndex ==
                  //                       index
                  //                   ? Colors.white
                  //                   : Colors.grey[700],
                  //               fontFamily: 'din-regular',
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // );
                },
              ),
            )),
            // add a setting button at the end of the drawer
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: GestureDetector(
                onTap: () {
                  showApiSettingDialog(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings, color: Colors.grey[700], size: 20.0),
                    const SizedBox(width: 15.0),
                    Text(
                      'API Setting',
                      style: TextStyle(
                        fontFamily: 'din-regular',
                        color: Colors.grey[700],
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showApiSettingDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String newName = 'YOUR_API_KEY';
      return AlertDialog(
        title: const Text('API Setting'),
        content: TextField(
          // display the current name of the conversation
          decoration: InputDecoration(
            hintText: 'Enter API Key',
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
              'Save',
              style: TextStyle(
                color: Color(0xff55bb8e),
              ),
            ),
            onPressed: () {
              if (newName == '') {
                Navigator.pop(context);
                return;
              }
              // set api
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
