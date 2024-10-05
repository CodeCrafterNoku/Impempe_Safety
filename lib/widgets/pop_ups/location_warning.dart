import 'package:flutter/material.dart';

class LocationWarning extends StatelessWidget {
  const LocationWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Row(
        children: [
          Icon(Icons.warning, color: Colors.red, size: 24),
          SizedBox(width: 8),
          Text('Warning', style: TextStyle(fontSize: 20)),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'You are entering an unsafe area. Do you want to share your location?',
          style: TextStyle(fontSize: 16),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // Close the dialog and return false
          },
          child: Text(
            'No',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true); // Close the dialog and return true
          },
          child: Text(
            'Yes',
            style: TextStyle(color: Colors.green, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
