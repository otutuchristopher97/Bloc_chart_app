class LoginModel {
  String email;
  String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  @override
  String toString() {
    return 'AuthModel => Code: Email: $email Password: $password';
  }
}
