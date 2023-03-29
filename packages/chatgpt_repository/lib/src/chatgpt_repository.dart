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
    _apiKey = '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';
    _chatClient = ChatGptClient(apiKey: _apiKey);
    _hiveStorage = HiveStorage();
  }

  Future<void> loadData() async {
    await _hiveStorage.initHive();
    _userApiKey = await SharePreferenceUtil.getKeyString('userKey') ?? '';
    _usingDefaultKey =
        await SharePreferenceUtil.getKeyBool('usingDefault') ?? true;
    _conversations = _hiveStorage.loadListConversation();
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
