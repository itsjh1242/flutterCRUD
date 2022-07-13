import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class edituser extends StatefulWidget{
  DocumentSnapshot docid;
  edituser({required this.docid});

  @override
  _edituserState createState() => _edituserState();
}

class _edituserState extends State<edituser>{
  TextEditingController uName = TextEditingController();
  TextEditingController uAge = TextEditingController();
  TextEditingController uBio = TextEditingController();

  @override
  void initState(){
    uName = TextEditingController(text: widget.docid.get('user_name'));
    uAge = TextEditingController(text: widget.docid.get('user_age'));
    uBio = TextEditingController(text: widget.docid.get('user_bio'));
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(150),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Padding(
                padding: EdgeInsets.all(100),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget> [
                      Text('CRUD: Update\n', style: TextStyle(fontSize: 40)),
                      TextField(
                          controller: uName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                          )
                      ),
                      TextField(
                          controller: uAge,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Age',
                          )
                      ),
                      TextField(
                          controller: uBio,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Bio',
                          )
                      )
                    ]
                ),
              ),
            )
        ),
        bottomNavigationBar: BottomAppBar(
            color: Colors.grey[100],
            child: Container(height: 100)
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              widget.docid.reference.update({
                'user_age': uAge.text,
                'user_bio': uBio.text,
                'user_name': uName.text
              }).whenComplete(() {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Home()));
              });
            },
            backgroundColor: Colors.green,
            icon: Icon(Icons.update),
            label: Text('Save!')
        )
    );
  }
}