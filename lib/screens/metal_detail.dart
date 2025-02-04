import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MetalDetailScreen extends StatelessWidget {
  final String metalName;
  final String price;
  final String change;
  final Color color;
  final List<Map<String, String>> types; // Update to include prices

  MetalDetailScreen({
    required this.metalName,
    required this.price,
    required this.change,
    required this.color,
    required this.types, // Initialize the list of metal types with prices
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF121212),
        title: Text(metalName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                metalName,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('Price:', style: TextStyle(fontSize: 24, color: Colors.white70)),
                  SizedBox(width: 8),
                  Text(price, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text('Change:', style: TextStyle(fontSize: 24, color: Colors.white70)),
                  SizedBox(width: 8),
                  Text(change, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: change.contains('-') ? Colors.red : Colors.green)),
                ],
              ),
              SizedBox(height: 16),
              Text('Price Trend:', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 8),
              Container(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: true),
                    borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey, width: 1)),
                    minX: 0,
                    maxX: 5,
                    minY: 0,
                    maxY: 3000,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 2000),
                          FlSpot(1, 2500),
                          FlSpot(2, 1800),
                          FlSpot(3, 2200),
                          FlSpot(4, 2700),
                          FlSpot(5, 3000),
                        ],
                        isCurved: true,
                        gradient: LinearGradient(colors: [color.withOpacity(1), color.withOpacity(0.5)]),
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(colors: [color.withOpacity(0.3), color.withOpacity(0)]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('Types of $metalName:', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 8),
              Column(
                children: types.map((type) {
                  return Card(
                    color: Color(0xFF1F1F1F),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.circle, color: color, size: 24),
                              SizedBox(width: 16),
                              Text(type['name'] ?? '', style: TextStyle(color: Colors.white, fontSize: 18)),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('International Price:', style: TextStyle(color: Colors.white70)),
                              Text(type['international'] ?? '', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text('Description:', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 8),
              Text(
                'This is a detailed overview of $metalName. It is widely used in various industries and is known for its value and versatility.',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
