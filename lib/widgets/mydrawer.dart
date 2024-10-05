import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpempe3/screens/self_defense_videos.dart';
import 'package:mpempe3/screens/signup.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white, // Background color of the drawer
        child: Column(
          children: [
            // Drawer Header
            Container(
              width: double.infinity,
              color: Color(0xFFfa8bb1), // Header background color

              child: const Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    radius: 40.0, // Profile image size
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Color(0xFFfa8bb1),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome, User!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            // Drawer Items
            ListTile(
              leading: const Icon(Icons.home, color: Color(0xFFfa8bb1)),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Handle navigation to Home
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.speaker_3, color: Color(0xFFfa8bb1)),
              title: const Text('Help'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Handle navigation to Help
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Color(0xFFfa8bb1)),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Handle navigation to Profile
              },
            ),
            const Divider(), // A line separating sections
            ListTile(
              leading: const Icon(Icons.settings, color: Color(0xFFfa8bb1)),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Handle navigation to Settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFFfa8bb1)),
              title: const Text('Log Out'),
              onTap: () async {
                Navigator.pop(context); // Close the drawer
                try {
                  await FirebaseAuth.instance.signOut(); // Sign out from Firebase
                  // Navigate to the login screen or handle redirection after logout
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => SignUpScreen()), // Replace with your login screen
                  );
                } catch (e) {
                  // Handle errors, if any
                  print('Error signing out: $e');
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.play_circle_outline, color: Color(0xFFfa8bb1)),
              title: const Text('Self Defense Training '),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => SelfDefenseVideos()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
