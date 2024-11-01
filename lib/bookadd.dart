//This is main format of add book to store
//update version will delete at the ending time.

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class BookAdd extends StatefulWidget {
  const BookAdd({Key? key}) : super(key: key);

  @override
  _BookAddState createState() => _BookAddState();
}

class _BookAddState extends State<BookAdd> {
  TextEditingController _tittle = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _section = TextEditingController();
  TextEditingController _issuedto = TextEditingController();
  TextEditingController _expiredDate = TextEditingController();

//image picker space start
  final ImagePicker _picker =
      ImagePicker(); // Create an instance of ImagePicker
  List<File> _selectedImages = []; // Store the selected images

  Future<void> _pickMultipleImagesFromGallery() async {
    final pickedImages = await _picker.pickMultiImage(
      //imageQuality: 100, // Adjust image quality as needed
      //maxHeight: 200, // Set maximum height
      //maxWidth: 200, // Set maximum width
    );

    if (pickedImages != Null) {
      setState(() {
        _selectedImages =
            pickedImages.map((Xfile) => File(Xfile.path)).toList();
      });
    }
  }

//image picker space end
//
//picked image uploaded to firebase storages -space start
  Future<List<String>> _uploadImagesToFirebase() async {
    //here added new List and <> update 12
    List<String> downloadUrls = []; //added list update 12
    try {
      for (final imageFile in _selectedImages) {
        final storage = FirebaseStorage.instance;
        final reference = storage.ref().child('images/${DateTime.now()}.jpg');
        await reference.putFile(imageFile);
        String downloadUrl = await reference
            .getDownloadURL(); //here added string variable update 12

        downloadUrls.add(downloadUrl); //this line is new 12

        Fluttertoast.showToast(
            msg: "Image upload succesfully Download URL: $downloadUrl.",
            textColor: Colors.yellow);
        //print('Image uploaded successfully. Download URL: $downloadUrl');
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something is Wrong.", textColor: Colors.yellow);
      print("Error uploading image:$e");
    }
    return downloadUrls; // here add s in last 12
  }

//picked image uploaded to firebase storages -space end
//
//here added both picked image and firebase firestore -space start
  sendbooktoDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("bookStore");

    List<String> downloadUrls =
        await _uploadImagesToFirebase(); //delleted var 12
//new update 13 to add bookId --start
    String bookId = Timestamp.now().millisecondsSinceEpoch.toString();
    //new update 17 --start
    //
    var existingBook = await _collectionRef
      .doc(currentUser!.email)
      .collection("book")
      .doc(bookId)
      .get();

  if (existingBook.exists) {
    // Book already exists, update it instead of adding a new one
    return _collectionRef
        .doc(currentUser.email)
        .collection("book")
        .doc(bookId)
        .update({
          "Tittle": _tittle.text,
          "Description": _description.text,
          "image": downloadUrls,
          "section": _section.text,
          "bookId": bookId,
          "ownerEmail": currentUser.email,//update 101 for borrow and buy
          "Tittle_lower": _tittle.text.toLowerCase(), //update 04 May
          "issuedto":_issuedto.text,
          "expiredDate": _expiredDate.text,
        })
        .then((value) => Fluttertoast.showToast(
              msg: "Updated successfully.",
              textColor: Colors.yellow,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              fontSize: 16.0,
            ))
        .catchError((error) => Fluttertoast.showToast(
            msg: "Something went wrong.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.blue,
            fontSize: 16.0,
            textColor: Colors.yellow));
  } else {
    // Book does not exist, add it
    return _collectionRef
        .doc(currentUser.email)
        .collection("book")
        .doc(bookId)
        .set({
          "Tittle": _tittle.text,
          "Description": _description.text,
          "image": downloadUrls,
          "section": _section.text,
          "bookId": bookId,
          "ownerEmail": currentUser.email, //update 101 for buy and borrow
          "Tittle_lower": _tittle.text.toLowerCase(),
          "issuedto":_issuedto.text,
          "expiredDate": _expiredDate.text, //update 04 May
        })
        .then((value) => Fluttertoast.showToast(
              msg: "Uploaded successfully.",
              textColor: Colors.yellow,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              fontSize: 16.0,
            ))
        .catchError((error) => Fluttertoast.showToast(
            msg: "Something went wrong.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.blue,
            fontSize: 16.0,
            textColor: Colors.yellow));
  }
  }
  //////here added both picked image and firebase firestore -space end
  //
  //here delete from firestore -space start

  //here delete from firestore -space start
  ///

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add book'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickMultipleImagesFromGallery,
            child: Text('Pick Images Must Be From Gallery'),
          ),
          if (_selectedImages.isNotEmpty)
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: _selectedImages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.file(
                    _selectedImages[index],
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          //FloatingActionButton(
          // onPressed: _uploadImagesToFirebase,
          //child: Icon(Icons.cloud_upload),
          //),
          //for section try start
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLength: int.fromEnvironment("defaultport", defaultValue: 30),
              controller: _section,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: "section (write all upercase)",
                hintText: "section",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => {},
              validator: (value) {
                return value!.isEmpty ? "Please Enter UserName" : null;
              },
            ),
          ),
          // for section try end
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLength: int.fromEnvironment("defaultport", defaultValue: 30),
              controller: _tittle,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: "Tittle",
                hintText: "Tittle",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => {},
              validator: (value) {
                return value!.isEmpty ? "Please Enter UserName" : null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLength: int.fromEnvironment("defaultport", defaultValue: 250),
              controller: _description,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: "Description",
                hintText: "Description",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => {},
              validator: (value) {
                return value!.isEmpty ? "Please Enter UserName" : null;
              },
            ),
          ),
          //book issue to --place start 02 june
          //
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLength: int.fromEnvironment("defaultport", defaultValue: 250),
              controller: _issuedto,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: "Issued To(Needed After Borrowed)",
                hintText: "Issued To",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => {},
              validator: (value) {
                return value!.isEmpty ? "Please Enter UserName" : null;
              },
              initialValue: _issuedto.text.isNotEmpty? _issuedto.text:null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLength: int.fromEnvironment("defaultport", defaultValue: 250),
              controller: _expiredDate,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: "Last Date of the Book borrowed.",
                hintText: "Last Date of the Book borrowed.",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => {},
              validator: (value) {
                return value!.isEmpty ? "Please Enter UserName" : null;
              },
              initialValue: _expiredDate.text.isNotEmpty?_expiredDate.text:null,
            ),
          ),
          //
          //book issue to --place end 02 june
          Container(
            width: 100,
            height: 50,
            child: FloatingActionButton(
              onPressed: () => {sendbooktoDB()},
              child: Text("Add To List"),
            ),
          ),
        ],
      ),
    );
  }
}
