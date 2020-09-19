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
int _page = 0;

  @override
void initState() { 
  FirebaseAuth.instance.currentUser;
  super.initState();
}


 
final tabs = [
    PostScreen(),
    Center(child: Container(child: Text("How ", style: TextStyle(color: Colors.white),))),
    Center(child: Container(child: Text("are", style: TextStyle(color: Colors.white),))),
    Center(child: Container(child: Text("you", style: TextStyle(color: Colors.white),))),
    AccountsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                elevation: 8.0,
          // centerTitle: true,
          // toolbarHeight: 50,
          title: _page == 0 ? Text("FEED",style: TextStyle(color: Colors.red),) : _page == 1 ? Text("ME",style: TextStyle(color: Colors.blue),) : _page == 2 ? Text("MY",style: TextStyle(color: Colors.cyan),) : _page == 3 ? Text("PRECIOUS",style: TextStyle(color: Colors.green),) : _page == 4 ? Text("DATA",style: TextStyle(color: Colors.purple),) : Text("LOL"),
          backgroundColor: _page == 0 ? Colors.grey.shade900 : _page == 1 ? Colors.grey.shade900 : _page == 2 ? Colors.grey.shade900 : _page == 3 ? Colors.grey.shade900 :Colors.grey.shade900,
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
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



class AccountsPage extends StatefulWidget {
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {

readFirestoreData() async{
  DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid).get();
  String name;

  setState(() {
    name = snapshot.data()['name'];
  });
  // print(abc);
  return name;
}

  @override
  Widget build(BuildContext context) {
    
     return FutureBuilder<dynamic>
     (
       future: readFirestoreData(),
       builder: (context, snapshot) {
         if(snapshot.hasData){
           return Column(
            //  mainAxisAlignment: MainAxisAlignment.start,
            //  crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               SizedBox(height: 20),
               Center(
                 child: CircleAvatar(
                   backgroundColor: Colors.purple,
                   maxRadius: 105,
                     child: CircleAvatar(
                     radius: 100,
                     backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser.photoURL),
                   ),
                 ),
               ),
               SizedBox(height: 30),
               Center(
                 child: Text(
                   snapshot.data, 
                   style: TextStyle(color: Colors.white, fontSize: 20),
                   )
                ),
                SizedBox(height: 50),
               Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Center(
                     child: Container(
                       child: Text("BIO", style: TextStyle(color:Colors.white)),
                     ),
                   ),
                   Container(
                    //  child: ,
                   ),
                 ],
               ) ,

             ],
           );
         }
         return Center(child:  CircularProgressIndicator(),);
       },
     );
   
  }
}