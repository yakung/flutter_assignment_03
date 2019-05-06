import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Addform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddformState();
  }
}

class AddformState extends State<Addform> {
  TextEditingController _subject = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Subject"),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, right: 10.0, left: 10.0, bottom: 0),
              child: TextFormField(
                controller: _subject,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: "Subject",
                  errorStyle: TextStyle(fontSize: 15,color: Colors.red[300])
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please fill subject";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0, right: 10.0, left: 10.0),
              child: RaisedButton(
                color: Colors.indigoAccent,
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    Firestore.instance.collection('todo').add({
                      'title': _subject.text,
                      'done': 0,
                    }).then((value) {
                      Navigator.pushReplacementNamed(context, '/');
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
