import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpempe3/screens/landing_page.dart';

class AccountSetupScreen extends StatefulWidget {
  const AccountSetupScreen({Key? key}) : super(key: key);

  @override
  State<AccountSetupScreen> createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends State<AccountSetupScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();
  final TextEditingController _contactRelationshipController = TextEditingController();
  final List<String> _addresses = [];
  final List<Map<String, String>> _contacts = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  void _addAddress() {
    if (_addressController.text.isNotEmpty) {
      setState(() {
        _addresses.add(_addressController.text);
        _addressController.clear();
      });
    }
  }

  void _addContact() {
    if (_contactNameController.text.isNotEmpty && _contactNumberController.text.isNotEmpty && _contactEmailController.text.isNotEmpty && _contactRelationshipController.text.isNotEmpty) {
      setState(() {
        _contacts.add({
          'name': _contactNameController.text,
          'number': _contactNumberController.text,
          'email': _contactEmailController.text,
          'relationship': _contactRelationshipController.text,
        });
        _contactNameController.clear();
        _contactNumberController.clear();
        _contactEmailController.clear();
        _contactRelationshipController.clear();
      });
    }
  }

  Future<void> _finishSetup() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Save user details in Firestore
        await _firestore.collection('users').doc(user.uid).update({
          'age': _ageController.text.trim(),
          'addresses': _addresses,
          'contacts': _contacts,
          'profileImage': _image != null ? File(_image!.path).toString() : null, // Handle file storage later
        });

        // Navigate to LandingPage
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => LandingPage()), // Define your LandingPage widget
        );
      } else {
        throw Exception("No user logged in");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            const SizedBox(height: 22),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null ? Image.file(File(_image!.path)).image : null,
                child: _image == null ? const Icon(Icons.add_a_photo, size: 50) : null,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addAddress,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Added Addresses:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ..._addresses.map((address) => ListTile(title: Text(address))),
            const SizedBox(height: 20),
            TextFormField(
              controller: _contactNameController,
              decoration: InputDecoration(
                labelText: 'Contact Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _contactNumberController,
              decoration: InputDecoration(
                labelText: 'Contact Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _contactEmailController,
              decoration: InputDecoration(
                labelText: 'Contact Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _contactRelationshipController,
              decoration: InputDecoration(
                labelText: 'Relationship',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.pink,
              ),
              onPressed: _addContact,
              child: const Text(
                'Add Contact',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Added Contacts:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ..._contacts.map((contact) => ListTile(
                  title: Text(contact['name']!),
                  subtitle: Text('Number: ${contact['number']}, Email: ${contact['email']}, Relationship: ${contact['relationship']}'),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.pink,
              ),
              onPressed: _finishSetup,
              child: const Text(
                'Finish Setup',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    _addressController.dispose();
    _contactNameController.dispose();
    _contactNumberController.dispose();
    _contactEmailController.dispose();
    _contactRelationshipController.dispose();
    super.dispose();
  }
}
