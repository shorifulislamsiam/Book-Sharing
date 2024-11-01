//this is for front end template

import 'package:bookshairing/catagories.dart';
import 'package:flutter/material.dart';

class nondepartment extends StatefulWidget {
  const nondepartment({super.key});

  @override
  State<nondepartment> createState() => _nondepartmentState();
}

class _nondepartmentState extends State<nondepartment> {
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
          title: Text("NON-DEPARTMENTAL BOOKS"),
          backgroundColor: Color(0xff199ee9),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(width: 0.8),
                      ),
                      hintText: "Search For Books...",
                      suffixIcon: IconButton(
                          onPressed: () {}, icon: Icon(Icons.search)),
                    ),
                  ),
                ),
                Container(
                  height: 140,
                  width: 380,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[300]),
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/grihodaho.jpg",
                            height: 150,
                            width: 80,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "Gridohao",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("Writer: Shorotchandrya Chottopadday."),
                            Text("Condition: New."),
                            Container(
                              width: 260,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.favorite_outlined,color: Colors.red,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 25,

                                      child: FloatingActionButton(onPressed: (){},
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
                ),
                SizedBox(height: 5,),
                Container(
                  // main container.
                  height: 140,
                  width: 380,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[300]),
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/titasektinodirnam.jpg",
                            height: 150,
                            width: 80,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "Titas Ekti Nodir Nam",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("Writer: Odoito Mollobormon."),
                            Text("Condition: New."),
                            Container(
                              width: 260,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.favorite_outlined,color: Colors.red,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 25,

                                      child: FloatingActionButton(onPressed: (){},
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
                ),
                SizedBox(height: 5,),
                Container(
                  // main container.
                  height: 140,
                  width: 380,
                  //color: Colors.blue[300],
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[300]),
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/himusomogro.jpg",
                            height: 150,
                            width: 80,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "Himu Somogro",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("Writer: Humaion Ahmed."),
                            Text("Condition: Old."),
                            Container(
                              width: 260,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.favorite_outlined,color: Colors.red,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 25,

                                      child: FloatingActionButton(onPressed: (){},
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
                ),
                SizedBox(height: 5,),
                Container(
                  // main container.
                  height: 140,
                  width: 380,
                  //color: Colors.blue[300],
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[300]),
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/rajnitir50bochor.jpg",
                            height: 150,
                            width: 80,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "Amar Dekha Rajnit..",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("Writer: Abul Monsur Ahmed."),
                            Text("Condition: New."),
                            Container(
                              width: 260,
                              
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.favorite_outlined,color: Colors.red,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 25,

                                      child: FloatingActionButton(onPressed: (){},
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
                ),
                SizedBox(height: 5,),
                 
              ],
            ),
          ),
        ),
    );
  }
}