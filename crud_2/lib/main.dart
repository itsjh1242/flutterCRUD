import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_2/addnote.dart';
import 'package:crud_2/editnote.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyDom7RedDL5M3EOxbKx7uE052ACy5b8DGc',
          appId: '1:68398204434:android:b72a2fb15c967febc8facb',
          messagingSenderId: '68398204434',
          projectId: 'fluttercrud-9b8f3')
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'CRUD APP',
      theme: ThemeData(
        primaryColor: Colors.blue[900]
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('MyCRUD').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (_) => addnote()));
        },
        child: Icon(Icons.add)
      ),
      appBar: AppBar(
        title: Text('CRUD')
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError){
            return Text('Something is wrong');
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator()
            );
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12)
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(builder: (_) => editnote(docid: snapshot.data!.docs[index])));
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      Padding(padding: EdgeInsets.only(left: 3, right: 3),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Colors.black
                          )
                        ),
                        title: Text(
                          snapshot.data!.docChanges[index].doc['user_name'],
                          style: TextStyle(
                            fontSize: 20
                          )
                        ),
                        subtitle: Text(
                          snapshot.data!.docChanges[index].doc['datetime'],
                          style: TextStyle(
                            fontSize: 15
                          ),
                        ),
                        trailing: IconButton(icon: Icon(Icons.delete), onPressed: () {
                        }),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16
                        ),
                      )
                      )
                    ],
                ),
                );
              },
            )
          );
        }
      )
    );
  }
}
