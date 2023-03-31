import 'package:chatgpt_api/chatgpt_api.dart';
import 'package:chatgpt_repository/chatgpt_repository.dart';
import 'package:local_storage/local_storage.dart';

class ChatGptRepository {
  late String _apiKey;
  late String _userApiKey;
  late ChatGptClient _chatClient;
  late HiveStorage _hiveStorage;
  late List<Conversation> _conversations;
  late bool _usingDefaultKey;
  ChatGptRepository() {
    _chatClient = ChatGptClient();
    _hiveStorage = HiveStorage();
  }

  Future<void> loadData() async {
    print('start load data');
    await _hiveStorage.initHive();
    print('init hive done');

    _apiKey = await FireStoreUtil.getConfig() ?? '';
    print('get apikey done');

    _chatClient.apiKey = _apiKey;
    _userApiKey = await SharePreferenceUtil.getKeyString('userKey') ?? '';

    usingDefaultKey =
        await SharePreferenceUtil.getKeyBool('usingDefault') ?? true;
    print('get reference done');

    _conversations = _loadConversation();
    print('load data done');
  }

  String get userApiKey => _userApiKey;
  set userApiKey(String apiKey) {
    _userApiKey = apiKey;
    SharePreferenceUtil.setKeyString('userKey', apiKey);
  }

  String get apiKey => _apiKey;
  set apiKey(String apiKey) {
    _apiKey = apiKey;
  }

  bool get usingDefaultKey => _usingDefaultKey;
  set usingDefaultKey(bool usingDefault) {
    _usingDefaultKey = usingDefault;
    if (usingDefaultKey) {
      _chatClient.apiKey = _apiKey;
    } else {
      _chatClient.apiKey = _userApiKey;
    }
    SharePreferenceUtil.setKeyBool('usingDefault', usingDefault);
  }

  List<Conversation> get conversations => _conversations;

  void addConversation(Conversation conversation) {
    _conversations.add(conversation);
    _hiveStorage.addConversation(conversation);
  }

  void removeConversation(int index) {
    _conversations.removeAt(index);
    _hiveStorage.removeConversation(index);
  }

  List<Conversation> _loadConversation() {
    return _hiveStorage.loadListConversation();
  }

  Future<String?> getAnswer(Conversation conversation) async {
    List<Map<String, String>> messages = [
      {
        'role': "system",
        'content': "",
      }
    ];
    for (Message message in conversation.message) {
      messages.add({
        'role': message.sender == 'user' ? 'user' : 'system',
        'content': message.content
      });
    }
    return _chatClient.sendMessage(messages);
  }
}
