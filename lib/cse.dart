
import 'package:bookshairing/catagories.dart';
import 'package:bookshairing/csebooks1.dart';
import 'package:flutter/material.dart';

class cse extends StatefulWidget {
  const cse({super.key});

  @override
  State<cse> createState() => _nondepartmentState();
}

class _nondepartmentState extends State<cse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const catagories();
              }));
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
        title: Text("CSE"),
        backgroundColor: Color(0xff199ee9),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(width: 0.8),
                    ),
                    hintText: "Search For Books...",
                    suffixIcon:
                        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                  ),
                ),
              ),

              Container(
                // main container.
                height: 140,
                width: 380,
                //color: Colors.blue[300],
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[300]),
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/java.jpg",
                          height: 150,
                          width: 80,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "Java",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text("Writer: Kathy Siera."),
                          Text("Condition: New."),
                          Container(
                            width: 260,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.favorite_outlined,
                                  color: Colors.red,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 25,
                                    child: FloatingActionButton(
                                      onPressed: () {},
                                      child: Text("View It"),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                // main container.
                height: 140,
                width: 380,
                //color: Colors.blue[300],
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[300]),
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/os.jpg",
                          height: 150,
                          width: 80,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "Modern Operati...",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text("Writer: Andrew S. Tanenbaum."),
                          Text("Condition: New."),
                          Container(
                            width: 260,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.favorite_outlined,
                                  color: Colors.red,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 25,
                                    child: FloatingActionButton(
                                      onPressed: () => {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return const csebooks1();
                                        }))
                                      },
                                      child: Text("View It"),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                // New book container.
                // main container.
                height: 140,
                width: 380,
                //color: Colors.blue[300],
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[300]),
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/pythonbook.jpg",
                          height: 150,
                          width: 80,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "Python Coding",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text("Writer: Jason Latorilla."),
                          Text("Condition: Old."),
                          Container(
                            width: 260,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.favorite_outlined,
                                  color: Colors.red,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 25,
                                    child: FloatingActionButton(
                                      onPressed: () {},
                                      child: Text("View It"),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
