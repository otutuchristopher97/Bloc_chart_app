import 'package:libary_messaging_system/common/repository/firestore_repository.dart';
import 'package:libary_messaging_system/screens/general_broadcast/broadcast_model.dart';
import 'package:libary_messaging_system/utils/constants.dart';

class GeneralBroadcastRepository {
  static Future<List<GeneralBroadcastModel>> getDepartmentBroadcast(
      {required String departmentId}) async {
    List<GeneralBroadcastModel> generalBcModel = [];

    await FirebaseRepository.usersCollection
        .doc(departmentId)
        .collection(FirestoreConstants.BROADCAST_MESSAGE)
        .orderBy('timeStamp')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        generalBcModel.add(
          GeneralBroadcastModel(
            message: element['message'],
            dateTime: DateTime.parse(element['timeStamp'].toDate().toString()),
          ),
        );
      });
    });
    return generalBcModel;
  }
}
