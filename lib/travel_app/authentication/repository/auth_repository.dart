import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String country,
    required String phoneNumber,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userCollection = FirebaseFirestore.instance.collection("user");

      String id = userCollection.doc(email).id;

      var newUser = UserModel(
        displayName: name,
        country: country,
        email: email,
        phoneNumber: phoneNumber,
        photoURL:
            'https://th.bing.com/th/id/OIP.fUdURS8RFDOUKFvzrCEe_AHaHa?rs=1&pid=ImgDetMain',
        id: id,
      );

      userCollection.doc(id).set(newUser.toJson());
      return newUser;
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }

  Future<UserModel> readData({required String email}) async {
    final userCollection =
        FirebaseFirestore.instance.collection("user").doc(email);

    final user = await userCollection.get();

    if (user.exists) {
      return UserModel.fromJson(user.data()!);
    } else {
      throw "User not found";
    }
  }

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var user = await readData(email: credential.user!.email!);
      print(user);
      return user;
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      print('Log out successfully');
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      throw e.code;
    }
  }
}

extension on User {
  UserModel get toUser {
    return UserModel(
      phoneNumber: phoneNumber,
      id: uid,
      email: email,
      displayName: displayName,
      photoURL: photoURL,
    );
  }
}
