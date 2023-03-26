part of 'chat_page_bloc.dart';

class ChatPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeCurrentConversation extends ChatPageEvent {
  final int newCurrent;
  ChangeCurrentConversation({required this.newCurrent});

  @override
  List<Object> get props => [newCurrent];
}

class AddNewConversation extends ChatPageEvent {
  AddNewConversation({required this.name});
  final String name;
}

class InitConversations extends ChatPageEvent {
  InitConversations();
}

class AddQuestion extends ChatPageEvent {
  AddQuestion({required this.question});
  final String question;
}

class ChangeName extends ChatPageEvent {
  ChangeName({required this.newName});
  final String newName;
}
