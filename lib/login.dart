import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recite_right_project/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ResetPasswordForm.dart';
import 'homepage.dart';
import 'dart:convert';

const Color charcoal = Color(0xFF555555);
const Color oliveGreen = Color(0xFF97B469);
const Color creamWhite = Color(0xFFF8F5F0);

void main() {
  runApp(MaterialApp(home: LoginPage(), debugShowCheckedModeBanner: false));
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _storage = FlutterSecureStorage(); // For secure token storage
  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _isLoading = false; // Added loading state
  bool _isLoginHovering = false;
  bool _isForgotPasswordHovering = false;
  bool _showEmailError = false;
  bool _showPasswordError = false;
  String _emailErrorText = '';
  String _passwordErrorText = '';
  double _passwordFieldSpacing = 8.0;
  double _formTopPosition = 0.25;
  double _formTopAdjustment = 0.04;
  double _imageTopPosition = 0.17;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  // Validate email format
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailController.text = prefs.getString('email') ?? '';
      _passwordController.text = prefs.getString('password') ?? '';
      _rememberMe = prefs.getBool('rememberMe') ?? false;
    });
  }

  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('email', _emailController.text);
      await prefs.setString('password', _passwordController.text);
      await prefs.setBool('rememberMe', true);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.setBool('rememberMe', false);
    }
  }

  Future<void> _handleLogin() async {
    if (_isLoading) return;

    // Reset states
    setState(() {
      _showEmailError = false;
      _showPasswordError = false;
      _emailErrorText = '';
      _passwordErrorText = '';
      _passwordFieldSpacing = 8.0;
      _formTopPosition = 0.25;
      _isLoading = true;
    });

    bool hasEmailError = false;
    bool hasPasswordError = false;

    // Validate email format
    if (!_isValidEmail(_emailController.text)) {
      hasEmailError = true;
      _emailErrorText = 'Please enter a valid email address';
    }

    // Validate password
    if (_passwordController.text.isEmpty) {
      hasPasswordError = true;
      _passwordErrorText = 'Password is required';
    } else if (_passwordController.text.length < 6) {
      hasPasswordError = true;
      _passwordErrorText = 'Password must be at least 6 characters long';
    }

    if (hasEmailError || hasPasswordError) {
      setState(() {
        _showEmailError = hasEmailError;
        _showPasswordError = hasPasswordError;
        _passwordFieldSpacing = 15.0;
        if (hasEmailError && hasPasswordError) {
          _formTopPosition =
              0.25 - (_formTopAdjustment * 1.5); // Extra space for two errors
        } else if (_formTopPosition == 0.25) {
          _formTopPosition = 0.25 - _formTopAdjustment;
        }
        _isLoading = false;
      });
      return;
    }

    // Rest of your login logic...
    try {
      final url = Uri.parse('https://your-api-url.com/login');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'email': _emailController.text,
        'password': _passwordController.text,
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          await _saveCredentials();

          if (data['token'] != null) {
            await _storage.write(key: 'auth_token', value: data['token']);
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                data['message'] ?? 'Unable to login. Please try again.',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Server error (${response.statusCode}). Please try again later.',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network error. Please check your connection.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamWhite,
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
                  bottom: height * 0.45,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/LoginBanner.png',
                        width: width,
                        height: height * 0.55,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                    decoration: BoxDecoration(
                      color: creamWhite,
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
                    child: _buildFormContent(isMobile),
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
                        width: isTablet ? 35 : 35,
                        height: isTablet ? 35 : 35,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'RECITE RIGHT',
                        style: TextStyle(
                          fontSize: isTablet ? 22 : 22,
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
                      height: 520,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/LoginBanner.png',
                          width: imageWidth,
                          height: 520,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                Positioned(
                  left:
                      (width - formWidth - (isDesktop ? imageWidth - 20 : 0)) /
                      2,
                  top: height * _formTopPosition,
                  child: Container(
                    width: formWidth,
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: creamWhite.withOpacity(0.97),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _buildFormContent(isMobile),
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
              'Login',
              style: TextStyle(
                fontSize: isMobile ? 22 : 24,
                fontWeight: FontWeight.bold,
                color: charcoal,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 25 : 25),

          _buildTextField(
            controller: _emailController,
            hintText: 'Enter your Email',
            icon: Icons.email,
            isMobile: isMobile,
            showError: _showEmailError,
            errorText: _emailErrorText,
          ),

          SizedBox(
            height:
                isMobile ? _passwordFieldSpacing : _passwordFieldSpacing + 7,
          ),

          _buildTextField(
            controller: _passwordController,
            hintText: 'Enter your Password',
            icon: Icons.vpn_key,
            isMobile: isMobile,
            isPassword: true,
            obscureText: _obscurePassword,
            onToggleVisibility: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            showError: _showPasswordError,
            errorText: _passwordErrorText,
          ),

          SizedBox(height: isMobile ? 10 : 15),

          _buildRememberForgotRow(isMobile),

          SizedBox(height: isMobile ? 15 : 20),

          _buildLoginButton(isMobile),

          SizedBox(height: isMobile ? 10 : 15),

          _buildSignupLink(isMobile),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
    required bool isMobile,
    bool showError = false,
    String errorText = '',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            border: const Border(left: BorderSide(color: oliveGreen, width: 7)),
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
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: isMobile ? 15 : 18,
                horizontal: isMobile ? 18 : 22,
              ),
              prefixIcon: Icon(icon, color: Colors.black54),
              suffixIcon:
                  isPassword
                      ? IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black54,
                        ),
                        onPressed: onToggleVisibility,
                      )
                      : null,
              filled: true,
              fillColor: creamWhite,
              errorStyle: TextStyle(height: 0),
            ),
          ),
        ),
        if (showError)
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            margin: EdgeInsets.only(left: 8.0, top: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 14),
                SizedBox(width: 5),
                Flexible(
                  child: Text(
                    errorText,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: isMobile ? 12 : 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildRememberForgotRow(bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value!;
                  });
                },
                activeColor: oliveGreen,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              Flexible(
                child: Text(
                  "Remember Me",
                  style: TextStyle(fontSize: isMobile ? 13 : 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Flexible(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResetPasswordPage()),
              );
            },
            child: MouseRegion(
              onEnter: (_) => setState(() => _isForgotPasswordHovering = true),
              onExit: (_) => setState(() => _isForgotPasswordHovering = false),
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: _isForgotPasswordHovering ? oliveGreen : charcoal,
                  fontSize: isMobile ? 13 : 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton(bool isMobile) {
    return Center(
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: oliveGreen,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 40 : 60,
            vertical: isMobile ? 15 : 18,
          ),
          minimumSize: Size(isMobile ? 150 : 180, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child:
            _isLoading
                ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: creamWhite,
                    strokeWidth: 2,
                  ),
                )
                : Text(
                  'LOGIN',
                  style: TextStyle(
                    color: creamWhite,
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
      ),
    );
  }

  Widget _buildSignupLink(bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account? "),
        MouseRegion(
          onEnter: (_) => setState(() => _isLoginHovering = true),
          onExit: (_) => setState(() => _isLoginHovering = false),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
              );
            },
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: _isLoginHovering ? oliveGreen : charcoal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
