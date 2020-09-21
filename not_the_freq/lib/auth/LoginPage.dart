
import 'dart:ui';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import "package:flutter/cupertino.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:not_the_freq/auth/SignupPage.dart';
import 'package:not_the_freq/ui/animatedLoader.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  Future<void> _userNotFound() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
          backgroundColor: Colors.grey.shade900,
          title: Text('No user was found with that email id !! ',
              style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ListBody(
              children: <Widget>[
                Text('please check your email and try again',
                    style: TextStyle(color: Colors.white)),
                SizedBox(height: 50),
                Text('click OK to continue',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK', style: TextStyle(color: shade1)),
              onPressed: () {
                // passwordController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  // FirebaseMessaging _fcm = FirebaseMessaging();
  //  _getAccountToken() async{
  //   String token;
  //   User user = await FirebaseAuth.instance.currentUser;
  //   String tokken = await _fcm.getToken();
  //   if(token == null){
  //     print(token);
  //   }
  // }

  Future<void> _invalidEmail() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
          backgroundColor: Colors.grey.shade900,
          title:
              Text('Invalid Email Id!!', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'The email address you entered is invalid',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 50),
                Text(
                  'Please try again',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Try Again',
                style: TextStyle(color: shade1),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _wrongPassword() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
          backgroundColor: Colors.grey.shade900,
          title: Text('Email and password does not match!!',
              style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please try again', style: TextStyle(color: Colors.white)),
                SizedBox(height: 50),
                Text('press continue to retry...',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Continue', style: TextStyle(color: shade1)),
              onPressed: () {
              
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
      backgroundColor: Colors.black,
      content: new Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
          SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  "Loading",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogs(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Invalid Credentials"),
      content: Text("Email Id and Password doesnot match"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



  TextEditingController emailController;
  TextEditingController passwordController;
  String email;
  String pass;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  VideoPlayerController _controller;
  void initState() {
    super.initState();
    // Pointing the video controller to our local asset.
    _controller = VideoPlayerController.asset("assets/videos/vid1.mp4")
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
  }

  Route _homeRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => AnimatedLoader(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.easeIn;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
              position: animation.drive(tween), child: child);
        });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool x = false;
  bool y = false;
  Color shade1 = Color(0xFF7447d8);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size?.width ?? 0,
                  height: _controller.value.size?.height ?? 0,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            Form(
              key: _loginFormKey,
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 200,
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(top: 100),
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Container(
                                height: 100,
                                width: 300,
                                margin: EdgeInsets.only(top: 30),
                                decoration: BoxDecoration(
                                    color: shade1,
                                    borderRadius: BorderRadius.circular(40),
                                    border:
                                        Border.all(color: shade1, width: 2))),
                            Container(
                              height: 400,
                              width: 400,
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(150)),
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.03,
                                left: MediaQuery.of(context).size.width * 0.05,
                                right:
                                    MediaQuery.of(context).size.width * 0.05),
                            child: TextFormField(
                              autocorrect: true,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (!(regex.hasMatch(value) &&
                                    value.isNotEmpty)) {
                                  setState(() {
                                    x = true;
                                  });
                                  return null;
                                } else {
                                  setState(() {
                                    x = false;
                                  });
                                  return null;
                                }
                              },
                              onSaved: (value) => email = value.trim(),
                              obscureText: false,
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                              autofocus: false,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.red),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(150)),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 0.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(150)),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 0.0),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  hintText: "Enter your Email ID",
                                  hintStyle: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          top: 3,
                        ),
                        child: Visibility(
                          child: Text(
                            "Email cannot be emty",
                            style: TextStyle(color: Colors.red),
                          ),
                          visible: x,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(150),
                          ),
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.04,
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.05),
                          child: TextFormField(
                            enabled: true,
                            autocorrect: true,
                            controller: passwordController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.length >= 6 && value.isNotEmpty) {
                                setState(() {
                                  y = false;
                                });
                                return null;
                              } else {
                                setState(() {
                                  y = true;
                                });
                                return null;
                              }
                            },
                            onSaved: (value) => pass = value.trim(),
                            obscureText: true,
                            onChanged: (val) {
                              setState(() => pass = val);
                            },
                            autofocus: false,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                // errorText: "Wrong Pass Cyuka Blyat",

                                border: InputBorder.none,
                                errorStyle: TextStyle(color: Colors.red),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(150)),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 0.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(150)),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 0.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.security,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                hintText: "Enter your password",
                                hintStyle: TextStyle(
                                    color: Colors.white, fontSize: 15),
                                labelText: "Password",
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          top: 3,
                        ),
                        child: Visibility(
                          child: Text(
                            "Password cannot be empty",
                            style: TextStyle(color: Colors.red),
                          ),
                          visible: y,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.049,
                            left: MediaQuery.of(context).size.width * 0.65),
                        child: RichText(
                            text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("hheheeheee");
                            },
                          text: "Forgot Password ?",
                          style: TextStyle(
                              color: shade1,
                              fontSize: 13,
                              fontWeight: FontWeight.w900),
                        )),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.02,
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: RaisedButton(
                          color: shade1,
                          onPressed: () async {
                            if (_loginFormKey.currentState.validate()) {
                              try {
                                showAlertDialog(context);
                                
                                SharedPreferences prefs = await SharedPreferences.getInstance();                             
                                Navigator.of(context).pop();
                                 await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                  email: email,
                                  password: pass,
                                )
                                  .then((value) { 
                                  prefs.setString('email', FirebaseAuth.instance.currentUser.email);
                                  Navigator.pushAndRemoveUntil(
                                      context, _homeRoute(), (_) => false);
                                    // _getAccountToken();
                                  print('user found with email: ' +
                                      value.user.email);
                                     
                                  return value;
                                });
                              } on FirebaseAuthException catch (e) {
                                if (e.code == "user-not-found") {
                                  _userNotFound();
                                  print("user not found ");
                                } else if (e.code == 'invalid-email') {
                                  _invalidEmail();
                                  print('invalid email address');
                                } else if (e.code == 'wrong-password') {
                                  _wrongPassword();
                                  print('invalid password try again');
                                }
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (_) => FunkyOverlay(),
                              );
                            }
                          },
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                          ),
                          elevation: 25,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.03,
                            left: MediaQuery.of(context).size.width * 0.05),
                        child: RichText(
                            text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // showAlertDialog(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupPage()));
                            },
                          text: "Don't have an account?? Sign up",
                          style: TextStyle(
                              color: shade1,
                              fontSize: 13,
                              fontWeight: FontWeight.w900),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FunkyOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.grey.shade900,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text(
                "Email and password cannot be empty!",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
