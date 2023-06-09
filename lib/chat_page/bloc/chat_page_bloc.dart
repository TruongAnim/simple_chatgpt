import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatgpt_repository/chatgpt_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
part 'chat_page_event.dart';
part 'chat_page_state.dart';

class ChatPageBloc extends Bloc<ChatPageEvent, ConversationState> {
  ChatPageBloc({required ChatGptRepository repository})
      : _repository = repository,
        super(ConversationState()) {
    print('start build bloc');
    on<InitConversations>(_initConversation);
    on<AddNewConversation>(_addNewConversation);
    on<AddQuestion>(_addQuestion);
    on<ChangeCurrentConversation>(_changeCurrentConversation);
    on<ChangeName>(_changeName);
    on<DeleteConversation>(_deleteConversation);
    on<ClearChat>(_clearChat);
    on<UpdateApiSetting>(_updateApiSetting);
    on<MessageCopied>(_messageClicked);
    on<OpenCodePad>(_openCodePad);
  }

  final ChatGptRepository _repository;

  void _initConversation(
      InitConversations event, Emitter<ConversationState> emit) async {
    await _repository.loadData();
    List<Conversation> conversations = _repository.conversations;
    if (conversations.isEmpty) {
      _repository.addConversation(
          Conversation(title: 'New conversation', message: []));
    }
    emit(state.copyWith(
        convsersations: conversations,
        currentConversation: 0,
        usingDefaultKey: _repository.usingDefaultKey,
        userKey: _repository.userApiKey));
  }

  void _addNewConversation(
      AddNewConversation event, Emitter<ConversationState> emit) {
    _repository.addConversation(Conversation(title: event.name, message: []));
    List<Conversation> conversations = _repository.conversations;
    emit(state.copyWith(
        convsersations: conversations,
        currentConversation: conversations.length - 1));
  }

  void _addQuestion(AddQuestion event, Emitter<ConversationState> emit) async {
    List<Conversation> conversations = _repository.conversations;
    conversations[state.currentConversation]
        .message
        .add(Message(content: event.question, sender: 'user'));
    conversations[state.currentConversation].save();
    emit(state.copyWith(
        convsersations: conversations,
        currentConversation: state.currentConversation,
        data: DateTime.now().toString()));
    await Future.delayed(Duration(seconds: 1));
    Message message = Message(content: 'typing', sender: 'system');
    conversations[state.currentConversation].message.add(message);
    emit(state.copyWith(
        convsersations: conversations,
        currentConversation: state.currentConversation,
        data: DateTime.now().toString()));

    // Old method without sse
    // String? answer =
    //     await _repository.getAnswer(conversations[state.currentConversation]);

    // message.content = answer ?? 'Error!!!';
    // conversations[state.currentConversation].save();
    // emit(state.copyWith(
    //     convsersations: conversations,
    //     currentConversation: state.currentConversation,
    //     data: DateTime.now().toString()));

    Stream<String> answer =
        _repository.getStreamAnswer(conversations[state.currentConversation]);
    await emit.forEach(
      answer,
      onData: (String data) {
        message.content = data;
        return state.copyWith(
            convsersations: conversations,
            currentConversation: state.currentConversation,
            data: DateTime.now().toString());
      },
      onError: (error, stackTrace) {
        message.content = error.toString();
        return state.copyWith(
            convsersations: conversations,
            currentConversation: state.currentConversation,
            data: DateTime.now().toString());
      },
    );
    if (message.content != 'typing') {
      conversations[state.currentConversation].save();
    }
  }

  void _changeCurrentConversation(
      ChangeCurrentConversation event, Emitter<ConversationState> emit) {
    emit(state.copyWith(currentConversation: event.newCurrent));
  }

  void _changeName(ChangeName event, Emitter<ConversationState> emit) {
    state.conversations[state.currentConversation].title = event.newName;
    state.conversations[state.currentConversation].save();
    emit(state.copyWith(
      data: DateTime.now().toString(),
    ));
  }

  void _deleteConversation(
      DeleteConversation event, Emitter<ConversationState> emit) {
    if (state.conversations.length == 1) {
      state.conversations[0].message.clear();
      state.conversations[0].title = 'New conversation';
      state.conversations[0].save();
    } else {
      _repository.removeConversation(state.currentConversation);
    }
    emit(state.copyWith(
        currentConversation: 0, data: DateTime.now().toString()));
  }

  void _clearChat(ClearChat event, Emitter<ConversationState> emit) {
    state.conversations[state.currentConversation].message.clear();
    state.conversations[state.currentConversation].save();
    emit(state.copyWith(data: DateTime.now().toString()));
  }

  void _updateApiSetting(
      UpdateApiSetting event, Emitter<ConversationState> emit) {
    _repository.usingDefaultKey = event.usingDefault;
    _repository.userApiKey = event.userKey;
    emit(state.copyWith(
        usingDefaultKey: event.usingDefault, userKey: event.userKey));
  }

  void _messageClicked(
      MessageCopied event, Emitter<ConversationState> emit) async {
    Clipboard.setData(ClipboardData(text: event.message));
    Fluttertoast.showToast(
        msg: 'Copied to clipboard',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade600,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _openCodePad(OpenCodePad event, Emitter<ConversationState> emit) async {
    Navigator.pushNamed(event.context, '/codePad', arguments: event.message);
  }
}
