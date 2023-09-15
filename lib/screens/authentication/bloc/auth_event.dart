import 'package:libary_messaging_system/screens/authentication/models/login_model.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class LoginRequestEvent extends AuthEvent {
  final LoginModel loginModel;

  LoginRequestEvent({required this.loginModel});
}

class LogOutRequestEvent extends AuthEvent {}
