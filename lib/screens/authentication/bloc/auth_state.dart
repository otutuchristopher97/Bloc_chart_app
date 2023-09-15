import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:libary_messaging_system/screens/authentication/models/login_model.dart';

enum AuthStatus { unknown, loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  final String? error;
  final AuthStatus status;
  final User? firebaseUser;

  const AuthState(this.status, {this.error, this.firebaseUser});
  @override
  List<Object?> get props => [status, firebaseUser, error];

  const AuthState.unknown() : this(AuthStatus.unknown);
  const AuthState.loading() : this(AuthStatus.loading);
  const AuthState.unauthenticated() : this(AuthStatus.unauthenticated);
  const AuthState.error(String error) : this(AuthStatus.error, error: error);
  const AuthState.authenticated(User? firebaseUser)
      : this(AuthStatus.authenticated, firebaseUser: firebaseUser);
}
