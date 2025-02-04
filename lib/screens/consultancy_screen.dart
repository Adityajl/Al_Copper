import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ConsultancyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultancy Services'),
        backgroundColor: Color(0xFF121212),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Explore Our Consultancy Services',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildServiceCard(context, 'Domestic Consultancy Service',
                    '₹15,000 + 18% GST\nTotal = ₹17,700',
                    LineIcons.briefcase,
                    _domesticConsultancyDetails(),
                  ),
                  _buildServiceCard(context, 'International Consultancy Service',
                    '₹30,000 + 18% GST\nTotal = ₹35,400',
                    LineIcons.globe,
                    _internationalConsultancyDetails(),
                  ),
                  _buildServiceCard(context, 'Plant Setup Consultancy',
                    '₹20,000 + 18% GST\nTotal = ₹23,600',
                    LineIcons.building,
                    _plantSetupDetails(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, String details, IconData icon, String description) {
    return Card(
      color: Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.tealAccent), // Colorful icon
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.white, fontSize: 18)),
                  SizedBox(height: 4),
                  Text(details, style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward, color: Colors.tealAccent), // Arrow icon for navigation
              onPressed: () {
                // Navigate to detailed description page
                Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetailScreen(courseName: title, description: description)));
              },
            ),
          ],
        ),
      ),
    );
  }

  String _domesticConsultancyDetails() {
    return '''
- We provide international metal scrap business consultancy from scratch to advance.
- We provide consultancy services online or offline according to customer needs.
- We provide consultancy according to client investment or requirement.
- In international consultancy we provide practical 80% & theoretical knowledge 20%.
- We have 100% every problem solution in the metal scrap business field.
- We help you start a business in various sectors like copper, aluminum, lead, iron scrap, metal ingots, billets, TMT, etc.
- Regular genuine international deals.
- We help you deal with direct & indirect international suppliers (scrap yards).
- Regularly update you on international metal scrap rates and how international scrap rate calculation works.
- Help in documentation and compliance.
- Provide information about scrap grades and sorting processes live in my scrap yard.
- We provide regular metal scrap deals to our paid clients.
- We finish onboarding new clients & maintaining relationships.
- We help in negotiating the deal with responsibility.
- We provide training for participation in e-auction or offline auction.
- Help you in business deals negotiations.
- Safe payment mode.
- Provide complete information about the import and export business.
- Provide complete knowledge about the metal recycling concept.
- International consultancy takes 1 hour daily and 4 days or more of complete training.
- Domestic consultancy takes 1 hour for 2 days of complete training.
- Providing valuation service of old factories, plants, and scrap sites.
- We help in cutting the complete plant and factory on contract.
- We provide complete labor and machinery support for lifting of scrap.
- Help in inspection and loading of scrap on site.
- In global trade, ensuring quality shipments is crucial. Pre-shipment inspections help ensure that shipped goods meet buyers' specifications and expectations. 
- We protect our clients from scams and fraud deals.
- We help our clients purchase scrap from the international market and sell them in the domestic market.
- Help in making healthy relationships between international suppliers and our clients.
- We take full responsibility for scrap quality and quantity.''';
  }

  String _internationalConsultancyDetails() {
    return '''
-We clear on the concept of metal scrap import and export business? How its work
?.metal scrap business concept is different from another business concept?
-What are the benefits to start import & export of metal scrap?
-How approach international seller?
-How much investment need to start a metal scrap international business in starting 	phase or regular running phase of the business?
-How much manpower is required to start a metal scrap business?
-Trouble shooting? & problem solution.
-Profit margins in international business every metals and metals grade have different 	profit margins?
-Provide you knowledge about classification grades of scrap metal?
-How find genuine deals from various countries?
-Tips and tricks to know if the deal is genuine or fake?
-How to spot whether a business person is fake or fraudulent?
-What documentation and compliance are required for international trade?
-What document prepared by importer side?
-What document prepared by the exporter side?
-How calculate scrap rate according to international terms.
-What check before purchasing metal scrap from international market?
-How sort scrap metal?
-Where to purchase metal scrap at less price?
-Where to sale metal scrap at a high price?
-How select best incoterms for trading ?
-What payment mode is best for business? .
-When this concept is clear then we start practical sales and purchasing from The international market.'''; // Placeholder for actual details
  }

  String _plantSetupDetails() {
    return '''
Plant setup details go here...'''; // Placeholder for actual details
  }
}

// Example Course Detail Screen (for navigation)
class CourseDetailScreen extends StatelessWidget {
  final String courseName;
  final String description;

  CourseDetailScreen({required this.courseName, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseName),
        backgroundColor: Color(0xFF121212),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(courseName,
                  style:
                  TextStyle(fontSize:
                  32,fontWeight:
                  FontWeight.bold,color:
                  Colors.white)),
              SizedBox(height:
              16),
              Text('Course Description:',style:
              TextStyle(fontSize:
              24,color:
              Colors.white)),
              SizedBox(height:
              8),
              Text(description,
                  style:
                  TextStyle(fontSize:
                  18,color:
                  Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}
