import 'package:bookshairing/profilepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class userdata extends StatefulWidget {
  const userdata({super.key});

  @override
  State<userdata> createState() => _userdataState();
}

class _userdataState extends State<userdata> {
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _contactnumber = TextEditingController();
  TextEditingController _semester = TextEditingController();
  List<String> gender = [
    "Male",
    "Female",
  ];

  sendusertoDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("User_form_data");
    return _collectionRef
        .doc(currentUser!.email)
        .set({
          "firstname": _firstname.text,
          "lastname": _lastname.text,
          "gender": _gender.text,
          "contactnumber": _contactnumber.text,
          "semester": _semester.text,
        })
        .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>profilepage())))
        .catchError((error) => print("something is wrong."));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Form(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: _firstname,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "firstname",
                  hintText: "firstname",
                  prefixIcon: Icon(Icons.edit_outlined),
                  border: UnderlineInputBorder()),
              onChanged: (String value) => {},
              validator: (value) {
                return value!.isEmpty ? "Please Enter UserName" : null;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: _lastname,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "lastname",
                  hintText: "lastname",
                  prefixIcon: Icon(Icons.edit_outlined),
                  border: UnderlineInputBorder()),
              onChanged: (String value) => {},
              validator: (value) {
                return value!.isEmpty ? "Please Enter UserName" : null;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(hintText: "Gender"),
              items: gender.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: new Text(value),
                  onTap: () => {
                    setState(() {
                      _gender.text = value;
                    })
                  },
                );
              }).toList(),
              onChanged: (_) => {},
            ),
          ), 
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: _contactnumber,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "ContactNumber",
                  hintText: "Contact Number",
                  prefixIcon: Icon(Icons.phone_outlined),
                  border: UnderlineInputBorder(),
                  hoverColor: Colors.black),
              onChanged: (String value) => {},
              validator: (value) {
                return value!.isEmpty ? "Please Enter ContactNumber" : null;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: _semester,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Semester",
                hintText: "Semester",
                border: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue)),
              ),
              onChanged: (String value) => {},
              validator: (value) {
                return value!.isEmpty ? "Please Enter Email" : null;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      )),
      SizedBox(
        height: 8,
      ),
      Container(
        width: 260,
        height: 50,
        child: FloatingActionButton(
          onPressed: () => {sendusertoDB()},
          backgroundColor: Colors.blue,
          child: Text("Register"),
        ),
      ),
    ]));
  }
}
