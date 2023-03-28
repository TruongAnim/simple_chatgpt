import 'package:hive/hive.dart';

class Message {
  String content;
  DateTime time;
  String sender;

  Message({required this.content, required this.sender, DateTime? newTime})
      : time = newTime ?? DateTime.now();
}
