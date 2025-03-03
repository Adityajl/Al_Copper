import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMetalScreen extends StatefulWidget {
  @override
  _AddMetalScreenState createState() => _AddMetalScreenState();
}

class _AddMetalScreenState extends State<AddMetalScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _changeController = TextEditingController();
  final _colorController = TextEditingController();
  List<Map<String, dynamic>> _types = [];

  void _addType() {
    setState(() {
      _types.add({'name': '', 'domestic': '', 'international': ''});
    });
  }

  void _removeType(int index) {
    setState(() {
      _types.removeAt(index);
    });
  }

  void _updateType(int index, String key, String value) {
    setState(() {
      _types[index][key] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Metal'),
        backgroundColor: Color(0xFF121212),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _changeController,
                  decoration: InputDecoration(labelText: 'Change'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _colorController,
                  decoration: InputDecoration(labelText: 'Color'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: 16),
                Text('Types:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 8),
                ..._types.asMap().entries.map((entry) {
                  final index = entry.key;
                  final type = entry.value;
                  return Column(
                    children: [
                      TextFormField(
                        initialValue: type['name'],
                        decoration: InputDecoration(labelText: 'Type Name'),
                        onChanged: (value) => _updateType(index, 'name', value),
                      ),
                      TextFormField(
                        initialValue: type['domestic'],
                        decoration: InputDecoration(labelText: 'Domestic Price'),
                        onChanged: (value) => _updateType(index, 'domestic', value),
                      ),
                      TextFormField(
                        initialValue: type['international'],
                        decoration: InputDecoration(labelText: 'International Price'),
                        onChanged: (value) => _updateType(index, 'international', value),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeType(index),
                      ),
                      Divider(),
                    ],
                  );
                }).toList(),
                ElevatedButton(
                  onPressed: _addType,
                  child: Text('Add Type'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _firestore.collection('metals').add({
                        'name': _nameController.text,
                        'price': _priceController.text,
                        'change': _changeController.text,
                        'color': _colorController.text,
                        'types': _types,
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add Metal'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}