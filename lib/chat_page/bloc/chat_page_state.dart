part of 'chat_page_bloc.dart';

class ConversationState extends Equatable {
  final List<Conversation> _conversations;
  final int _currentConversation;
  final String _data;
  final bool _usingDefaultKey;
  final String _userKey;

  ConversationState(
      {List<Conversation>? conversations,
      int? currentConversation,
      String? data,
      bool? usingDefaultKey,
      String? userKey})
      : _conversations = conversations ??
            [Conversation(title: 'init converstaion', message: [])],
        _currentConversation = currentConversation ?? 0,
        _data = data ?? 'data',
        _usingDefaultKey = usingDefaultKey ?? true,
        _userKey = userKey ?? '',
        super();

  List<Conversation> get conversations => _conversations;
  int get currentConversation => _currentConversation;
  String get data => _data;
  bool get usingDefaultKey => _usingDefaultKey;
  String get userKey => _userKey;

  ConversationState copyWith(
      {List<Conversation>? convsersations,
      int? currentConversation,
      String? data,
      bool? usingDefaultKey,
      String? userKey}) {
    print('copyWith: $usingDefaultKey');
    return ConversationState(
        conversations: convsersations ?? _conversations,
        currentConversation: currentConversation ?? _currentConversation,
        data: data ?? _data,
        usingDefaultKey: usingDefaultKey ?? _usingDefaultKey,
        userKey: userKey ?? _userKey);
  }

  @override
  List<Object> get props =>
      [currentConversation, conversations, data, usingDefaultKey, userKey];
}
