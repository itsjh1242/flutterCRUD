import 'package:flutter/material.dart';

// firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// image
import 'package:image_picker/image_picker.dart';
// model
import 'package:crud3/adduser.dart';
import 'package:crud3/edituser.dart';
import 'package:crud3/infouser.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyDom7RedDL5M3EOxbKx7uE052ACy5b8DGc',
          appId: '1:68398204434:android:b72a2fb15c967febc8facb',
          messagingSenderId: '68398204434',
          projectId: 'fluttercrud-9b8f3'));
  runApp(MyApp());
}


class StringBase {
  final appName = 'CRUD V1.3';
  late Timestamp time;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 마크 제거
      title: 'CRUD V1.3',
      theme: ThemeData(primaryColor: Colors.blue[900]),
      home: Home(),
    );
  }
}

// Home Code
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Stream<QuerySnapshot> _firebaseStream = FirebaseFirestore.instance
      .collection('MyCRUD')
      .orderBy('user_timestamp')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.blueAccent,
            ),
            onPressed: () {},
          ),
          backgroundColor: Colors.white70,
          title:
              Text(StringBase().appName, style: TextStyle(color: Colors.grey)),
          actions: <Widget>[
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.home, color: Colors.blueAccent)),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.logout, color: Colors.blueAccent))
          ]),
      body: StreamBuilder(
        stream: _firebaseStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something is wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsets.all(40),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12)
              ),
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(builder: (_) => infouser(docid: snapshot.data!.docs[index])));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(children: [
                          SizedBox(height: 4),
                          Padding(
                            padding: EdgeInsets.all(3),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: Colors.black)),
                                leading: CircleAvatar(
                                    backgroundImage: AssetImage('_profile.png'), foregroundColor: Colors.black),
                                title: Row(children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data!.docChanges[index]
                                            .doc['user_name'],
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      Text(
                                        snapshot.data!.docChanges[index]
                                            .doc['user_timestamp']
                                            .toDate()
                                            .toString(),
                                        // Timestamp.fromMillisecondsSinceEpoch(snapshot.data!.docChanges[index].doc['user_timestamp'].toString()),
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                ]),
                                trailing: Wrap(
                                  spacing: 12,
                                  children: <Widget> [
                                    // edit
                                    IconButton(onPressed: (){
                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (_) => edituser(docid: snapshot.data!.docs[index])));
                                    }, icon: Icon(Icons.edit, color: Colors.blue)),
                                    // delete
                                    IconButton(onPressed: (){
                                      DocumentSnapshot ds = snapshot.data!.docs[index];
                                      FirebaseFirestore.instance.collection('MyCRUD').doc(ds.id).delete();
                                    }, icon: Icon(Icons.delete, color: Colors.red))
                                  ],
                                )
                              ),
                            ),
                          )
                        ]),
                      ),
                    );
                  }),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[100],
        child: Container(height: 50,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context, MaterialPageRoute(builder: (_) => adduser())
            );
          },
          backgroundColor: Colors.green,
          icon: Icon(Icons.add),
          label: Text('Create!')
      )
    );
  }
}