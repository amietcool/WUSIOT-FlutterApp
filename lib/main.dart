import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wusiotapp/Dashboard.dart';
import 'package:wusiotapp/login/Login.dart';

void main() async {
  runApp(const MyApp(isLoggedIn: true,));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isLoggedIn ? Dashboard() : Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login())));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.amber,
      body: Center(// Center the image horizontally and vertically
        child: Image.asset(
          'assets/image/loginlogo.png', // Path to your image asset
          height: 200, // Set height
          width: 150, // Set width
        ),
      ),
    ));
  }
}