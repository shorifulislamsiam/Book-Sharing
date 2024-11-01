import 'package:bookshairing/settingslist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Notification"),
        leading: IconButton(
          onPressed: ()=>{
            Navigator.push(context, MaterialPageRoute(builder: (_)=>settingslist()))
          }, 
          icon: Icon(Icons.arrow_back_ios_new_rounded)),
        
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              
            )
          ],
        ),
      ),
    );
  }
}