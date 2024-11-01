// try to fetch book details page

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';

class bookdescription extends StatefulWidget {
  final Map<String, dynamic> data;
  final String bookId;
  const bookdescription({
    Key? key,
    required this.data,
    required this.bookId,
  }) : super(key: key);

  @override
  State<bookdescription> createState() => bookdescriptionState();
}

class bookdescriptionState extends State<bookdescription> {
  //textediting controller update version 13 --start
  //
  TextEditingController? _tittle;
  TextEditingController? _description;
  TextEditingController? _section;
  TextEditingController? _issuedto;
  TextEditingController? _expiredDate;
  String? ownerEmail; //update 25
  //
  //textediting controller update version 13 --end
  //List<Map<String, dynamic>> books = []; //update 14
  //update 17- --start
  //
  @override
  void initState() {
    super.initState();
    _tittle = TextEditingController(text: widget.data['Tittle']);
    _description = TextEditingController(text: widget.data['Description']);
    _section = TextEditingController(text: widget.data['section']);
    _issuedto = TextEditingController(text: widget.data["issuedto"]);
    _expiredDate = TextEditingController(text: widget.data["expiredDate"]);

    // Fetch owner's email when the widget initializes update25 --start
    getBookOwnerEmail(widget.bookId).then((email) {
      setState(() {
        ownerEmail = email;
        print("owners email: $ownerEmail");
      });
    }).catchError((error) {
      print("Error fetching owner's email:$error");
    }); //update 25 --end
  }

  //
//update 17 --end
  //delete button space start
  Future<bool?> deleteBook(String bookId) async {
    print("Deleting book wit bookId:$bookId");
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("bookStore");

    try {
      await _collectionRef
          .doc(currentUser!.email) //--currentUser!.email
          .collection("book")
          .doc(bookId)
          .delete();
      Fluttertoast.showToast(
        msg: "Deleted successfully.",
        textColor: Colors.yellow,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        fontSize: 16.0,
      );
      //update 14 start
      //
      setState(() {
        //widget.data.remove(bookId);
        //books.removeWhere((book) => book['bookId'] == bookId);
        widget.data.removeWhere((key, value) => key == bookId);
      });
      //
      //update 14 end
      return true;
    } catch (error) {
      Fluttertoast.showToast(
          msg: "Something went wrong.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.blue,
          fontSize: 16.0,
          textColor: Colors.yellow);
      return false;
    }
  }

  //delete button space end
  //
  //
  //update book space start
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
      if (_tittle == null ||
          _description == null ||
          _section == null ||
          _issuedto == null ||
          _expiredDate == null) {
        return; // Controllers not properly initialized, exit function
      }

      final String tittle = _tittle?.text ?? widget.data["Tittle"];
      final String description =
          _description?.text ?? widget.data["Description"];
      final String section = _section?.text ?? widget.data["section"];
      final String issuedto = _issuedto?.text ?? widget.data["issuedto"];
      final String expiredDate =
          _expiredDate?.text ?? widget.data["expiredDate"];

      Map<String, dynamic> updatedData = {
        "Tittle": tittle, 
        "Description": description,
        "section": section,
        "Tittle_lower": tittle.toLowerCase(), //new update 04 May
        "issuedto": issuedto,
        "expiredDate":expiredDate,
      };
      buildForm();
      updateBook(widget.bookId, updatedData); // update 14
    } else {
      print('No bookId found');
    }
  }

//update 17 --start
  Widget buildForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _tittle,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _description,
            decoration: InputDecoration(
              labelText: 'Description',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _section,
            decoration: InputDecoration(
              labelText: 'section',
            ),
          ),
        ),
        //book issue to --place start 02 june
        //
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _issuedto,
            decoration: InputDecoration(
              labelText: 'issue to',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _expiredDate,
            decoration: InputDecoration(
              labelText: 'expiredate',
            ),
          ),
        ),
        //
        //book issue to --place end 02 june
        FloatingActionButton(
          onPressed: handleUpdate,
          child: Icon(Icons.save),
        ),
        //issue to 28 may update

        //
      ],
    );
  }
  //update 17 --end
  //update book space end

  ///send message of borrow and buy update 25 --place start

  /////to get owner email --place start

  Future<String> getBookOwnerEmail(String bookId) async {
    DocumentSnapshot bookSnapshot = await FirebaseFirestore.instance
        .collection("bookStore")
        .doc(widget.data[
            'ownerEmail']) // Use owner's email stored in the book document
        .collection("book")
        .doc(widget.bookId) //bookId
        .get();

    if (bookSnapshot.exists) {
      return bookSnapshot.get("ownerEmail");
    } else {
      print("Book does not have an owners");
      // Handle the case where the book doesn't exist or doesn't have an owner
      return "";
    }
  }

  /////to get owner email --place end
  Future<void> sendEmail(String email, String subject, String body) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    try {
      await launch(emailUri.toString());
    } catch (e) {
      throw 'Could not launch $emailUri';
    }
  }

  /// create handler for borrow and buy --place start
  void handleBorrow() {
    if (ownerEmail != null && ownerEmail!.isNotEmpty) {
      print("Owner's email:$ownerEmail");
      sendEmail(ownerEmail!, "Book Borrow Request",
          "A user wants to borrow your book: ${widget.data["Tittle"]}. Please contact them for further details.");
      print("successfully send");
      Fluttertoast.showToast(
          msg: "Successfully send", textColor: Colors.yellow);
    } else {
      // Handle the case where owner's email
      print("Owners email is not available");
      Fluttertoast.showToast(
          msg: "Owners email is not available", textColor: Colors.yellow);
      // is not available
    }
  }

//
  void handleBuy() {
    if (ownerEmail != null && ownerEmail!.isNotEmpty) {
      print("owner's email:$ownerEmail");
      sendEmail(ownerEmail!, "Book Purchase Request",
          "A user wants to buy your book: ${widget.data["Tittle"]}");
      Fluttertoast.showToast(
          msg:
              "This Function is Not Available At The Moment", //Owners email is not available--after success it will vise-varsa
          textColor: Colors.yellow);
    } else {
      // Handle the case where owner's email is not available
      print("Owners email is not available");
      Fluttertoast.showToast(
          msg:
              "This Function is Not Available At The Moment", //after success it will vise-varsa
          textColor: Colors.yellow);
    }
  }

  ///create handler for borrow and buy --place end
  ///update issued to --place start 28 May

  ///update issued to --place end 28 May

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded)),
          title: Text(""),
          backgroundColor: Color(0xff199ee9),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //for update and delete button -space start

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: 120,
                        child: FloatingActionButton(
                          onPressed: () => {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: buildForm(),
                                  );
                                })
                          },
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          )),
                          child: Text("Update"),
                        ),
                      ),
                      
                      Container(
                        height: 50,
                        width: 120,
                        child: FloatingActionButton(
                          onPressed: () => {
                            if (widget.data.containsKey('bookId'))
                              {
                                deleteBook(widget
                                        .bookId)
                                    .then((success) {
                                  if (success == true) {
                                    print('Book deleted successfully');
                                  } else {
                                    print('Failed to delete book');
                                  }
                                })
                              }
                            else
                              {print('No bookId found')}
                          },

                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          )),
                          child: Text("Delete"),
                        ),
                      ),
                    ],
                  ),
                ),

                //for update and delete button -space end

                SizedBox(
                  height: 10,
                ),
                Text(
                  "Description About Book-",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 300,
                    width: 380,
                    color: Colors.amber[50],
                    child: Row(
                        //first container of book description.
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 300,
                              width: 160,
                              child: Column(
                                children: [
                                  Image.network(
                                    widget.data["image"][0],
                                    height: 150,
                                    width: 80,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  
                                  Text(widget.data["Description"]),
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
                                    Image.network(
                                      widget.data["image"][0],
                                      height: 150,
                                      width: 80,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    
                                  ],
                                )),
                          ),
                        ]),
                  ),
                ),
                Text(
                  "Some Picture Of Book-",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
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
                            itemCount: widget.data["image"].length, //.length
                            builder: (context, index) {
                              return PhotoViewGalleryPageOptions(
                                imageProvider:
                                    //FileImage(widget._selectedImages[index]),
                                    NetworkImage(
                                        widget.data["image"][index]), //[index]
                                minScale:
                                    PhotoViewComputedScale.contained * 0.8,
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
                SizedBox(
                  height: 5,
                ),
                //issued to update 26 May --start place
                Container(
                  child: Column(
                    children: [
                      Text(
                        "This Book is Issued To- " +
                            (widget.data["issuedto"] ?? "No One"),
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Expired Date- " +
                            (widget.data["expiredDate"] ?? "None"),
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
                //issued to update 26 May --end place
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Container(
                        height: 50,
                        width: 90,
                        child: FloatingActionButton(
                          onPressed: () => handleBorrow(), //update 25

                          backgroundColor: Colors.blue,
                          //elevation: 14.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          )),
                          child: Text("Borrow It"),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                        color: Colors.blueAccent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 35),
                      child: Container(
                        height: 50,
                        width: 90,
                        child: FloatingActionButton(
                          onPressed: () => handleBuy(),
                          backgroundColor: Colors.blue,
                          //elevation: 14.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          )),
                          child: Text("Buy It"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
