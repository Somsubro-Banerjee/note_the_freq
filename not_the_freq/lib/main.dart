import 'package:firebase_core/firebase_core.dart';
import 'package:not_the_freq/auth/LoginPage.dart';
import 'package:flutter/services.dart';
import 'package:not_the_freq/ui/animatedLoader.dart';
import 'package:not_the_freq/ui/splashToHome.dart';
import 'package:not_the_freq/ui/splashToLogin.dart';
import 'package:not_the_freq/ui/splashToOnBoarding.dart';
import './ui/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:not_the_freq/ui/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;
var userDetails;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userDetails = prefs.getString('email');
  initScreen = prefs.getInt('initScreen');
  await prefs.setInt('initScreen', 1);
  print('initScreen $initScreen');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
      initialRoute: initScreen == 0 || initScreen == null
          ? 'splashToOnBoarding'
          : userDetails == null
              ? 'splashToLogin'
              : 'splashToHome',
      routes: {
        'login': (context) => LoginPage(),
        'onBoarding': (context) => OnboardingScreen(),
        'home': (context) => HomePage(),
        'splashToLogin': (context) => SplashtoLogin(),
        'splashToHome': (context) => SplashtoHome(),
        'splashToOnBoarding': (context) => SplashtoOnBoarding(),
        'animatedLoader': (context) => AnimatedLoader(),
      },
    );
  }
}
