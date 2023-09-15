import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:libary_messaging_system/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static CollectionReference usersCollection =
      firebaseFirestore.collection(FirestoreConstants.USERS);
  static CollectionReference messagesCollection =
      firebaseFirestore.collection(FirestoreConstants.MESSAGES);
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
}
