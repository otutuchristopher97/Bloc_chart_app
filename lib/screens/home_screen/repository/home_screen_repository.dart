import 'package:libary_messaging_system/common/models/department_model.dart';
import 'package:libary_messaging_system/common/repository/firestore_repository.dart';
import 'package:libary_messaging_system/common/repository/user_repository.dart';
import 'package:libary_messaging_system/locator.dart';

class HomeScreenRepository {
  static Future<List<DepartmentModel>> getAllDepartments() async {
    List<DepartmentModel> departModel = [];
    await FirebaseRepository.usersCollection.get().then((value) {
      value.docs.forEach((element) {
        if (element['user_id'] != getIt<UserRepository>().userModel!.userId) {
          departModel.add(DepartmentModel(
              departmentId: element['user_id'],
              departmentEmail: element['email']));
        }
      });
    });
    return departModel;
  }
}
