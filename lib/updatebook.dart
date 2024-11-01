//update page for book

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateBookPage extends StatefulWidget {
  final Map<String, dynamic> data;
  final String bookId; 
  const UpdateBookPage({Key? key, required this.data, required this.bookId}): super(key: key);


  @override
  _UpdateBookPageState createState() => _UpdateBookPageState();
}

class _UpdateBookPageState extends State<UpdateBookPage> {
  TextEditingController? _tittle;
  TextEditingController? _description;
  TextEditingController? _section;

  @override
      void initState() {
        super.initState();
        _tittle = TextEditingController(text: widget.data['Tittle']);
        _description = TextEditingController(text: widget.data['Description']);
        _section = TextEditingController(text: widget.data['Section']);
      }

  Future<void> updateBook(
      String bookId, Map<String, dynamic> updatedData) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("bookStore");

    try {
      await _collectionRef
          .doc(currentUser!.email)
          .collection("book")
          .doc(bookId)
          .update(updatedData);
      Fluttertoast.showToast(
        msg: "Updated successfully.",
        textColor: Colors.yellow,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        fontSize: 16.0,
      );
    } catch (error) {
      Fluttertoast.showToast(
          msg: "Something went wrong.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.blue,
          fontSize: 16.0,
          textColor: Colors.yellow);
    }
  }

  void handleUpdate() {
    print("Handleupdate called");
    if (widget.data.containsKey('bookId')) {
    if (_tittle == null || _description == null || _section == null) {
      return; 
    }
      final String tittle = _tittle?.text ?? widget.data["Tittle"];
      final String description =
          _description?.text ?? widget.data["Description"];
      final String section = _section?.text ?? widget.data["Section"];
      Map<String, dynamic> updatedData = {
        "Tittle": tittle, 
        "Description": description, 
        "Section": section, 
      };
      updateBook(widget.bookId, updatedData); 
    } else {
      print('No bookId found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _tittle,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _description,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _section,
              decoration: InputDecoration(labelText: 'Section (all uppercase)'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: handleUpdate,
              child: Text('Update Book'),
            ),
          ],
        ),
      ),
    );
  }
}
