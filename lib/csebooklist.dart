//for trying the fetch data from firestore with section

import 'package:bookshairing/bookdescription.dart';
import 'package:bookshairing/catagories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class csebooklist extends StatefulWidget {
  const csebooklist({super.key});

  @override
  State<csebooklist> createState() => _csebooklistState();
}

class _csebooklistState extends State<csebooklist> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ////update 101 for limited words --start. date 27-03-2024
  ///
  String limitCharacters(String text, int limit) {
  return text.length <= limit ? text : text.substring(0, limit) + '...';
  }
  ///
  ///update 101 --end
  ///
  /// add to favorite section --start 07 May
  Future addToFavorite(String bookId, Map<String, dynamic> data) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("favoriteList");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(bookId)
        .set(data)
        .then((value) => 
        Fluttertoast.showToast(
          msg: "Added to Favorite List",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.blue,
          fontSize: 16.0,
          textColor: Colors.white));       
    }
  ///add to favorite section --end 07 May
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const catagories();
              }));
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
        title: Text("CSE"),
        backgroundColor: Color(0xff199ee9),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collectionGroup("book")
            .where("section",isEqualTo: "CSE") // This line is for subcatagories.
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
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
                          Text(limitCharacters(data["Tittle"], 20),
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(limitCharacters(data["Description"], 30)),
                          Container(
                            width: 260,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () => addToFavorite(bookId, data),
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                    //color: Colors.red,
                                  ),
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
                                        builder: (_) => bookdescription(data: data, bookId: bookId)));
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
