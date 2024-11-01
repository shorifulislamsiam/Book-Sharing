
import 'package:bookshairing/signpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class signuppage extends StatefulWidget {
  const signuppage({super.key});

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GoogleSignIn _googleSignIn = GoogleSignIn();

signUp() async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    var authCredential = userCredential.user;
    print(authCredential!.uid);
    if (authCredential.uid.isNotEmpty) {
      Navigator.push(context, CupertinoPageRoute(builder: (_) => signpage()));
    } else {
      Fluttertoast.showToast(msg: "Something is Wrong.",textColor: Colors.yellow);
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      Fluttertoast.showToast(msg: 'The password provided is too weak.',textColor: Colors.yellow);
    } else if (e.code == 'email-already-in-use') {
      Fluttertoast.showToast(msg: 'The account already exists for that email.',textColor: Colors.yellow);
    }
  } catch (e) {
    print(e);
  }
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const signpage();
                    }));
                  },
                  icon: Icon(Icons.arrow_back_ios_new_rounded)),
              title: Text("Era Books"),
              backgroundColor: Color(0xff199ee9),
            ),
            body: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  children: [
                    const Text(
                      "Create an Account",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Icon(Icons.lock),
                  ],
                ),
              ),
              const Text("Don't worry only you can see your personal data."),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 150,
                      width: 200,
                      child: CircleAvatar(
                        child: Icon(
                          Icons.person,
                          size: 80,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 110,
                        left: 160,
                      ),
                      child: Icon(Icons.edit),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Form(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "E-mail",
                            hintText: "E-mail",
                            prefixIcon: Icon(Icons.email_outlined),
                            border: UnderlineInputBorder()),
                        onChanged: (String value) => {},
                        validator: (value) {
                          return value!.isEmpty ? "Please Enter Email" : null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password),
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
                      height: 8,
                    ),
                    Text(
                        "By signing up, you agree to our Terms ,\n Privacy Policy and Cookies Policy"),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 300,
                      child: FloatingActionButton(
                        onPressed: () => {
                          signUp()
                        },
                        backgroundColor: Colors.blue,
                        child: Text("Sign up"),
                      ),
                    )
                  ],
                ),
              )
            ]
            )
            )
            );
  }
}
