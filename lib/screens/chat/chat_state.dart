part of 'chat_bloc.dart';

enum ChatStatus { unknown, loading, loaded, error }

class ChatState extends Equatable {
  final String? error;
  final ChatStatus? status;
  final List<ChatModel>? chatModelList;

  const ChatState(this.status, {this.error, this.chatModelList});

  const ChatState.unknown() : this(ChatStatus.unknown);
  const ChatState.loading() : this(ChatStatus.loading);
  const ChatState.loaded(List<ChatModel> chatModelList)
      : this(ChatStatus.loaded, chatModelList: chatModelList);
  const ChatState.error(String error) : this(ChatStatus.loading, error: error);

  @override
  List<Object?> get props => [status, chatModelList, error];
}
