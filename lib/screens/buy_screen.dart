import 'package:flutter/material.dart';
import 'dart:ui'; // For ImageFilter

class BuyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Books'),
        backgroundColor: Color(0xFF121212),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {
            // Navigate to cart
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75, // Adjust the aspect ratio for card size
          ),
          itemCount: bookNames.length, // Use the length of the bookNames list
          itemBuilder: (context, index) {
            return _buildBookCard(context, index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to cart
        },
        child: Icon(Icons.shopping_cart),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  Widget _buildBookCard(BuildContext context, int index) {
    // List of flat colors for book covers
    final List<Color> bookColors = [
      Colors.blueGrey,
      Colors.teal,
      Colors.deepPurple,
      Colors.deepOrange,
      Colors.indigo,
      Colors.cyan,
    ];

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookPreviewScreen(bookNames[index])),
        );
      },
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 250, // Increased height for larger icons
        borderRadius: 20,
        blur: 20,
        alignment: Alignment.bottomCenter,
        border: 2,
        linearGradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.1),
            Colors.grey.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderGradient: LinearGradient(
          colors: [
            Colors.grey.withOpacity(0.5),
            Colors.black.withOpacity(0.5),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: bookColors[index % bookColors.length], // Apply flat color
                ),
                child: Center(
                  child: Icon(Icons.book, color: Colors.white, size: 70), // Larger book icon
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookNames[index],
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '₹Price',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Glassmorphic container widget
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

// List of book names
final List<String> bookNames = [
  '5 Aluminum Scrap Type International',
  'Domestic Aluminium Scrap Type',
  'Lead Types of Grades and Process',
  'Copper Book',
  'Lead Acid Battery Merged',
  'Iron and Scrap Types',
  'Mixed Metal Types of Grades',
  'Motor Scrap Types and Recovery',
];

// Book Preview Screen
class BookPreviewScreen extends StatelessWidget {
  final String bookTitle;

  BookPreviewScreen(this.bookTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Preview'),
        backgroundColor: Color(0xFF121212),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bookTitle,
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Author: Puneet Kumar',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'First Page of the Book...',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Spacer(),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
              ),
              onPressed: () {
                // Handle purchase
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FullBookScreen(bookTitle)),
                );
              },
              child: Text('Buy Now to Read More'),
            ),
          ],
        ),
      ),
    );
  }
}

// Full Book Screen
class FullBookScreen extends StatelessWidget {
  final String bookTitle;

  FullBookScreen(this.bookTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Book'),
        backgroundColor: Color(0xFF121212),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bookTitle,
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Author: Puneet Kumar',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'Full Content of the Book...',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
