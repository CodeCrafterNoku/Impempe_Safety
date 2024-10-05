import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmergencyDial extends StatefulWidget {
  @override
  _EmergencyDialState createState() => _EmergencyDialState();
}

class _EmergencyDialState extends State<EmergencyDial> {
  // List to store the scale state for each item
  List<double> _scales = List<double>.filled(4, 1.0);

  // Animation control for ellipsis
  int _ellipsisCount = 0;
  Timer? _ellipsisTimer;

  @override
  void dispose() {
    _ellipsisTimer?.cancel(); // Cancel the timer when disposing
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns in the grid
            crossAxisSpacing: 16, // Space between columns
            mainAxisSpacing: 16, // Space between rows
            childAspectRatio: 1.5, // Aspect ratio of each container
          ),
          itemCount: 4, // Number of items
          itemBuilder: (context, index) {
            return _buildGridItem(index);
          },
        ),
      ),
    );
  }

  Widget _buildGridItem(int index) {
    // Define the icons and titles for each grid item
    final List<Map<String, dynamic>> items = [
      {'icon': FontAwesomeIcons.idBadge, 'title': 'Police'},
      {'icon': FontAwesomeIcons.ambulance, 'title': 'Ambulance'},
      {'icon': FontAwesomeIcons.fistRaised, 'title': 'Gender Based Violence'},
      {'icon': FontAwesomeIcons.child, 'title': 'Childline'},
    ];

    return GestureDetector(
      onTapDown: (_) {
        // Scale down on tap
        setState(() {
          _scales[index] = 0.9; // Scale down to 90%
        });
      },
      onTapUp: (_) {
        // Scale up on tap release
        setState(() {
          _scales[index] = 1.0; // Scale back to original size
        });
        _showCallingSheet(items[index]['title']); // Show calling sheet
      },
      onTapCancel: () {
        // Scale back if the tap is canceled
        setState(() {
          _scales[index] = 1.0;
        });
      },
      child: Transform.scale(
        scale: _scales[index], // Dynamic scale based on tap
        alignment: Alignment.bottomCenter, // Zoom towards the center bottom
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white70, // Background color of the container
            borderRadius: BorderRadius.circular(15), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3), // Shadow color
                offset: Offset(3, 3), // Horizontal and vertical offset
                blurRadius: 10, // Blur radius
                spreadRadius: 1, // Spread radius
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            children: [
              Icon(
                items[index]['icon'],
                size: 40, // Icon size
                color: Colors.pinkAccent, // Icon color
              ),
              SizedBox(height: 10), // Space between icon and title
              Text(
                items[index]['title'],
                textAlign: TextAlign.center, // Align text to the center
                style: TextStyle(
                  color: Colors.black, // Text color
                  fontSize: 18, // Text size
                  fontWeight: FontWeight.bold, // Text weight
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCallingSheet(String title) {
    // Start ellipsis animation
    _ellipsisCount = 0;
    _ellipsisTimer?.cancel();
    _ellipsisTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _ellipsisCount = (_ellipsisCount + 1) % 4; // Cycle through 0-3
      });
    });

    // Show bottom sheet
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.phone,
                size: 40,
                color: Colors.green, // Phone icon color
              ),
              SizedBox(height: 10), // Space between icon and title
              Text(
                'Calling: $title',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10), // Space between text and ellipsis
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Please wait'),
                  AnimatedEllipsis(count: _ellipsisCount), // Animated ellipsis
                ],
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      // Stop ellipsis animation when bottom sheet is closed
      _ellipsisTimer?.cancel();
    });
  }
}

class AnimatedEllipsis extends StatelessWidget {
  final int count;

  AnimatedEllipsis({required this.count});

  @override
  Widget build(BuildContext context) {
    String dots = '.' * count; // Generate dots based on count
    return Text(
      dots,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
