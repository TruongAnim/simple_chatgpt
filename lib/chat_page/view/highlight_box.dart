import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:simple_chatgpt/chat_page/bloc/chat_page_bloc.dart';

class HighlightBox extends StatelessWidget {
  HighlightBox({super.key, required this.content, required this.isExpand});
  String content;
  bool isExpand;

  @override
  Widget build(BuildContext context) {
    String message = content.replaceAll('```', '');
    List<String> lines = message.split('\n');
    String language = lines[0];
    message = message.replaceAll(language, '');
    return InkWell(
      onTap: isExpand
          ? null
          : () {
              context
                  .read<ChatPageBloc>()
                  .add(OpenCodePad(context: context, message: content));
            },
      child: Container(
        margin: isExpand ? null : const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xff282c34),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: InkWell(
              onTap: () {
                context
                    .read<ChatPageBloc>()
                    .add(MessageCopied(message: content));
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(language.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    const Text(
                      'Copy',
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ]),
            ),
          ),
          HighlightView(
            message.trim(), language: 'dart',
            theme: atomOneDarkTheme,
            padding: const EdgeInsets.all(8),

            // Specify text style
            textStyle: isExpand
                ? TextStyle(
                    fontFamily: 'FiraCode',
                    fontSize: 18,
                  )
                : TextStyle(
                    fontFamily: 'FiraCode',
                    fontSize: 15,
                  ),
          ),
        ]),
      ),
    );
  }
}
