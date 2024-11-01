
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class bookdetails extends StatefulWidget {
  final Map<String, dynamic> data;
  const bookdetails({Key? key, required this.data}) : super(key: key);
  @override
  State<bookdetails> createState() => bookdetailsState();
}

class bookdetailsState extends State<bookdetails> {
  



  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.arrow_back_ios_new_rounded)
            ),
        title: Text(""),
        backgroundColor: Color(0xff199ee9),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collectionGroup("book")
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Description About Book-",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 300,
                        width: 380,
                        color: Colors.amber[50],
                        child: Row(
                            //first container of book description.
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 300,
                                  width: 160,
                                  child: Column(
                                    children: [ 
                                      Image.network(
                                        data["image"][0], //new add on update 12
                                        height: 150,
                                        width: 80,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(data["Description"]),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 300,
                                    width: 160,
                                    child: Column(
                                      children: [
                                        Image.network(
                                        data["image"][1],
                                        height: 150,
                                        width: 80,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    )),
                              ),
                            ]),
                      ),
                    ),
                    Text(
                      "Some Picture Of Book-",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Container(
                      height: 280,
                      width: 380,
                      color: Colors.amber[50],
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              height: 280,
                              width: 380,
                              padding: EdgeInsets.all(16.0),
                              child: PhotoViewGallery.builder(
                                itemCount: widget.data["image"].length,
                                builder: (context, index) {
                                  return PhotoViewGalleryPageOptions(
                                    imageProvider:
                                        NetworkImage(widget.data["image"][index]),
                                    minScale:
                                        PhotoViewComputedScale.contained * 0.8,
                                    maxScale:
                                        PhotoViewComputedScale.covered * 2,
                                  );
                                },
                                scrollPhysics: BouncingScrollPhysics(),
                                backgroundDecoration: BoxDecoration(
                                  color: Colors.blue[300],
                                ),
                                pageController: PageController(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: Container(
                            height: 50,
                            width: 90,
                            child: FloatingActionButton(
                              onPressed: () => {},

                              backgroundColor: Colors.blue,
                              
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              )),
                              child: Text("Borrow It"),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            color: Colors.blueAccent,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 35),
                          child: Container(
                            height: 50,
                            width: 90,
                            child: FloatingActionButton(
                              onPressed: () => {},
                              backgroundColor: Colors.blue,
                              //elevation: 14.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              )),
                              child: Text("Buy It"),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
