import 'package:flutter/cupertino.dart';
import 'package:intern_appcyclone/practice/week01/cupertino_ui/expanded_flexible/flexible.dart';

class ExpandedTestForCupertino extends StatelessWidget {
  const ExpandedTestForCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Expanded With CupertinoUI'),
        trailing: CupertinoButton(
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return const FlexibleTestForCupertino();
              }));
            },
            child: const Icon(CupertinoIcons.arrow_right_circle_fill)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: CupertinoColors.activeBlue,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: CupertinoColors.systemRed,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: CupertinoColors.activeGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
