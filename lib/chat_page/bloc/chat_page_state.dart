part of 'chat_page_bloc.dart';

class ConversationState extends Equatable {
  final List<Conversation> _conversations;
  final int _currentConversation;
  final String _data;

  ConversationState(
      {List<Conversation>? conversations,
      int? currentConversation,
      String? data})
      : _conversations = conversations ??
            [Conversation(title: 'init converstaion', message: [])],
        _currentConversation = currentConversation ?? 0,
        _data = data ?? 'data',
        super();

  List<Conversation> get conversations => _conversations;
  int get currentConversation => _currentConversation;
  String get data => _data;

  ConversationState copyWith(
      {List<Conversation>? convsersations,
      int? currentConversation,
      String? data}) {
    return ConversationState(
        conversations: convsersations ?? _conversations,
        currentConversation: currentConversation ?? _currentConversation,
        data: data ?? _data);
  }

  @override
  List<Object> get props => [currentConversation, conversations, data];
}
