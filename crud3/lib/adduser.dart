import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:crud3/main.dart';

class adduser extends StatelessWidget{
  TextEditingController uName = TextEditingController();
  TextEditingController uAge = TextEditingController();
  TextEditingController uBio = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('MyCRUD');

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
                Text('CRUD: Create', style: TextStyle(fontSize: 40)),
                CircleAvatar(
                ),
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
            ref.add({
              'user_age': uAge.text,
              'user_bio': uBio.text,
              'user_name': uName.text,
              'user_timestamp': Timestamp.now()
            }).whenComplete(() {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Home()));
            });
          },
          backgroundColor: Colors.green,
          icon: Icon(Icons.add),
          label: Text('Submit!')
      )
    );
  }
}