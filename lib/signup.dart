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
  bool _isChecked = false; // Checkbox state
  bool _isPasswordVisible = false; // Password visibility state
  bool _isConfirmPasswordVisible = false; // Confirm password visibility state

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

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: oliveGreen, width: 7), // Left border only
        ),
        boxShadow: [
          BoxShadow(
            color: oliveGreen.withOpacity(0.5),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(3, 3), // Soft bottom-right shadow
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
            vertical: 12,
            horizontal: 15, // Adjusted horizontal padding
          ),
          suffixIcon: suffixIcon, // Add suffix icon for password fields
          // Removing default borders
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,

          filled: true,
          fillColor: Colors.white,
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double formWidth = constraints.maxWidth * 0.25;
          double imageWidth = constraints.maxWidth * 0.25;

          if (constraints.maxWidth < 1100) {
            formWidth = constraints.maxWidth * 0.35;
            imageWidth = constraints.maxWidth * 0.35;
          }

          return Stack(
            children: [
              Positioned(
                top: 20,
                left: 20,
                child: Row(
                  children: [
                    Image.asset('assets/QuranLogo.png', width: 35, height: 35),
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

              Positioned(
                left: constraints.maxWidth * 0.50,
                top: constraints.maxHeight * 0.12,
                child: Container(
                  width: imageWidth,
                  constraints: BoxConstraints(minHeight: 470),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'SignUp_Banner.png',
                      width: 200,
                      height: 580,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              Positioned(
                top:
                    constraints.maxHeight *
                    0.17, // Adjusted to move the form upwards
                left: constraints.maxWidth * 0.26,
                child: Container(
                  width: formWidth,
                  padding: EdgeInsets.all(30),
                  constraints: BoxConstraints(minHeight: 300),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.97),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // Added circular radius to form
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: charcoal,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),

                        Row(
                          children: [
                            Expanded(
                              child: _buildInputField(
                                controller: _firstNameController,
                                hintText: 'First Name',
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: _buildInputField(
                                controller: _lastNameController,
                                hintText: 'Last Name',
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),
                        _buildInputField(
                          controller: _emailController,
                          hintText: 'Email',
                          validator: _validateEmail,
                        ),
                        SizedBox(height: 20),
                        _buildInputField(
                          controller: _passwordController,
                          hintText: 'Password',
                          obscureText: !_isPasswordVisible,
                          validator: _validatePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color:
                                  Colors
                                      .black54, // Changed eye icon color to charcoal
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        _buildInputField(
                          controller: _confirmPasswordController,
                          hintText: 'Confirm Password',
                          obscureText: !_isConfirmPasswordVisible,
                          validator: _validateConfirmPassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color:
                                  Colors
                                      .black54, // Changed eye icon color to charcoal
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 15),

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
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),

                        Center(
                          child: SizedBox(
                            width: 150, // Reduced button width
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: oliveGreen,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    _isChecked) {
                                  // Process signup
                                }
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),

                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Already have an account? Login",
                              style: TextStyle(color: charcoal, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
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
}
