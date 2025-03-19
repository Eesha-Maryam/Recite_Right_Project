// footer.dart
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.black,
      child: const Center(
        child: Text(
          'Footer Content Here',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
