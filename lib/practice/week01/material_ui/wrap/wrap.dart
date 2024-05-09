import 'package:flutter/material.dart';
import 'package:intern_appcyclone/practice/week01/material_ui/stack/stack.dart';

class WrapTest extends StatelessWidget {
  const WrapTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expanded'),
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const StackTest();
                }));
              },
            ),
          ],
        ),
        body: Wrap(
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
        ));
  }
}
