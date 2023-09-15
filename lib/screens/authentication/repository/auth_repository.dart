import 'package:firebase_auth/firebase_auth.dart';
import 'package:libary_messaging_system/common/repository/firestore_repository.dart';
import 'package:libary_messaging_system/screens/authentication/models/login_model.dart';

class AuthRepository {
  static Future addUser({required String userId, required String email}) async {
    await FirebaseRepository.usersCollection
        .doc(userId)
        .set({'user_id': userId, 'email': email});
  }

  static Future<User?> login({required LoginModel loginModel}) async {
    UserCredential userCredential =
        await FirebaseRepository.firebaseAuth.signInWithEmailAndPassword(
      email: loginModel.email,
      password: loginModel.password,
    );
    return userCredential.user;
  }

  static Future logOut() async {
    await FirebaseRepository.firebaseAuth.signOut();
  }
}
