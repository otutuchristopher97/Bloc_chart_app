import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:libary_messaging_system/common/repository/user_repository.dart';
import 'package:libary_messaging_system/locator.dart';
import 'package:libary_messaging_system/screens/chat/models/chat_model.dart';
import 'package:libary_messaging_system/screens/chat/repository/chat_repository.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({required ChatState initialState}) : super(ChatState.unknown()) {
    on<SendChatEvent>(_processSendChatEvent);
    on<GetAllMessagesEvent>(_processGetAllMessagesEvent);
  }
}

_processSendChatEvent(SendChatEvent event, Emitter<ChatState> emit) async {
  try {
    await ChatRepository.sendChat(chatModel: event.chatModel);
  } catch (e) {
    print('CHAT ERROR: ${e.toString()}');
    emit(ChatState.error(e.toString()));
  }
}

_processGetAllMessagesEvent(
    GetAllMessagesEvent event, Emitter<ChatState> emit) async {
  try {
    ChatRepository.getChatMessages(
      userId: event.userId,
      otherDepartmentId: event.otherDepartmentId,
    );
  } catch (e) {
    print('GET ALL MESSAGES ERROR: ${e.toString()}');
    emit(ChatState.error(e.toString()));
  }
}
