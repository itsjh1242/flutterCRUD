import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class addnote extends StatelessWidget{
  TextEditingController user_name = TextEditingController();
  TextEditingController desc = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('MyCRUD');

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            onPressed: () {
              ref.add({
                'datetime': DateTime.now().toString(),
                'user_name': user_name.text,
                'desc': desc.text
              }).whenComplete(() {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Home()));
              });
            },
            child: Text('save'),
          )
        ]
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: user_name,
                decoration: InputDecoration(
                  hintText: 'userName'
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: desc,
                expands: true,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'desc'
                ),
              )
            ))
          ],
        ),
      ),
    );
  }
}