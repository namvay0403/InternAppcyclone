import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intern_appcyclone/travel_app/authentication/models/user.dart';

class AccountRepository {
  Future<void> updateProfile(UserModel user) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection("user");
      await userCollection.doc(user.email).update(user.toJson());
    } catch (e) {
      throw e.toString();
    }
  }
}
