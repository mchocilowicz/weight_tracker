import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/screen/login_screen.dart';
import 'package:weight_tracker/screen/signup_screen.dart';
import 'package:weight_tracker/screen/weight_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showLoginScreen = true;
  bool _showCreateScreen = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          _showLoginScreen = true;
          _showCreateScreen = false;
        });
      } else {
        setState(() {
          _showLoginScreen = false;
          _showCreateScreen = false;
        });
      }
    });
  }

  void onLoggedIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      setState(() {
        _showLoginScreen = false;
        _showCreateScreen = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void onCreateUser() {
    setState(() {
      _showLoginScreen = false;
      _showCreateScreen = true;
    });
  }

  void onSignUp(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('---- The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('---- The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if(_showLoginScreen) return LoginScreen(onLogin: onLoggedIn, onCreate: onCreateUser);
    if(_showCreateScreen) return SignUpScreen(onSignUp: onSignUp);
    return const WeightScreen();
  }
}
