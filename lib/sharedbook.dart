//import 'dart:io';

import 'package:bookshairing/bookdescription.dart';
import 'package:bookshairing/profilepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class sharedbook extends StatefulWidget {
  const sharedbook({super.key});

  @override
  State<sharedbook> createState() => _addbooklistState();
}

class _addbooklistState extends State<sharedbook> {
  TextEditingController section = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController images = TextEditingController();
  TextEditingController images1 = TextEditingController();
  TextEditingController submit = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
   int totalbooks = 0;
  

  ////update 101 for limited words --start. date 27-03-2024
  ///
  String limitCharacters(String text, int limit) {
    return text.length <= limit ? text : text.substring(0, limit) + '...';
  }

  ///
  ///update 101 --end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const profilepage();
              }));
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
        title: Text("Shared Books = $totalbooks"),
        backgroundColor: Color(0xff199ee9),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('bookStore')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection("book")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            //print(snapshot.error);
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          totalbooks = snapshot.data!.docs.length;
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              //bookid add new version 13
              String bookId = document.id;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.lightBlue.shade100,
                        Colors.blue,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          data["image"][0],
                          height: 150,
                          width: 80,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            limitCharacters(data["Tittle"], 20),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(limitCharacters(data["Description"], 30)),
                          Container(
                            width: 260,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.favorite_outlined,
                                  color: Colors.red,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 25,
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => bookdescription(
                                                  data: data, bookId: bookId),
                                            ));
                                      },
                                      child: Text("View It"),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
