import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intern_appcyclone/practice/week01/cupertino_ui/column_row/row.dart';
import 'package:intern_appcyclone/practice/week01/material_ui/column_row/row.dart';

class ColumnTestForCupertino extends StatelessWidget {
  const ColumnTestForCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Column With CupertinoUI'),
        backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
        trailing: CupertinoButton(
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return const RowTestForCupertino();
              }));
            },
            child: const Icon(CupertinoIcons.arrow_right_circle_fill)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                height: 100,
              ),
              Container(
                color: Colors.red,
                height: 100,
              ),
              Container(
                color: Colors.green,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
