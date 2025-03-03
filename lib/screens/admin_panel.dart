import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'add_metal_screen.dart';
import 'edit_metal_screen.dart';

class AdminPanel extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        backgroundColor: Color(0xFF121212),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('metals').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final metals = snapshot.data!.docs;
            return ListView.builder(
              itemCount: metals.length,
              itemBuilder: (context, index) {
                final metal = metals[index];
                final data = metal.data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['name'], style: TextStyle(color: Colors.white)),
                  subtitle: Text(data['price'], style: TextStyle(color: Colors.white70)),
                  trailing: IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      // Navigate to edit screen
                      _navigateToEditScreen(context, metal.id, data);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add new metal screen
          _navigateToAddScreen(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToEditScreen(BuildContext context, String metalId, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditMetalScreen(metalId: metalId, initialData: data),
      ),
    );
  }

  void _navigateToAddScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddMetalScreen()),
    );
  }
}