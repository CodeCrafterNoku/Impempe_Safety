import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'landing_page.dart';

class ProfileSetup extends StatefulWidget {
  const ProfileSetup({Key? key}) : super(key: key);

  @override
  State<ProfileSetup> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetup> {
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
  final FirebaseStorage _storage = FirebaseStorage.instance;

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

  Future<String?> _uploadProfileImage(String userId) async {
    if (_image == null) return null;

    try {
      Reference storageRef = _storage.ref().child('profile_images').child('$userId.jpg');
      UploadTask uploadTask = storageRef.putFile(File(_image!.path));
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading profile image: $e');
      return null;
    }
  }

  void _addContact() {
    if (_contactNameController.text.isNotEmpty && _contactNumberController.text.isNotEmpty && _contactEmailController.text.isNotEmpty && _contactRelationshipController.text.isNotEmpty) {
      setState(() {
        _contacts.add({
          'name': _contactNameController.text.trim(),
          'number': _contactNumberController.text.trim(),
          'email': _contactEmailController.text.trim(),
          'relationship': _contactRelationshipController.text.trim(),
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
      if (user == null) {
        // Handle unauthenticated state
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not authenticated')),
        );
        return;
      }

      String userId = user.uid;

      // Upload profile image if selected
      String? profileImageUrl = await _uploadProfileImage(userId);

      // Prepare data to save
      Map<String, dynamic> userData = {
        'age': _ageController.text.trim(),
        'addresses': _addresses,
        'contacts': _contacts,
        'profile_image': profileImageUrl,
        // Add more fields if necessary
      };

      // Save data to Firestore
      await _firestore.collection('users').doc(userId).set(userData, SetOptions(merge: true));

      // Optionally, navigate to another screen or show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile setup completed successfully')),
      );

      // Navigate to the landing page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LandingPage()), // Change LandingPage to your actual landing page widget
      );
    } catch (e) {
      print('Error saving profile setup: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to complete setup: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink, // Matching color theme
        title: const Text('Profile Setup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 30),
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
                labelText: 'Enter your age',
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
                labelText: 'Enter your home address',
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
              'Your Addresses:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ..._addresses.map((address) => ListTile(
                  title: Text(address),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _addresses.remove(address);
                      });
                    },
                  ),
                )),
            const SizedBox(height: 20),
            const Text(
              'Link a Trusted Contact:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
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
// Uncomment if you want to specify the keyboard type
// keyboardType: TextInputType.phone,
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
// Uncomment if you want to specify the keyboard type
// keyboardType: TextInputType.emailAddress,
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
                backgroundColor: Colors.pink, // Pink button for consistency
              ),
              onPressed: _addContact,
              child: const Text(
                'Add Contact',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white, // White text
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
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _contacts.remove(contact);
                      });
                    },
                  ),
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
