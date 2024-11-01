//this is try version do not need but for backup and need to delete

import 'package:bookshairing/navigatorpage.dart';
import 'package:flutter/material.dart';

class recomendend extends StatefulWidget {
  const recomendend({super.key});

  @override
  State<recomendend> createState() => _recomendendState();
}

class _recomendendState extends State<recomendend> {
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(width: 0.8),
                  ),
                  hintText: "Search For Books...",
                  suffixIcon:
                      IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
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
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text("Writer: Shorotchandrya Chottopadday."),
                          Text("Condition: New."),
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
                                      onPressed: () {},
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
            
          ],
        ),
      ),
    );
  }
}
