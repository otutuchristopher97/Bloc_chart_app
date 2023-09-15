import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:libary_messaging_system/common/repository/firestore_repository.dart';
import 'package:libary_messaging_system/common/repository/user_repository.dart';
import 'package:libary_messaging_system/screens/authentication/bloc/auth_event.dart';
import 'package:libary_messaging_system/screens/authentication/bloc/auth_state.dart';
import 'package:libary_messaging_system/screens/authentication/models/user_model.dart';
import 'package:libary_messaging_system/screens/authentication/repository/auth_repository.dart';
import 'package:libary_messaging_system/utils/utils.dart';

import '../../../locator.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthState initialState}) : super(AuthState.unknown()) {
    on<LoginRequestEvent>(_processLoginRequest);
    on<LogOutRequestEvent>(_processLogOutRequest);
  }

  void _processLoginRequest(
      LoginRequestEvent event, Emitter<AuthState> emit) async {
    emit(AuthState.loading());

    try {
      User? firebaseUser =
          await AuthRepository.login(loginModel: event.loginModel);
      await AuthRepository.addUser(
          userId: firebaseUser!.uid, email: firebaseUser.email!);
      emit(AuthState.authenticated(firebaseUser));

      getIt<UserRepository>().setUserModel = UserModel(
        userId: firebaseUser.uid,
        email: firebaseUser.email,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthState.error('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthState.error('Wrong password'));
      } else if (e.code == 'invalid-email') {
        emit(AuthState.error('Invalid email address'));
      }
    } catch (e) {
      print('FIREBASE LOGIN ERROR: $e');
      emit(AuthState.error(e.toString()));
    }
  }

  void _processLogOutRequest(
      LogOutRequestEvent event, Emitter<AuthState> emit) async {
    await AuthRepository.logOut();
    emit(AuthState.unauthenticated());
  }
}
