import 'package:flutter/material.dart';
import 'login.dart';

const Color charcoal = Color(0xFF333333);
const Color oliveGreen = Color(0xFF97B469);

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isChecked = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isHovering = false;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(value)) {
      return 'Must contain upper, lower, and number';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Confirm password is required';
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
          bool isMobile = width < 600;
          bool isTablet = width < 900 && width >= 600;
          bool isDesktop = width >= 900;

          if (isMobile) {
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: height * 0.5,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/SignUp_Banner.png',
                        width: width,
                        height: height * 0.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: height * 0.0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 25,
                          spreadRadius: 5,
                          offset: Offset(0, -10),
                        ),
                      ],
                    ),
                    child: _buildFormContent(true),
                  ),
                ),
              ],
            );
          } else {
            double formWidth = isTablet ? width * 0.65 : 400;
            double imageWidth = isDesktop ? 400 : 0;

            return Stack(
              children: [
                // Logo for both tablet and desktop
                Positioned(
                  top: 20,
                  left: 20,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/QuranLogo.png',
                        width: 35,
                        height: 35,
                      ),
                      SizedBox(width: 8),
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

                // In the desktop section of your code, modify these parts:
                if (isDesktop)
                  Positioned(
                    left: (width - formWidth - imageWidth) / 2 + formWidth - 20,
                    top:
                        height * 0.10, // Changed from 0.10 to 0.15 (moved down)
                    child: Container(
                      width: imageWidth,
                      height: 620, // Increased from 580 to 620
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/SignUp_Banner.png',
                          width: imageWidth,
                          height: 620, // Match container height
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                Positioned(
                  left:
                      (width - formWidth - (isDesktop ? imageWidth - 20 : 0)) /
                      2,
                  top: height * 0.15, // Changed from 0.10 to 0.15 (moved down)
                  child: Container(
                    width: formWidth,
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.97),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _buildFormContent(false),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildFormContent(bool isMobile) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: isMobile ? 22 : 24,
                fontWeight: FontWeight.bold,
                color: charcoal,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 25 : 25),

          Row(
            children: [
              Expanded(
                child: _buildInputField(
                  controller: _firstNameController,
                  hintText: 'First Name',
                  isMobile: isMobile,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _buildInputField(
                  controller: _lastNameController,
                  hintText: 'Last Name',
                  isMobile: isMobile,
                ),
              ),
            ],
          ),

          SizedBox(height: isMobile ? 15 : 20),
          _buildInputField(
            controller: _emailController,
            hintText: 'Email',
            validator: _validateEmail,
            isMobile: isMobile,
          ),
          SizedBox(height: isMobile ? 15 : 20),
          _buildInputField(
            controller: _passwordController,
            hintText: 'Password',
            obscureText: !_isPasswordVisible,
            validator: _validatePassword,
            isMobile: isMobile,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.black54,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          SizedBox(height: isMobile ? 15 : 20),
          _buildInputField(
            controller: _confirmPasswordController,
            hintText: 'Confirm Password',
            obscureText: !_isConfirmPasswordVisible,
            validator: _validateConfirmPassword,
            isMobile: isMobile,
            suffixIcon: IconButton(
              icon: Icon(
                _isConfirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.black54,
              ),
              onPressed: () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              },
            ),
          ),
          SizedBox(height: isMobile ? 15 : 15),

          Row(
            children: [
              Checkbox(
                value: _isChecked,
                activeColor: oliveGreen,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value!;
                  });
                },
              ),
              Expanded(
                child: Text(
                  'I accept all the Privacy Policy & Terms',
                  style: TextStyle(fontSize: isMobile ? 13 : 14),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 15 : 25),

          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: oliveGreen,
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 40 : 60,
                  vertical: isMobile ? 15 : 18,
                ),
                minimumSize: Size(isMobile ? 150 : 180, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate() && _isChecked) {
                  // Process signup
                }
              },
              child: Text(
                'SIGN UP',
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(height: isMobile ? 15 : 20),

          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: MouseRegion(
                onEnter: (_) => setState(() => _isHovering = true),
                onExit: (_) => setState(() => _isHovering = false),
                child: Text(
                  "Already have an account? Login",
                  style: TextStyle(
                    color: _isHovering ? oliveGreen : charcoal,
                    fontSize: isMobile ? 13 : 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    String? Function(String?)? validator,
    Widget? suffixIcon,
    required bool isMobile,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: isMobile ? 10 : 0),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: oliveGreen, width: 7),
          top: BorderSide(color: charcoal.withOpacity(0.7)),
          right: BorderSide(color: charcoal.withOpacity(0.7)),
          bottom: BorderSide(color: charcoal.withOpacity(0.7)),
        ),
        boxShadow: [
          BoxShadow(
            color: oliveGreen.withOpacity(0.5),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black54),
          contentPadding: EdgeInsets.symmetric(
            vertical: isMobile ? 15 : 18,
            horizontal: isMobile ? 18 : 22,
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
        ),
        validator: validator,
      ),
    );
  }
}
