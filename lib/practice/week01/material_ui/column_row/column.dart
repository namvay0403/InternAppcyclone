import 'package:flutter/material.dart';
import 'package:intern_appcyclone/practice/week01/material_ui/column_row/row.dart';

class ColumnTest extends StatelessWidget {
  const ColumnTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Column'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const RowTest();
              }));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            height: 100,
          ),
          Container(
            color: Colors.red,
            height: 200,
          ),
          Container(
            color: Colors.green,
            height: 100,
          ),
        ],
      ),
    );
  }
}
