import 'package:flutter/cupertino.dart';

class ListViewTestForCupertino extends StatelessWidget {
  const ListViewTestForCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
        middle: const Text('ListView With CupertinoUI'),
        trailing: CupertinoButton(
            onPressed: () {
              // Navigator.push(context, CupertinoPageRoute(builder: (context) {
              //   return const RowTestForCupertino();
              // }));
            },
            child: const Icon(CupertinoIcons.arrow_right_circle_fill)),
      ),
      child: SafeArea(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoListTile(
                title: Text('Index ${index + 1}'),
                leading: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: index % 2 == 0
                      ? CupertinoColors.systemRed
                      : CupertinoColors.systemBlue,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
