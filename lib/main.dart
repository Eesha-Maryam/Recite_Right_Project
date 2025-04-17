/* import 'package:flutter/material.dart';
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

*/

import 'package:flutter/material.dart';
import 'homepage.dart';
import 'quran.dart';
import 'mutashabihat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recite Right',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        '/quran': (context) => const QuranPage(),
        '/mutashabihat': (context) => const MutashabihatPage(),
      },
    );
  }
}
