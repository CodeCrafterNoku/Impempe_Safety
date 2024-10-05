import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNav extends StatefulWidget {
  final VoidCallback onCenterTap;
  final ValueChanged<int> onBottomNavTap; // New callback for navigation

  CustomNav({required this.onCenterTap, required this.onBottomNavTap}); // Update constructor

  @override
  _CustomNavState createState() => _CustomNavState();
}

class _CustomNavState extends State<CustomNav> {
  int _currentIndex = 0; // Track the current index

  void _onTap(int index) {
    setState(() {
      _currentIndex = index; // Update the current index
    });
    widget.onBottomNavTap(index); // Call the callback
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SizedBox.shrink(), // Empty space for the floating icon
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.phone_outlined),
              label: 'Emergency',
            ),
          ],
          currentIndex: _currentIndex, // Set the current index
          selectedItemColor: Colors.pink, // Color for the selected item
          unselectedItemColor: Colors.grey, // Color for unselected items
          onTap: _onTap, // Handle navigation
          type: BottomNavigationBarType.fixed,
        ),
        Positioned(
          bottom: 30.0, // Adjust this value to raise or lower the button
          left: MediaQuery.of(context).size.width / 2 - 30, // Center horizontally
          child: FloatingActionButton(
            onPressed: widget.onCenterTap, // Call the callback when pressed
            backgroundColor: Colors.pink,
            child: Icon(CupertinoIcons.speaker_3, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
