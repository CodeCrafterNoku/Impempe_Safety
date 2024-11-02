import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mpempe3/screens/onboarding.dart';
// import 'package:mpempe3/screens/current_location_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  OnboardingScreen(),
    );
  }
}
