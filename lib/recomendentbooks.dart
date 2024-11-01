import 'package:bookshairing/bookdescription.dart';

import 'package:bookshairing/navigatorpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class recomendentbooks extends StatefulWidget {
  const recomendentbooks({super.key});
  @override
  State<recomendentbooks> createState() => _recommendedState();
}

class _recommendedState extends State<recomendentbooks> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ////update 101 for limited words --start. date 27-03-2024
  ///
  String limitCharacters(String text, int limit) {
    return text.length <= limit ? text : text.substring(0, limit) + '...';
  }

  ///
  ///update 101 --end

  //// add to favourite section --space start 07 May

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
          msg: "Added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.blue,
          fontSize: 16.0,
          textColor: Colors.white));       
       // print('Added to Favorite List'));
    }

////add to favourite section --space end 07 May
  ///
  ///remove from favorite section--space start 07 May
  ///
  Future removeFromFavorite(
    String bookId,
  ) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("favoriteList");
    try {
      return await _collectionRef
          .doc(currentUser!.email)
          .collection("items")
          .doc(bookId)
          .delete()
          .then((value) => print('Removed from Favorite List'));
    } catch (e) {
      print('Failed to remove book from favorite list: $e');
    }
  }
  /// remove from favorite section--space start 07 May

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const navigatorpage();
              }));
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
        title: Text("Recomendend Books"),
        backgroundColor: Color(0xff199ee9),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collectionGroup("book")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
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
                          Text(
                            limitCharacters(
                                data["Tittle"], 20),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(limitCharacters(data["Description"], 30)),
                          Container(
                            width: 260, //260 update 101
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween, //update 101
                              children: [
                                IconButton(
                                  onPressed: () => addToFavorite(bookId, data),
                                  icon: Icon(
                                    Icons.favorite_outline,
                                    color: Colors.white,
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
                                              builder: (_) => bookdescription(
                                                data: data,
                                                bookId: bookId,
                                              ),
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
