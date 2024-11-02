import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mpempe3/widgets/customnav.dart';
import 'package:mpempe3/widgets/mydrawer.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'help.dart'; // Import your HelpPage

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  Color _backgroundColor = Colors.white; // Default background color
  bool _isListening = false; // Track whether listening is in progress
  PageController _pageController = PageController(); // Controller for PageView
  int _currentIndex = 0; // Track the current page index

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _checkLocationPermission(); // Check location permission during initialization
  }

  // Method to open the drawer
  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer(); // Open the drawer using the GlobalKey
  }

  /// Initialize Speech Recognition
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Check and request location permission
  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      // Handle the case where the user denies the permission permanently.
      // Show a dialog explaining that location permissions are required.
      print('Location permission is permanently denied, please enable it in settings.');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          // title: Text('Location Permission Needed'),
          content: Text('Location permissions are permanently denied. Please enable them in settings to use this feature.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  /// Start listening to speech
  void _startListening() async {
    await _checkLocationPermission(); // Check permissions before starting to listen
    if (_speechEnabled && !_speechToText.isListening && !_isListening) {
      setState(() {
        _isListening = true;
      });
      await _speechToText.listen(onResult: _onSpeechResult);
    }
  }

  /// Stop listening to speech
  void _stopListening() async {
    if (_speechToText.isListening) {
      await _speechToText.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  /// Callback for recognized speech
  void _onSpeechResult(SpeechRecognitionResult result) {
    // Only act on the word "red"
    if (result.recognizedWords.isNotEmpty && result.recognizedWords.toLowerCase() == 'red') {
      setState(() {
        _backgroundColor = Colors.red; // Change background to red
        _showAlertDialog(); // Show pop-up alert
      });
    }
  }

  /// Show alert dialog for "red" keyword
  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('Your location is being sent to your friends'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _onBottomNavTap(int index) {
    _pageController.jumpToPage(index); // Jump to the selected page
    setState(() {
      _currentIndex = index; // Update the current index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
      backgroundColor: _backgroundColor, // Dynamically set background color
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index; // Update current index when page changes
          });
        },
        children: [
          _buildHomeContent(), // Home content goes here
          HelpPage(), // HelpPage widget
        ],
      ),
      bottomNavigationBar: CustomNav(
        onCenterTap: _speechToText.isListening ? _stopListening : _startListening, // Toggle listening on button tap
        onBottomNavTap: _onBottomNavTap, // Pass the tap handler
      ),
      drawer: MyDrawer(), // Add your custom drawer here
    );
  }

  Widget _buildHomeContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: _openDrawer, // Open drawer when tapped
                child: Icon(Icons.menu),
              ),
              Text(
                "Impempe",
                style: TextStyle(fontSize: 22),
              ),
              Icon(
                Icons.notifications_none,
              ),
            ],
          ),
          const SizedBox(
            height: 200,
          ),
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Bottom container (red)
                Container(
                  height: 440,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: const Color(0xFFfa8bb1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 10, // Blur radius
                        offset: const Offset(0, 5), // Changes position of shadow
                      ),
                    ],
                  ),
                ),
                // Top container (blue) positioned to overlap above the red container
                Positioned(
                  top: -80, // This will position the blue container above the red one
                  child: Container(
                    width: 340, // Width of the blue container
                    height: 280, // Height of the blue container
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80), // Match the container's radius
                      child: SvgPicture.asset(
                        'assets/Women.svg', // Ensure the path is correct
                        fit: BoxFit.cover, // Cover the entire container
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
