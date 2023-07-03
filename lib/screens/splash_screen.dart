import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../main.dart';
import '../api/apis.dart';
import 'auth/login_screen.dart';
import 'home_screen.dart';

//splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //delays the screen to appear on the screen late for 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      //exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode
          .edgeToEdge); // this takes up entire screen, even the safeArea
      //this overlay the entire screen to white color, if we dont use this, then the screen above appbar remains black
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white));

      //checks if the user is alredy present in the firebaseAuth
      if (APIs.auth.currentUser != null) {
        //log('\nUser: ${APIs.auth.currentUser}');
        //navigate to home screen if user is already registered
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        //navigate to login screen to register a new user
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    mq = MediaQuery.of(context).size;

    return Scaffold(
      //body
      body: Stack(children: [
        //app logo
        Positioned(
            //shows the logo of the chat app
            top: mq.height * .15,
            right: mq.width * .25,
            width: mq.width * .5,
            child: Image.asset('assets/chat.png')),

        //google login button
        Positioned(
            bottom: mq.height * .15,
            width: mq.width,
            child: const Center(
              child: Text('MADE WITH ❤️',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24, color: Colors.black87, letterSpacing: .5)),
            )),
      ]),
    );
  }
}
