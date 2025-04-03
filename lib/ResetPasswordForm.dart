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
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          final isMobile = screenWidth < 600;
          final isTablet = screenWidth >= 600 && screenWidth < 900;
          final isDesktop = screenWidth >= 900;

          if (isMobile) {
            return Stack(
              children: [
                // Full olive green background
                Container(color: oliveGreen),

                // Centered logo moved down to vertical center of olive green area
                Positioned(
                  top: screenHeight * 0.25,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/QuranLogo.png',
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'RECITE RIGHT',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Compact form at bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: screenHeight * 0.45,
                  child: Container(
                    decoration: BoxDecoration(
                      color: oliveGreen,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 15),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(25, 25, 25, 15),
                        child: _buildMobileFormContent(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Tablet/Desktop Layout
            // Tablet/Desktop Layout
            return Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 20,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/QuranLogo.png',
                        width: isDesktop ? 40 : 35,
                        height: isDesktop ? 40 : 35,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'RECITE RIGHT',
                        style: TextStyle(
                          fontSize: isDesktop ? 24 : 22,
                          fontWeight: FontWeight.bold,
                          color: oliveGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: isTablet ? screenWidth * 0.7 : 550, // Wider form
                    padding: const EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      color: oliveGreen,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 35, // More horizontal space
                        vertical: 25,
                      ),
                      child: _buildFormContent(isDesktop: isDesktop),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildMobileFormContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Reset Password',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: charcoal,
          ),
        ),
        const SizedBox(height: 25),
        _customTextField(hintText: 'New Password', icon: Icons.lock),
        const SizedBox(height: 20),
        _customTextField(hintText: 'Confirm New Password', icon: Icons.lock),
        const SizedBox(height: 25),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: oliveGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'RESET',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormContent({required bool isDesktop}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Reset Password',
          style: TextStyle(
            fontSize: isDesktop ? 26 : 24,
            fontWeight: FontWeight.bold,
            color: charcoal,
          ),
        ),
        SizedBox(height: isDesktop ? 30 : 25),
        _customTextField(hintText: 'New Password', icon: Icons.lock),
        SizedBox(height: isDesktop ? 25 : 20),
        _customTextField(hintText: 'Confirm New Password', icon: Icons.lock),
        SizedBox(height: isDesktop ? 30 : 25),
        SizedBox(
          width: double.infinity,
          height: isDesktop ? 55 : 50,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: oliveGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'RESET',
              style: TextStyle(
                color: Colors.white,
                fontSize: isDesktop ? 18 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _customTextField({required String hintText, required IconData icon}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        border: const Border(left: BorderSide(color: oliveGreen, width: 4)),
        boxShadow: [
          BoxShadow(
            color: oliveGreen.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black54, fontSize: 16),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20, // Increased horizontal padding
          ),
          prefixIcon: Icon(icon, color: oliveGreen, size: 24),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
