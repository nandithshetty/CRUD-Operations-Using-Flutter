import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_eg/login_screen.dart';
import 'package:firebase_eg/reset_password_screen.dart';
import 'package:firebase_eg/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_eg/home_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyDJqpxi2ntW-P9TucfYhYAJmt5haLdzufE",
    authDomain: "fir-7a174.firebaseapp.com",
    projectId: "fir-7a174",
    storageBucket: "fir-7a174.firebasestorage.app",
    messagingSenderId: "445887042601",
    appId: "1:445887042601:web:e77da3a4b8bef04e1ef838"));
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseAuth.instance.currentUser!=null?HomeScreen(): LoginScreen(),
    );
  }
}