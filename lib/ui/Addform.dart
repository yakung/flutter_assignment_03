import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Addform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddformState();
  }
}

class AddformState extends State<Addform> {
  TextEditingController txtctrl = TextEditingController();
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
              padding: const EdgeInsets.only(top:10.0,right: 10.0,left: 10.0,bottom: 0),
              child: TextFormField(
                controller: txtctrl,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: "Subject",
                  
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please fill subject";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:2.0,right: 10.0,left: 10.0),
              child: RaisedButton(
                child: Text("Save",style: TextStyle(fontSize: 15),),
                onPressed: ()  {
                  if(_formkey.currentState.validate()){
                    Firestore.instance
                        .collection('todo').add(
                          {"title": txtctrl,
                            "done": "0"
                          }
                        );
                        Navigator.pushReplacementNamed(context, '/');
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