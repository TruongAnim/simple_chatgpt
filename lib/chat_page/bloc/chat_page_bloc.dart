import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatgpt_repository/chatgpt_repository.dart';
part 'chat_page_event.dart';
part 'chat_page_state.dart';

class ChatPageBloc extends Bloc<ChatPageEvent, ConversationState> {
  ChatPageBloc({required ChatGptRepository repository})
      : _repository = repository,
        super(ConversationState()) {
    on<InitConversations>(_initConversation);
    on<AddNewConversation>(_addNewConversation);
    on<AddQuestion>(_addQuestion);
    on<ChangeCurrentConversation>(_changeCurrentConversation);
  }

  final ChatGptRepository _repository;

  void _initConversation(
      InitConversations event, Emitter<ConversationState> emit) {
    List<Conversation> conversations = _repository.conversations;
    if (conversations.isEmpty) {
      conversations.add(Conversation(title: 'New conversation'));
    }
    emit(ConversationState(
        conversations: conversations, currentConversation: 0));
  }

  void _addNewConversation(
      AddNewConversation event, Emitter<ConversationState> emit) {
    List<Conversation> conversations = _repository.conversations;
    conversations.add(Conversation(title: event.name));
    emit(ConversationState(
        conversations: List.of(conversations),
        currentConversation: conversations.length - 1));
  }

  void _addQuestion(AddQuestion event, Emitter<ConversationState> emit) async {
    List<Conversation> conversations = _repository.conversations;
    print("len: ${conversations[state.currentConversation].messages.length}");

    conversations[state.currentConversation]
        .messages
        .add(Message(content: event.question, senderId: 'user'));
    // List<Conversation> newList = List.of(conversations);
    // newList[0].title = 'new titlte';
    // emit(state.copyWith(convsersations: newList));
    emit(state.copyWith(
        convsersations: conversations,
        currentConversation: state.currentConversation,
        data: event.question));
    String? answer =
        await _repository.getAnswer(conversations[state.currentConversation]);
    conversations[state.currentConversation]
        .messages
        .add(Message(content: answer ?? 'Error!!!', senderId: 'system'));
    emit(state.copyWith(
        convsersations: conversations,
        currentConversation: state.currentConversation,
        data: answer ?? 'Error!!!'));
  }

  void _changeCurrentConversation(
      ChangeCurrentConversation event, Emitter<ConversationState> emit) {
    emit(state.copyWith(currentConversation: event.newCurrent));
  }
}
