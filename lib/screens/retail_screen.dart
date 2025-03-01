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
            _buildMetalCard(context, 'Copper', '\$4.21', '+0.6', Colors.orange, LineIcons.barChart, [
              {'name': 'Copper Super D', 'domestic': '\$50,000'},
              {'name': 'Copper Amature', 'domestic': '\$48,000'},
              {'name': 'Copper no 1', 'domestic': '\$46,000'},
              {'name': 'Copper no 2', 'domestic': '\$45,000'},
              {'name': 'Copper no 3', 'domestic': '\$47,000'},
              {'name': 'Copper Cable', 'domestic': '\$49,000'},
              {'name': 'Copper-Radiator', 'domestic': '\$44,000'},
              {'name': 'Copper Aluminium', 'domestic': '\$43,000'}
            ]),
            _buildMetalCard(context, 'Aluminium', '\$2.50', '-1.1', Colors.blue, LineIcons.industry, [
              {'name': 'Wire', 'domestic': '\$14,000'},
              {'name': 'Utensil', 'domestic': '\$12,000'},
              {'name': 'Section', 'domestic': '\$11,000'},
              {'name': 'Alu Purja', 'domestic': '\$10,000'}
            ]),
            _buildMetalCard(context, 'Brass', '\$3.80', '+1.3', Colors.yellow, LineIcons.balanceScale, [
              {'name': 'Brass Purja', 'domestic': '\$20,000'},
              {'name': 'Brass Sheet', 'domestic': '\$21,000'},
              {'name': 'Brass Honey scrap', 'domestic': '\$21,000'},
            ]),
            _buildMetalCard(context, 'Gunmetal', '\$5.00', '+2.0', Colors.grey, Icons.security, [
              {'name': 'Gunmetal Local scrap', 'domestic': '\$18,000'},
              {'name': 'Gunmetal mix', 'domestic': '\$19,000'},
              {'name': 'Gunmetal Jalandhar', 'domestic': '\$20,000'}
            ]),
            _buildMetalCard(context, 'Radiator', '\$1.50', '+0.9', Colors.red, LineIcons.fan, [
              {'name': 'Radiator Aluminum', 'domestic': '\$10,000'},
              {'name': 'Radiator Copper', 'domestic': '\$12,000'},
              {'name': 'Radiator mix', 'domestic': '\$11,000'}
            ]),
            _buildMetalCard(context, 'SSteel', '\$3.60', '-0.4', Colors.green, LineIcons.recycle, [
              {'name': 'SS mix scrap', 'domestic': '\$25,000'},
              {'name': 'SS 202', 'domestic': '\$24,000'},
              {'name': 'SS 304', 'domestic': '\$23,000'},
              {'name': 'SS 309', 'domestic': '\$22,000'},
              {'name': 'SS 310', 'domestic': '\$21,000'},
              {'name': 'SS 316', 'domestic': '\$20,000'}
            ]),
            _buildMetalCard(context, 'Battery', '\$1.80', '+1.5', Colors.blueGrey, Icons.battery_charging_full, [
              {'name': 'Battery Black Base', 'domestic': '\$15,000'},
              {'name': 'White Base', 'domestic': '\$14,000'}
            ]),
            _buildMetalCard(context, 'Iron', '\$20.00', '-0.8', Colors.brown, Icons.construction, [
              {'name': 'Cast Iron', 'domestic': '\$30,000'},
              {'name': 'HMS 1', 'domestic': '\$31,000'},
              {'name': 'HMS 2', 'domestic': '\$31,000'},
              {'name': 'HMS 3', 'domestic': '\$31,000'},
              {'name': '80-20 mix', 'domestic': '\$31,000'},
              {'name': 'CRC Scrap', 'domestic': '\$31,000'},
              {'name': 'END Cutting', 'domestic': '\$31,000'},

            ]),
            _buildMetalCard(context, 'Metal Ingots', '\$18.50', '+1.0', Colors.purple, LineIcons.atom, [
              {'name': 'Alu Ingots 85%', 'domestic': '\$40,000'},
              {'name': 'Alu Ingots 96%', 'domestic': '\$40,000'},
              {'name': 'Alu Ingots 98%', 'domestic': '\$40,000'},
              {'name': 'Alu Ingots 99%', 'domestic': '\$40,000'},
              {'name': 'Lead Ingots 99%', 'domestic': '\$40,000'},
              {'name': 'Nickel Ingots 99%', 'domestic': '\$40,000'},
              {'name': 'Tin Ingots 99%', 'domestic': '\$40,000'},
              {'name': 'Zinc Ingots 99%', 'domestic': '\$40,000'},
            ]),
            _buildMetalCard(context, 'Zinc', '\$2.20', '+0.5', Colors.indigo, Icons.science, [
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
            _buildMetalCard(context, 'Copper', '\$4.21', '+0.6', Colors.orange, LineIcons.barChart, [
              {'name': 'Copper Super D', 'International': '\$50,000'},
              {'name': 'Copper Amature', 'International': '\$48,000'},
              {'name': 'Copper no 1', 'International': '\$46,000'},
              {'name': 'Copper no 2', 'International': '\$45,000'},
              {'name': 'Copper no 3', 'International': '\$47,000'},
              {'name': 'Copper Cable', 'International': '\$49,000'},
              {'name': 'Copper-Radiator', 'International': '\$44,000'},
              {'name': 'Copper Aluminium', 'International': '\$43,000'}
            ]),
            _buildMetalCard(context, 'Aluminium', '\$2.50', '-1.1', Colors.blue, LineIcons.industry, [
              {'name': 'Wire', 'International': '\$14,000'},
              {'name': 'Utensil', 'International': '\$12,000'},
              {'name': 'Section', 'International': '\$11,000'},
              {'name': 'Alu Purja', 'International': '\$10,000'}
            ]),
            _buildMetalCard(context, 'Brass', '\$3.80', '+1.3', Colors.yellow, LineIcons.balanceScale, [
              {'name': 'Brass Purja', 'International': '\$20,000'},
              {'name': 'Brass Sheet', 'International': '\$21,000'},
              {'name': 'Brass Honey scrap', 'International': '\$21,000'},
            ]),
            _buildMetalCard(context, 'Gunmetal', '\$5.00', '+2.0', Colors.grey, Icons.security, [
              {'name': 'Gunmetal Local scrap', 'International': '\$18,000'},
              {'name': 'Gunmetal mix', 'International': '\$19,000'},
              {'name': 'Gunmetal Jalandhar', 'International': '\$20,000'}
            ]),
            _buildMetalCard(context, 'Radiator', '\$1.50', '+0.9', Colors.red, LineIcons.fan, [
              {'name': 'Radiator Aluminum', 'International': '\$10,000'},
              {'name': 'Radiator Copper', 'International': '\$12,000'},
              {'name': 'Radiator mix', 'International': '\$11,000'}
            ]),
            _buildMetalCard(context, 'SSteel', '\$3.60', '-0.4', Colors.green, LineIcons.recycle, [
              {'name': 'SS mix scrap', 'International': '\$25,000'},
              {'name': 'SS 202', 'International': '\$24,000'},
              {'name': 'SS 304', 'International': '\$23,000'},
              {'name': 'SS 309', 'International': '\$22,000'},
              {'name': 'SS 310', 'International': '\$21,000'},
              {'name': 'SS 316', 'International': '\$20,000'}
            ]),
            _buildMetalCard(context, 'Battery', '\$1.80', '+1.5', Colors.blueGrey, Icons.battery_charging_full, [
              {'name': 'Battery Black Base', 'International': '\$15,000'},
              {'name': 'White Base', 'International': '\$14,000'}
            ]),
            _buildMetalCard(context, 'Iron', '\$20.00', '-0.8', Colors.brown, Icons.construction, [
              {'name': 'Cast Iron', 'International': '\$30,000'},
              {'name': 'HMS 1', 'International': '\$31,000'},
              {'name': 'HMS 2', 'International': '\$31,000'},
              {'name': 'HMS 3', 'International': '\$31,000'},
              {'name': '80-20 mix', 'International': '\$31,000'},
              {'name': 'CRC Scrap', 'International': '\$31,000'},
              {'name': 'END Cutting', 'International': '\$31,000'},

            ]),
            _buildMetalCard(context, 'Metal Ingots', '\$18.50', '+1.0', Colors.purple, LineIcons.atom, [
              {'name': 'Alu Ingots 85%', 'International': '\$40,000'},
              {'name': 'Alu Ingots 96%', 'International': '\$40,000'},
              {'name': 'Alu Ingots 98%', 'International': '\$40,000'},
              {'name': 'Alu Ingots 99%', 'International': '\$40,000'},
              {'name': 'Lead Ingots 99%', 'International': '\$40,000'},
              {'name': 'Nickel Ingots 99%', 'International': '\$40,000'},
              {'name': 'Tin Ingots 99%', 'International': '\$40,000'},
              {'name': 'Zinc Ingots 99%', 'International': '\$40,000'},
            ]),
            _buildMetalCard(context, 'Zinc', '\$2.20', '+0.5', Colors.indigo, Icons.science, [
              {'name': 'Zinc Dross', 'International': '\$11,000'},
              {'name': 'Zinc Hindustan', 'International': '\$12,000'},
              {'name': 'Zinc PMJ', 'International': '\$13,000'},
              {'name': 'Zinc Tukda', 'International': '\$14,000'}
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

