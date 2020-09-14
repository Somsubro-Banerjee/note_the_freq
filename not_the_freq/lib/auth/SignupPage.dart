import"package:flutter/cupertino.dart";
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:not_the_freq/auth/LoginPage.dart';
import 'package:video_player/video_player.dart';
import 'package:not_the_freq/ui/HomeScreen.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController passController;
  TextEditingController cnfPassController;
  TextEditingController bioController;
  TextEditingController interestController;



  String name;
  String email;
  String pass;
  String cnfPass;
  String bio;
  String interest;

  String text = "Nothing to show";
  VideoPlayerController _controller;

  void initState() {
    nameController = new TextEditingController();
    emailController = new TextEditingController();
    passController = new TextEditingController();
    cnfPassController = new TextEditingController();
    bioController = new TextEditingController();
    interestController = new TextEditingController();
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
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width:  80,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top:5, left: 5),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Container(
                              height: 80,
                              width: 80,
                              margin: EdgeInsets.only(top:30, left: 5),
                              decoration: BoxDecoration(
                                  color: shade1,
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: shade1,
                                      width: 2
                                  )
                              )
                          ),
                          Container(
                            height: 200,
                            width: 200,
                            margin: EdgeInsets.only(left: 0, top: 5),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white,
                                size: 30
                                ,),
                              onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                              }
                          )
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      width:  250,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(top: 70),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Container(
                              height: 100,
                              width: 300,
                              margin: EdgeInsets.only(top:30),
                              decoration: BoxDecoration(
                                  color: shade1,
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: shade1,
                                      width: 2
                                  )
                              )
                          ),
                          Container(
                            height: 400,
                            width: 600,
                            margin: EdgeInsets.only(left: 10),
                            child: Text("Sign up",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),),
                          )
                        ],
                      ),
                    ),
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
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            onSaved: (value) => name = value.trim(),
                            obscureText: false,
                            onChanged: (val) {
                              setState(() => name = val);
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
                                
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                hintText: "Enter your Name",
                                hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                                labelText: "Name",
                                labelStyle: TextStyle(color: Colors.white, fontSize: 18)
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.height*0.05,),
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
                            controller: emailController,
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
                            onSaved: (value) => email = value.trim(),
                            obscureText: false,
                            onChanged: (val) {
                              setState(() => email = val);
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
                        child: TextFormField(
                          enabled: true,
                          autocorrect: true,
                          controller: passController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            
                            if ( value.length >= 6 && value.isNotEmpty)
                              return "Looks good";
                            else
                              return "Password must be greater than 6 characters";
                          },
                          onSaved: (value) => pass = value.trim(),
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => pass = val);
                          },
                          autofocus: false,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              // errorText: "password must be more than 6 characters",
                              errorStyle: TextStyle(color: Colors.red),
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
                          controller: cnfPassController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                           
                            if (value.length >= 6 && cnfPassController.text == passController.text && value.isNotEmpty)
                              return "looks good";
                            else
                              return "Fuck you Cyuka blyat";
                          },
                          onSaved: (value) => cnfPass = value.trim(),
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => cnfPass = val);
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
                             
                              prefixIcon: Icon(
                                Icons.security,
                                color: Colors.white,
                                size: 25,
                              ),
                              hintText: "Type Password again",
                              hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                              labelText: "Confirm Password",
                              labelStyle: TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                      ),
                    ),
                    Container(
                      height: 90,
                      width:  250,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(top: 5),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Container(
                              height: 20,
                              width: 45,
                              margin: EdgeInsets.only(top:30),
                              decoration: BoxDecoration(
                                  color: shade1,
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: shade1,
                                      width: 2
                                  )
                              )
                          ),
                          Container(
                            height: 20,
                            width: 40,
                            margin: EdgeInsets.only(left: 5, top: 20),
                            child: Text("Bio",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.05),
                          child: TextFormField(
                            maxLines: 10,
                            autocorrect: true,
                            controller: bioController,
                            keyboardType: TextInputType.multiline,
                            onSaved: (value) => bio = value.trim(),
                            obscureText: false,
                            onChanged: (val) {
                              setState(() => bio = val);
                            },
                            autofocus: false,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                                errorStyle: TextStyle(color: Colors.white),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide:
                                  const BorderSide(color: Colors.black, width: 0.0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                hintText: "Write your short bio in about 10 lines*",
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ),
                        ),

                    ),
                    Row(
                      children: [
                        Container(
                      height: 70,
                      width:  70,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(top: 1),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Container(
                              height: 20,
                              width: 45,
                              margin: EdgeInsets.only(top:20),
                              decoration: BoxDecoration(
                                  color: shade1,
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: shade1,
                                      width: 2
                                  )
                              )
                          ),
                          Container(
                            height: 70,
                            width: 70,
                            margin: EdgeInsets.only(left: 1, top: 0),
                            child: IconButton(
                              icon: Icon(Icons.done, color: Colors.white),
                              iconSize: 30,
                              onPressed:() {
                                setState(() {
                                  bio = bioController.text;
                                });
                              },
                              ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 70,
                      width:  70,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(top: 1),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Container(
                              height: 20,
                              width: 40,
                              margin: EdgeInsets.only(top:20),
                              decoration: BoxDecoration(
                                  color: shade1,
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: shade1,
                                      width: 2
                                  )
                              )
                          ),
                          Container(
                            height: 70,
                            width: 50,
                            margin: EdgeInsets.only(left: 0, top: 0),
                            child: IconButton(
                              icon: Icon(Icons.close, color: Colors.white),
                              iconSize: 30,
                              onPressed:() {
                                setState(() {
                                  bioController.text = "";
                                });
                              },
                              ),
                          )
                        ],
                      ),
                    ),
                      ],
                    ),
                    Container(
                      height: 90,
                      width:  250,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(top: 5),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Container(
                              height: 20,
                              width: 100,
                              margin: EdgeInsets.only(top:30),
                              decoration: BoxDecoration(
                                  color: shade1,
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: shade1,
                                      width: 2
                                  )
                              )
                          ),
                          Container(
                            height: 20,
                            width: 80,
                            margin: EdgeInsets.only(left: 5, top: 20),
                            child: Text("Interests ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),),
                          )
                        ],
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01,
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                      child: FlutterTagging(
                        textFieldDecoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.tag, color: Colors.white),
                            border: InputBorder.none,
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide:
                              const BorderSide(color: Colors.black, width: 0.0),
                            ),
                            labelText: "Enter your interests",
                          labelStyle: TextStyle(color: Colors.grey)

                        ),
                        addButtonWidget: _buildAddButton(),
                        chipsColor: shade1,
                        chipsFontColor: Colors.white,
                        deleteIcon: Icon(Icons.cancel,color: Colors.white),
                        chipsPadding: EdgeInsets.all(2.0),
                        chipsFontSize: 14.0,
                        chipsSpacing: 5.0,
                        suggestionsCallback: (pattern) async {
                          return await TagSearchService.getSuggestions(pattern);
                        },
                        onChanged: (result) {
                          setState(() {
                            text = result.toString();
                          });
                        },
                      )
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.09,
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05),
                      child: RaisedButton(
                        color: shade1,
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
                          "SIGN UP",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                        elevation: 25,
                      ),
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


Widget _buildAddButton() {
  Color shade1 = Color(0xFF7447d8);
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      color: shade1,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.add,
          color: Colors.white,
          size: 15.0,
        ),
        Text(
          "Add New Tag",
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ],
    ),
  );
}

class TagSearchService {
  static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(milliseconds: 400), null);
    List<dynamic> tagList = <dynamic>[];
    tagList.add({'name': "Piano", 'value': 1});
    tagList.add({'name': "Saxophone", 'value': 2});
    tagList.add({'name': "Harmonica", 'value': 3});
    tagList.add({'name': "Photography", 'value': 4});
    tagList.add({'name': "Artistry", 'value': 5});
    tagList.add({'name': "Music Composing", 'value': 6});
    tagList.add({'name': "video Editing", 'value': 7});
    tagList.add({'name': "VFX", 'value': 8});
    tagList.add({'name': "Photoshop", 'value': 9});
    tagList.add({'name': "Drums", 'value': 10});
    tagList.add({'name': "Guitar", 'value': 11});
    tagList.add({'name': "Keypad", 'value': 12});
    List<dynamic> filteredTagList = <dynamic>[];
    if (query.isNotEmpty) {
      filteredTagList.add({'name': query, 'value': 0});
    }
    for (var tag in tagList) {
      if (tag['name'].toLowerCase().contains(query)) {
        filteredTagList.add(tag);
      }
    }
    return filteredTagList;
  }
}
