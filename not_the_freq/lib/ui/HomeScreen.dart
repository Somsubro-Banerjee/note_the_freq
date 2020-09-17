import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_drawer/curved_drawer.dart';
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
int _page = 0;
int _dPage = 0;
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
 
final tabs = [
    PostScreen(),
    Center(child: Container(child: Text("How ", style: TextStyle(color: Colors.white),))),
    Center(child: Container(child: Text("are", style: TextStyle(color: Colors.white),))),
    Center(child: Container(child: Text("you", style: TextStyle(color: Colors.white),))),
    Center(child: Container(child: Text("nigga", style: TextStyle(color: Colors.white),))),
  ];
  List<DrawerItem> _drawerItems = <DrawerItem>[
    DrawerItem(icon: Icon(Icons.people), label: "People"),
    DrawerItem(icon: Icon(Icons.trending_up), label: "Trending"),
    DrawerItem(icon: Icon(Icons.tv)),
    DrawerItem(icon: Icon(Icons.work), label: "Work"),
    DrawerItem(icon: Icon(Icons.web)),
    DrawerItem(icon: Icon(Icons.videogame_asset)),
    DrawerItem(icon: Icon(Icons.book), label: "Book"),
    DrawerItem(icon: Icon(Icons.call), label: "Telephone")
  ];
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      drawer: CurvedDrawer(
        items:<DrawerItem> [
          // DrawerItem(icon: Icon(Icons.people), label: "people")
          _drawerItems[_dPage],
        ],
        ),

      appBar: AppBar(
        backgroundColor: _page == 0 ? Colors.grey.shade900 : _page == 1 ? Colors.grey.shade900 : _page == 2 ? Colors.grey.shade900 : _page == 3 ? Colors.grey.shade900 :Colors.grey.shade900,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        backgroundColor: _page == 0 ? Colors.grey.shade900 : _page == 1 ? Colors.grey.shade900 : _page == 2 ? Colors.grey.shade900 : _page == 3 ? Colors.grey.shade900 :Colors.grey.shade900,
        buttonBackgroundColor: Colors.white,
        items: [
          Icon(Icons.done_all, size: 20,color: Colors.red,),
          Icon(Icons.verified, size: 20,color: Colors.blue,),
          Icon(Icons.add, size: 20,color: Colors.cyan,),
          Icon(Icons.share, size: 20,color: Colors.green,),
          Icon(Icons.close, size: 20,color: Colors.purple,),
          
        ],
        animationDuration: Duration(milliseconds: 300),
        // animationCurve: Curves.bounceInOut,
        onTap: (index){
          setState(() {
            _page = index;
          });
        },
        ),
      backgroundColor: _page == 0 ? Colors.grey.shade900 : _page == 1 ? Colors.grey.shade900 : _page == 2 ? Colors.grey.shade900 : _page == 3 ? Colors.grey.shade900 :Colors.grey.shade900,
      body: tabs[_page] ,
    );

  }
}
 Route loginRoute()
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


class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
  return Container(
  child: Center(
    child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Center(child: Text(FirebaseAuth.instance.currentUser.email, style: TextStyle(color: Colors.white, fontSize: 20),)),
                ],
              ) ,
            ),
            IconButton(icon: Icon(Icons.clear, color: Colors.white,), onPressed: () async{
               SharedPreferences prefs = await SharedPreferences.getInstance();  
              FirebaseAuth.instance.signOut().whenComplete(() => Navigator.pushReplacement(context, loginRoute()));
              prefs.remove('email');
            })
          ],
        ),
      ),
    );
  }
}