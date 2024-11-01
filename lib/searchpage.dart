

import 'package:bookshairing/bookdescription.dart';
import 'package:bookshairing/catagories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class searchpage extends StatefulWidget {
  const searchpage({super.key});

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  String limitCharacters(String input, int limit) {
    return (input.length <= limit) ? input : '${input.substring(0, limit)}...';
  }

  var inputText = "";
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
        title: Text("Search Page"),
        backgroundColor: Color(0xff199ee9),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (val) {
                setState(() {
                  inputText = val.toLowerCase();
                  print(inputText);
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collectionGroup("book")
                      .where("Tittle_lower", isGreaterThanOrEqualTo: inputText)
                      .where("Tittle_lower", isLessThan: inputText+"z")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    ///////
                    if (snapshot.hasError) {
                      print("error is ${snapshot.error}");
                      return Center(
                        child: Text("Something went wrong"),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text("Loading"),
                      );
                    }
                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
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
                                      limitCharacters(data["Tittle"],20), 
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(limitCharacters(
                                        data["Description"], 30)),
                                    Container(
                                      width: 260, 
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween, 
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
                                                        builder: (_) =>
                                                            bookdescription(
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
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
