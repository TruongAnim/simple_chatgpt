part of 'chat_page_bloc.dart';

class ChatPageState extends Equatable {
  const ChatPageState();
  @override
  List<Object> get props => [];
}

class ConversationState extends ChatPageState {
  final List<Conversation> _conversations;
  final int _currentConversation;

  const ConversationState(
      {required conversations, required currentConversation})
      : _conversations = conversations,
        _currentConversation = currentConversation,
        super();

  List<Conversation> get conversation => _conversations;
  int get currentConversation => _currentConversation;

  ConversationState copyWith(
      {List<Conversation>? convsersations, int? currentConversation}) {
    return ConversationState(
        conversations: convsersations ?? _conversations,
        currentConversation: currentConversation ?? _currentConversation);
  }

  @override
  List<Object> get props => [_currentConversation, _conversations];
}
