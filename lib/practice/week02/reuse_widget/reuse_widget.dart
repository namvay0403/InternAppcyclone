import 'package:flutter/material.dart';

class TestReuseWidget extends StatefulWidget {
  const TestReuseWidget({super.key});

  @override
  State<TestReuseWidget> createState() => _TestReuseWidgetState();
}

class _TestReuseWidgetState extends State<TestReuseWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reuse Widget'),
      ),
      body: Wrap(
        children: [
          customNameTag(name: 'John'),
          customNameTag(name: 'John'),
          customNameTag(name: 'John'),
          customNameTag(name: 'John'),
          customNameTag(name: 'John'),
          customNameTag(name: 'John'),
          customNameTag(name: 'John'),
        ],
      ),
    );
  }

  Widget customNameTag({required String name}) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
