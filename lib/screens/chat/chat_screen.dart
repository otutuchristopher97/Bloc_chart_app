import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_messaging_system/common/widgets/action_button.dart';
import 'package:libary_messaging_system/common/widgets/custom_text_field.dart';
import 'package:libary_messaging_system/screens/chat/chat_bloc.dart';
import 'package:libary_messaging_system/screens/chat/models/chat_model.dart';
import 'package:libary_messaging_system/screens/chat/repository/chat_repository.dart';

import '../../common/repository/user_repository.dart';
import '../../locator.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String otherDepartmentId; // ID of the department you want to chat with.
  final String otherDepartmentName;

  const ChatScreen(
      {Key? key,
      required this.otherDepartmentName,
      required this.otherDepartmentId})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();

    userId = getIt<UserRepository>().userModel!.userId!;
    getStreamOfChatMessages();
  }

  late String userId;
  bool nullMessageStream = false;
  Stream<QuerySnapshot<Map<String, dynamic>>>? messageStream;
  TextEditingController messageCtrl = TextEditingController();

  getStreamOfChatMessages() async {
    await ChatRepository.getChatMessages(
      otherDepartmentId: widget.otherDepartmentId,
      userId: getIt<UserRepository>().userModel!.userId!,
    ).then((value) {
      print('VALUE ::: $value');
      messageStream = value;
      nullMessageStream = messageStream == null;
      setState(() {});
    });
  }

  void handleOverflowMenuClick(String value) {
    switch (value) {
      case 'Call':
        break;
      case 'Email':
        break;
    }
  }

  Widget getOverFlowMenuIcon(String value) {
    switch (value) {
      case 'Call':
        return Icon(Icons.call, color: Colors.black, size: 18);
      case 'Email':
        return Icon(Icons.email, color: Colors.black, size: 18);
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.otherDepartmentName),
        actions: [
          PopupMenuButton<String>(
            onSelected: handleOverflowMenuClick,
            itemBuilder: (BuildContext context) {
              return {'Call', 'Email'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Row(
                    children: [
                      getOverFlowMenuIcon(choice),
                      SizedBox(width: 8),
                      Text(choice),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: getMessageList()),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomTextField(
                    validator: (value) {},
                    hintText: 'Type message...',
                    controller: messageCtrl,
                  ),
                ),
              ),
              IconButton(
                iconSize: 34,
                icon: Icon(
                  Icons.send,
                  color: Color(0xffff0000),
                ),
                onPressed: () {
                  getStreamOfChatMessages();
                  context.read<ChatBloc>().add(SendChatEvent(
                          chatModel: ChatModel(
                        senderId: getIt<UserRepository>().userModel!.userId!,
                        otherDepartmentId: widget.otherDepartmentId,
                        message: messageCtrl.text,
                      )));
                  messageCtrl.clear();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getMessageList() {
    return StreamBuilder(
      stream: messageStream,
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        print(snapshot.data);
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              reverse: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                ChatModel chatModel = ChatModel.fromJson(
                    snapshot.data!.docs.reversed.toList()[index].data());

                return MessageBubble(
                    dateTime: chatModel.dateTime,
                    sender: chatModel.senderId == userId,
                    message: chatModel.message);
              },
            );
          } else {
            return Center(
                child: Text('You have no chat messages at the moment'));
          }
        } else {
          return Center(
            child: Text('You have no chat messages at the moment'),
          );
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final bool sender;
  final String message;
  final DateTime? dateTime;
  const MessageBubble(
      {Key? key,
      required this.dateTime,
      required this.sender,
      required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            sender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 200),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: sender
                    ? BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )
                    : BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 4),
          Text(
            dateTime == null ? '' : getTimeOfMessage(dateTime!),
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  String getTimeOfMessage(DateTime dateTime) {
    return DateFormat.jm().format(dateTime);
  }
}
