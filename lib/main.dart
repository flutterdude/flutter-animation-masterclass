import 'package:flutter/material.dart';
import 'package:the_car_rental_app/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Rental App',
      // 🚫 Hide the debug banner for a cleaner demo recording
      debugShowCheckedModeBanner: false,

      // 🎨 Define the global theme and font
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Metropolis', // Ensure this font is in your pubspec.yaml
      ),

      // 🚀 Launch the Onboarding Screen
      home: const OnboardingScreen(),
    );
  }
}