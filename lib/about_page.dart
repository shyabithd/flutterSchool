import 'package:flutter/material.dart';

// Create a Form widget.
class AboutPage extends StatefulWidget {
  @override
  AboutPageState createState() {
    return AboutPageState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class AboutPageState extends State<AboutPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<AboutPageState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(15),
              child: Text('About Us', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Center(
                child: SizedBox.fromSize(
                    size: Size(400, 200),
                    child: Image.network('https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80', fit: BoxFit.cover, width: 1000.0),
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Center(
                child: SizedBox.fromSize(
                  size: Size(400, 200),
                  child: Text('Creating good looking forms on mobile is not a trivial task. The kind of layouts that are available on native development tools as well as cross-platform frameworks (e.g. Xamarin, React Native etc.) make use of complex layout hierarchies to achieve a satisfactory output. In this brief post, I’m going to show you how easy it is to build a form in Flutter.'),
                )
            ),
          ),
        ],
      ),
    );
  }
}