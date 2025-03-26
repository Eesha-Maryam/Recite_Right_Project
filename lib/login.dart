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
    if (_formKey.currentState!.validate()) {
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
                    child: buildFormContent(true),
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
                    left:
                        (width - formWidth - imageWidth) / 2 +
                        formWidth -
                        20, // 20px overlap
                    top: height * 0.17,
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
                      2, // Account for overlap
                  top: height * 0.25,
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
                    child: buildFormContent(false),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget buildFormContent(bool isMobile) {
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

          buildTextField(
            controller: _emailController,
            hintText: 'Enter your Email',
            icon: Icons.email,
            isMobile: isMobile,
          ),

          SizedBox(height: isMobile ? 15 : 20),

          buildTextField(
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
          ),

          SizedBox(height: isMobile ? 15 : 20),

          buildRememberForgotRow(isMobile),

          SizedBox(height: isMobile ? 15 : 25),

          buildLoginButton(isMobile),

          SizedBox(height: isMobile ? 15 : 20),

          buildSignupLink(isMobile),
        ],
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
    required bool isMobile,
  }) {
    return Container(
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
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          if (isPassword && value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
      ),
    );
  }

  Widget buildRememberForgotRow(bool isMobile) {
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

  Widget buildLoginButton(bool isMobile) {
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

  Widget buildSignupLink(bool isMobile) {
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
