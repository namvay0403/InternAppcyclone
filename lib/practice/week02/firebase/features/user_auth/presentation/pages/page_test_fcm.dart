import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intern_appcyclone/practice/week02/firebase/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FCMTest extends StatefulWidget {
  const FCMTest({super.key});

  @override
  State<FCMTest> createState() => _FCMTestState();
}

class _FCMTestState extends State<FCMTest> {
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      String title = message.notification?.title ?? '';
      String body = message.notification?.body ?? '';
      print('onMessageOpenedApp: $title, $body');


      Alert(
      context: context,
      type: AlertType.error,
      title: title,
      desc: body,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
    });

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FCM Test'),
      ),
    );
  }
}
