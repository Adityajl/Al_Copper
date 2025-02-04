import 'package:flutter/material.dart';
import 'package:flutter/animation.dart'; // For animations
import 'package:intl/intl.dart';

import 'dart:ui';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E), // Dark background color
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFF121212),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            // Profile picture with animation and glassmorphism effect
            GlassmorphicContainer(
              width: 120,
              height: 120,
              borderRadius: 60,
              blur: 20,
              alignment: Alignment.bottomCenter,
              border: 2,
              linearGradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderGradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.5),
                  Colors.purple.withOpacity(0.5),
                ],
              ),
              child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage('<Your Profile Picture URL>'),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Name with gradient text style
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
              ),
            ),
            SizedBox(height: 10),
            // Job Title with a modern font and shadow effect
            Text(
              'Metal Trader Enthusiast',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.blueAccent,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Profile details section with improved styling
            _buildProfileDetail(Icons.email, 'Email', 'john.doe@example.com'),
            _buildProfileDetail(Icons.phone, 'Phone', '+91 12345 67890'),
            _buildProfileDetail(Icons.location_on, 'Location', 'Delhi, India'),
            SizedBox(height: 30),
            // Last transactions section
            Text(
              'Last Transactions',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            _buildTransactionCard('Bought Gold', '₹50,000', DateTime.now()),
            _buildTransactionCard('Sold Silver', '₹45,000', DateTime.now().subtract(Duration(days: 1))),
            _buildTransactionCard('Bought Copper', '₹7,000', DateTime.now().subtract(Duration(days: 2))),
            SizedBox(height: 30),
            // Courses enrolled section
            Text(
              'Courses Enrolled',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            _buildCourseCard('Metal Trading 101'),
            _buildCourseCard('Advanced Metal Analysis'),
            _buildCourseCard('Metal Markets and Trends'),
            SizedBox(height: 20),
            // Add a logout button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 14)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                ),
                onPressed: () {
                  // Handle logout
                },
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetail(IconData icon, String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.pinkAccent),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                detail,
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(String title, String amount, DateTime date) {
    return Card(
      color: Color(0xFF2C2C2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.attach_money, color: Colors.greenAccent),
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(date),
          style: TextStyle(color: Colors.white70),
        ),
        trailing: Text(
          amount,
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }

  Widget _buildCourseCard(String courseName) {
    return Card(
      color: Color(0xFF2C2C2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.school, color: Colors.tealAccent),
        title: Text(
          courseName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Glassmorphism container widget
class GlassmorphicContainer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final double blur;
  final Alignment alignment;
  final double border;
  final LinearGradient linearGradient;
  final LinearGradient borderGradient;
  final Widget child;

  const GlassmorphicContainer({
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.blur,
    required this.alignment,
    required this.border,
    required this.linearGradient,
    required this.borderGradient,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        alignment: alignment,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: Container(
                alignment: alignment,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  gradient: linearGradient,
                  border: Border.all(width: border, color: Colors.transparent),
                ),
                child: child,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: borderGradient,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
