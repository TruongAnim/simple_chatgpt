import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatgpt_repository/chatgpt_repository.dart';
part 'chat_page_event.dart';
part 'chat_page_state.dart';

class ChatPageBloc extends Bloc<ChatPageEvent, ChatPageState> {
  ChatPageBloc({required ChatGptRepository repository})
      : _repository = repository,
        super(const ChatPageState()) {
    on<InitConversations>(_initConversation);
    on<AddNewConversation>(_addNewConversation);
  }

  final ChatGptRepository _repository;

  void _initConversation(InitConversations event, Emitter<ChatPageState> emit) {
    List<Conversation> conversations = _repository.conversations;
    if (conversations.isEmpty) {
      conversations.add(Conversation(title: 'New conversation'));
    }
    emit(ConversationState(
        conversations: conversations, currentConversation: 0));
  }

  void _addNewConversation(
      AddNewConversation event, Emitter<ChatPageState> emit) {
    List<Conversation> conversations = _repository.conversations;
    conversations.add(Conversation(title: event.name));
    emit(ConversationState(
        conversations: List.of(conversations),
        currentConversation: conversations.length - 1));
  }
}
