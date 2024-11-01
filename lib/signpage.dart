
import 'package:bookshairing/navigatorpage.dart';
import 'package:bookshairing/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class signpage extends StatefulWidget {
  const signpage({super.key});

  @override
  State<signpage> createState() => _signpageState();
}

class _signpageState extends State<signpage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
////google sign in directly --place start 03 may
///
final GoogleSignIn googleSignIn = GoogleSignIn();
Future<UserCredential?> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
///
///google sign in directly --place end 03 may


//// meta sign in directly -- place start 03 may
///
Future<UserCredential?> signInWithFacebook() async {
  final LoginResult result = await FacebookAuth.instance.login();

  if (result.status == LoginStatus.success) {
    final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } else {
    print('Facebook sign-in failed');
    return null;
  }
}
///
///meta sign in directly -- place end 03 may


  //signed user can directly open the navigator page update 14 --place start
  //
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserAuthentication();
    });
  }

  _checkUserAuthentication() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    if (user != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => navigatorpage()));
    }
  }
  //
  // signed user can directly open the navigator page update 14 --place start

  signIn() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      var authCredential = userCredential.user;
      print(authCredential!.uid);

      if (authCredential.uid.isNotEmpty) {
        Navigator.push(
            context, CupertinoPageRoute(builder: (_) => navigatorpage()));
      } else {
        Fluttertoast.showToast(
            msg: "Something is Wrong",
            textColor: Colors.yellow);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "No User Found For This Email",
            textColor: Colors.yellow);
      } else if (e.code == 'wrong-password') {
        
        Fluttertoast.showToast(
            msg: "Wrong Password Provided For That User",
            textColor: Colors.yellow);
      }
    } catch (e) {
      print(e);
    }
  }

// for easy login purpose if not worked then it can be removed
  void splaceController() {
    if (AuthCredential != true) {
      Navigator.push(
          context, CupertinoPageRoute(builder: (_) => navigatorpage()));
      //remove navigator page update 14
    }
  }
  /////forget password function --start 28 april
  Future<void> resetPassword(String email) async {
  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);}

  /////forget password function --end 28 april

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset("assets/students.jpg"),
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Hello- good morning",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ))
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Column(
              children: [
                Form(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "E-mail",
                            hintText: "E-mail",
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder()),
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
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value) => {},
                        validator: (value) {
                          return value!.isEmpty ? "Please Enter Email" : null;
                        },
                      ),
                    ),
                  ],
                )
                ),
                SizedBox(
                  height: 4,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue, minimumSize: Size(330, 40)),
                    onPressed: () => {signIn()},
                    child: Text(
                      "Sign-In",
                      style: TextStyle(color: Colors.black),
                    )),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      signInWithGoogle().then((UserCredential? userCredential) {
                        if (userCredential != null) {
                          Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (_) => navigatorpage()),
                          );
                        } else {
                          Fluttertoast.showToast(
                          msg: "Something is Wrong",
                          textColor: Colors.yellow,
                          );
                        }
                      });
                    },
                    label: Image.asset(
                      "assets/googlebutton.png",
                      height: 70,
                      width: 290,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      signInWithFacebook().then((UserCredential? userCredential) {
                        if (userCredential != null) {
                          Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (_) => navigatorpage()),
                          );
                        } 
                        else {
                          Fluttertoast.showToast(
                          msg: "Something is Wrong",
                          textColor: Colors.yellow,
                          );
                        }
                      });
                    },
                    label: Image.asset(
                      "assets/facebookbutton.png",
                      height: 40,
                      width: 190,
                    ),
                  ),
                ),
                //forget password--start 28 april

                Container(
                  child: ElevatedButton(
                    onPressed: () async {
                    try {
                    await resetPassword(_emailController.text);
                    Fluttertoast.showToast(
                    msg: "Password reset email sent",
                    textColor: Colors.green,
                    );
                    } catch (e) {
                      Fluttertoast.showToast(
                      msg: "Error occurred while sending password reset email",
                      textColor: Colors.red,
                    );
                    }
                    },
                  child: Text(
                   "Forget Password?",
                     style: TextStyle(fontSize: 10, color: Colors.red),
                  ),
                  ),
                ),


                //forget password --end 28 april
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    children: [
                      Text(
                        "Don't have an account. ",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      Container(
                        child: ElevatedButton(
                          onPressed: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return const signuppage();
                            }))
                          },
                          child: Text(
                            "Sign-up?",
                            style: TextStyle(fontSize: 20, color: Colors.red),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
