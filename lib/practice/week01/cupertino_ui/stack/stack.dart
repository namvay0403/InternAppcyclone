import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intern_appcyclone/practice/week01/cupertino_ui/listview/listview.dart';
import 'package:intern_appcyclone/practice/week01/material_ui/listview/listview.dart';

class StackTestForCupertino extends StatelessWidget {
  const StackTestForCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
        middle: const Text('Stack With CupertinoUI'),
        trailing: CupertinoButton(
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return const ListViewTestForCupertino();
              }));
            },
            child: const Icon(CupertinoIcons.arrow_right_circle_fill)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Colors.blue,
                height: 300,
                width: 300,
              ),
              Container(
                color: Colors.red,
                height: 100,
                width: 100,
              ),
              Container(
                color: Colors.yellow,
                height: 40,
                width: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
