import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'metal_detail.dart'; // Import your MetalDetailScreen

class RetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metal Rates'),
        backgroundColor: Color(0xFF121212),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Current Metal Prices', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 16),
              _buildDomesticPricesSection(context),
              SizedBox(height: 16),
              _buildInternationalPricesSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDomesticPricesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Domestic Prices', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 16),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),  // Disable grid scrolling
          shrinkWrap: true,  // Take only needed space
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildMetalCard(context, 'Copper', '\$4.21', '+0.6%', Colors.orange, LineIcons.barChart, [
              {'name': 'Copper no1', 'domestic': '\$50,000'},
              {'name': 'Copper no2', 'domestic': '\$48,000'},
              {'name': 'Copper no3', 'domestic': '\$46,000'},
              {'name': 'Copper CC', 'domestic': '\$45,000'},
              {'name': 'Copper Rod', 'domestic': '\$47,000'},
              {'name': 'Copper Super D', 'domestic': '\$49,000'},
              {'name': 'Copper Copper cable', 'domestic': '\$44,000'},
              {'name': 'Copper Armature', 'domestic': '\$43,000'}
            ]),
            _buildMetalCard(context, 'Aluminium', '\$2.50', '-1.1%', Colors.blue, LineIcons.industry, [
              {'name': 'Rod', 'domestic': '\$15,000'},
              {'name': 'Wire', 'domestic': '\$14,000'},
              {'name': 'Sheet', 'domestic': '\$13,000'},
              {'name': 'Utensil', 'domestic': '\$12,000'},
              {'name': 'Section', 'domestic': '\$11,000'},
              {'name': 'TT', 'domestic': '\$10,000'}
            ]),
            _buildMetalCard(context, 'Brass', '\$3.80', '+1.3%', Colors.yellow, LineIcons.balanceScale, [
              {'name': 'Brass Accessories', 'domestic': '\$20,000'},
              {'name': 'Brass Shortcutting', 'domestic': '\$21,000'}
            ]),
            _buildMetalCard(context, 'Gunmetal', '\$5.00', '+2.0%', Colors.grey, Icons.security, [
              {'name': 'Gunmetal Local scrap', 'domestic': '\$18,000'},
              {'name': 'Gunmetal mix', 'domestic': '\$19,000'},
              {'name': 'Gunmetal Jalandhar', 'domestic': '\$20,000'}
            ]),
            _buildMetalCard(context, 'Radiator', '\$1.50', '+0.9%', Colors.red, LineIcons.fan, [
              {'name': 'Radiator Aluminum', 'domestic': '\$10,000'},
              {'name': 'Radiator Copper', 'domestic': '\$12,000'},
              {'name': 'Radiator mix', 'domestic': '\$11,000'}
            ]),
            _buildMetalCard(context, 'SS Mix', '\$3.60', '-0.4%', Colors.green, LineIcons.recycle, [
              {'name': 'SS mix scrap', 'domestic': '\$25,000'},
              {'name': 'SS 202', 'domestic': '\$24,000'},
              {'name': 'SS 304', 'domestic': '\$23,000'},
              {'name': 'SS 309', 'domestic': '\$22,000'},
              {'name': 'SS 310', 'domestic': '\$21,000'},
              {'name': 'SS 316', 'domestic': '\$20,000'}
            ]),
            _buildMetalCard(context, 'Lead', '\$1.80', '+1.5%', Colors.blueGrey, Icons.battery_charging_full, [
              {'name': 'Lead Type 1', 'domestic': '\$15,000'},
              {'name': 'Lead Type 2', 'domestic': '\$14,000'}
            ]),
            _buildMetalCard(context, 'Tin', '\$20.00', '-0.8%', Colors.brown, Icons.kitchen, [
              {'name': 'Tin Type 1', 'domestic': '\$30,000'},
              {'name': 'Tin Type 2', 'domestic': '\$31,000'}
            ]),
            _buildMetalCard(context, 'Nickel', '\$18.50', '+1.0%', Colors.purple, LineIcons.atom, [
              {'name': 'Nickel Type 1', 'domestic': '\$40,000'},
              {'name': 'Nickel Type 2', 'domestic': '\$41,000'}
            ]),
            _buildMetalCard(context, 'Zinc', '\$2.20', '+0.5%', Colors.indigo, Icons.science, [
              {'name': 'Zinc tanget', 'domestic': '\$10,000'},
              {'name': 'Zinc Dross', 'domestic': '\$11,000'},
              {'name': 'Zinc Hindustan', 'domestic': '\$12,000'},
              {'name': 'Zinc PMJ', 'domestic': '\$13,000'},
              {'name': 'Zinc Tukda', 'domestic': '\$14,000'}
            ]),
          ],
        ),
      ],
    );
  }

  Widget _buildInternationalPricesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('International Prices', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 16),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),  // Disable grid scrolling
          shrinkWrap: true,  // Take only needed space
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildMetalCard(context, 'Copper Scrap', '\$3.50', '+0.4%', Colors.orange, LineIcons.barChart, [
              {'name': 'Copper Scrap', 'international': '\$30,000'}
            ]),
            _buildMetalCard(context, 'Alum Scrap', '\$2.00', '-0.7%', Colors.blue, LineIcons.industry, [
              {'name': 'Alum Scrap', 'international': '\$12,000'}
            ]),
            _buildMetalCard(context, 'Brass Scrap', '\$3.80', '+1.2%', Colors.yellow, LineIcons.balanceScale, [
              {'name': 'Brass Accessory Scrap', 'international': '\$25,000'}
            ]),
            _buildMetalCard(context, 'Brass Sheet', '\$3.90', '+1.3%', Colors.yellow, LineIcons.balanceScale, [
              {'name': 'Brass Sheet Scrap', 'international': '\$26,000'}
            ]),
            _buildMetalCard(context, 'Brass Heavy', '\$4.00', '+1.4%', Colors.yellow, LineIcons.balanceScale, [
              {'name': 'Brass Heavy', 'international': '\$27,000'}
            ]),
            _buildMetalCard(context, 'GM Local Scrap', '\$5.50', '+1.0%', Colors.grey, Icons.security, [
              {'name': 'Gun Metal Local Scrap', 'international': '\$28,000'}
            ]),
            _buildMetalCard(context, 'Gun Metal Mix', '\$5.60', '+1.1%', Colors.grey, Icons.security, [
              {'name': 'Gun Metal Mix', 'international': '\$29,000'}
            ]),
            _buildMetalCard(context, 'GM Jalandhar', '\$5.70', '+1.2%', Colors.grey, Icons.security, [
              {'name': 'GM Jalandhar', 'international': '\$30,000'}
            ]),
            _buildMetalCard(context, 'Radiator Copp', '\$4.20', '+0.9%', Colors.red, LineIcons.fan, [
              {'name': 'Radiator Copp', 'international': '\$13,000'}
            ]),
            _buildMetalCard(context, 'Radiator Alum', '\$4.10', '+0.8%', Colors.red, LineIcons.fan, [
              {'name': 'Radiator Alum', 'international': '\$12,000'}
            ]),
            _buildMetalCard(context, 'Radiator Mix', '\$4.00', '+0.7%', Colors.red, LineIcons.fan, [
              {'name': 'Radiator Mix', 'international': '\$11,000'}
            ]),
            _buildMetalCard(context, 'Lead', '\$2.00', '+0.5%', Colors.blueGrey, Icons.battery_charging_full, [
              {'name': 'Lead', 'international': '\$15,000'}
            ]),
            _buildMetalCard(context, 'Nickel', '\$18.50', '+1.0%', Colors.purple, LineIcons.atom, [
              {'name': 'Nickel', 'international': '\$40,000'}
            ]),
            _buildMetalCard(context, 'Tin', '\$20.00', '-0.8%', Colors.brown, Icons.kitchen, [
              {'name': 'Tin', 'international': '\$30,000'}
            ]),
            _buildMetalCard(context, 'Zinc Ingot', '\$2.20', '+0.5%', Colors.indigo, Icons.science, [
              {'name': 'Zinc Ingot', 'international': '\$10,000'}
            ]),
          ],
        ),
      ],
    );
  }



  Widget _buildMetalCard(BuildContext context, String name, String price, String change, Color color, IconData icon, List<Map<String, String>> types) {
    return GestureDetector(
      onTap: () {
        // Navigate to MetalDetailScreen with metal details and types
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MetalDetailScreen(
            metalName: name,
            price: price,
            change: change,
            color: color,
            types: types, // Pass the list of metal types
          )),
        );
      },
      child: Card(
        color: Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(height: 8),
              Text(name, style: TextStyle(color: Colors.white, fontSize: 18)),
              SizedBox(height: 4),
              Text(price, style: TextStyle(color: Colors.white70, fontSize: 16)),
              SizedBox(height: 4),
              Text(change, style: TextStyle(color: change.contains('-') ? Colors.red : Colors.green, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

