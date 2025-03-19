import 'package:flutter/material.dart';

const Color charcoal = Color(0xFF333333);
const Color oliveGreen = Color(0xFF97B469);

void main() {
  runApp(
    MaterialApp(home: ResetPasswordPage(), debugShowCheckedModeBanner: false),
  );
}

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 🔹 Top Left "RECITE RIGHT" Logo + Text
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                Image.asset('assets/QuranLogo.png', width: 35, height: 35),
                const SizedBox(width: 8),
                Text(
                  'RECITE RIGHT',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: oliveGreen,
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Center Olive Green Block
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: screenWidth * 0.41, // Adjusted width
                height: screenHeight * 0.65, // Adjusted height
                decoration: BoxDecoration(
                  color: oliveGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Container(
                    width: screenWidth * 0.30, // Adjusted inner container width
                    height:
                        screenHeight * 0.45, // Adjusted inner container height
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(20), // Reduced padding
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 🔹 Reset Password Title
                        Text(
                          'Reset Password',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: charcoal,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // 🔹 New Password Field
                        _customTextField(
                          hintText: 'New Password',
                          icon: Icons.lock,
                        ),

                        const SizedBox(height: 15),

                        // 🔹 Confirm New Password Field
                        _customTextField(
                          hintText: 'Confirm New Password',
                          icon: Icons.lock,
                        ),

                        const SizedBox(height: 20),

                        // 🔹 Reset Button
                        ElevatedButton(
                          onPressed: () {
                            // Add reset password logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: oliveGreen,
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                              vertical: 16,
                            ), // Increased vertical padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'RESET',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom Text Field Widget with Left Border & Shadow
  Widget _customTextField({required String hintText, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: oliveGreen, width: 5), // Left border only
        ),
        boxShadow: [
          BoxShadow(
            color: oliveGreen.withOpacity(0.5),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(3, 3), // Soft bottom-right shadow
          ),
        ],
      ),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black54),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 15,
          ), // Adjusted padding
          prefixIcon: Icon(icon, color: oliveGreen),

          // Removing default borders
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,

          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
