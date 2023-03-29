import 'package:hive/hive.dart';
import 'models.dart';

part 'conversation.g.dart';

@HiveType(typeId: 1)
class Conversation extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  List<Message> message;

  Conversation({required this.title, required this.message});
}
