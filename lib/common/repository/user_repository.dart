import 'package:libary_messaging_system/screens/authentication/models/user_model.dart';

class UserRepository {
  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  set setUserModel(UserModel userModel) {
    _userModel = userModel;
  }
}
