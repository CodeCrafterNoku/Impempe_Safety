import 'package:flutter/material.dart';
import 'package:mpempe3/screens/account_set_up.dart'; // Import your AccountSetupScreen
import 'package:permission_handler/permission_handler.dart'; // Import permission handler package

class InitialSetupScreen extends StatefulWidget {
  @override
  _InitialSetupScreenState createState() => _InitialSetupScreenState();
}

class _InitialSetupScreenState extends State<InitialSetupScreen> {
  bool locationPermissionGranted = false;
  bool micPermissionGranted = false;
  bool contactsPermissionGranted = false;

  Future<void> _requestPermissions() async {
    // Request the necessary permissions
    var locationStatus = await Permission.location.request();
    var micStatus = await Permission.microphone.request();
    var contactsStatus = await Permission.contacts.request();

    // Update state based on whether the permissions are granted
    setState(() {
      locationPermissionGranted = locationStatus.isGranted;
      micPermissionGranted = micStatus.isGranted;
      contactsPermissionGranted = contactsStatus.isGranted;
    });

    // If all permissions are granted, navigate to the next screen
    if (locationPermissionGranted && micPermissionGranted && contactsPermissionGranted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AccountSetupScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _requestPermissions(); // Automatically request permissions on page load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Initial Setup"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "We need the following permissions:",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            // Location permission tile
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("Location"),
              trailing: Icon(
                locationPermissionGranted ? Icons.check_circle : Icons.error,
                color: locationPermissionGranted ? Colors.green : Colors.red,
              ),
            ),
            // Microphone permission tile
            ListTile(
              leading: const Icon(Icons.mic),
              title: const Text("Microphone"),
              trailing: Icon(
                micPermissionGranted ? Icons.check_circle : Icons.error,
                color: micPermissionGranted ? Colors.green : Colors.red,
              ),
            ),
            // Contacts permission tile
            ListTile(
              leading: const Icon(Icons.contacts),
              title: const Text("Contacts"),
              trailing: Icon(
                contactsPermissionGranted ? Icons.check_circle : Icons.error,
                color: contactsPermissionGranted ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 40),
            // Grant Permissions Button
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => AccountSetupScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  height: 68,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(
                      24,
                    ),
                  ),
                  child: Center(
                      child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
