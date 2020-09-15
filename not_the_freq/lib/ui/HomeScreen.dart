import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:not_the_freq/auth/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
void initState() { 
  FirebaseAuth.instance.currentUser;
  super.initState();

}
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Center(child: Text(FirebaseAuth.instance.currentUser.email, style: TextStyle(color: Colors.white, fontSize: 20),)) ,
            ),
            IconButton(icon: Icon(Icons.clear, color: Colors.white,), onPressed: (){
              FirebaseAuth.instance.signOut().whenComplete(() => Navigator.pushAndRemoveUntil(context, _loginRoute(), (_) => false));
            })
          ],
        ),
      ),
    );

  }
}
