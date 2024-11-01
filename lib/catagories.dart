import 'dart:ui';
import 'package:bookshairing/bbabooklist.dart';
import 'package:bookshairing/csebooklist.dart';
import 'package:bookshairing/englishbooklist.dart';
import 'package:bookshairing/navigatorpage.dart';
import 'package:bookshairing/nondepartmentbook.dart';
import 'package:bookshairing/textile.dart';
import 'package:flutter/material.dart';

class catagories extends StatefulWidget {
  const catagories({super.key});

  @override
  State<catagories> createState() => _catagoriesState();
}

class _catagoriesState extends State<catagories> {
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
        title: Text("CATAGORIES"),
        backgroundColor: Color(0xff199ee9),
      ),
      body: Center(
        child: Container(
          height: 550,
          width: 330,
          decoration: BoxDecoration(
                        borderRadius:
                          BorderRadius.only(
                            topLeft: Radius.elliptical(280, 200),
                            topRight: Radius.elliptical(150, 0),
                            bottomRight: Radius.elliptical(280, 150),
                            bottomLeft: Radius.elliptical(280, 150)
                          ),
                        
                          gradient: LinearGradient(
                          colors: [Colors.blue,Colors.blue.shade200],

                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          ),
                  
                      ),
          //color: Colors.amber,
          child: Column(
            children: [
              SizedBox(height: 80,),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Container(
                  width: 250,
                  child: FloatingActionButton(
                    onPressed: () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const csebooklist();
                      }))
                    },
                    child: Text("CSE"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 250,
                  child: FloatingActionButton(
                    
                    onPressed: () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const textile();
                      }))
                    },
                    
                    child: Text("TEXTILE"),
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 250,
                  child: FloatingActionButton(
                    onPressed: () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const bbabooklist();
                      }))
                    },
                    child: Text("BBA"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 250,
                  child: FloatingActionButton(
                    onPressed: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>englishbooklist()))
                    },
                    child: Text("ENGLISH"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 250,
                  child: FloatingActionButton(
                    onPressed: () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const nondepartmentbook();
                      }))
                    },
                    child: Text("NON-DEPARTMENT"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
