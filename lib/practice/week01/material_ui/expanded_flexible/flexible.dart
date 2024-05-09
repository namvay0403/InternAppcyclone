import 'package:flutter/material.dart';
import 'package:intern_appcyclone/practice/week01/material_ui/column_row/column.dart';

class FlexibleTest extends StatelessWidget {
  const FlexibleTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flexible'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ColumnTest();
              }));
            },
          ),
        ],
      ),
      body: Column(
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
    );
  }
}
