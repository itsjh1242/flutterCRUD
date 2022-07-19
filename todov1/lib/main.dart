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
  final todoCtrl = TextEditingController();
  final tododateCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String nowDate1 = DateFormat('yyyy / MM / dd').format(now);
    String nowDate2 = DateFormat('HH : mm').format(now);
    return Scaffold(
      resizeToAvoidBottomInset : false,
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
              children: <Widget> [
                Text('일정'),
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
                                    ListTile(
                                      title: Text(documentSnapshot['context']),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: (){
                                          FirebaseFirestore.instance.collection('todo').doc(documentSnapshot.id).delete();
                                        },
                                      )
                                    ),
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
                ),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  spacing: 10,
                  children: [
                    SizedBox(width: 50, child: TextField(controller: tododateCtrl,)),
                    SizedBox(width: 260, child: TextField(controller: todoCtrl)),
                    IconButton(onPressed: (){
                      FirebaseFirestore.instance.collection('todo').add({
                        'context': todoCtrl.text,
                        'data': Timestamp.now()
                      });
                    }, icon: Icon(Icons.add))
                  ],
                )
              ],
            )
          ),
          SliverFillRemaining(
            child: Column(
              children: <Widget> [
                Text('일정'),
                StreamBuilder(
                  stream: _memo.snapshots(),
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
                                    ListTile(
                                        title: Text(documentSnapshot['context']),
                                        trailing: IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: (){
                                            FirebaseFirestore.instance.collection('memo').doc(documentSnapshot.id).delete();
                                          },
                                        )
                                    ),
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
                ),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  spacing: 10,
                  children: [
                    SizedBox(width: 260, child: TextField(controller: memoCtrl)),
                    IconButton(onPressed: (){
                      FirebaseFirestore.instance.collection('memo').add({
                        'context': memoCtrl.text
                      });
                    }, icon: Icon(Icons.add))
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }
}
