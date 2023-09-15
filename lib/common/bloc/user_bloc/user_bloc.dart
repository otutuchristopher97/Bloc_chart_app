import 'package:bloc/bloc.dart';
import 'package:libary_messaging_system/common/bloc/user_bloc/user_event.dart';
import 'package:libary_messaging_system/common/bloc/user_bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(UserState initialState) : super(initialState) {
    on<AddUserEmailEvent>(_processAddEmailEvent);
  }

  _processAddEmailEvent(AddUserEmailEvent event, Emitter<UserState> emit) {
    emit(UserState.emailAdded(email: event.email));
  }
}
