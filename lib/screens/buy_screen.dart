import 'package:flutter/material.dart';
import 'dart:ui'; // For ImageFilter
import 'package:url_launcher/url_launcher.dart'; // Add this import for URL launching
import 'package:pay/pay.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// List of books with local image paths and download links
final List<Book> books = [
  Book('5 Aluminum Scrap Type International', 'lib/images/B1.png', 'https://drive.google.com/file/d/1RjToDL58u__ivovald8jp50k9HhBoMrO/view'),
  Book('Lead Acid Batteries', 'lib/images/B2.png', 'https://drive.google.com/file/d/1RjToDL58u__ivovald8jp50k9HhBoMrO/view'),
  Book('Copper Recycling', 'lib/images/B3.png', 'https://drive.google.com/file/d/1ZPfRKGEAM37KdM4XXBMnlXuPype0WNiu/view'),
  Book('Aluminium Scrap Domestic', 'lib/images/B4.png', 'https://drive.google.com/file/d/1l3ePl3WEd5Gorzoc-4dvUBv7SXUtDPOh/view'),
  Book('Ferrous Scrap Grades', 'lib/images/B5.png', 'https://drive.google.com/file/d/1qAPNvc9vonLqxRkuIugVQMz4LYaGzmql/view'),
  Book('Iron and Scrap Types', 'lib/images/B6.png', 'https://drive.google.com/file/d/1veWubZlcEqssjs3HF8xRDjZGl0g9QAcQ/view'),
  Book('Mixed Metal Types of Grades', 'lib/images/B7.png', 'https://drive.google.com/file/d/1UnwmWeQS_bvLiSgWKIqgrmwazsMe4Q-t/view'),
];

class Book {
  final String title;
  final String firstPageImagePath;
  final String downloadLink;

  Book(this.title, this.firstPageImagePath, this.downloadLink);
}

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
          itemCount: books.length, // Use the length of the books list
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
          MaterialPageRoute(builder: (context) => BookPreviewScreen(books[index])),
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
                    books[index].title,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '₹1000',
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                    ),
                    onPressed: () async {
                      // Redirect to WhatsApp link
                      final whatsappUrl = 'https://wa.me/919565909177?text=Hi, I am interested in purchasing the book: ${books[index].title}';
                      if (await canLaunch(whatsappUrl)) {
                        await launch(whatsappUrl);
                      } else {
                        throw 'Could not launch $whatsappUrl';
                      }
                    },
                    child: Text('Buy Now'),
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

// Book Preview Screen
class BookPreviewScreen extends StatelessWidget {
  final Book book;

  BookPreviewScreen(this.book);

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
              book.title,
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Author: Puneet Kumar',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            SizedBox(height: 16),
            Image.asset(book.firstPageImagePath), // Display the first page as an image from the local path
            Spacer(),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
              ),
              onPressed: () async {
                // Redirect to WhatsApp link
                final whatsappUrl = 'https://wa.me/919565909177?text=Hi, I am interested in purchasing the book: ${book.title}';
                if (await canLaunch(whatsappUrl)) {
                  await launch(whatsappUrl);
                } else {
                  throw 'Could not launch $whatsappUrl';
                }
              },
              child: Text('Buy Now to Read More'),
            ),
          ],
        ),
      ),
    );
  }
}