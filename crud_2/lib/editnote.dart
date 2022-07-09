import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class editnote extends StatefulWidget {
  DocumentSnapshot docid;
  editnote({required this.docid});

  @override
  _editnoteState createState() => _editnoteState();
}

class _editnoteState extends State<editnote>{
  TextEditingController user_name = TextEditingController();
  TextEditingController desc = TextEditingController();

  @override
  void initState(){
    user_name = TextEditingController(text: widget.docid.get('user_name'));
    desc = TextEditingController(text: widget.docid.get('desc'));
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'datetime': DateTime.now().toString(),
                'user_name': user_name.text,
                'desc': desc.text,
              }).whenComplete((){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Home()));
              });
            },
            child: Text('save')
          ),
          MaterialButton(
              onPressed: () {
                widget.docid.reference.delete().whenComplete((){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Home()));
                });
              },
              child: Text('delete')
          ),
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
                  hintText: 'user_name'
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
      )
    );
  }
}