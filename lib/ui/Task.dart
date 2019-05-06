import 'package:flutter/material.dart';
import './Addform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Task extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskState();
  }
}

class TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Todo"),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.add),
              onPressed: () {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Addform()));
                });
              }),
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('todo')
              .where('done', isEqualTo: 0)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return buildList(snapshot.data.documents);
            } else {
              return CircularPercentIndicator(
                radius: 150.0,
                lineWidth: 10,
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.blueAccent,
                center: Text("loading..."),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildList(List<DocumentSnapshot> data) {
    return data.length != 0
        ? ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: new BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black, width: 0.5))),
                child: CheckboxListTile(
                  title: Text(data.elementAt(index).data["title"]),
                  onChanged: (bool value) {
                    setState(() {
                      Firestore.instance
                          .collection('todo')
                          .document(data.elementAt(index).documentID)
                          .setData({
                        'title': data.elementAt(index).data['title'],
                        'done': 1
                      });
                    });
                  },
                  value: data.elementAt(index).data['done'] != 0,
                ),
              );
            },
          )
        : Center(
            child: Text("No data found...", style: TextStyle(fontSize: 15)));
  }
}
