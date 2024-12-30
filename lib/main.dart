import 'package:flutter/material.dart';
import 'package:momentum/Screens/signin.dart';
import 'package:momentum/Screens/signup.dart';
import 'package:momentum/Screens/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Momentum ',
      //creating page routes 
      routes: {
        '/welcome': (context) => const Welcome()
        '/signin': (context) => const Signin()
        '/signup': (context) => const Signup()
      }
      theme: ThemeData(
        primaryColor: const Color(0xFF7140FC),
        fontFamily: 'Poppins', //default font family
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        // creating text theme

        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Poppins')
          headlineLarge: TextStyle(fontSize: 32, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Poppins')
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Poppins'),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'Poppins'),
        ),
        primaryTextTheme: const  TextTheme(headlineLarge: TextStyle(color: Colors.black)),
        useMaterial3: true,
      ),
      color: Colors.white,
      initialRoute: '/welcome', //setting initial route so that welcome page opens when app is started
    );
  }
}
