abstract class UserEvent {}

class AddUserEmailEvent extends UserEvent {
  final String email;
  AddUserEmailEvent({required this.email});
}
