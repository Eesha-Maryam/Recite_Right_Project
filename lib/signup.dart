import 'package:flutter/material.dart';
import 'login.dart';
import 'dart:math';

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

  // Form positioning variables
  double _baseTopPosition = 0.18;
  double _formTopPosition = 0.18;
  double _maxTopAdjustment = 0.08;
  double _perErrorAdjustment = 0.02;
  double _imageTopPosition = 0.10;

  // Error states
  bool _showEmailError = false;
  bool _showPasswordError = false;
  bool _showConfirmPasswordError = false;
  bool _showTermsError = false;
  double _fieldSpacing = 8.0;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(value)) {
      return 'Must contain upper, lower, and number';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  void _checkErrors() {
    setState(() {
      _showEmailError = _validateEmail(_emailController.text) != null;
      _showPasswordError = _validatePassword(_passwordController.text) != null;
      _showConfirmPasswordError =
          _validateConfirmPassword(_confirmPasswordController.text) != null;
      _showTermsError = !_isChecked;

      // Count active errors
      int errorCount =
          [
            _showEmailError,
            _showPasswordError,
            _showConfirmPasswordError,
            _showTermsError,
          ].where((e) => e).length;

      // Calculate dynamic adjustment
      double adjustment = errorCount * _perErrorAdjustment;
      _formTopPosition = _baseTopPosition - min(adjustment, _maxTopAdjustment);
    });
  }

  void _handleSignUp() {
    final isValid = _formKey.currentState?.validate() ?? false;
    _checkErrors();

    if (isValid && _isChecked) {
      // Process successful signup
      print('Sign up successful');
    }
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

                if (isDesktop)
                  Positioned(
                    left: (width - formWidth - imageWidth) / 2 + formWidth - 20,
                    top: height * _imageTopPosition,
                    child: Container(
                      width: imageWidth,
                      height: 620,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/SignUp_Banner.png',
                          width: imageWidth,
                          height: 620,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left:
                      (width - formWidth - (isDesktop ? imageWidth - 20 : 0)) /
                      2,
                  top: height * _formTopPosition,
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

          SizedBox(height: _fieldSpacing),
          _buildInputField(
            controller: _emailController,
            hintText: 'Email',
            isMobile: isMobile,
          ),
          if (_showEmailError)
            _buildErrorText(_validateEmail(_emailController.text) ?? ''),

          SizedBox(height: _fieldSpacing),
          _buildInputField(
            controller: _passwordController,
            hintText: 'Password',
            obscureText: !_isPasswordVisible,
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
          if (_showPasswordError)
            _buildErrorText(_validatePassword(_passwordController.text) ?? ''),

          SizedBox(height: _fieldSpacing),
          _buildInputField(
            controller: _confirmPasswordController,
            hintText: 'Confirm Password',
            obscureText: !_isConfirmPasswordVisible,
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
          if (_showConfirmPasswordError)
            _buildErrorText(
              _validateConfirmPassword(_confirmPasswordController.text) ?? '',
            ),

          SizedBox(height: 10),
          Row(
            children: [
              Checkbox(
                value: _isChecked,
                activeColor: oliveGreen,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value!;
                    _showTermsError = false;
                  });
                },
              ),
              Text(
                'I accept all the Privacy Policy & Terms',
                style: TextStyle(fontSize: isMobile ? 13 : 14),
              ),
            ],
          ),
          if (_showTermsError)
            Padding(
              padding: EdgeInsets.only(left: 8, top: 4),
              child: _buildErrorText('You must accept the terms'),
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
              onPressed: _handleSignUp,
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
    Widget? suffixIcon,
    required bool isMobile,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
          child: TextField(
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
          ),
        ),
      ],
    );
  }

  Widget _buildErrorText(String error) {
    return Padding(
      padding: EdgeInsets.only(left: 8, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 16),
          SizedBox(width: 5),
          Expanded(
            child: Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
