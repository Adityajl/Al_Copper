import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';
import 'home_screen.dart';  // Import your home screen

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _role = 'user';
  bool _isPhoneRegister = false;
  bool _isOTPSent = false;
  bool _isOTPMode = false;
  String? _verificationId;

  void _toggleRegisterMethod() {
    setState(() {
      _isPhoneRegister = !_isPhoneRegister;
      _nameController.clear();
      _companyController.clear();
      _emailController.clear();
      _phoneController.clear();
      _passwordController.clear();
      _otpController.clear();
      _isOTPSent = false;
    });
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

  void _register() async {
    if (_isPhoneRegister) {
      _registerWithPhone();
    } else {
      _registerWithEmail();
    }
  }

  void _registerWithEmail() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      User? user = userCredential.user;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({
          'name': _nameController.text,
          'company': _companyController.text,
          'email': user.email,
          'role': _role,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration successful!")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),  // Navigate to home screen
        );
      }
    } catch (e) {
      print('Error registering with email: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed: $e")),
      );
    }
  }

  void _registerWithPhone() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: _phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Phone registration successful!")),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Error registering with phone: $e');
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
      print('Error registering with phone: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error registering with phone: $e")),
      );
    }
  }

  void _submitOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _otpController.text,
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({
          'name': _nameController.text,
          'company': _companyController.text,
          'phone': _phoneController.text,
          'role': _role,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration successful!")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),  // Navigate to home screen
        );
      }
    } catch (e) {
      print('Error submitting OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP verification failed: $e")),
      );
    }
  }

  void _loginWithEmail() async {
    if (_isOTPMode) {
      _sendOTPForEmail();
    } else {
      _loginWithEmailAndPassword();
    }
  }

  void _loginWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login successful!")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),  // Navigate to home screen
      );
    } catch (e) {
      print('Error logging in with email: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: $e")),
      );
    }
  }

  void _sendOTPForEmail() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: _emailController.text,  // Assuming email is used as a unique identifier here
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login successful!")),
          );
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
        SnackBar(content: Text("Error sending OTP: $e")),
      );
    }
  }

  void _submitLoginOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _otpController.text,
      );
      await _auth.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP login successful!")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),  // Navigate to home screen
      );
    } catch (e) {
      print('Error submitting OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP login failed: $e")),
      );
    }
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
                  _isOTPMode ? 'Login with OTP' : (_isPhoneRegister ? 'Register with Phone' : 'Register with Email'),
                  style: GoogleFonts.roboto(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                if (!_isOTPMode)
                  ...[
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        filled: true,
                        fillColor: Colors.black.withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _companyController,
                      decoration: InputDecoration(
                        hintText: 'Company',
                        filled: true,
                        fillColor: Colors.black.withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20),
                  ],
                TextField(
                  controller: _isPhoneRegister ? _phoneController : _emailController,
                  decoration: InputDecoration(
                    hintText: _isPhoneRegister ? 'Phone' : 'Email',
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                  style: TextStyle(color: Colors.white),
                  keyboardType: _isPhoneRegister ? TextInputType.phone : TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                if (!_isOTPMode && !_isPhoneRegister)
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
                DropdownButton<String>(
                  value: _role,
                  dropdownColor: Color(0xFF121212),
                  onChanged: (String? newValue) {
                    setState(() {
                      _role = newValue!;
                    });
                  },
                  items: <String>['user', 'admin']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isOTPSent
                      ? (_isOTPMode ? _submitLoginOTP : _submitOTP)
                      : (_isOTPMode ? _sendOTPForEmail : _register),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _isOTPSent ? 'Submit OTP' : (_isOTPMode ? 'Send OTP' : (_isPhoneRegister ? 'Register' : 'Register')),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: _toggleRegisterMethod,
                  child: Text(
                    _isPhoneRegister ? 'Switch to Email Register' : 'Switch to Phone Register',
                    style: TextStyle(color: Colors.white),
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
                Text(
                  'Already a user?',
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
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    'Login here',
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
