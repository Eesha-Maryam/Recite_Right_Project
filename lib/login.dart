import 'package:flutter/material.dart';
import 'package:recite_right_project/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ResetPasswordForm.dart'; // Import ResetPasswordForm
// Import SignUp pages

const Color charcoal = Color(0xFF333333);
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
  bool _obscurePassword = true; // For eye icon toggle
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
                top: constraints.maxHeight * 0.15,
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
                      'assets/LoginBanner.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: constraints.maxHeight * 0.20,
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
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: charcoal,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),

                        // Email Field
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(color: oliveGreen, width: 5),
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
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Enter your Email',
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black54,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        // Password Field with Eye Icon
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(color: oliveGreen, width: 5),
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
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              hintText: 'Enter your Password',
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                              prefixIcon: Icon(
                                Icons.vpn_key,
                                color: Colors.black54,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black54,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        // Remember Me & Forgot Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value!;
                                    });
                                  },
                                  activeColor: oliveGreen,
                                ),
                                Text("Remember Me"),
                              ],
                            ),
                            MouseRegion(
                              onEnter: (_) {
                                setState(() {
                                  _isHovering = true;
                                });
                              },
                              onExit: (_) {
                                setState(() {
                                  _isHovering = false;
                                });
                              },
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResetPasswordPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: _isHovering ? oliveGreen : charcoal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 25),

                        // Login Button
                        Center(
                          child: ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: oliveGreen,
                              padding: EdgeInsets.symmetric(
                                horizontal: 60,
                                vertical: 18,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        // Sign Up Link
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ), // Ensure Signup() is imported
                              );
                            },
                            child: Text(
                              "Don't have an account? Sign Up",
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
