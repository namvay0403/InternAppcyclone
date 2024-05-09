import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intern_appcyclone/practice/week01/cupertino_ui/stack/stack.dart';
import 'package:intern_appcyclone/practice/week01/material_ui/stack/stack.dart';

class WrapTestForCupertino extends StatefulWidget {
  const WrapTestForCupertino({super.key});

  @override
  State<WrapTestForCupertino> createState() => _WrapTestForCupertinoState();
}

class _WrapTestForCupertinoState extends State<WrapTestForCupertino> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
        middle: const Text('Wrap With CupertinoUI'),
        trailing: CupertinoButton(
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return const StackTestForCupertino();
              }));
            },
            child: const Icon(CupertinoIcons.arrow_right_circle_fill)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 10,
            runSpacing: 20,
            children: [
              Container(
                color: Colors.blue,
                height: 100,
                width: 100,
              ),
              Container(
                color: Colors.red,
                height: 100,
                width: 100,
              ),
              Container(
                color: Colors.green,
                height: 100,
                width: 100,
              ),
              Container(
                color: Colors.pink,
                height: 100,
                width: 100,
              ),
              Container(
                color: Colors.pinkAccent,
                height: 100,
                width: 100,
              ),
              Container(
                color: Colors.blueGrey,
                height: 100,
                width: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
