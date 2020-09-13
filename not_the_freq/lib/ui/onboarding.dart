import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:not_the_freq/auth/LoginPage.dart';

int initScreen;
class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/4.jpg',
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => print('Skip'),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 600.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Container(
                          margin: EdgeInsets.only(top: 60),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                              ),
                              SizedBox(height: 200.0),
                              Text(
                                'LEARN',
                                style: TextStyle(
                                  letterSpacing: 5,
                                  color: Colors.white,
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold
                                ),
                                
                              ),
                              SizedBox(height: 60.0),
                              Text(
                                'Learn from unlimited sources enhance your capabilities and knowledge...',
                                style: TextStyle(
                                  letterSpacing: 5,
                                  color: Colors.white,
                                  fontSize: 20
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Container(
                          margin: EdgeInsets.only(top: 60),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                              ),
                              SizedBox(height: 200.0),
                              Text(
                                'TEACH',
                                style: TextStyle(
                                  letterSpacing: 5,
                                  color: Colors.white,
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold
                                ),
                                
                              ),
                              SizedBox(height: 60.0),
                              Text(
                                'Pass on your knowledge and capabilities to others, pave a path to their future...',
                                style: TextStyle(
                                  letterSpacing: 5,
                                  color: Colors.white,
                                  fontSize: 20
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Container(
                          margin: EdgeInsets.only(top: 60),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                              ),
                              SizedBox(height: 200.0),
                              Text(
                                'SHARE',
                                style: TextStyle(
                                  letterSpacing: 5,
                                  color: Colors.white,
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold
                                ),
                                
                              ),
                              SizedBox(height: 60.0),
                              Text(
                              
                                'Share your work with thousands of other emerging artists make yourself famous...',
                                style: TextStyle(
                                  letterSpacing: 5,
                                  color: Colors.white,
                                  fontSize: 20
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40,),
                     child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _buildPageIndicator(),
                  ),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    letterSpacing: 2,
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 80.0,
              width: double.infinity,
              color: Colors.black,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Center(
                      child: Text(
                        'GET STARTED',
                        style: TextStyle(
                          letterSpacing: 3,
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}