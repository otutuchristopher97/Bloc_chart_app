import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:libary_messaging_system/common/repository/firestore_repository.dart';
import 'package:libary_messaging_system/screens/chat/models/chat_model.dart';

class ChatRepository {
  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>?> getChatMessages(
      {required String userId, required String otherDepartmentId}) async {
    bool firstCheck = false;
    bool secondCheck = false;

    await FirebaseRepository.messagesCollection
        .doc('$userId-$otherDepartmentId')
        .get()
        .then((value) {
      if (value.exists) {
        firstCheck = true;
      }
    });

    await FirebaseRepository.messagesCollection
        .doc('$otherDepartmentId-$userId')
        .get()
        .then(
      (value) {
        if (value.exists) {
          secondCheck = true;
        }
      },
    );

    if (firstCheck) {
      print('FIRST ::: $firstCheck');
      return FirebaseRepository.messagesCollection
          .doc('$userId-$otherDepartmentId')
          .collection('$userId-$otherDepartmentId')
          .orderBy('timeStamp')
          .snapshots();
    } else if (secondCheck) {
      return FirebaseRepository.messagesCollection
          .doc('$otherDepartmentId-$userId')
          .collection('$otherDepartmentId-$userId')
          .orderBy('timeStamp')
          .snapshots();
    }
    return null;
  }

  static Future sendChat({required ChatModel chatModel}) async {
    print('S::: ${chatModel.senderId}-${chatModel.otherDepartmentId}');
    bool firstCheck = false;
    bool secondCheck = false;

    await FirebaseRepository.messagesCollection
        .doc('${chatModel.senderId}-${chatModel.otherDepartmentId}')
        .get()
        .then((value) {
      if (value.exists) {
        firstCheck = true;
      }
    });
    await FirebaseRepository.messagesCollection
        .doc('${chatModel.otherDepartmentId}-${chatModel.senderId}')
        .get()
        .then((value) {
      if (value.exists) {
        secondCheck = true;
      }
    });

    if (firstCheck) {
      await FirebaseRepository.messagesCollection
          .doc('${chatModel.senderId}-${chatModel.otherDepartmentId}')
          .collection('${chatModel.senderId}-${chatModel.otherDepartmentId}')
          .doc()
          .set(
        {
          'senderId': chatModel.senderId,
          'message': chatModel.message,
          'timeStamp': FieldValue.serverTimestamp(),
        },
      );
    }

    if (secondCheck) {
      await FirebaseRepository.messagesCollection
          .doc('${chatModel.otherDepartmentId}-${chatModel.senderId}')
          .collection('${chatModel.otherDepartmentId}-${chatModel.senderId}')
          .doc()
          .set(
        {
          'senderId': chatModel.senderId,
          'message': chatModel.message,
          'timeStamp': FieldValue.serverTimestamp(),
        },
      );
    }

    if (firstCheck == false && secondCheck == false) {
      await FirebaseRepository.messagesCollection
          .doc('${chatModel.senderId}-${chatModel.otherDepartmentId}')
          .set({'exists': true});

      await FirebaseRepository.messagesCollection
          .doc('${chatModel.senderId}-${chatModel.otherDepartmentId}')
          .collection('${chatModel.senderId}-${chatModel.otherDepartmentId}')
          .doc()
          .set(
        {
          'senderId': chatModel.senderId,
          'message': chatModel.message,
          'timeStamp': FieldValue.serverTimestamp(),
        },
      );
    }
  }
}
