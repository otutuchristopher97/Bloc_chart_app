enum UserStatus { userEmailAdded }

class UserState {
  final String? email;
  final UserStatus status;

  UserState({this.email, required this.status});

  UserState.emailAdded({String? email})
      : this(email: email, status: UserStatus.userEmailAdded);
}
