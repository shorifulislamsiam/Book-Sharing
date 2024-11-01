//this was too try format it will delete.

import 'dart:typed_data';
import 'package:bookshairing/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class addbook extends StatefulWidget { 
  const addbook({super.key});

  @override
  State<addbook> createState() => _booklistState();
}

class _booklistState extends State<addbook> {
  TextEditingController _section = TextEditingController();
  TextEditingController _description = TextEditingController();

  sendbookdatatoDB() async {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    var _currentuser = _auth.currentUser;


    CollectionReference _collectionref =
        FirebaseFirestore.instance.collection("books");
    return _collectionref
        .doc(_currentuser!.email)
        .set({
          "section": _section.text,
          "description": _description.text,
        })
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => homepage())))
        .catchError((error) => print("something is wrong."));
  }

  Uint8List? _imageBytes;

  Future<void> pickImage() async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (_file != null) {
      setState(() async {
        _imageBytes = await _file.readAsBytes();
      });
    } else {
      print("No Image Selected");
    }
  }

  Future<void> uploadImageToFirebase() async {
    try {
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child("images/${DateTime.now().millisecondsSinceEpoch}.jpg");

      await storageReference.putData(_imageBytes!);

      String imageUrl = await storageReference.getDownloadURL();
      print("Image uploaded to Firebase Storage: $imageUrl");

      // Now you can save imageUrl to Firebase Firestore or Realtime Database if needed.
    } catch (e) {
      print("Error uploading image to Firebase Storage: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _section,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "section",
                      hintText: "section",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => {},
                    validator: (value) {
                      return value!.isEmpty ? "Please Enter UserName" : null;
                    },
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLength:
                        int.fromEnvironment("defaultport", defaultValue: 100),
                    controller: _description,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: "description",
                      hintText: "description",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => {},
                    validator: (value) {
                      return value!.isEmpty ? "Please Enter UserName" : null;
                    },
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  child: Form(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            child: Text(
                              "pick the image",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () => {pickImage()}),
                      ),

                      //for better uderstand the gap
                      Center(
                        //for first image collection
                        child: _imageBytes != null
                            ? Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: MemoryImage(_imageBytes!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Text("No image selected"),
                      ),
                      FloatingActionButton(
                        onPressed: pickImage,
                        child: Icon(Icons.photo),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            child: Text(
                              "pick the image",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () => {pickImage()}),
                      ),
                    ],
                  )),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  width: 300,
                  child: FloatingActionButton(
                    onPressed: uploadImageToFirebase,
                    backgroundColor: Colors.blue,
                    child: Text("Submit"),
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
