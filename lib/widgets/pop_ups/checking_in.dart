import 'package:flutter/material.dart';
import '../../screens/landing_page.dart';

class PeriodicCheckIn extends StatelessWidget {
  const PeriodicCheckIn({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.pink[100], // Set the background color to a light pink
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        'Periodic Check-In',
        style: TextStyle(fontSize: 20),
      ),
      content: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'This is your periodic check-in. Please click OK to share that you are safe with your trusted ones.',
          style: TextStyle(fontSize: 16),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Show confirmation dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.pink[100], // Set background color for confirmation dialog
                  title: const Text('Are you sure?'),
                  content: const Text('Do you really want to cancel the check-in?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the confirmation dialog
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close confirmation
                        // Navigate to LandingPage
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LandingPage()), // Call the existing LandingPage
                        );
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: () {
            // Navigate to existing LandingPage
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LandingPage()), // Call the existing LandingPage
            );
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.green, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
