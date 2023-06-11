import 'package:chatgpt_repository/chatgpt_repository.dart';
import 'package:flutter/material.dart';
import 'package:simple_chatgpt/chat_page/view/highlight_box.dart';
import 'package:simple_chatgpt/utils/list_utils.dart';

const userId = 'user';

class MessageBox extends StatelessWidget {
  const MessageBox({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    RegExp pattern = RegExp(r'```([\s\S]+?)```');
    Iterable<RegExpMatch> matches = pattern.allMatches(message.content);
    List<String> matchess = [
      for (RegExpMatch match in matches) match.group(0) ?? ''
    ];
    List<String> result = message.content.split(pattern);
    List<String> blocks = ListUtils.zip(result, matchess);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.generate(
        blocks.length,
        (index) {
          if (index % 2 == 0) {
            return Text(
              blocks[index].trim(),
              style: TextStyle(
                  fontSize: 16,
                  color: message.sender == userId
                      ? Colors.white
                      : Theme.of(context).textTheme.bodySmall?.color),
            );
          } else {
            return HighlightBox(content: blocks[index]);
          }
        },
      ),
    );
  }
}
