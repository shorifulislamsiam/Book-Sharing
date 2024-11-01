import 'package:bookshairing/signpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBwXOKzUyYES6OMk47v4kh2E4-FfElmZho",
          appId: "1:283332584246:android:26f1a59c29ac0c33d74997",
          messagingSenderId: "283332584246",
          projectId: "booksharing2-f4e1f",
          storageBucket: 'booksharing2-f4e1f.appspot.com',
        ),
    );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const home(),
    );
  }
}

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 410,
                    height: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.elliptical(0, 50))),
                    child: Image.asset("assets/book-lover.png")),
              ),
              Center(
                child: Container(
                  width: 310,
                  height: 50,
                  child: Center(
                    child: const Text(
                      "Book Share Hub",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 412,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(280, 110),
                        topRight: Radius.elliptical(150, -50),
                      ),
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.blue.shade200],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Let's keep",
                          style: TextStyle(fontSize: 40, color: Colors.black),
                        ),
                        const Text(
                          "Regarding Together",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        const Text(
                          " -Read & Explore- ",
                          style: TextStyle(fontSize: 25),
                        ),
                        Center(
                          child: IconButton(
                            onPressed: () => {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return const signpage();
                              }))
                            },
                            icon: const Icon(Icons.fingerprint,
                            size: 35,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
