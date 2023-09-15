import 'package:get_it/get_it.dart';
import 'package:libary_messaging_system/common/repository/user_repository.dart';

final getIt = GetIt.instance;

setup() {
  getIt.registerSingleton<UserRepository>(UserRepository());
}
