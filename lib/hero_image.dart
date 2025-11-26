import 'package:flutter/material.dart';

class HeroImage extends StatefulWidget {
  const HeroImage({super.key});

  @override
  State<HeroImage> createState() => _HeroImageState();
}

class _HeroImageState extends State<HeroImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  // 🎢 Custom Cubic curve for a "premium" bouncy feel
  final reducedOvershootCurve = Cubic(0.175, 0.885, 0.32, 1.1375);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200), // 1.2 seconds total
    );

    // ➡️ Slide in from the left (-1.0) to center (0.0)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: reducedOvershootCurve));

    // 🔍 Scale up from 50% to 100%
    _scaleAnimation = Tween<double>(
        begin: 0.5,
        end: 1.0
    ).animate(CurvedAnimation(parent: _controller, curve: reducedOvershootCurve));

    // 👻 Fade in
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        // ⏳ Fade happens faster (first 70%) than the movement
        curve: const Interval(
          0.0,
          0.7,
          curve: Curves.easeIn,
        ),
      ),
    );

    // ⏱️ Start the animation after a brief delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _controller.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // 📦 Combining animations: Fade -> Scale -> Slide
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Transform.translate(
              // 🔧 Minor adjustment to center the car image perfectly
                offset: Offset(-20, 0),
                child: Image.asset('assets/bmw.png', fit: BoxFit.contain)),
          ),
        ),
      ),
    );
  }
}