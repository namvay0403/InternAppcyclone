import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intern_appcyclone/practice/week03/rxdart/bloc/provider_user.dart';
import 'package:intern_appcyclone/practice/week03/rxdart/bloc/user_bloc.dart';
import 'package:intern_appcyclone/practice/week03/rxdart/models/users.dart';
import 'package:intern_appcyclone/practice/week03/rxdart/view/user_view.dart';

class DemoRxDart extends StatefulWidget {
  const DemoRxDart({super.key});

  @override
  State<DemoRxDart> createState() => _DemoRxDartState();
}

class _DemoRxDartState extends State<DemoRxDart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      final bloc = UserProvider.of(context);
      bloc.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = UserProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('RxDart'),
      ),
      body: StreamBuilder(
        stream: bloc.users,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(snapshot.data![index].name!),
                  subtitle: Text(snapshot.data![index].email!),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserView(user: snapshot.data![index]),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
