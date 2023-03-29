import 'package:hive_flutter/hive_flutter.dart';
import 'models/models.dart';

class HiveStorage {
  HiveStorage();
  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MessageAdapter());
    Hive.registerAdapter(ConversationAdapter());
    await Hive.openBox<Conversation>('conversations');
    print('init hive done');
  }

  List<Conversation> loadListConversation() {
    var box = Hive.box<Conversation>('conversations');
    var keys = box.keys;
    return keys.map((key) => box.get(key) as Conversation).toList();
  }

  void addConversation(Conversation conversation) {
    var box = Hive.box<Conversation>('conversations');
    box.add(conversation);
  }

  void removeConversation(int index) {
    var box = Hive.box<Conversation>('conversations');
    box.deleteAt(index);
  }
}
