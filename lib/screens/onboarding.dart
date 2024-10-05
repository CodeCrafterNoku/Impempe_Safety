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
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                buildOnboardingPage('assets/onboarding1.svg', 'Welcome to Mpempe!'),
                buildOnboardingPage('assets/onboarding2.svg', 'Your App for Your Safety'),
                buildOnboardingPage('assets/onboarding3.svg', 'Let\'s get started!'),
              ],
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
        Text(text, style: const TextStyle(fontSize: 18)),
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
