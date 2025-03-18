import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line_icons/line_icons.dart';
import 'metal_detail.dart';

class RetailScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
              Text('Current Metal Prices', style: TextStyle(fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
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
        Text('Domestic Prices', style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 16),
        StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('metals').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final metals = snapshot.data!.docs;
            return GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: metals.map((metal) {
                final data = metal.data() as Map<String, dynamic>;
                final types = List<Map<String, dynamic>>.from(
                    data['types'] ?? []);
                return _buildMetalCard(
                  context,
                  data['name'],
                  data['price'],
                  data['change'],
                  _getColor(data['color']),
                  _getIcon(data['name']),
                  types,
                  'Domestic',
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildInternationalPricesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('International Prices', style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 16),
        StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('metals').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final metals = snapshot.data!.docs;
            return GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: metals.map((metal) {
                final data = metal.data() as Map<String, dynamic>;
                return _buildMetalCard(
                  context,
                  data['name'],
                  data['price'],
                  data['change'],
                  _getColor(data['color']),
                  _getIcon(data['name']),
                  List<Map<String, dynamic>>.from(data['types']),
                  'International',
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Color _getColor(String colorName) {
    switch (colorName) {
      case 'orange':
        return Colors.orange;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'grey':
        return Colors.grey;
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blueGrey':
        return Colors.blueGrey;
      case 'brown':
        return Colors.brown;
      case 'purple':
        return Colors.purple;
      case 'indigo':
        return Colors.indigo;
      default:
        return Colors.white;
    }
  }

  IconData _getIcon(String metalName) {
    switch (capitalize(metalName)) {
      case 'Copper':
        return LineIcons.barChart;
      case 'Aluminium':
        return LineIcons.industry;
      case 'Brass':
        return LineIcons.balanceScale;
      case 'Gunmetal':
        return Icons.security;
      case 'Radiator':
        return LineIcons.fan;
      case 'Steel':
        return LineIcons.recycle;
      case 'Battery':
        return Icons.battery_charging_full;
      case 'Iron':
        return Icons.construction;
      case 'Metal Ingots':
        return LineIcons.atom;
      case 'Zinc':
        return Icons.science;
      default:
        return Icons.help_outline;
    }
  }

  Widget _buildMetalCard(BuildContext context,
      String name,
      String price,
      String change,
      Color color,
      IconData icon,
      List<Map<String, dynamic>> types,
      String priceType,) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MetalDetailScreen(
                  metalName: name,
                  price: price,
                  change: change,
                  color: color,
                  types: types,
                  priceType: priceType,
                ),
          ),
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
              // Use Flexible to allow the text to wrap or scale
              Flexible(
                child: Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  overflow: TextOverflow.ellipsis, // Handle overflow
                  maxLines: 2, // Allow up to 2 lines
                  textAlign: TextAlign.center, // Center the text
                ),
              ),
              SizedBox(height: 4),
              Text(
                price,
                style: TextStyle(color: Colors.white70, fontSize: 16),
                overflow: TextOverflow.ellipsis, // Handle overflow
                maxLines: 1, // Allow only 1 line
              ),
              SizedBox(height: 4),
              Text(
                change,
                style: TextStyle(
                  color: change.contains('-') ? Colors.red : Colors.green,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis, // Handle overflow
                maxLines: 1, // Allow only 1 line
              ),
            ],
          ),
        ),
      ),
    );
  }

  String capitalize(String input) {
    if (input == null) {
      throw new ArgumentError("string: $input");
    }
    if (input.length == 0) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

}
