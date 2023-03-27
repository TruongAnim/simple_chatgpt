import 'package:chatgpt_repository/chatgpt_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chatgpt/chat_page/bloc/chat_page_bloc.dart';

class ChatPageDrawer extends StatelessWidget {
  ChatPageDrawer({super.key});
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
                  context
                      .read<ChatPageBloc>()
                      .add(AddNewConversation(name: 'New Conversation'));
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
            Expanded(child: BlocBuilder<ChatPageBloc, ConversationState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.conversations.length,
                  itemBuilder: (BuildContext context, int index) {
                    Conversation conversation = state.conversations[index];
                    return Dismissible(
                      key: UniqueKey(),
                      child: GestureDetector(
                        onTap: () {
                          context.read<ChatPageBloc>().add(
                              ChangeCurrentConversation(newCurrent: index));
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: state.currentConversation == index
                                ? const Color(0xff55bb8e)
                                : Colors.white,
                            // border: Border.all(color: Color(Colors.grey[200]?.value ?? 0)),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // coversation icon
                              Icon(
                                Icons.person,
                                color: state.currentConversation == index
                                    ? Colors.white
                                    : Colors.grey[700],
                                size: 20.0,
                              ),
                              const SizedBox(width: 15.0),
                              Text(
                                conversation.title,
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  color: state.currentConversation == index
                                      ? Colors.white
                                      : Colors.grey[700],
                                  fontFamily: 'din-regular',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
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
      return const ApiDialog();
    },
  );
}

class ApiDialog extends StatelessWidget {
  const ApiDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatPageBloc, ConversationState>(
      builder: (context, state) {
        print('${state.usingDefaultKey}');

        return ApiDialogView(
          checkedValue: state.usingDefaultKey,
          userKey: state.userKey,
        );
      },
    );
  }
}

class ApiDialogView extends StatefulWidget {
  ApiDialogView({super.key, required this.checkedValue, required this.userKey});
  late String userKey;
  late bool checkedValue;
  @override
  State<ApiDialogView> createState() => _ApiDialogViewState();
}

class _ApiDialogViewState extends State<ApiDialogView> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controller.text = widget.userKey;
    return AlertDialog(
      title: const Text('API Setting'),
      content: SizedBox(
        height: 80,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: widget.checkedValue,
                onChanged: (newValue) {
                  setState(() {
                    widget.checkedValue = !widget.checkedValue;
                  });
                },
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            const Text('Use free default key')
          ]),
          TextField(
            enabled: !widget.checkedValue,
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter your API Key',
            ),
          ),
        ]),
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
            context.read<ChatPageBloc>().add(UpdateApiSetting(
                usingDefault: widget.checkedValue, userKey: controller.text));
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
