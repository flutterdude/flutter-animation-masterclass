import 'package:flutter/material.dart';
import 'package:the_car_rental_app/action_button.dart';
import 'package:the_car_rental_app/circle_animation.dart';
import 'package:the_car_rental_app/hero_image.dart';
import 'package:the_car_rental_app/skip_button.dart';
import 'package:the_car_rental_app/word_cascade_animation.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 📐 Column allows us to stack widgets vertically
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔝 Header Section: Background Circles and Skip Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 🔵 Animated background shapes
              CircleAnimation(),
              Spacer(),
              // ⏭️ Skip button with fade-in effect
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SkipButton(text: 'Skip', onPressed: (){
                  print('Skip button is being pressed');
                }),
              )
            ],
          ),

          Spacer(), // Pushes content below to the center/bottom

          // 🏎️ The Main Hero Image (Car) with complex animations
          HeroImage(),

          // 📝 Title Text: "Cascading" word animation
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: WordCascadeAnimation(
              text: "Your Luxury Car Awaits",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(height: 24),

          // 📄 Description Text: Staggered animation with a delay
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 24),
            child: WordCascadeAnimation(
              text:
              'Experience the thrill of driving the world\'s finest cars. Select your dream vehicle, and we\'ll handle the rest.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              delay: 700, // Wait 700ms before starting this paragraph
            ),
          ),

          Spacer(),

          // 🔘 Bottom Section: Call to Action Button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(text: 'Get Started', onPressed: (){
                print('Get Stared is being pressed');
              })
            ],),
          SizedBox(height: 32,),
        ],
      ),
    );
  }
}