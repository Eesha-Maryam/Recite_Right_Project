import 'package:flutter/material.dart';
import 'package:recite_right_project/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ResetPasswordForm.dart';

const Color charcoal = Color(0xFF555555);
const Color oliveGreen = Color(0xFF97B469);

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
  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _isHovering = false;
  bool _showEmailError = false;
  bool _showPasswordError = false;
  String _emailErrorText = '';
  String _passwordErrorText = '';
  double _passwordFieldSpacing = 8.0;
  double _formTopPosition = 0.25; // Initial top position (25% of screen height)
  double _formTopAdjustment = 0.04; // Adjustable value for form movement (2% of screen height)
  double _imageTopPosition = 0.17; // Fixed position for image placeholder

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
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

  void _handleLogin() async {
    // Reset error states and spacing
    setState(() {
      _showEmailError = false;
      _showPasswordError = false;
      _emailErrorText = '';
      _passwordErrorText = '';
      _passwordFieldSpacing = 8.0;
      _formTopPosition = 0.25; // Reset to original position
    });

    // Validate fields
    bool isValid = true;

    if (_emailController.text.isEmpty) {
      setState(() {
        _showEmailError = true;
        _emailErrorText = 'This field is required';
        _passwordFieldSpacing = 15.0;
        _formTopPosition = 0.25 - _formTopAdjustment; // Move form up
      });
      isValid = false;
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _showPasswordError = true;
        _passwordErrorText = 'This field is required';
        _passwordFieldSpacing = 15.0;
        // Only adjust position if it hasn't been adjusted yet
        if (_formTopPosition == 0.25) {
          _formTopPosition = 0.25 - _formTopAdjustment;
        }
      });
      isValid = false;
    } else if (_passwordController.text.length < 6) {
      setState(() {
        _showPasswordError = true;
        _passwordErrorText = 'Password must be at least 6 characters';
        _passwordFieldSpacing = 15.0;
        // Only adjust position if it hasn't been adjusted yet
        if (_formTopPosition == 0.25) {
          _formTopPosition = 0.25 - _formTopAdjustment;
        }
      });
      isValid = false;
    }

    if (isValid) {
      final email = _emailController.text;
      final password = _passwordController.text;

      if (email == 'user@example.com' && password == 'password123') {
        await _saveCredentials();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Successful'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid email or password'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
                    top: height * _imageTopPosition, // Fixed position for image
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
                  left: (width - formWidth - (isDesktop ? imageWidth - 20 : 0)) / 2,
                  top: height * _formTopPosition, // Dynamic position for form
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

  // Rest of your code remains the same...
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
              fillColor: Colors.white,
              errorStyle: TextStyle(height: 0),
            ),
          ),
        ),
        if (showError)
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 4.0,
            ), // Increased internal padding
            margin: EdgeInsets.only(
              left: 8.0,
              top: 4.0,
            ), // Increased top margin
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
              onEnter: (_) => setState(() => _isHovering = true),
              onExit: (_) => setState(() => _isHovering = false),
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: _isHovering ? oliveGreen : charcoal,
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
        onPressed: _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: oliveGreen,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 40 : 60,
            vertical: isMobile ? 15 : 18,
          ),
          minimumSize: Size(isMobile ? 150 : 180, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 14 : 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSignupLink(bool isMobile) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpPage()),
          );
        },
        child: Text(
          "Don't have an account? Signup",
          style: TextStyle(color: charcoal, fontSize: isMobile ? 13 : 14),
        ),
      ),
    );
  }
}
