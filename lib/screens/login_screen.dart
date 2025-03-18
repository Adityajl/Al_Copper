import 'package:Al_copper/screens/admin_panel.dart';
import 'package:Al_copper/screens/forgot_password_screen.dart';
import 'package:Al_copper/screens/register_screen.dart';
import 'package:Al_copper/screens/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/session_manager.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isOTPSent = false;
  bool _isOTPMode = false;
  String? _verificationId;

  @override
  void initState() {
    super.initState();
    _checkSessionAndNavigate();
  }

  Future<void> _checkSessionAndNavigate() async {
    Map<String, String>? sessionData = await SessionManager.checkSession();
    if (sessionData != null) {
      _navigateBasedOnRole(sessionData['role']!);
    }
  }

  void _navigateBasedOnRole(String role) {
    if (role == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminPanel()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  void _login() async {
    if (_isOTPMode) {
      _sendOTPForPhone();
    } else {
      _loginWithEmailAndPassword();
    }
  }

  void _loginWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      User? user = userCredential.user;
      if (user != null) {
        if (user.emailVerified) {
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
          Map<String, dynamic> userData = userDoc.data() as Map<String,
              dynamic>;
          await SessionManager.saveSessionData(user.uid, userData['role']);
          if (userData['role'] == 'admin') {
            // Navigate to admin dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>
                  AdminPanel()), // Navigate to admin panel
            );
          } else {
            // Navigate to user dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>
                  HomeScreen()), // Navigate to home screen
            );
          }
        }
        else{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EmailVerificationScreen()), // Navigate to verification screen
          );
        }
      }
    } catch (e) {
      print('Error logging in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: ${e.toString()}")),
      );
    }
  }

  void _sendOTPForPhone() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: _phoneController.text,  // Assuming email field is used for phone number in OTP mode
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Phone login successful!")),
          );
          _navigateToHomeOrAdmin();
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Error during phone verification: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Verification failed: ${e.message}")),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
            _isOTPSent = true;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
          });
        },
      );
    } catch (e) {
      print('Error sending OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error sending OTP: ${e.toString()}")),
      );
    }
  }

  void _submitOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _otpController.text,
      );
      await _auth.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP login successful!")),
      );
      _navigateToHomeOrAdmin();
    } catch (e) {
      print('Error submitting OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP login failed: ${e.toString()}")),
      );
    }
  }

  void _navigateToHomeOrAdmin() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      await SessionManager.saveSessionData(user.uid, userData['role']);
      if (userData['role'] == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminPanel()),  // Navigate to admin panel
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),  // Navigate to home screen
        );
      }
    }
  }

  void _toggleOTPMode() {
    setState(() {
      _isOTPMode = !_isOTPMode;
      _emailController.clear();
      _passwordController.clear();
      _otpController.clear();
      _isOTPSent = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  _isOTPMode ? 'Login with OTP' : 'Login',
                  style: GoogleFonts.roboto(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _isOTPMode ? _phoneController : _emailController,
                  decoration: InputDecoration(
                    hintText: _isOTPMode ? 'Phone' : 'Email',
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                  style: TextStyle(color: Colors.white),
                  keyboardType: _isOTPMode ? TextInputType.phone : TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                if (!_isOTPMode)
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: TextStyle(color: Colors.white54),
                    ),
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                  ),
                if (_isOTPSent)
                  Column(
                    children: [
                      SizedBox(height: 20),
                      TextField(
                        controller: _otpController,
                        decoration: InputDecoration(
                          hintText: 'Enter OTP',
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintStyle: TextStyle(color: Colors.white54),
                        ),
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isOTPSent ? _submitOTP : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _isOTPSent ? 'Submit OTP' : (_isOTPMode ? 'Send OTP' : 'Login with Email'),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                if(!_isOTPMode)
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                    child: Text(
                      'Forgot Password',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                TextButton(
                  onPressed: _toggleOTPMode,
                  child: Text(
                    _isOTPMode ? 'Switch to Email/Password Login' : 'Switch to OTP Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Divider(color: Colors.white54), // Optional: to visually separate the sections
                // Link to the login screen
                Text(
                  'New user?',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    'Register here',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}