import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileSetupScreen extends StatefulWidget {
  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _verificationId;
  bool _isOTPSent = false;
  bool _isEmailRegistered = false;
  bool _isPhoneRegistered = false;

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Your Profile'),
        backgroundColor: Color(0xFF121212),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Address Field
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16),

              // Phone Number Field (if not already registered)
              if (!_isPhoneRegistered)
                Column(
                  children: [
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 8),
                    if (!_isOTPSent)
                      ElevatedButton(
                        onPressed: _sendOTP,
                        child: Text('Send OTP'),
                      ),
                    if (_isOTPSent)
                      Column(
                        children: [
                          TextFormField(
                            controller: _otpController,
                            decoration: InputDecoration(labelText: 'Enter OTP'),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: _submitOTP,
                            child: Text('Submit OTP'),
                          ),
                          TextButton(
                            onPressed: _sendOTP,
                            child: Text('Resend OTP'),
                          ),
                        ],
                      ),
                  ],
                ),
              SizedBox(height: 16),

              // Email Field (if not already registered)
              if (!_isEmailRegistered)
                Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _linkEmail,
                      child: Text('Send Verification Link'),
                    ),
                  ],
                ),

              // Reset Password Button (if email is already registered)
              if (_isEmailRegistered)
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                TextButton(
                  onPressed: _sendPasswordResetEmail,
                  child: Text(
                    'Reset Password',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              SizedBox(height: 16),

              // Save Profile Button
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fetch user details from Firestore
  Future<void> _fetchDetails() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        final data = userDoc.data(); // Get the document data as a Map
        setState(() {
          _addressController.text = data?['address'] ?? '';
          _phoneController.text = data?['phone'] ?? '';
          _emailController.text = data?['email'] ?? '';
          _isEmailRegistered = data?['email'] != null;
          _isPhoneRegistered = data?['phone'] != null;
        });
      } else {
        print('Document does not exist for user: ${user.uid}');
      }
    } else {
      print('User is not logged in');
    }
  }

  // Update Firestore with new profile details
  Future<void> _updateProfileInFirestore(String address, String phone, String email) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'address': address,
        'phone': phone,
        'email': email,
      });
      print('Profile updated in Firestore!');
    }
  }

  // Send OTP for phone number verification
  Future<void> _sendOTP() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: _phoneController.text,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await user.linkWithCredential(credential);
            print('Phone number linked successfully!');
            setState(() {
              _isOTPSent = false;
              _isPhoneRegistered = true;
            });
          },
          verificationFailed: (FirebaseAuthException e) {
            print('Verification failed: ${e.message}');
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
      }
    }
  }

  // Submit OTP for phone number verification
  Future<void> _submitOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _otpController.text,
      );
      await _auth.currentUser?.linkWithCredential(credential);
      print('Phone number linked successfully!');
      setState(() {
        _isOTPSent = false;
        _isPhoneRegistered = true;
      });
    } catch (e) {
      print('Error submitting OTP: $e');
    }
  }

  // Link email to the user's account
  Future<void> _linkEmail() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        AuthCredential credential = EmailAuthProvider.credential(
          email: _emailController.text,
          password: _passwordController.text,
        );
        await user.linkWithCredential(credential);
        await user.sendEmailVerification();
        print('Email linked and verification email sent!');
        setState(() {
          _isEmailRegistered = true;
        });
      } catch (e) {
        print('Error linking email: $e');
      }
    }
  }

  // Send password reset email
  Future<void> _sendPasswordResetEmail() async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      print('Password reset email sent!');
    } catch (e) {
      print('Error sending password reset email: $e');
    }
  }

  // Save profile details
  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final user = _auth.currentUser;
      if (user != null) {
        // Update Firestore
        await _updateProfileInFirestore(
          _addressController.text,
          _phoneController.text,
          _emailController.text,
        );

        // Link phone number if it's new
        if (_phoneController.text.isNotEmpty && !_isPhoneRegistered) {
          await _sendOTP();
        }

        // Link email if it's new
        if (_emailController.text.isNotEmpty && !_isEmailRegistered) {
          await _linkEmail();
        }

        Navigator.pop(context); // Return to the previous screen
      }
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _otpController.dispose();
    super.dispose();
  }
}