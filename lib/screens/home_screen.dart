import 'package:Al_copper/screens/admin_panel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'retail_screen.dart'; // Import RetailScreen for navigation
import 'buy_screen.dart'; // Import BuyScreen for navigation
import 'consultancy_screen.dart'; // Import ConsultancyScreen for navigation
import 'profile_screen.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isAdmin = false; // Track if the user is an admin
  String _name = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _checkIfAdmin(); // Check if the user is an admin
  }

  Future<void> _checkIfAdmin() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if(userDoc.exists){
        setState(() {
          _name = userDoc.data()?['name'];
        });
      }
      if (userDoc.exists && userDoc.data()?['role'] == 'admin') {
        setState(() {
          _isAdmin = true;
        });
      }
    }
  }




  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(userName: _name), // Add custom name here
      RetailScreen(),
      BuyScreen(),
      ConsultancyScreen(),
      AdminPanel(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('AlCopper'),
        backgroundColor: Color(0xFF121212),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          IconButton(icon: Icon(Icons.person), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()),);
          }), // User profile icon
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6C63FF), Color(0xFF3F2B8D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BottomNavigationBar(
          items: _isAdmin
              ? const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Live Rates'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Buy'),
            BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Consultancy'),
            BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: 'Admin Panel'), // Admin Panel option
          ]
              : const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Live Rates'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Buy'),
            BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Consultancy'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String userName;

  HomePage({required this.userName});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAboutSection(),
            SizedBox(height: 16),
            Text(
              'Welcome, $userName!',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              DateFormat('EEEE, d MMMM yyyy, HH:mm').format(DateTime.now()),
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),
            _buildRatesSummary(),
            SizedBox(height: 16),
            _buildConsultancyHighlights(),
            SizedBox(height: 16),
            _buildBooksAndGuides(),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Us',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            'GST Number: 1234567890ABCD',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Feedback email: ',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),

          SizedBox(height: 4),
          InkWell(
            onTap: () {
              'USHAMETALS29@gmail.com';
            },
            child: Text(
              'USHAMETALS29@gmail.com',
              style: TextStyle(color: Colors.blueAccent, fontSize: 16, decoration: TextDecoration.underline),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Company Information:',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            'AlCopper is a leading company in the metal industry, providing a wide range of metal products and services. Our mission is to deliver high-quality metal products to our customers with excellent customer service.',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          SizedBox(height:16),
          InkWell(
            onTap: () async {
              final url = 'https://wa.me/919565909177';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Text(
              'Whatsapp for Enquiry ',
              style: TextStyle(color: Colors.green, fontSize: 16, decoration: TextDecoration.underline),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildRatesSummary() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Metal Prices',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetalCard('Lead', '\$10,000/kg', Icons.battery_charging_full, Colors.blueGrey),
              _buildMetalCard('Iron', '\$20,000/kg', Icons.construction, Colors.brown),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetalCard('Copper', '\$7,000/kg', Icons.memory, Colors.orange),
              _buildMetalCard('Aluminium', '\$3,000/kg', LineIcons.industry, Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetalCard(String metal, String rate, IconData icon, Color color) {
    return Expanded(
      child: Card(
        color: Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 40),
              SizedBox(height: 8),
              Text(
                metal,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                rate,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConsultancyHighlights() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Consultancy Highlights',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildServiceIcon(Icons.lightbulb_outline, 'Tips'),
              _buildServiceIcon(Icons.school, 'Courses'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.tealAccent, size: 40),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildBooksAndGuides() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Books & Guides',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 8),
          Card(
            color: Color(0xFF1F1F1F),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.book, color: Colors.pinkAccent, size: 40),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mastering Metal Trades',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'by Puneet Kumar',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
