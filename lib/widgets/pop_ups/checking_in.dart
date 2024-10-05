import 'package:flutter/material.dart';

class PeriodicCheckIn extends StatelessWidget {
  const PeriodicCheckIn({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: () {
            // Code to share safety status
            Navigator.of(context).pop(); // Close the dialog
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
