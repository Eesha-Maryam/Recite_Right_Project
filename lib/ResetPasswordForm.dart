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
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return Stack(
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
                        fontSize:
                            screenWidth < 600 ? 18 : 22, // Responsive font size
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
                    width:
                        screenWidth < 600
                            ? screenWidth *
                                0.9 // Adjusted for small screens
                            : screenWidth * 0.41, // Adjusted for larger screens
                    height:
                        screenHeight < 600
                            ? screenHeight *
                                0.7 // Adjusted for small screens
                            : screenHeight *
                                0.65, // Adjusted for larger screens
                    decoration: BoxDecoration(
                      color: oliveGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Container(
                        width:
                            screenWidth < 600
                                ? screenWidth *
                                    0.8 // Adjusted for small screens
                                : screenWidth *
                                    0.30, // Adjusted for larger screens
                        height:
                            screenHeight < 600
                                ? screenHeight *
                                    0.5 // Adjusted for small screens
                                : screenHeight *
                                    0.45, // Adjusted for larger screens
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(
                          screenWidth < 600 ? 15 : 20,
                        ), // Responsive padding
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 🔹 Reset Password Title
                            Text(
                              'Reset Password',
                              style: TextStyle(
                                fontSize:
                                    screenWidth < 600
                                        ? 20
                                        : 24, // Responsive font size
                                fontWeight: FontWeight.bold,
                                color: charcoal,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight < 600 ? 15 : 20,
                            ), // Responsive spacing
                            // 🔹 New Password Field
                            _customTextField(
                              hintText: 'New Password',
                              icon: Icons.lock,
                            ),

                            SizedBox(
                              height: screenHeight < 600 ? 10 : 15,
                            ), // Responsive spacing
                            // 🔹 Confirm New Password Field
                            _customTextField(
                              hintText: 'Confirm New Password',
                              icon: Icons.lock,
                            ),

                            SizedBox(
                              height: screenHeight < 600 ? 15 : 20,
                            ), // Responsive spacing
                            // 🔹 Reset Button
                            ElevatedButton(
                              onPressed: () {
                                // Add reset password logic here
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: oliveGreen,
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.04,
                                  vertical:
                                      screenHeight < 600
                                          ? 10
                                          : 19, // Responsive padding
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'RESET',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      screenWidth < 600
                                          ? 14
                                          : 16, // Responsive font size
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
          );
        },
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
