import 'package:flutter/material.dart';
import 'package:mpempe3/screens/account_set_up.dart';
import 'package:permission_handler/permission_handler.dart';

class InitialSetupScreen extends StatefulWidget {
  @override
  _InitialSetupScreenState createState() => _InitialSetupScreenState();
}

class _InitialSetupScreenState extends State<InitialSetupScreen> {
  bool locationPermissionGranted = false;
  bool micPermissionGranted = false;
  bool contactsPermissionGranted = false;

  Future<void> _requestPermissions() async {
    var locationStatus = await Permission.location.request();
    var micStatus = await Permission.microphone.request();
    var contactsStatus = await Permission.contacts.request();

    setState(() {
      locationPermissionGranted = locationStatus.isGranted;
      micPermissionGranted = micStatus.isGranted;
      contactsPermissionGranted = contactsStatus.isGranted;
    });

    if (locationPermissionGranted && micPermissionGranted && contactsPermissionGranted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AccountSetupScreen(),
      ));
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
        title: Text("Initial Setup"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "We need the following permissions:",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text("Location"),
              trailing: Icon(
                locationPermissionGranted ? Icons.check_circle : Icons.error,
                color: locationPermissionGranted ? Colors.green : Colors.red,
              ),
            ),
            ListTile(
              leading: Icon(Icons.mic),
              title: Text("Microphone"),
              trailing: Icon(
                micPermissionGranted ? Icons.check_circle : Icons.error,
                color: micPermissionGranted ? Colors.green : Colors.red,
              ),
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text("Contacts"),
              trailing: Icon(
                contactsPermissionGranted ? Icons.check_circle : Icons.error,
                color: contactsPermissionGranted ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _requestPermissions,
              child: Text("Grant Permissions"),
            ),
          ],
        ),
      ),
    );
  }
}
