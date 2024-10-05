import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class RoutineSetupScreen extends StatefulWidget {
  const RoutineSetupScreen({Key? key}) : super(key: key);

  @override
  State<RoutineSetupScreen> createState() => _RoutineSetupScreenState();
}

class _RoutineSetupScreenState extends State<RoutineSetupScreen> {
  final List<Map<String, dynamic>> _stops = [];
  final TextEditingController _locationController = TextEditingController();
  bool notifyEmergencyContact = false; // State for the switch
  double preferredMaxDistance = 10; // Default max distance

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to handle time picking
  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  // Function to add a new stop to the list
  void _addStop() async {
    final startTime = await _selectTime(context);
    final endTime = await _selectTime(context);
    if (_locationController.text.isNotEmpty && startTime != null && endTime != null) {
      setState(() {
        _stops.add({
          'location': _locationController.text,
          'startTime': startTime,
          'endTime': endTime,
        });
        _locationController.clear();
      });
    }
  }

  // Function to validate and save routine
  void _saveRoutine() async {
    try {
      String? missingFields = '';

      if (!notifyEmergencyContact) {
        missingFields += ' - Notify Emergency Contact on Anomaly must be on\n';
      }

      if (_stops.isEmpty) {
        missingFields += ' - At least one stop must be added\n';
      }

      if (missingFields.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please address the following missing fields:\n$missingFields"),
            duration: const Duration(seconds: 3),
          ),
        );
      } else {
        // Get the current user's UID
        String? userId = FirebaseAuth.instance.currentUser?.uid;

        if (userId != null) {
          // Save the routine under the user's Firestore document
          await _firestore.collection('users').doc(userId).update({
            'stops': _stops,
            'notifyEmergencyContact': notifyEmergencyContact,
            'preferredMaxDistance': preferredMaxDistance,
            'createdAt': FieldValue.serverTimestamp(), // Optional: timestamp
          });

          // Display success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Routine saved!"),
              duration: Duration(seconds: 2),
            ),
          );
          print('Routine saved!');
        } else {
          // Handle case where user is not authenticated
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Error: User not logged in"),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink, // Pink color theme to match
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Brief description at the top
            const Text(
              'Please add your routine stops below. '
                  'Select a location and set the start and end times for each stop. '
                  'You can also specify your maximum preferred distance and choose to notify an emergency contact if an anomaly occurs.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),

            // Location input field
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Button to add a stop with start and end times
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.pink, // Pink button for consistency
              ),
              onPressed: _addStop,
              child: const Text(
                'Add Stop',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white, // White text
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Display list of added stops
            const Text(
              'Added Stops:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Showing added stops
            ..._stops.map((stop) {
              return ListTile(
                title: Text(stop['location']),
                subtitle: Text(
                  'Start Time: ${stop['startTime']!.format(context)}, End Time: ${stop['endTime']!.format(context)}',
                ),
              );
            }).toList(),

            const SizedBox(height: 20),

            // Notify Emergency Contact switch
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text("Notify Emergency Contact on Anomaly?"),
              value: notifyEmergencyContact,
              onChanged: (value) {
                setState(() {
                  notifyEmergencyContact = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Preferred Max Distance display
            Text(
              "Preferred Max Distance: ${preferredMaxDistance.round()} km",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Slider(
              label: "Max Distance (${preferredMaxDistance.round()} km)",
              min: 1,
              max: 100,
              value: preferredMaxDistance,
              onChanged: (value) {
                setState(() {
                  preferredMaxDistance = value;
                });
              },
            ),

            const SizedBox(height: 20),

            // Final save button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.pink, // Pink button for consistency
              ),
              onPressed: _saveRoutine, // Updated to use the validation function
              child: const Text(
                'Save Routine',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }
}
