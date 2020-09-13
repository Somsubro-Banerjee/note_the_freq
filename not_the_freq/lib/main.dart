import 'package:not_the_freq/auth/LoginPage.dart';

import './ui/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:not_the_freq/ui/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
int initScreen;
Future<void>main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt('initScreen');
  await prefs.setInt('initScreen', 1);
  print('initScreen $initScreen');
  runApp(NoteTheFreq());
}

class NoteTheFreq extends StatefulWidget {
  @override
  _NoteTheFreqState createState() => _NoteTheFreqState();
}

class _NoteTheFreqState extends State<NoteTheFreq> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initScreen == 0 || initScreen == null ? "first" : '/' ,
      routes: {
        '/' : (context) => LoginPage(),
        'first' : (context) => OnboardingScreen(),
      },
    );
  }
}
