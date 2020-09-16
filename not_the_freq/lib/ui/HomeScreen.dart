import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
final FirebaseFirestore _database =  FirebaseFirestore.instance;
Future<DocumentSnapshot> name = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid).get().then((documentSnapshot) {
  String naeme = documentSnapshot.data()["bio"];
  print(naeme);
  return documentSnapshot;
});
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
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.black,
        items: [
          Icon(Icons.done_all, size: 20,color: Colors.red,),
          Icon(Icons.verified, size: 20,color: Colors.blue,),
          Icon(Icons.share, size: 20,color: Colors.green,),
          Icon(Icons.close, size: 20,color: Colors.purple,)
        ],
        animationDuration: Duration(milliseconds: 300),
        // animationCurve: Curves.bounceInOut,
        onTap: (index){
          debugPrint('current index is : $index');
        },
        ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Center(child: Text(FirebaseAuth.instance.currentUser.email, style: TextStyle(color: Colors.black, fontSize: 20),)),
                ],
              ) ,
            ),
            IconButton(icon: Icon(Icons.clear, color: Colors.black,), onPressed: () async{
               SharedPreferences prefs = await SharedPreferences.getInstance();    
              FirebaseAuth.instance.signOut().whenComplete(() => Navigator.pushReplacement(context, _loginRoute()));
              prefs.remove('email');
            })
          ],
        ),
      ),
    );

  }
}
