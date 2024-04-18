import 'package:flutter/material.dart';
import 'package:weight_tracker/screen/login_screen.dart';
import 'package:weight_tracker/screen/weight_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoggedIn = false;

  void onLoggedIn() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn ? WeightScreen() : LoginScreen(callback: onLoggedIn);
  }
}
