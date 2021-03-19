import 'package:flutter/material.dart';

// Create a Form widget.
class RecordBookPage extends StatefulWidget {
  @override
  RecordBookPageState createState() {
    return RecordBookPageState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class RecordBookPageState extends State<RecordBookPage> {

  Widget getSubject(String subject, int marks, int len) {
    String subj = subject + ':';
    double length = (60.0 + len);
    return Padding(
        padding: EdgeInsets.fromLTRB(50,0,0,20),
        child: Row(
            children: [
              Text(subj, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              Padding(padding: EdgeInsets.fromLTRB(100,0,length,0)),
              Text(marks.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
            ]
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return new Scaffold(
      appBar: AppBar(
        title: Text('Record Book'),
      ),
      body: new Column(
        children: <Widget>[
          Padding(
          padding: EdgeInsets.all(50),
          ),
          getSubject('Sinhala', 67, 0),
          getSubject('English', 90, 0),
          getSubject('Religion', 76, -5),
          getSubject('Math', 89, 17),
          getSubject('Science', 94, -5),
        ],
      ),
    );
  }
}