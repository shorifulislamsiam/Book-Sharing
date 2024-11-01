import 'package:bookshairing/bookdescription.dart';
import 'package:bookshairing/navigatorpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

class favouritelist extends StatefulWidget {
  const favouritelist({super.key});

  @override
  State<favouritelist> createState() => _favouritelistState();
}

class _favouritelistState extends State<favouritelist> {
  bool isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }
String limitCharacters(String text, int limit) {
    return text.length <= limit ? text : text.substring(0, limit) + '...';
  }

Future removeFromFavorite(String bookId,) async {
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
        .then((value) => 
        Fluttertoast.showToast(
          msg: "Remove From Favorite List",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.blue,
          fontSize: 16.0,
          textColor: Colors.white));
        //print('Removed from Favorite List'));
  } catch (e) {
    print('Failed to remove book from favorite list: $e');
  }
}


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const navigatorpage();
                }));
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded)),
          title: Text("Favourite List"),
          backgroundColor: Color(0xff199ee9),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('favoriteList')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("items")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              //print(snapshot.error);
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
                //String ownerEmail = ownere; //27 april
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
                                  data["Tittle"], 20), //data["Tittle"],//
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            //Text(data["Description"],),
                            Text(limitCharacters(data["Description"], 30)),
                            //Text("Condition: New."),
                            Container(
                              width: 260, //260 update 101
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween, //update 101
                                children: [
                                  IconButton(
                                    onPressed: () => removeFromFavorite(bookId),
                                    icon: Icon(
                                      Icons.favorite_outlined,
                                      color: Colors.red,
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
                                                  //ownerEmail: ownerEmail,
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
      ),
    );
  }
}
