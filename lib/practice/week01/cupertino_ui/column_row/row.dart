import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intern_appcyclone/practice/week01/cupertino_ui/wrap/wrap.dart';
import 'package:intern_appcyclone/practice/week01/material_ui/wrap/wrap.dart';

class RowTestForCupertino extends StatelessWidget {
  const RowTestForCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Row With CupertinoUI'),
        trailing: CupertinoButton(
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return const WrapTestForCupertino();
              }));
            },
            child: const Icon(CupertinoIcons.arrow_right_circle_fill)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.blue,
                height: 100,
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.red,
                height: 200,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.green,
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
