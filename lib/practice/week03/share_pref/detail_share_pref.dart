import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var name = '';
  var designation = '';
  var salary = '';
  var experience = '';

  @override
  void initState() {
    // TODO: implement initState
    getSavedData();
    super.initState();
  }

  getSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name')!;
    designation = prefs.getString('designation')!;
    salary = prefs.getString('salary')!;
    experience = prefs.getString('experience')!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text('Details'),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              designation,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              salary,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              experience,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
