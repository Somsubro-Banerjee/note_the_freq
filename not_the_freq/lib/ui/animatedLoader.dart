import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:not_the_freq/ui/HomeScreen.dart';

class AnimatedLoader extends StatefulWidget {
  @override
  _AnimatedLoaderState createState() => _AnimatedLoaderState();
}

String animationName = 'cosmos';

class _AnimatedLoaderState extends State<AnimatedLoader> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  Route _homeRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.fastOutSlowIn;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
              position: animation.drive(tween), child: child);
        });
  }

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(context, _homeRoute());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
            child: Stack(fit: StackFit.expand, children: [
          FlareActor(
            'assets/animations/cosmos.flr',
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
            animation: animationName,
          )
        ])),
      ),
    );
  }
}
