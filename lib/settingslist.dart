import 'package:bookshairing/main.dart';
import 'package:bookshairing/navigatorpage.dart';
import 'package:bookshairing/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class settingslist extends StatefulWidget {
  const settingslist({super.key});

  @override
  State<settingslist> createState() => _settingslistState();
}

class _settingslistState extends State<settingslist> {
  signOut() async {
    
    await FirebaseAuth.instance.signOut();
    Navigator.push(context, CupertinoPageRoute(builder: (_) => home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const navigatorpage();
              }
              )
              );
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
        title: Text("Settings"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: 45,
            ),
          )
        ],
        backgroundColor: Color(0xff199ee9),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.lightBlue.shade100,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Borrow Request Notification",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        onPressed: () =>{
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>notification()))
                        },
                        icon: Icon(
                          Icons.arrow_right_alt_sharp,
                          size: 40,
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.lightBlue.shade100,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Wish List Notification",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_right_alt_sharp,
                          size: 40,
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 0.1,
            ),
            
            SizedBox(
              height: 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.lightBlue.shade100,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "App Language",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_right_alt_sharp,
                          size: 40,
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.lightBlue.shade100,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Request For Books to Library",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_right_alt_sharp,
                          size: 40,
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.lightBlue.shade100,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Privacy & Security",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_right_alt_sharp,
                          size: 40,
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.lightBlue.shade100,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Help & others",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_right_alt_sharp,
                          size: 40,
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.lightBlue.shade100,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Invite Friends",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_right_alt_sharp,
                          size: 40,
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.lightBlue.shade100,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Log-Out",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        onPressed: () => {signOut()},
                        icon: Icon(
                          Icons.logout_rounded,
                          size: 40,
                        ))
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
