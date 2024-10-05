import 'package:flutter/material.dart';
import 'package:mpempe3/widgets/emergency_dial.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Emergency Help",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pinkAccent, // Customize the color as needed
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "What emergency do you have?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "Which emergency services do you want to use?",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(child: EmergencyDial())
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyButton(BuildContext context, {required String label, required Color color, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners
        ),
        padding: EdgeInsets.symmetric(vertical: 16), // Button padding
        shadowColor: Colors.black.withOpacity(0.3), // Shadow color
        elevation: 5, // Shadow elevation
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Text color
        ),
      ),
    );
  }

  void _launchEmergencyService(String number) {
    // Implement the functionality to call the service or show a dialog
    print("Dialing emergency service: $number");
    // You can also use url_launcher package to call
    // launch("tel:$number");
  }
}
