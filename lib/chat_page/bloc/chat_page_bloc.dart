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
    on<ChangeName>(_changeName);
    on<DeleteConversation>(_deleteConversation);
    on<ClearChat>(_clearChat);
    on<UpdateApiSetting>(_updateApiSetting);
  }

  final ChatGptRepository _repository;

  void _initConversation(
      InitConversations event, Emitter<ConversationState> emit) async {
    await _repository.loadData();
    List<Conversation> conversations = _repository.conversations;
    if (conversations.isEmpty) {
      conversations.add(Conversation(title: 'New conversation'));
    }
    emit(state.copyWith(
        convsersations: conversations,
        currentConversation: 0,
        usingDefaultKey: _repository.usingDefaultKey,
        userKey: _repository.userApiKey));
  }

  void _addNewConversation(
      AddNewConversation event, Emitter<ConversationState> emit) {
    List<Conversation> conversations = _repository.conversations;
    conversations.add(Conversation(title: event.name));
    emit(state.copyWith(
        convsersations: conversations,
        currentConversation: conversations.length - 1));
  }

  void _addQuestion(AddQuestion event, Emitter<ConversationState> emit) async {
    List<Conversation> conversations = _repository.conversations;
    conversations[state.currentConversation]
        .messages
        .add(Message(content: event.question, senderId: 'user'));
    emit(state.copyWith(
        convsersations: conversations,
        currentConversation: state.currentConversation,
        data: DateTime.now().toString()));
    String? answer =
        await _repository.getAnswer(conversations[state.currentConversation]);
    conversations[state.currentConversation]
        .messages
        .add(Message(content: answer ?? 'Error!!!', senderId: 'system'));
    emit(state.copyWith(
        convsersations: conversations,
        currentConversation: state.currentConversation,
        data: DateTime.now().toString()));
  }

  void _changeCurrentConversation(
      ChangeCurrentConversation event, Emitter<ConversationState> emit) {
    emit(state.copyWith(currentConversation: event.newCurrent));
  }

  void _changeName(ChangeName event, Emitter<ConversationState> emit) {
    state.conversations[state.currentConversation].title = event.newName;
    emit(state.copyWith(
      data: DateTime.now().toString(),
    ));
  }

  void _deleteConversation(
      DeleteConversation event, Emitter<ConversationState> emit) {
    if (state.conversations.length == 1) {
      state.conversations[0].messages.clear();
      state.conversations[0].title = 'New conversation';
    } else {
      state.conversations.removeAt(state.currentConversation);
    }
    emit(state.copyWith(
        currentConversation: 0, data: DateTime.now().toString()));
  }

  void _clearChat(ClearChat event, Emitter<ConversationState> emit) {
    state.conversations[state.currentConversation].messages.clear();
    emit(state.copyWith(data: DateTime.now().toString()));
  }

  void _updateApiSetting(
      UpdateApiSetting event, Emitter<ConversationState> emit) {
    _repository.usingDefaultKey = event.usingDefault;
    _repository.userApiKey = event.userKey;
    emit(state.copyWith(
        usingDefaultKey: event.usingDefault, userKey: event.userKey));
  }
}
