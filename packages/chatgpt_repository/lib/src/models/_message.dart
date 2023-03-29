class Message {
  final String _content;
  final DateTime _time;
  final String _senderId;

  Message({required String content, required String senderId, DateTime? time})
      : _content = content,
        _senderId = senderId,
        _time = time ?? DateTime.now();

  String get content => _content;
  DateTime get time => _time;
  String get senderId => _senderId;
}
