import 'package:bookshairing/bookadd.dart';
import 'package:bookshairing/borrowed.dart';
import 'package:bookshairing/navigatorpage.dart';
import 'package:bookshairing/sharedbook.dart';
import 'package:bookshairing/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class profilepage extends StatefulWidget {
  const profilepage({super.key});

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  TextEditingController? lastname;
  TextEditingController? contactnumber;
  TextEditingController? semester;
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
          title: Text("Profile"),
          backgroundColor: Color(0xff199ee9),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 200,
                      child: CircleAvatar(
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 70,
                        left: 130,
                      ),
                      child: IconButton(
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => userdata()))
                              },
                          icon: const Icon(Icons.edit)),
                    )
                  ],
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("User_form_data")
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    var data = snapshot.data;
                    if (data == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container(
                      child: Column(
                        children: [
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 110),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                controller: lastname = TextEditingController(
                                    text: data["lastname"]),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 110),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: contactnumber = TextEditingController(
                                  text: data["contactnumber"]),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 110),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: semester = TextEditingController(
                                  text: FirebaseAuth.instance.currentUser!
                                      .email),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.lightBlue.shade100, Colors.blue],
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              IconButton(
                                  onPressed: () => {
                                        //
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Rate Us"),
                                                content: RatingBar.builder(
                                                    initialRating: 3,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        EdgeInsets.symmetric( horizontal: 4),
                                                    itemBuilder: (context, _) =>Icon(Icons.star),
                                                    onRatingUpdate: (rating) {
                                                      print(rating);
                                                    }),
                                              );
                                            })
                                        //
                                      },
                                  icon: Icon(
                                    Icons.star_half_sharp,
                                    size: 30,
                                  )),
                              Text("Points"),
                              Text("0"),
                            ],
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 70,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.bookmark_added_sharp,
                                size: 30,
                              ),
                              Text("Shared Books"),
                              Text("0"),
                            ],
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 70,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.bookmark_add_rounded,
                                size: 30,
                              ),
                              Text("Borrowed Books"),
                              Text("0"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blue[300]),
                              child: Column(
                                children: [
                                  Center(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Title(
                                              color: Colors.black,
                                              child: Text(
                                                "Show Share Books",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              height: 25,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: FloatingActionButton(
                                                  onPressed: () => {
                                                    Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                            builder: (_) =>
                                                                sharedbook()))
                                                  },
                                                  child: Text(
                                                    "see",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Center(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Title(
                                              color: Colors.black,
                                              child: Text(
                                                "Show Borrow Books",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              height: 25,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: FloatingActionButton(
                                                  onPressed: () => {
                                                    Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                            builder: (_) =>
                                                                borrowed()))
                                                  },
                                                  child: Text(
                                                    "see",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  // button container.
                  width: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.blue.shade200],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          onPressed: () {},
                          child: Icon(Icons.update),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookAdd()));
                          },
                          child: const Icon(Icons.add),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          onPressed: () {},
                          child: const Icon(Icons.share_sharp),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
