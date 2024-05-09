import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../global/common/toast.dart';

class HomePageLogin extends StatefulWidget {
  const HomePageLogin({super.key});

  @override
  State<HomePageLogin> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageLogin> {
  User? userFirebase = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     Navigator.pushNamed(context, "/login");
    //   }
    //   print(user);
    // });
    print(userFirebase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("HomePage"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _createData(
                      UserModel2(
                        username: "Nam",
                        age: 22,
                        adress: "VN",
                      ),
                      userFirebase!);
                },
                child: Container(
                  height: 45,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      "Create Data",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              StreamBuilder<List<UserModel2>>(
                  stream: _readData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data!.isEmpty) {
                      return const Center(child: Text("No Data Yet"));
                    }
                    final users = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                          children: users!.map((user) {
                        return ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              _deleteData(user.id!);
                            },
                            child: Icon(Icons.delete),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              _updateData(
                                UserModel2(
                                  id: user.id,
                                  username: "Nam 2",
                                  adress: "VN",
                                ),
                              );
                            },
                            child: Icon(Icons.update),
                          ),
                          title: Text(user.username!),
                          subtitle: Text(user.adress!),
                        );
                      }).toList()),
                    );
                  }),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, "/login");
                  showToast(message: "Successfully signed out");
                },
                child: Container(
                  height: 45,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Sign out",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Stream<List<UserModel2>> _readData() {
    final userCollection = FirebaseFirestore.instance.collection("Users");

    return userCollection.snapshots().map((qureySnapshot) => qureySnapshot.docs
        .map(
          (e) => UserModel2.fromSnapshot(e),
        )
        .toList());
  }

  void _createData(UserModel2 userModel, User user) {
    // final userCollection = FirebaseFirestore.instance.collection("Users");
    final userCollection = FirebaseFirestore.instance.collection("Users");

    String id = userCollection.doc().id;

    final newUser = UserModel2(
      username: userModel.username,
      age: userModel.age,
      adress: userModel.adress,
      id: id,
    ).toJson();

    userCollection.doc(id).set(newUser);
  }

  void _updateData(UserModel2 userModel) {
    final userCollection = FirebaseFirestore.instance.collection("Users");

    final newData = UserModel2(
      username: userModel.username,
      id: userModel.id,
      adress: userModel.adress,
      age: userModel.age,
    ).toJson();

    userCollection.doc(userModel.id).update(newData);
  }

  void _deleteData(String id) {
    final userCollection = FirebaseFirestore.instance.collection("Users");
    print(id);
    userCollection.doc(id).delete();
  }
}

class UserModel2 {
  final String? username;
  final String? adress;
  final int? age;
  final String? id;

  UserModel2({this.id, this.username, this.adress, this.age});

  static UserModel2 fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel2(
      username: snapshot['username'],
      adress: snapshot['adress'],
      age: snapshot['age'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "age": age,
      "id": id,
      "adress": adress,
    };
  }
}
