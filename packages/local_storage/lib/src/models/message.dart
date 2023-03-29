import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 0)
class Message extends HiveObject {
  @HiveField(0)
  String content;
  @HiveField(1)
  DateTime time;
  @HiveField(2)
  String sender;

  Message({required this.content, required this.sender, DateTime? newTime})
      : time = newTime ?? DateTime.now();
}
