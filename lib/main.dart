import 'package:flutter/material.dart';
import 'package:school_system/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return getMainWidget();
  }

  Widget getMainWidget() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: LoginPage(),
    );
  }
}
