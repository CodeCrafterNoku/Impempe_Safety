import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpempe3/screens/signup.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  buildOnboardingPage('assets/onboarding1.svg', 'Impempe helps you share your location with trusted contacts, ensuring you are always connected and safe wherever you go. Feel protected knowing someone is looking after your daily movements.'),
                  buildOnboardingPage('assets/onboarding2.svg', 'Automatic Alerts for Peace of Mind ,Move beyond your usual routes? Impempe automatically triggers an alert to your trusted contacts if you move more than 35 km from your normal address, even when you are unable to send a message'),
                  buildOnboardingPage('assets/onboarding3.svg', 'Empower Yourself with Safety Tips,Learn self-defense with our specialized video classes for kids and adults. Empower yourself and your loved ones to stay safe, while Impempe takes care of the rest!'),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) => buildDot(index, context)),
          ),
          const SizedBox(height: 80),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => SignUpScreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 72,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.black),
                child: const Center(
                  child: Text(
                    "Get Started",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildOnboardingPage(String asset, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(asset, height: 300),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(textAlign: TextAlign.center, text, style: const TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      width: _currentIndex == index ? 20 : 10,
      decoration: BoxDecoration(
        color: _currentIndex == index ? const Color(0xFFfa8bb1) : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
