class ChatModel {
  final String message;
  final String senderId;
  final DateTime? dateTime;
  final String? otherDepartmentId;

  ChatModel(
      {this.dateTime,
      required this.message,
      required this.senderId,
      required this.otherDepartmentId});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      message: json['message'],
      senderId: json['senderId'],
      otherDepartmentId: json['otherDepartmentId'] ?? null,
      dateTime: json['timeStamp'] == null
          ? null
          : DateTime.parse(json['timeStamp'].toDate().toString()),
    );
  }
}
