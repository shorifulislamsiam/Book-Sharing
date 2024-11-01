//This is book details page
import 'package:bookshairing/cse.dart';
import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class csebooks1 extends StatefulWidget {
  const csebooks1({super.key});

  @override
  State<csebooks1> createState() => _csebooks1State();
}

class _csebooks1State extends State<csebooks1> {

  final List<String> imageAssets = [
    'assets/os.jpg',
    'assets/os2.png',
    'assets/os3.png',
    'assets/os4.png',

    // Add more image assets as needed
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const cse();
              }));
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
        title: Text("CSE"),
        backgroundColor: Color(0xff199ee9),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text("Description About Book-",
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 300,
              width: 380,
              color: Colors.amber[50],
              child: Row( //first container of book description.
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 300,
                        width: 160,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/os.jpg",
                              height: 150,
                              width: 80,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Book: Modern Operating System."),
                            Text("Writer: Andrew S. Tanenbaum."),
                            Text("Conditiion: Old."),
                            Text("Copy Owner: Library."),
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
                              Image.asset(
                                "assets/os.jpg",
                                height: 150,
                                width: 80,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Issue to: Name"),
                              Text("Contact No: 01*********"),
                              SizedBox(height: 10,),
                              Text("Hand-Over: 4 times."),
                              Text("Rating: 4.5/5.")
                            ],
                          )),
                    ),
                  ]),
            ),
          ),
          Text("Some Picture Of Book-",
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
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
                  child: FloatingActionButton(onPressed: ()=>{},

                  backgroundColor: Colors.blue,
                  //elevation: 14.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )
                  ),
                  child: Text("Borrow It"),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15,),
                  color: Colors.blueAccent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Container(
                  height: 50,
                  width: 90,
                  
                  child: FloatingActionButton(onPressed: ()=>{},
                  backgroundColor: Colors.blue,
                  //elevation: 14.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )
                  ),
                  child: Text("Buy It"),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
