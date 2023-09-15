part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class SendChatEvent extends ChatEvent {
  final ChatModel chatModel;

  SendChatEvent({required this.chatModel});
}

class GetAllMessagesEvent extends ChatEvent {
  final String userId;
  final String otherDepartmentId;

  GetAllMessagesEvent({required this.userId, required this.otherDepartmentId});
}
