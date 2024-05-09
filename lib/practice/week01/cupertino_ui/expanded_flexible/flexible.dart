import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intern_appcyclone/practice/week01/cupertino_ui/column_row/column.dart';
import 'package:intern_appcyclone/practice/week01/material_ui/column_row/column.dart';

class FlexibleTestForCupertino extends StatelessWidget {
  const FlexibleTestForCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Flexible With CupertinoUI'),
        trailing: CupertinoButton(
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return const ColumnTestForCupertino();
              }));
            },
            child: const Icon(CupertinoIcons.arrow_right_circle_fill)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                color: Colors.blue,
                height: 100,
              ),
            ),
            Flexible(
              child: Container(
                color: Colors.red,
                height: 500,
              ),
            ),
            Flexible(
              child: Container(
                color: Colors.green,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
