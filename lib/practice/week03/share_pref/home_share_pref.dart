import 'package:flutter/material.dart';
import 'package:intern_appcyclone/practice/week03/share_pref/detail_share_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenSharePref extends StatefulWidget {
  @override
  _HomeScreenSharePrefState createState() => _HomeScreenSharePrefState();
}

class _HomeScreenSharePrefState extends State<HomeScreenSharePref> {
  var name = '';
  var designation = '';
  var salary = '';
  var experience = '';

  final nameTextController = TextEditingController();
  final designationTextController = TextEditingController();
  final salaryTextController = TextEditingController();
  final experienceTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSavedData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameTextController.dispose();
    designationTextController.dispose();
    salaryTextController.dispose();
    experienceTextController.dispose();
  }

  getSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name')! ?? '';
    designation = prefs.getString('designation')! ?? '';
    salary = prefs.getString('salary')! ?? '';
    experience = prefs.getString('experience')! ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    nameTextController.text = name;
    designationTextController.text = designation;
    salaryTextController.text = salary;
    experienceTextController.text = experience;

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Icon(
                      Icons.person_pin,
                      size: 100,
                      color: Colors.teal,
                    ),
                    const Text(
                      'Personal Details',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: nameTextController,
                      decoration: InputDecoration(
                          hintText: 'Enter Name',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.teal,
                          )),
                    ),
                    TextFormField(
                      controller: designationTextController,
                      decoration: InputDecoration(
                          hintText: 'Enter Designation',
                          prefixIcon: Icon(
                            Icons.work,
                            color: Colors.teal,
                          )),
                    ),
                    TextFormField(
                      controller: salaryTextController,
                      decoration: InputDecoration(
                          hintText: 'Enter Salary',
                          prefixIcon: Icon(
                            Icons.attach_money,
                            color: Colors.teal,
                          )),
                    ),
                    TextFormField(
                      controller: experienceTextController,
                      decoration: InputDecoration(
                          hintText: 'Work Experience',
                          prefixIcon: Icon(
                            Icons.timer_outlined,
                            color: Colors.teal,
                          )),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString(
                              'name', nameTextController.text);
                          await prefs.setString(
                              'designation', designationTextController.text);
                          await prefs.setString(
                              'salary', salaryTextController.text);
                          await prefs.setString(
                              'experience', experienceTextController.text);

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DetailsScreen();
                          }));
                        },
                        child: Text('Save & Navigate')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
