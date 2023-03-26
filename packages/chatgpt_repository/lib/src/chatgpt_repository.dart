import 'package:chatgpt_api/chatgpt_api.dart';
import 'package:chatgpt_repository/chatgpt_repository.dart';

class ChatGptRepository {
  late String _apiKey;
  late ChatGptClient _chatClient;
  late List<Conversation> _conversations;
  ChatGptRepository() {
    _apiKey = '';
    _chatClient = ChatGptClient(apiKey: _apiKey);

    _conversations = _loadConversation();
  }
  set apiKey(String apiKey) {
    _apiKey = apiKey;
  }

  List<Conversation> get conversations => _conversations;

  List<Conversation> _loadConversation() {
    return [];
  }

  Future<String?> getAnswer(Conversation conversation) async {
    List<Map<String, String>> messages = [
      {
        'role': "system",
        'content': "",
      }
    ];
    for (Message message in conversation.messages) {
      messages.add({
        'role': message.senderId == 'user' ? 'user' : 'system',
        'content': message.content
      });
    }
    return _chatClient.sendMessage(messages);
  }
}
