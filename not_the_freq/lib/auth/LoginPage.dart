import"package:flutter/cupertino.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:not_the_freq/auth/SignupPage.dart';
import 'package:not_the_freq/ui/HomeScreen.dart';
import 'package:video_player/video_player.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width:  200,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(top: 100),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Container(
                            height: 100,
                              width: 300,
                            margin: EdgeInsets.only(top:30),
                            decoration: BoxDecoration(
                              color: Colors.green.shade900,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: Colors.green.shade900,
                                width: 2
                              )
                            )
                          ),
                          Container(
                            height: 400,
                            width: 400,
                            margin: EdgeInsets.only(left: 10),
                            child: Text("Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.10,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Container(
                      decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(150)
                      ),

                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.03,
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.05),
                          child: TextFormField(
                            autocorrect: true,
                            // controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              Pattern pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = new RegExp(pattern);
                              if (!(regex.hasMatch(value) && value.isNotEmpty))
                                return "Please enter a valid Email-ID";
                              else
                                return null;
                            },
                            // onSaved: (value) => _email = value.trim(),
                            obscureText: false,
                            onChanged: (val) {
                              // setState(() => _email = val);
                            },
                            autofocus: false,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(

                                errorStyle: TextStyle(color: Colors.white),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(150)),
                                  borderSide:
                                  const BorderSide(color: Colors.black, width: 0.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(150)),
                                  borderSide:
                                  const BorderSide(color: Colors.black, width: 0.0),
                                ),
                                // border: const OutlineInputBorder(
                                //   borderSide:
                                //   const BorderSide(color: Colors.black, width: 1.75),
                                // ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                hintText: "Enter your Email ID",
                                hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                                labelText: "Email",
                                labelStyle: TextStyle(color: Colors.white, fontSize: 18)
                            ),
                          ),
                        ),
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
                        child: TextField(
                          enabled: true,
                          autocorrect: true,
                          // controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          // validator: (value) {
                          //   Pattern pattern =
                          //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          //   RegExp regex = new RegExp(pattern);
                          //   if (!(regex.hasMatch(value) && value.isNotEmpty))
                          //     return "Please enter a valid Email-ID";
                          //   else
                          //     return null;
                          // },
                          // onSaved: (value) => _email = value.trim(),
                          obscureText: false,
                          onChanged: (val) {
                            // setState(() => _email = val);
                          },
                          autofocus: false,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              errorStyle: TextStyle(color: Colors.white),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(150)),
                                borderSide:
                                const BorderSide(color: Colors.black, width: 0.0),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(150)),
                                borderSide:
                                const BorderSide(color: Colors.black, width: 0.0),
                              ),
                              // border: const OutlineInputBorder(
                              //   borderSide:
                              //   const BorderSide(color: Colors.black, width: 1.75),
                              // ),
                              prefixIcon: Icon(
                                Icons.security,
                                color: Colors.white,
                                size: 25,
                              ),
                              hintText: "Enter your password",
                              hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.white, fontSize: 18)),
                        ),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              },
                            text: "Forgot Password ?",
                            style: TextStyle(
                                color: Colors.green,
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
                        color: Colors.green,
                        onPressed: () async {
                          // if (_formKey.currentState.validate()) {
                          //   try {
                          //     showAlertDialog(context);
                          //     dynamic result = await _auth.signInWithEmailAndPassword(
                          //         _email, _pass);
                          //     Navigator.pop(context);
                          //     if (result == null) {
                          //       setState(() {
                          //         Flushbar(
                          //           borderRadius: 8.0,
                          //           title: "Invalid Password/Email",
                          //           message:
                          //           "Please enter correct Email and Password",
                          //           flushbarPosition: FlushbarPosition.BOTTOM,
                          //           flushbarStyle: FlushbarStyle.FLOATING,
                          //           reverseAnimationCurve: Curves.decelerate,
                          //           forwardAnimationCurve: Curves.bounceIn,
                          //           backgroundColor: Colors.black,
                          //           mainButton: FlatButton(
                          //               onPressed: () {
                          //                 Navigator.pop(context);
                          //               },
                          //               child: Text(
                          //                 "OK",
                          //                 style: TextStyle(color: Colors.white),
                          //               )),
                          //           boxShadows: [
                          //             BoxShadow(
                          //                 color: Colors.blue[800],
                          //                 offset: Offset(0.0, 5.0),
                          //                 blurRadius: 8.0)
                          //           ],
                          //           margin:
                          //           EdgeInsets.only(bottom: 8, left: 8, right: 8),
                          //           isDismissible: true,
                          //           duration: Duration(seconds: 10),
                          //           icon: Icon(
                          //             Icons.error_outline,
                          //             color: Colors.white,
                          //           ),
                          //         )..show(context);
                          //       });
                          //     }
                          //   } catch (e) {
                          //     var errorr = e.toString();
                          //     print(errorr);
                          //   }
                          // }
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SignupPage()));
                              },
                            text: "Don't have an account?? Sign up",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 13,
                                fontWeight: FontWeight.w900),
                          )),
                    ),
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


