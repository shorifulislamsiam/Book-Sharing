import 'package:bookshairing/profilepage.dart';
import 'package:flutter/material.dart';

class borrowed extends StatefulWidget {
  const borrowed({super.key});

  @override
  State<borrowed> createState() => _borrowedState();
}

class _borrowedState extends State<borrowed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const profilepage();
              }));
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
        title: Text("Borrowed Books"),
        backgroundColor: Color(0xff199ee9),
      ),
      body: Center(child: Text("Borrowed item")),
    );
  }
}