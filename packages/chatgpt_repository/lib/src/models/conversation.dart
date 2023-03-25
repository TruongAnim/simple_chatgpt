import 'models.dart';

class Conversation {
  final List<Message> _messages;
  final String _title;

  Conversation({String? title, List<Message>? message})
      : _title = title ?? 'New conversation',
        _messages = message ?? List.empty();

  String get title => _title;
  List<Message> get messages => _messages;
}
