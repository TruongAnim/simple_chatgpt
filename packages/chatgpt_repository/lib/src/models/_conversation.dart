import 'models.dart';

class Conversation {
  List<Message> _messages;
  String _title;

  Conversation({String? title, List<Message>? message})
      : _title = title ?? 'New conversation',
        _messages = message ?? [];

  String get title => _title;
  set title(String newTitle) {
    _title = newTitle;
  }

  List<Message> get messages => _messages;
  set messages(List<Message> newMessages) {
    _messages = newMessages;
  }
}