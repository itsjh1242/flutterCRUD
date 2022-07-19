// import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyDuyeaWtPxT_dfN9suStQdJjoD0jdWeRVI',
          appId: '1:844418215947:android:97a66eb72affb84b5f570e',
          messagingSenderId: '844418215947',
          projectId: 'todoapp-8f707'));
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 마크 제거
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  final CollectionReference _todo = FirebaseFirestore.instance.collection('todo');
  final CollectionReference _memo = FirebaseFirestore.instance.collection('memo');
  final memoCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String nowDate1 = DateFormat('yyyy / MM / dd').format(now);
    String nowDate2 = DateFormat('HH : mm').format(now);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget> [
          SliverAppBar(
            backgroundColor: Colors.orange[300],
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(nowDate1),
                      Text(nowDate2, style: TextStyle(fontSize: 30))
                    ],
                  ),
                ),
              ),
              centerTitle: true,
            ),
            pinned: false,
            floating: true,
            expandedHeight: 250.0,
          ),
          SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          // alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [Text('일정')]),
                              ),
                              StreamBuilder(
                                stream: _todo.snapshots(),
                                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                                  if (streamSnapshot.hasData){
                                    return Column(
                                      children: [
                                        ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: streamSnapshot.data!.docs.length,
                                          itemBuilder: (context, index){
                                            final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                                            return GestureDetector(
                                              onTap: () {print(documentSnapshot['context']);},
                                              child: Column(
                                                children: [
                                                  ListTile(title: Text(documentSnapshot['context'])),
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    );
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}
