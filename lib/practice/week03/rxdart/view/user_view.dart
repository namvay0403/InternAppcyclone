import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intern_appcyclone/practice/week03/rxdart/models/users.dart';

class UserView extends StatefulWidget {
  const UserView({super.key, required this.user});

  final User user;

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RxDart'),
      ),
      body: Center(
        child: Card(
          child: ListTile(
            title: Text(widget.user.name!),
            subtitle: Text(widget.user.email!),
          ),
        ),
      ),
    );
  }
}
