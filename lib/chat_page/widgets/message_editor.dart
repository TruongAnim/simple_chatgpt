import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chatgpt/chat_page/chat_page.dart';
import 'package:simple_chatgpt/constants.dart';

class MessageEditor extends StatelessWidget {
  const MessageEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SendButtonCubit>(
        create: (context) => SendButtonCubit(), child: MessageEditorView());
  }
}

class MessageEditorView extends StatelessWidget {
  const MessageEditorView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();
    _textController.addListener(
      () {
        print('hello');
        context.read<SendButtonCubit>().textChange(_textController.text);
      },
    );
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(32.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              autofocus: false,
              decoration:
                  const InputDecoration.collapsed(hintText: 'Ask anything...'),
            ),
          ),
          BlocBuilder<SendButtonCubit, bool>(
            builder: (context, state) {
              return IconButton(
                disabledColor: kPrimaryColor.withOpacity(0.2),
                color: kPrimaryColor,
                icon: const Icon(
                  Icons.send,
                ),
                onPressed: state
                    ? () {
                        String question = _textController.text;
                        context
                            .read<ChatPageBloc>()
                            .add(AddQuestion(question: question));
                        _textController.clear();
                        final FocusScopeNode currentScope =
                            FocusScope.of(context);
                        if (!currentScope.hasPrimaryFocus &&
                            currentScope.hasFocus) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      }
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
