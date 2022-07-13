import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class infouser extends StatefulWidget{
  DocumentSnapshot docid;
  infouser({required this.docid});

  @override
  _infouserState createState() => _infouserState();
}

class _infouserState extends State<infouser>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(150),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12)
              ),
              child: Padding(
                padding: EdgeInsets.all(100),
                child: Column(
                    children: <Widget> [
                      Text('CRUD: Read' + '\n', style: TextStyle(fontSize: 40)),
                      CircleAvatar(
                        radius: 50.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.asset('_profile3.jpg'),
                        ),
                      ),
                      Text('\n\n'),
                      Text(
                        widget.docid.get('user_name') + '님',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        widget.docid.get('user_age') + '세',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        widget.docid.get('user_bio'),
                        style: TextStyle(fontSize: 15),
                      )
                    ]
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            color: Colors.grey[100],
            child: Container(height: 100)
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Home()));
            },
            backgroundColor: Colors.green,
            icon: Icon(Icons.home),
            label: Text('Home!')
        )
    );
  }
}