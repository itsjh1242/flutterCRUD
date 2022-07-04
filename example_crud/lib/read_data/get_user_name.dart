import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget{

  late final String documentId;

  GetUserName({required this.documentId});

  Widget build(BuildContext context){
    // get the collection
    CollectionReference users = FirebaseFirestore.instance.collection('MyCRUD');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: ((context, snapshot){
      if (snapshot.connectionState == ConnectionState.done){
        Map<String, dynamic> data =
        snapshot.data!.data() as Map<String, dynamic>;
        return Text('이름: ${data['studentName']} 학번: ${data['studentID']} 수강번호: ${data['studyProgramID']} 학점: ${data['studentGPA']}');
      }
      return Text('loading..');
    }),
    );
  }
}