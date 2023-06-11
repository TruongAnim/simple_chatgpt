import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:simple_chatgpt/chat_page/bloc/chat_page_bloc.dart';

class HighlightBox extends StatelessWidget {
  HighlightBox({super.key, required this.content});
  String content;

  @override
  Widget build(BuildContext context) {
    content = content.replaceAll('```', '');
    List<String> lines = content.split('\n');
    String language = lines[0];
    content = content.replaceAll(language, '');
    return InkWell(
      onTap: () {
        context.read<ChatPageBloc>().add(MessageClicked(message: content));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
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
          HighlightView(
            content.trim(), language: 'dart',
            theme: atomOneDarkTheme,
            padding: const EdgeInsets.all(12),

            // Specify text style
            // textStyle: TextStyle(
            //   fontFamily: 'My awesome monospace font',
            //   fontSize: 20,
            // ),
          ),
        ]),
      ),
    );
  }
}
