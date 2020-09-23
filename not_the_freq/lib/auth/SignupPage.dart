import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import"package:flutter/cupertino.dart";
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:not_the_freq/auth/LoginPage.dart';

import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


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

Future<void> _emailAlredyExists() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
        backgroundColor: Colors.grey.shade900,
        title: Text('Invalid Email Id!!',
        style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('The email address you entered is already in use',
                style: TextStyle(color: Colors.white)
                ,),
                SizedBox(height: 50),
                Text('Please try again',
                style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
        
        actions: <Widget>[
          FlatButton(
            child: Text('Try Again', style: TextStyle(color: shade1),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _accountCreated() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
        backgroundColor: Colors.grey.shade900,
        title: Text('Account created succesfully',
        style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('press continue to login',
                style: TextStyle(color: Colors.white)
                ,),
                // SizedBox(height: 50),
                // Text('Please try again',
                // style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
        
        actions: <Widget>[
          FlatButton(
            child: Text('Continue', style: TextStyle(color: shade1),),
            onPressed: () {
              Navigator.pushAndRemoveUntil(context, _loginRoute(), (route) => false);
            },
          ),
        ],
      );
    },
  );
}

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
        title: Text(
          'Invalid Email Id!!',
        style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('The email address you entered is not acceptable or already in use',
                style: TextStyle(color: Colors.white)
                ,),
                SizedBox(height: 50),
                Text('Please try again',
                style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
        
        actions: <Widget>[
          FlatButton(
            child: Text('Try Again', style: TextStyle(color: shade1),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _weakPassword() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
        backgroundColor: Colors.grey.shade900,
        title: Text('Weal Password',
        style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('the password you entered is very small',
                style: TextStyle(color: Colors.white)
                ,),
                SizedBox(height: 50),
                Text('Please try again',
                style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
        
        actions: <Widget>[
          FlatButton(
            child: Text('Try Again', style: TextStyle(color: shade1),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


Future<void> _imagePicker() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
        backgroundColor: Colors.grey.shade900,
        title: Text('Pick your Image!!!',
        style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please choose where to upload your image from',
                style: TextStyle(color: Colors.white)
                ,),
              ],
            ),
          ),
        
        actions: <Widget>[
          FlatButton(
            child: Text('Camera', style: TextStyle(color: shade1),),
            onPressed: () {
              getImageFromCamera();
              Navigator.of(context).pop();
            },
          ),

          FlatButton(
            child: Text('Gallery', style: TextStyle(color: shade1),),
            onPressed: () {
              getImageFromGallery();
              Navigator.of(context).pop();
            },
          ),

          FlatButton(
            child: Text('Cancel', style: TextStyle(color: shade1),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
File _image;
final _picker = ImagePicker();
Future getImageFromGallery() async {
    final image = await _picker.getImage(source: ImageSource.gallery);
    final File file =File(image.path); 
    setState(() {
      _image = file;
      // updateProfilePicture();
    });
  }
  Future getImageFromCamera() async {
    final image = await _picker.getImage(source: ImageSource.camera);
    final File file =File(image.path); 
    setState(() {
      _image = file;
      // updateProfilePicture();
    });
  }

  updateProfilePicture() async {
    
    StorageReference storageRefrence = FirebaseStorage.instance.ref()
    .child("Profile pictures/${FirebaseAuth.instance.currentUser.displayName}/${FirebaseAuth.instance.currentUser.uid}/${_image.path}");
    StorageUploadTask storageUploadTask = storageRefrence.putFile(_image);
    await storageUploadTask.onComplete;
    print('file uploaded');
    storageRefrence.getDownloadURL().then((url) {
      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid).update({"profilePic" : url}).catchError((e){
      print(e.toString());
    });
      setState(() {
        profilePic = url;
        if(FirebaseAuth.instance.currentUser != null){
        FirebaseAuth.instance.currentUser.updateProfile(photoURL: url, displayName: name);
        print(url);
        print(name);
    }
    });
    });
   
  }

  // getPhoto()async
  // {
  //   User user = await _auth.currentUser;
  //   profilePic = user.photoURL;
  // }

  bool x = false;
  bool y = false;

  
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController passController;
  TextEditingController cnfPassController;
  TextEditingController bioController;
  TextEditingController interestController;
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  String name;
  String email;
  String pass;
  String cnfPass;
  String bio;
  String interest;
  String profilePic;

 

  String text = "Nothing to show";
  VideoPlayerController _controller;

   bool validateAndSave() {
    final FormState form = _signUpFormKey.currentState;
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }
  Route _loginRoute()
  {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child){
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeOut;

        var tween = Tween (begin: begin , end :end).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween),
        child : child);
      }
      );
  }
 

  @override
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
                Form(
                  key: _signUpFormKey,
                     child: SingleChildScrollView(
                       scrollDirection: Axis.vertical,
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
                                    Navigator.pushReplacement(context, _loginRoute());
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
                          margin: EdgeInsets.only(top:0),
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
                          height: 200,
                          width: 200,
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width*0.24,
                            top: MediaQuery.of(context).size.height*0.04),
                          child: CircleAvatar(
                            backgroundColor: shade1,
                            radius: 100,
                            backgroundImage: _image == null ? AssetImage('assets/images/1.jpg'): FileImage(_image),
                          ),
                        ),
                        Container(
                          height: 90,
                          width:  250,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(top: 0, left:120 ),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Container(
                                  height: 20,
                                  width: 120,
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
                                width: 135,
                                margin: EdgeInsets.only(left: 0, top: 20),
                                child: FlatButton(
                                  onPressed: (){
                                    _imagePicker();
                                    // Navigator.of(context).pop();
                                  },
                                     child: Text("Add Picture",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                ),
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
                                  top: MediaQuery.of(context).size.height * 0.04,
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
                                borderRadius: BorderRadius.circular(150)),
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.02,
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
                              top: MediaQuery.of(context).size.height * 0.02,
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.05),
                          child: TextFormField(
                            enabled: true,
                            autocorrect: true,
                            controller: passController,
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
                            "Password cannot be empty must be more than 6 characters",
                            style: TextStyle(color: Colors.red),
                          ),
                          visible: y,
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
                                top: MediaQuery.of(context).size.height * 0.02,
                                left: MediaQuery.of(context).size.width * 0.05,
                                right: MediaQuery.of(context).size.width * 0.05),
                            child: TextFormField(
                              enabled: true,
                              autocorrect: true,
                              controller: cnfPassController,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value.length >= 6 && cnfPassController.text == passController.text && value.isNotEmpty)
                                {
                                  setState(() {
                                  y = false; 
                                  return null ;
                                });
                                }                       
                                else
                                  {
                                    setState(() {
                                  y = true;
                                });
                                return null;
                                }
                                return null;
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
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          top: 3,
                        ),
                        child: Visibility(
                          child: Text(
                            "Passwords do not match",
                            style: TextStyle(color: Colors.red),
                          ),
                          visible: y,
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
                        
                        Container(
                          height: 90,
                          width:  250,
                          padding: EdgeInsets.only(left: 20, ),
                          margin: EdgeInsets.only(top: 1),
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
                              prefixIcon: Icon(Icons.person, color: Colors.white),
                                border: InputBorder.none,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide:
                                  const BorderSide(color: Colors.black, width: 0.0),
                                ),
                                labelText: "Enter your interests",
                              labelStyle: TextStyle(color: Colors.grey)

                            ),
                            direction: AxisDirection.up,
                            getImmediateSuggestions: true,
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
                              if(_signUpFormKey.currentState.validate())
                              {
                                if(passController.text == cnfPassController.text)
                                {
                                  // showAlertDialog(context);
                                  try{
                                    
                                   UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passController.text);
                                    FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userCredential.user.uid)
                                    .set({
                                      'bio': bioController.text,
                                      'name': nameController.text,
                                      'email': emailController.text,
                                      'intrest': text,
                                      'uid': userCredential.user.uid,
                                      
                                    });
                                  // Navigator.pushAndRemoveUntil(context, _homeRoute(), (route) => false);
                                  updateProfilePicture();
                                  _accountCreated();

                                  } on FirebaseAuthException catch(err){
                                    if(err.code == "email-already-in-use"){
                                      _emailAlredyExists();
                                      print("email already exists in database");
                                    } else if(err.code == "invalid-email"){
                                      _invalidEmail();
                                      print("email entered is invalid ");
                                    } else if(err.code == "weak-password"){
                                      _weakPassword();
                                      print("password is weak just like you");
                                    }
                                  }
                                  
                                }
                              }
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
