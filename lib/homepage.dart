//This page is for home page of Navigator

import 'package:bookshairing/bookdescription.dart';
import 'package:bookshairing/catagories.dart';

//import 'package:bookshairing/profilepage.dart';
import 'package:bookshairing/recomendentbooks.dart';


//import 'package:bookshairing/recomendentbooks.dart';

//import 'package:bookshairing/recomendentbooks.dart'; update
import 'package:bookshairing/searchpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class homepage extends StatefulWidget {
  
  const homepage({super.key});//super.key

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  //List<String> itemmenu = ["CSE","Textile","BBA","English",nondepartment()];
  //new update 22 of banner --space Start
  //
  final List<String> imageAssets = [
    //'assets/os4.png',
    'assets/Banner1.jpeg',
    'assets/Banner2.jpeg',

    // Add more image assets as needed
  ];
  final PageController _imagecontroller = PageController();
  //
  //new update 22 of banner -- space End

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              Container(
                width: 405,
                height: 110,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(215, 30),
                    ),
                    gradient: LinearGradient(
                        colors: [Colors.blue, Colors.blue.shade200])),
                child: Column(
                  children: [
                    //there was a row that cut
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Book Share Hub", //Enjoy Reading
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(width: 10.8),
                    ),
                    hintText: " Search For Books...",
                    suffixIcon:
                        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                  ),
                  onTap: () => {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const searchpage();
                    })),
                  },
                ),
              ),

              //////new update 22 of banner --place start
              ///
              Container(
                height: 210, //144
                width: 365,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xff199ee9),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        height: 200, //144
                        width: 365,
                        padding: EdgeInsets.all(1.0),
                        child: PhotoViewGallery.builder(
                          itemCount: imageAssets.length,
                          builder: (context, index) {
                            return PhotoViewGalleryPageOptions(
                              imageProvider: AssetImage(imageAssets[index]),
                              minScale: PhotoViewComputedScale.contained * 0.8,
                              maxScale: PhotoViewComputedScale.covered * 2,
                            );
                          },
                          scrollPhysics: BouncingScrollPhysics(),
                          backgroundDecoration: BoxDecoration(
                            color: Color(0xff199ee9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          pageController: _imagecontroller,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              ///
              /////new update 22 of banner --place end
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(onTap: ()=>
                Navigator.push(context, MaterialPageRoute(builder: (_)=>catagories())),
                child: Container(
                  width: 365,
                  height: 37,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xff199ee9)),
                  //color: Color(0xff199ee9),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.5),
                        child: IconButton(
                            onPressed: () => {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const catagories();
                                    },
                                  ))
                                },
                            icon: Icon(Icons.list,
                              size: 27,
                            )),
                      ),
                      Text(
                        "CATAGORIES",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )
                    ],
                  ),
                ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: GestureDetector(onTap: ()=>
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>recomendentbooks())),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        
                        child: Container(
                          width: 5,
                          height: 20,
                          color: Color(0xff199ee9),
                          
                          
                        ),
                      ),
                      Text(
                        "RECOMENDEND",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      IconButton(
                        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>recomendentbooks())), 
                        icon: Icon(Icons.arrow_right_alt_sharp,size: 25,))
                    ],
                  ),
                  ),
                  
                ),
              ),
              Container(
              width: 365,
              height: 260,
              child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
              .collectionGroup('book')
              .limit(6)
              .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
              
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
              
                return GridView.count(
                crossAxisCount: 3,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
                  String bookId = document.id;
                  return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  color: Colors.red,
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
                  child: Container(
                  child: Image.network(
                  data["image"][0],
                  height: 100,
                  ),
                  ),
                  ),
                  ),
                  );
                },
                ).toList(),
                );
              },
              ),
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
