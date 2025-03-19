import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(MyApp()); // Removed 'const' here
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Removed 'const' here
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
