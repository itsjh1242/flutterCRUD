import 'dart:html';

import 'package:example_crud/read_data/get_user_name.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyDom7RedDL5M3EOxbKx7uE052ACy5b8DGc',
          appId: '1:68398204434:android:b72a2fb15c967febc8facb',
          messagingSenderId: '68398204434',
          projectId: 'fluttercrud-9b8f3')
  );
  runApp(const MyApp());
}
// => runApp(MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//           brightness: Brightness.light,
//           primaryColor: Colors.blue,
//           accentColor: Colors.cyan
//       ),
//       home: MyApp()
//   ));
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String studentName, studentID, studyProgramID, studentGPA;

  getStudentName(name){
    studentName = name;
  }
  getStudentID(id){
    studentID = id;
  }
  getStudyProgramID(programID){
    studyProgramID = programID;
  }
  getStudentGPA(gpa){
    studentGPA = gpa;
  }

  createData() async {
    final docUser = FirebaseFirestore.instance.collection('MyCRUD').doc(studentID);
    final json = {
      'studentName': studentName,
      'studentID': studentID,
      'studyProgramID': studyProgramID,
      'studentGPA': studentGPA
    };
    await docUser.set(json);
    print('Created!');
  }
  readData() async {
    print('Read!');
  }
  updateData() async {
    final docUser = FirebaseFirestore.instance.collection('MyCRUD').doc(studentID);
    final json = {
      'studentName': studentName,
      'studentID': studentID,
      'studyProgramID': studyProgramID,
      'studentGPA': studentGPA
    };
    await docUser.update(json);
    print('Updated!');
  }
  deleteData(){
    final docUser = FirebaseFirestore.instance.collection('MyCRUD').doc(studentID);
    docUser.delete();
    print('Deleted!');
  }

  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance.collection('MyCRUD').get().then(
            (snapshot) => snapshot.docs.forEach((document) {
          print(document.reference);
          docIDs.add(document.reference.id);
        })
    );
  }

  @override
  void initState(){
    getDocId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('My Flutter App'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget> [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Name',
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0)
                        )
                    ),
                    onChanged: (String name){
                      getStudentName(name);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'StudentID',
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0)
                        )
                    ),
                    onChanged: (String id){
                      getStudentID(id);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Study Program ID',
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0)
                        )
                    ),
                    onChanged: (String programID){
                      getStudyProgramID(programID);
                    },
                  ),
                ),Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'GPA',
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0)
                        )
                    ),
                    onChanged: (String gpa){
                      getStudentGPA(gpa);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: Text('Create'),
                      textColor: Colors.white,
                      onPressed: (){
                        createData();
                      },
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: Text('Read'),
                      textColor: Colors.white,
                      onPressed: (){
                        readData();
                      },
                    ),
                    RaisedButton(
                      color: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: Text('Update'),
                      textColor: Colors.white,
                      onPressed: (){
                        updateData();
                      },
                    ),
                    RaisedButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: Text('Delete'),
                      textColor: Colors.white,
                      onPressed: (){
                        deleteData();
                      },
                    )
                  ],
                ),
                Expanded(
                    child: FutureBuilder(
                      future: getDocId(),
                      builder: (context, snapshot){
                        return ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: GetUserName(documentId: docIDs[index]),
                                tileColor: Colors.grey[100],
                              ),
                            );
                          }
                        );
                      }
                    ))
              ],
            ),
          ),
        )
    );
  }
  // Stream<List<User>> readUsers() => FirebaseFirestore.instance.collection('MyCRUD').doc(studentID).snapshots()
  //     .map((snapshot) => snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}
